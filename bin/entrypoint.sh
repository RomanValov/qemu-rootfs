#!/bin/bash

set -ex

if [ -e $CHROOT.tar.* ]; then
  extract-tar.sh "$CHROOT" $CHROOT.tar.*
fi

if [ ! -e "$KERNEL" ]; then
  detect-kernel.sh
fi

if [ -e "$CHROOT" ] && [ ! -e "$HDA_QCOW2" ]; then
  create-image.sh "$CHROOT"
fi

exec qemu.sh "$@"
