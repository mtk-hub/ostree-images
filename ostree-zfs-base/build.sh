#!/bin/bash

RED='\033[0;31m'
NO_COLOR='\033[0m'

set -eou pipefail


err_report() {
    echo
    echo
    echo -e "${RED}Error $1 occured on line $2${NO_COLOR}"
    echo
    exit $1
}

trap 'err_report $? $LINENO' ERR

cd $(dirname -- ${BASH_SOURCE[0]})

pushd files/selinux/ &> /dev/null
make
popd &> /dev/null

IMGNAME=$(basename $PWD)
DATESTAMP=$(date +%Y-%m-%d)

time podman build $@ . -t "${IMGNAME}:${DATESTAMP}" -t "${IMGNAME}:latest" -t "ghcr.io/mtk-hub/${IMGNAME}:latest"
