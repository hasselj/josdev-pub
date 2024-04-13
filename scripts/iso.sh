#!/usr/bin/env bash

#
# This script creates a bootable ISO file. The 'bootable' datum of the ISO file
# is the EFI System Partition (ESP).
#
# https://www.gnu.org/software/mtools/manual/mtools.html
#

set -eu

_ISO_BUILD_ROOT=$(mktemp --directory)
_ESP_FILE_NAME=esp.dd
_ESP_FILE_PATH=/tmp/$_ESP_FILE_NAME

# Create GPT formatted disk image with one partition
dd if=/dev/zero of=$_ESP_FILE_PATH bs=1M count=128

# Create FAT32 file system inside the GPT disk image on partition 1
$MFORMAT -i $_ESP_FILE_PATH -F

# Create directories
$MMD -i $_ESP_FILE_PATH ::/EFI ::/EFI/BOOT

# Copy files
$MCOPY -i $_ESP_FILE_PATH $BOOTLOADER_EXE_PATH ::/efi/boot/bootx64.efi
$MCOPY -i $_ESP_FILE_PATH $KERNEL_EXE_PATH ::/$KERNEL_FILE_NAME

#
# Create ISO
#

cp $_ESP_FILE_PATH $_ISO_BUILD_ROOT/

cd /tmp
$GENISOIMAGE -R -J \
    -b $_ESP_FILE_NAME -no-emul-boot \
    -o $ISO_FILE_PATH $_ISO_BUILD_ROOT/