#!/bin/bash

set -ex

if [ -e $ROOTFS.tar.* ]; then
  extract-tar.sh "$ROOTFS" $ROOTFS.tar.*
fi

detect-kernel.sh

if [ -e "$ROOTFS" ] && [ ! -e "$HDA_QCOW2" ]; then
  create-image.sh "$ROOTFS"
fi

exec qemu.sh "$@"
