#!/bin/sh
export DEBIAN_FRONTEND=noninteractive
# exit when any command fails
set -e
# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo -e "\"${last_command}\" command filed with exit code $?."; echo -e "Installer: Installation Failed"; echo -e "Try rebooting if the RTL8812AU driver was not installed; dkms status"' ERR
echo 'Installer: Installing RTL8812AU drivers for NETGEAR A6100/AC600'
echo 'Installer: Running apt-get update & upgrade & dist-upgrade'
apt-get update -y && apt-get upgrade -y && apt dist-upgrade -y
echo 'Installer: Installing headers'
echo apt-get install linux-headers-$(uname -r) -y
echo 'Installer: Installing Git'
apt-get install git -y
echo 'Installer: Getting the installation files'
rm -rf rtl8812au
git clone https://github.com/aircrack-ng/rtl8812au
echo 'Installer: Installing dkms'
apt-get install dkms -y
echo 'Installer: Installing drivers'
rm -r /var/lib/dkms/8812au ||:
cd rtl8812au
make dkms_install
echo 'Installer: Installation complete!'