#!/usr/bin/env bash

set -eu

docker run --rm -it \
    --mount type=bind,source="$(pwd)",target=/bindmount \
    --workdir /bindmount \
    --env ABS_PATH_TO_REPO_ROOT=/bindmount \
    --env BOOTLOADER_ARTIFACTS_DIR=$BOOTLOADER_ARTIFACTS_DIR \
    --env BOOTLOADER_DIR=$BOOTLOADER_DIR \
    --env EDK2_REPO_PATH=$EDK2_REPO_PATH \
    --env BOOTLOADER_SRC_DIR=$BOOTLOADER_SRC_DIR \
    --env BOOTLOADER_EDK2_EXE_PATH=$BOOTLOADER_EDK2_EXE_PATH \
    --env BOOTLOADER_EXE_PATH=$BOOTLOADER_EXE_PATH \
    --env KERNEL_FILE_NAME=$KERNEL_FILE_NAME \
    $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG bootloader/build-scripts/build.sh