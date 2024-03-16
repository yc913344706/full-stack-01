#!/bin/bash

##################
debug_flag="$1"
if [ "${debug_flag}" == "-d" ]; then
  set -x
  DEBUG_MODE="-d"
  LOG_LEVEL="DEBUG"
  shift 1
fi

set -e
[ -n "${WORKSPACE}" ] || WORKSPACE="$(dirname $(dirname $(dirname $(realpath $0))))"
source ${WORKSPACE}/lib/log.sh

CURRENT_DIR="$(dirname $0)"
###################

source ${WORKSPACE}/lib/docker_tools.sh
source ${WORKSPACE}/lib/check.sh

[ "$#" -ge 3 ] || die "params error"
CODE_DIR="$1"
NODE_DOCKER_IMAGE="$2"
NPM_RUN_FLAG="$3"
NODE_MODULES_PERSISTENT_DIR="$4"
BUILD_TIMEOUT="$5"

[ -n "${BUILD_TIMEOUT}" ] || BUILD_TIMEOUT=60

prepare_docker_image "${NODE_DOCKER_IMAGE}"

DOCKER_CONTAINER_NAME="${PROJECT_FLAG}_BUILD_FRONTEND"
BUILD_FLAG_FILE_NAME="build.result"
rm -rf "${CODE_DIR}/${BUILD_FLAG_FILE_NAME}"

[ -d "${CODE_DIR}/dist" ] && {
  rm -rf "${CODE_DIR}/dist"
}

volumes=(
  -v "${CODE_DIR}":/root/code_dir
  -v "${WORKSPACE}"/lib/frontend/build_frontend_run.sh:/root/code_dir/build_frontend_run.sh
)
if [ -n "${NODE_MODULES_PERSISTENT_DIR}" ]; then
  [ -d "${NODE_MODULES_PERSISTENT_DIR}" ] || die "cannot find NODE_MODULES_PERSISTENT_DIR you gave: ${NODE_MODULES_PERSISTENT_DIR}"
  volumes=("${volumes[@]} -v ${NODE_MODULES_PERSISTENT_DIR}:/root/code_dir/node_modules")
fi

cmds=(
  docker run -itd --rm
  ${volumes[@]}
  --name "${DOCKER_CONTAINER_NAME}"
  "${NODE_DOCKER_IMAGE}"
  bash -c "/root/code_dir/build_frontend_run.sh ${DEBUG_MODE} ${NPM_RUN_FLAG} ${BUILD_FLAG_FILE_NAME}"
)

stop_old_docker_container_by_name "NODE_DOCKER_IMAGE"
echo "${cmds[@]}"
"${cmds[@]}"

check_file_existed_with_timeout "${CODE_DIR}/${BUILD_FLAG_FILE_NAME}" "${BUILD_TIMEOUT}"
