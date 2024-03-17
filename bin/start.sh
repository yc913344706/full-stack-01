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
source ${WORKSPACE}/lib/check.sh

main() {
    check_deps

    export WORKSPACE
    docker-compose \
        -f ./deploy/docker-compose.yml \
        --env-file etc/docker-compose.env \
        pull &&
        docker-compose \
            -f ./deploy/docker-compose.yml \
            --env-file etc/docker-compose.env \
            up -d

    log_info "启动完毕。通过 http://localhost:18080/ 访问服务。"
}

main
