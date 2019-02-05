#!/bin/bash

set -e

basename="$1"

if [ -z "$basename" ]; then
  echo "usage: resolve-bootpath vmlinuz" >&2
  exit 1
fi

if [ -z "$BOOTPATH" ]; then
  BOOTPATH="/boot"
fi

for path in ${BOOTPATH//:/ }; do
  if [ -f "$path/$basename" ]; then
    echo "$path/$basename"
    exit
  fi
done

for path in ${BOOTPATH//:/ }; do
  for filename in $(compgen -G "$path/$basename*"); do
    echo "$filename"
    exit
  done
done

exit 1
