#!/bin/bash


echo -n "RUN dnf download --arch x86_64 "
line_len=0
pkg_cnt=0
for pkg in $(cat current-host-rpm-packages.txt); do
  if [ "$pkg" == "zfs-fuse" -o \
       "$pkg" == "gpg-pubkey" -o \
       "$pkg" == "libglusterfs0" -o \
       "$pkg" == "glusterfs" -o \
       "$pkg" == "glusterfs-cli" -o \
       "$pkg" == "glusterfs-client-xlators" -o \
       "$pkg" == "glusterfs-fuse" -o \
       "$pkg" == "nim-srpm-macros" -o \
       "$pkg" == "jack-audio-connection-kit" -o \
       "$pkg" == "fedora-release-server" -o \
       "$pkg" == "fedora-release-identity-server" \
     ]; then 
    # Ignore these packages
    continue
  fi

  # Skip packages that are already installed on new-host
  if grep "^$pkg$" new-host-rpm-packages.txt &> /dev/null; then
    continue
  fi

#  # rpm-ostree with too many packages is SUPER slow. Break it up.
#  if [ $pkg_cnt -gt 30 ]; then
#    pkg_cnt=0
#    line_len=${#pkg}
#    echo "  && \\"
#    echo -n "    rpm-ostree install $pkg "
#    continue
#  fi

  pkg_cnt=$((pkg_cnt + 1))
  line_len=$((line_len + ${#pkg}))
  if [ $line_len -gt 45 ]; then
    line_len=0
    echo "  \\"
    echo -n "      "
  fi

  echo -n "$pkg "
done
echo "  && \\"
echo "    rm -vrf /var && \\"
echo "    ostree container commit"
