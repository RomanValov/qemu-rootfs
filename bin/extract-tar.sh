#!/bin/bash

set -ex

mkdir -p "$1"
pushd "$1"

tar xf "$2"

if [ -w "$2" ]; then
  rm "$2"
fi
