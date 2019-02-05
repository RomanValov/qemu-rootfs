#!/bin/bash

set -e

export BOOTPATH="$ROOTFS:$ROOTFS/boot"

detect() {
  if [ ! -f "$3" ]; then
    path=$(resolve-bootpath.sh "$2")
    if [ -f "$path" ]; then
      echo "Detected rootfs $1: $path" >&2
      cp "$path" "$3"
    fi
  fi
}

detect "kernel" "vmlinuz" "$KERNEL"
detect "initrd" "initrd.img" "$INITRD"
