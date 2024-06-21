#!/bin/bash
set -e

echo "Activating feature 'oracle instant client'"

# Main
if [ "$(id -u)" -ne 0 ]; then
  echo -e "This script must be run as root!"
  exit 1
fi

. /etc/os-release
if [ "${ID}" = "debian" ] || [ "${ID_LIKE}" = "debian" ]; then
  ADJUSTED_ID="debian"
else
  echo "Only debian distro is supported. ${ID} is not supported yet."
  exit 1
fi

echo "Installing distro packages"
apt-get update && \
  apt-get -y install libaio1

cd /usr/local/lib
wget https://download.oracle.com/otn_software/linux/instantclient/191000/instantclient-basiclite-linux.arm64-19.10.0.0.0dbru-2.zip --show-progress --progress=dot
unzip -o instantclient-basiclite-linux.arm64-19.10.0.0.0dbru-2.zip
rm instantclient-basiclite-linux.arm64-19.10.0.0.0dbru-2.zip
echo "/usr/local/lib/instantclient_19_10" >/etc/ld.so.conf.d/oracle-instantclient.conf
ldconfig

ORACLE_HOME=/usr/local/lib/instantclient_19_10
