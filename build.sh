#!/bin/bash

rm /etc/rpm/macros.image-language-conf
sed -i '/tsflags=nodocs/d' /etc/dnf/dnf.conf

dnf5 -y upgrade
dnf5 -y swap coreutils-single coreutils-full
dnf5 -y swap glibc-minimal-langpack glibc-all-langpacks

# see: curl ultramarine-linux.org/migrate.sh
VERSION=$(rpm -E %fedora 2>/dev/null || echo "39")

nonfree=$(rpm -qa rpmfusion-nonfree-release | head -c1 | wc -c)
free=$(rpm -qa rpmfusion-free-release | head -c1 | wc -c)
if [ "$nonfree" -eq 0 ] && [ "$free" -eq 0 ]; then
  dnf5 install -y "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-${VERSION}.noarch.rpm" "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${VERSION}.noarch.rpm"
elif [ "$nonfree" -eq 0 ]; then
  dnf5 install -y "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${VERSION}.noarch.rpm"
elif [ "$free" -eq 0 ]; then
  dnf5 install -y "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-${VERSION}.noarch.rpm"
fi

if [ "$(rpm -qa terra-release | head -c1 | wc -c)" -eq 0 ]; then
  dnf5 install -y --repofrompath "terra,https://repos.fyralabs.com/terra${VERSION}" --setopt="terra.gpgkey=https://repos.fyralabs.com/terra${VERSION}/key.asc" terra-release
fi

if [ "$(rpm -qa ultramarine-repos-common | head -c1 | wc -c)" -eq 0 ]; then
  dnf5 install -y --repofrompath "ultramarine,https://repos.fyralabs.com/um${VERSION}" --setopt="ultramarine.gpgkey=https://repos.fyralabs.com/um${VERSION}/key.asc" ultramarine-repos-common
fi

dnf5 swap -y fedora-release-common ultramarine-release-common --allowerasing
dnf5 group install --allowerasing --no-best -y ultramarine-product-common

echo max_parallel_downloads=20 >>/etc/dnf/dnf.conf
echo defaultyes=True >>/etc/dnf/dnf.conf
