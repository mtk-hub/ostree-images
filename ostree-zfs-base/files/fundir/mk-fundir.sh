#!/bin/bash

/sysroot/usr/bin/lsattr -d /sysroot
/sysroot/usr/bin/chattr -V -i /sysroot
mkdir -p -v /sysroot/fun
/sysroot/usr/bin/chattr -V +i /sysroot
/sysroot/usr/bin/lsattr -d /sysroot
