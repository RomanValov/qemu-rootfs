#!/bin/bash

set -ex

shopt -s nullglob

detect_paths() {
  for path in "$@" ; do
    if [ -e "$path" ]; then
      echo "$path"
      break
    fi
  done
}

KERNEL=$(detect_paths "$CHROOT/vmlinuz" "$CHROOT/boot/vmlinuz" "$CHROOT/boot"/vmlinuz*)
INITRD=$(detect_paths "$CHROOT/initrd.img" "$CHROOT/boot/initrd.img" "$CHROOT/boot"/initrd.img*)

[ -e "$KERNEL" ] && cp "$KERNEL" /vmlinuz
[ -e "$INITRD" ] && cp "$INITRD" /initrd.img

