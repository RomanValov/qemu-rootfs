#!/bin/bash

set -ex

if [ -e "/dev/kvm" ]; then
  USE_KVM="--enable-kvm"
fi

if [ ! -e "$HDA_QCOW2" ]; then
  echo "missing HDA_QCOW2=$HDA_QCOW2" >&2
  exit 1
fi

if [ ! -e "$KERNEL" ]; then
  echo "missing kernel" >&2
  exit 1
fi

if [ -e "$INITRD" ]; then
  USE_INITRD="-initrd $INITRD"
fi

if [ -n "$1" ]; then
  APPEND="init=$1"
fi

exec qemu-system-x86_64 \
  -no-reboot \
  -kernel "$KERNEL" \
  $USE_INITRD \
  -append "root=/dev/sda rw console=ttyS0 panic=1 $APPEND" \
  -display none -serial stdio \
  $USE_KVM \
  -m "$MEM" \
  -netdev type=user,id=net0 -device virtio-net-pci,netdev=net0 \
  -hda "$HDA_QCOW2"
