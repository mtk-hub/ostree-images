#!/bin/bash

if [ "$1" == "/proc/1/comm" ]; then
  echo systemd
  exit 0
fi

/usr/bin/cat.orig $@
