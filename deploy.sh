#!/usr/bin/env bash

set -xeuo pipefail

environment=${1:-local}
registry=${2:-localhost:5000}
frontend_folder=${3:-${CARNOVO_FRONTEND_FOLDER:-}}
backend_folder=${4:-${CARNOVO_BACKEND_FOLDER:-}}

export DOCKER_REGISTRY=$registry
export ENVIRONMENT=$environment

if [ ! "$environment" = "local" ]; then
	for file in versions/$environment/*.properties
	do
		. $file
	done
fi

if [ "$environment" = "staging" ] || [ "$environment" = "local" ]; then
	export EXTERNAL_PORT=5555
	export EXTERNAL_MYSQL_PORT=3309
	export BACKEND_PORT=8000
	export CARNOVO_PORT=8087
	export ADMIN_PORT=8086
fi

if [ "$environment" = "local" ]; then
	export KARAMBACARS_VERSION=latest
 	export KARAMBA_FRONTEND_VERSION=latest
 	export DEBIAN_SOURCES=${DEBIAN_JESSIE_SOURCES_MIRROR:-}
 	export PHANTOMJS_CDNURL=${PHANTOMJS_CDNURL:-}
 	export NPM_CONFIG_REGISTRY=${NPM_CONFIG_REGISTRY:-}
 	export SASS_BINARY_SITE=${SASS_BINARY_SITE:-}
 	export BASE_COMPOSE="BACKEND_BUILD_CONTEXT=$backend_folder FRONTEND_BUILD_CONTEXT=$frontend_folder docker-compose -f docker-compose.yml -f local.yml"
 	make kill-all
 	make -e build
fi



if [ "$environment" = "qa" ]; then
	export EXTERNAL_PORT=8080
	export EXTERNAL_MYSQL_PORT=3307
	export BACKEND_PORT=8001
	export CARNOVO_PORT=8089
	export ADMIN_PORT=8088
fi

if [ "$environment" = "production" ]; then
	export EXTERNAL_PORT=80
	export EXTERNAL_MYSQL_PORT=3306
	export BACKEND_PORT=8002
	export CARNOVO_PORT=8091
	export ADMIN_PORT=8090
fi

export KARAMBACARS_VERSION=$KARAMBACARS_VERSION
export KARAMBA_FRONTEND_VERSION=$KARAMBA_FRONTEND_VERSION

make -e
