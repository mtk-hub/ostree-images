#!/bin/bash

if [ $# -ne 2 ]; then
  echo
  echo "Usage: $(basename $0) <current-host> <new-host>"
  echo
  exit
fi

current_host=$1
new_host=$2

if [ -f current-host-rpm-packages.txt ]; then
  echo "current-host-rpm-packages.txt exists, skipping"
else
  echo -n "Gathering package list from $current_host... "
  ssh "$current_host" rpm -qa --queryformat '%{NAME}\\n' | sort > current-host-rpm-packages.txt
  echo "Done."
fi

if [ -f new-host-rpm-packages.txt ]; then
  echo "new-host-rpm-packages.txt exists, skipping"
else
  echo -n "Gathering package list from $new_host... "
  ssh "$new_host" rpm -qa --queryformat '%{NAME}\\n' | sort > new-host-rpm-packages.txt
  echo "Done."
fi
