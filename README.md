# netgear_a6100_ac600_driver_installer_linux
Bash script to install the necessary drivers for Netgear's AC600 Dual Band Wireless AC Adapter Model A6100.
The installer installs the rtl8812au drivers from https://github.com/aircrack-ng/rtl8812au automatically for linux based operating systems.
You might need to reboot your system after the installer runs apt dist-upgrade, so that it can find all the necessary headers and install them.
