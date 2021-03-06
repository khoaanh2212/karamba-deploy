VERSION = 1.0

DOCKER_REGISTRY?=localhost:5000
ENVIRONMENT?=staging
EXTERNAL_PORT?=81
KARAMBACARS_VERSION?=latest
KARAMBA_FRONTEND_VERSION?=latest
BACKEND_PROJECT_NAME?=carambacars
FRONTEND_PROJECT_NAME?=karamba-frontend-carnovo
ADMIN_PROJECT_NAME?=karamba-frontend-admin
PROXY_PROJECT_NAME?=karamba-proxy
BASE_COMPOSE?=docker-compose
EXTERNAL_MYSQL_PORT?=3306
BACKEND_PORT?=8002
CARNOVO_PORT?=8091
ADMIN_PORT?=8090
COMPOSE_VARS=ENVIRONMENT=$(ENVIRONMENT) EXTERNAL_MYSQL_PORT=$(EXTERNAL_MYSQL_PORT) BACKEND_PORT=$(BACKEND_PORT) CARNOVO_PORT=$(CARNOVO_PORT) ADMIN_PORT=$(ADMIN_PORT) EXTERNAL_PORT=$(EXTERNAL_PORT) DOCKER_REGISTRY=$(DOCKER_REGISTRY) KARAMBACARS_VERSION=$(KARAMBACARS_VERSION) KARAMBA_FRONTEND_VERSION=$(KARAMBA_FRONTEND_VERSION) BACKEND_PROJECT_NAME=$(BACKEND_PROJECT_NAME) ADMIN_PROJECT_NAME=$(ADMIN_PROJECT_NAME) FRONTEND_PROJECT_NAME=$(FRONTEND_PROJECT_NAME) PROXY_PROJECT_NAME=$(PROXY_PROJECT_NAME)
DOCKER_COMPOSE=$(COMPOSE_VARS) $(BASE_COMPOSE)


deploy:
	$(DOCKER_COMPOSE) up -d --force-recreate

all:
	deploy

build:
	$(DOCKER_COMPOSE) build

kill-all:
	$(DOCKER_COMPOSE) kill
	echo "yes" | $(DOCKER_COMPOSE) rm

restart:
	$(DOCKER_COMPOSE) restart

logs:
	$(DOCKER_COMPOSE) logs

compose:
	echo "$(DOCKER_COMPOSE)"

pull:
	$(DOCKER_COMPOSE) pull

ps:
	$(DOCKER_COMPOSE) ps
