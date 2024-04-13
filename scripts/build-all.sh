#!/usr/bin/env bash

# convenience script

set -eu

source vars.sh

./.docker/bootloader-build-wrapper.sh
./.docker/kernel-build-wrapper.sh
./.docker/iso-wrapper.sh