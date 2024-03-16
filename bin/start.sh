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
[ -n "${WORKSPACE}" ] || WORKSPACE="$(dirname $(dirname $(realpath $0)))"
source ${WORKSPACE}/lib/log.sh

CURRENT_DIR="$(dirname $0)"
###################

source ${WORKSPACE}/etc/basic
source ${WORKSPACE}/etc/docker_config
source ${WORKSPACE}/lib/prepare.sh


build_frontend() {
     "${WORKSPACE}"/lib/frontend/build_frontend.sh \
    ${DEBUG_MODE} \
    "${WORKSPACE}/frontend" \
    "${FRONTEND_BUILD_IMAGE}" \
    "build" \
    "${NODE_MODULES_PERSISTENT_DIR}" \
    "300"
}

main() {
    build_frontend
}

main
