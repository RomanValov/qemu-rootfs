#!/bin/bash

set -ex

if [ ! -e "$HDA_QCOW2" ]; then
  if [ -e $ROOTFS.tar.* ]; then
    extract-tar.sh "$ROOTFS" $ROOTFS.tar.*
  fi

  if [ -e "$ROOTFS" ]; then
    detect-kernel.sh
    create-image.sh "$ROOTFS"
  fi
fi

exec qemu.sh "$@"
