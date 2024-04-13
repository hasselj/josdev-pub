#!/usr/bin/env bash

set -eu

docker build \
    --tag $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG \
    --file .docker/Dockerfile \
    --build-arg NONROOT_USERNAME=$NONROOT_USERNAME \
    --build-arg NONROOT_PROJ_DATA_DIR_BASE=$NONROOT_PROJ_DATA_DIR_BASE \
    --build-arg EDK2_REPO_URL=$EDK2_REPO_URL \
    --build-arg EDK2_REPO_TAG=$EDK2_REPO_TAG \
    --build-arg EDK2_REPO_PATH=$EDK2_REPO_PATH \
    --build-arg BINUTILS_REPO_URL=$BINUTILS_REPO_URL \
    --build-arg BINUTILS_REPO_TAG=$BINUTILS_REPO_TAG \
    --build-arg BINUTILS_REPO_PATH=$BINUTILS_REPO_PATH \
    --build-arg GCC_REPO_URL=$GCC_REPO_URL \
    --build-arg GCC_REPO_TAG=$GCC_REPO_TAG \
    --build-arg GCC_REPO_PATH=$GCC_REPO_PATH \
    --build-arg KERNEL_TOOLCHAIN_PREFIX=$KERNEL_TOOLCHAIN_PREFIX \
    .