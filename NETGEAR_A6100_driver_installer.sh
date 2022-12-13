#!/bin/sh
UID=$(id -u)
if [ x$UID != x0 ] 
then
    #Beware of how you compose the command
    printf -v cmd_str '%q ' "$0" "$@"
    exec sudo su -c "bash $cmd_str"
fi

set -e
slp=2

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo "\"${last_command}\" command filed with exit code $?."' EXIT

echo "Installer: Installing RTL8812AU drivers for NETGEAR A6100/AC600"
sleep $slp
echo "Installer: Running apt-get update & upgrade and dist-upgrade"
sleep $slp
DEBIAN_FRONTEND=noninteractive apt-get update -y && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y
echo "Installer: Installing headers"
sleep $slp
DEBIAN_FRONTEND=noninteractive apt-get install linux-headers-$(uname -r) -y
echo "Installer: Installing Git"
sleep $slp
apt-get install git -y
echo "Installer: Getting the installation files"
sleep $slp
rm -rf rtl8812au
git clone https://github.com/aircrack-ng/rtl8812au
echo "Installer: Installing dkms"
sleep $slp
DEBIAN_FRONTEND=noninteractive apt-get install dkms -y
cd rtl8812au
echo "Installer: Installing drivers"
sleep $slp
rm -r /var/lib/dkms/8812au
make dkms_install
dkms status
echo "Installer: Installation complete!"


