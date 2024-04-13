#!/usr/bin/env bash

set -eu

docker run --rm -it \
    --mount type=bind,source="$(pwd)",target=/bindmount \
    --workdir /bindmount \
    --env ABS_PATH_TO_REPO_ROOT=/bindmount \
    --env ISO_FILE_NAME=$ISO_FILE_NAME \
    --env ISO_FILE_PATH=$ISO_FILE_PATH \
    --env BOOTLOADER_EXE_PATH=$BOOTLOADER_EXE_PATH \
    --env KERNEL_EXE_PATH=$KERNEL_EXE_PATH \
    --env KERNEL_FILE_NAME=$KERNEL_FILE_NAME \
    --env MFORMAT=$MFORMAT \
    --env MMD=$MMD \
    --env MCOPY=$MCOPY \
    --env GENISOIMAGE=$GENISOIMAGE \
    $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG ./scripts/iso.sh