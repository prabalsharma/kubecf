#!/usr/bin/env bash

set -o errexit -o nounset
set -o xtrace

# shellcheck disable=SC2046
eval $("${MINIKUBE}" docker-env)

find .

if [[ "${#DOCKER_IMAGES[@]}" -gt 0 ]] ; then
  docker load --input "${DOCKER_IMAGES[@]}"
fi

exit 1
