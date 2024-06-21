#!/bin/bash
set -e

echo "Activating feature 'neovim'"

VERSION=${VERSION:-stable}
echo "Using version ${VERSION}"


# Main
if [ "$(id -u)" -ne 0 ]; then
  echo -e "This script must be run as root!"
  exit 1
fi

ADJUSTED_VERSION=${VERSION}
if [ "${VERSION}" != "stable" ] && [ "${VERSION}" != "nightly" ]; then
  ADJUSTED_VERSION="v${VERSION}"
fi

. /etc/os-release
if [ "${ID}" = "debian" ] || [ "${ID_LIKE}" = "debian" ]; then
  ADJUSTED_ID="debian"
else
  echo "Only debian distro is supported. ${ID} is not supported yet."
  exit 1
fi

echo "Installing build packages"
apt-get update && \
  apt-get -y install ninja-build gettext cmake unzip curl build-essential

cd /tmp
git clone https://github.com/neovim/neovim.git
cd neovim
git checkout ${ADJUSTED_VERSION}
make CMAKE_BUILD_TYPE=Release && make CMAKE_INSTALL_PREFIX=/usr/local/nvim install
ln -sf /usr/local/nvim/bin/nvim /usr/local/bin/nvim
rm -rf /tmp/neovim
