#!/bin/sh
#check for root
UID=$(id -u)
if [ x$UID != x0 ] 
then
    #Beware of how you compose the command
    printf -v cmd_str '%q ' "$0" "$@"
    exec sudo su -c "bash $cmd_str"
fi

export DEBIAN_FRONTEND=noninteractive
slp=0 

# exit when any command fails
set -e
# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo -e "\"${last_command}\" command filed with exit code $?."; echo -e "Installer: Installation Failed"; echo -e "Try rebooting if the RTL8812AU driver was not installed; dkms status"' ERR

echo 'Installer: Installing RTL8812AU drivers for NETGEAR A6100/AC600'
echo 'Installer: Running apt-get update & upgrade & dist-upgrade'
sleep $slp
apt-get update -y && apt-get upgrade -y && apt dist-upgrade -y
echo 'Installer: Installing headers'
sleep $slp
echo apt-get install linux-headers-$(uname -r) -y
echo 'Installer: Installing Git'
sleep $slp
apt-get install git -y
echo 'Installer: Getting the installation files'
sleep $slp
rm -rf rtl8812au
git clone https://github.com/aircrack-ng/rtl8812au
echo 'Installer: Installing dkms'
sleep $slp
apt-get install dkms -y
echo 'Installer: Installing drivers'
sleep $slp
rm -r /var/lib/dkms/8812au ||:
cd rtl8812au
make dkms_install
echo 'Installer: Installation complete!'
