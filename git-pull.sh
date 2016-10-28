#!/usr/bin/env bash

set -euo pipefail

pull-project() {
    pushd $1
    git pull
    popd
}

git pull
pull-project ${CARNOVO_FRONTEND_FOLDER}
pull-project ${CARNOVO_BACKEND_FOLDER}
