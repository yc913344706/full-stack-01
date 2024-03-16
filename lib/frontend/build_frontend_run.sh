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

CURRENT_DIR="$(dirname $0)"
###################

run_flag="$1"
flag_file="$2"

npm config set registry https://registry.npm.taobao.org
npm config set strict-ssl false
npm install -g cnpm --registry=https://registry.npm.taobao.org

[ -f "${CURRENT_DIR}/package-lock.json" ] && rm ${CURRENT_DIR}/package-lock.json

cd ${CURRENT_DIR} &&
    cnpm install &&
    npm run ${run_flag} &&
    [ -d "./dist" ] &&
    echo "success" > ${flag_file} || exit 1
