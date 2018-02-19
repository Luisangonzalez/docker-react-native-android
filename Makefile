# .PHONY: build cache_clean start dev-server test-server dev-client up

# Important
PROJECT_NAME=react-native-android
DOCKER_COMPOSE_WEB=docker-compose -p ${PROJECT_NAME} -f ./docker-compose.yml
DOCKER_COMPOSE_RUN_WEB=${DOCKER_COMPOSE_WEB} run web

# default: build

# cache_clean:
# 		${DOCKER_COMPOSE_RUN_WEB} yarn cache clean

# build: cache_clean
# 		${DOCKER_COMPOSE_RUN_WEB} yarn

# compile: build
# 		${DOCKER_COMPOSE_WEB} run --rm --service-ports web yarn compile

# dev: compile
# 		${DOCKER_COMPOSE_WEB} run --rm --service-ports web yarn dev

# test: build
# 		${DOCKER_COMPOSE_WEB} run --rm --service-ports web yarn test

# up:
# 		${DOCKER_COMPOSE_WEB} run --rm --service-ports web /bin/bash

shell:
		${DOCKER_COMPOSE_WEB} run --rm android /bin/bash
