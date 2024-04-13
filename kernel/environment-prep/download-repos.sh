#!/usr/bin/env bash

set -eu

git clone --depth=1 --branch $GCC_REPO_TAG $GCC_REPO_URL $GCC_REPO_PATH
git clone --depth=1 --branch $BINUTILS_REPO_TAG $BINUTILS_REPO_URL $BINUTILS_REPO_PATH
