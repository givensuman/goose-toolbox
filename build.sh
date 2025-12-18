rm /etc/rpm/macros.image-language-conf
sed -i '/tsflags=nodocs/d' /etc/dnf/dnf.conf

dnf -y upgrade
dnf -y swap coreutils-single coreutils-full
dnf -y swap glibc-minimal-langpack glibc-all-langpacks

# see: curl ultramarine-linux.org/migrate.sh
VERSION=$(rpm -E %fedora 2>/dev/null || echo "39")

nonfree=$(rpm -qa rpmfusion-nonfree-release | head -c1 | wc -c)
free=$(rpm -qa rpmfusion-free-release | head -c1 | wc -c)
if [ "$nonfree" -eq 0 ] && [ "$free" -eq 0 ]; then
  echo " --> Installing rpmfusion-nonfree-release and rpmfusion-free-release"
  trace sudo dnf install -y "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-${VERSION}.noarch.rpm" "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${VERSION}.noarch.rpm"
elif [ "$nonfree" -eq 0 ]; then
  echo " --> Detected rpmfusion-free-release"
  echo " --> Installing rpmfusion-nonfree-release"
  trace sudo dnf install -y "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${VERSION}.noarch.rpm"
elif [ "$free" -eq 0 ]; then
  echo " --> Detected rpmfusion-nonfree-release"
  echo " --> Installing rpmfusion-free-release"
  trace sudo dnf install -y "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-${VERSION}.noarch.rpm"
else
  echo " --> Seems like both rpmfusion-nonfree-release and rpmfusion-free-release are installed"
fi

if [ "$(rpm -qa terra-release | head -c1 | wc -c)" -eq 0 ]; then
  trace sudo dnf install -y --repofrompath "terra,https://repos.fyralabs.com/terra${VERSION}" --setopt="terra.gpgkey=https://repos.fyralabs.com/terra${VERSION}/key.asc" terra-release
else
  echo " --> Seems like terra-release has already been installed"
fi

if [ "$(rpm -qa ultramarine-repos-common | head -c1 | wc -c)" -eq 0 ]; then
  trace sudo dnf install -y --repofrompath "ultramarine,https://repos.fyralabs.com/um${VERSION}" --setopt="ultramarine.gpgkey=https://repos.fyralabs.com/um${VERSION}/key.asc" ultramarine-repos-common
else
  echo " [!] Seems like ultramarine-repos-common has already been installed"
fi

trace sudo dnf swap -y fedora-release-common ultramarine-release-common --allowerasing
trace sudo dnf group install --allowerasing --no-best -y ultramarine-product-common

echo max_parallel_downloads=20 >>/etc/dnf/dnf.conf
echo defaultyes=True >>/etc/dnf/dnf.conf
