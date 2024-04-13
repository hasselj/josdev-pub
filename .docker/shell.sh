#!/usr/bin/env bash

set -eu

docker run --rm -it \
    --mount type=bind,source="$(pwd)",target=/bindmount \
    --workdir /bindmount \
    $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG /bin/bash