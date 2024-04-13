#!/usr/bin/env bash

set -eu

_ISO_FILE_PATH=josdev.iso
_QEMU_OVMF_CODE=/usr/local/ovmf/edk2-ovmf-code.fd
_QEMU_OVMF_VARS=/usr/local/ovmf/edk2-ovmf-vars.fd

qemu-system-x86_64 \
    -accel tcg,thread=single \
    -smp 1 \
    -cpu qemu64 \
    -m 128 \
    -drive if=pflash,format=raw,unit=0,file=$_QEMU_OVMF_CODE,readonly=on \
    -drive if=pflash,format=raw,unit=1,file=$_QEMU_OVMF_VARS \
    -net none \
    -cdrom $_ISO_FILE_PATH \
    -no-reboot

# -nographic \
# -S -s
