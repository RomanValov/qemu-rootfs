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

NEW_KERNEL=$(detect_paths "$CHROOT/vmlinuz" "$CHROOT/boot/vmlinuz" "$CHROOT/boot"/vmlinuz*)
NEW_INITRD=$(detect_paths "$CHROOT/initrd.img" "$CHROOT/boot/initrd.img" "$CHROOT/boot"/initrd.img*)

[ -e "$NEW_KERNEL" ] && cp "$NEW_KERNEL" "$KERNEL"
[ -e "$NEW_INITRD" ] && cp "$NEW_INITRD" "$INITRD"
