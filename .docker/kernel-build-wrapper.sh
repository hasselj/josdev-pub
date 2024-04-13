#!/usr/bin/env bash

set -eu

docker run --rm -it \
    --mount type=bind,source="$(pwd)",target=/bindmount \
    --workdir /bindmount \
    --env ABS_PATH_TO_REPO_ROOT=/bindmount \
    --env KERNEL_ARTIFACTS_DIR=$KERNEL_ARTIFACTS_DIR \
    --env KERNEL_TOOLCHAIN_PREFIX=$KERNEL_TOOLCHAIN_PREFIX \
    --env KERNEL_FILE_NAME=$KERNEL_FILE_NAME \
    --env KERNEL_EXE_PATH=$KERNEL_EXE_PATH \
    --env BOOTLOADER_DIR=$BOOTLOADER_DIR \
    $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG kernel/build-scripts/build.sh