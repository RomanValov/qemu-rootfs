#!/bin/bash

set -ex

[ -e "$HDA_QCOW2" ] || create-image.sh
exec qemu.sh "$@"
