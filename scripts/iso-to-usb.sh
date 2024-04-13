#!/usr/bin/env bash

set -eu

_ISO_FILE_PATH=josdev.iso
_USB_DEVICE=/dev/sda

sudo dd if=$_ISO_FILE_PATH of=$_USB_DEVICE bs=8M status=progress
