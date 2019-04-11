#!/usr/bin/env bash

set -e

: ${ALICLOUD_ACCESS_KEY_ID:?}
: ${ALICLOUD_ACCESS_KEY_SECRET:?}
: ${ALICLOUD_DEFAULT_REGION:?}

source bosh-cpi-src/ci/tasks/utils.sh

export GOPATH=${PWD}/bosh-cpi-src
export PATH=${GOPATH}/bin:$PATH

export ACCESS_KEY_ID=${ALICLOUD_ACCESS_KEY_ID}
export ACCESS_KEY_SECRET=${ALICLOUD_ACCESS_KEY_SECRET}
export ACCESS_KEY_CONFIG=${ALICLOUD_ACCESS_KEY_SECRET}

check_go_version $GOPATH
check_param $ACCESS_KEY_ID
#check_param $ACCESS_KEY_SECRET


cd ${PWD}/bosh-cpi-src


# logs
echo "begin unit test..."

make
make test
