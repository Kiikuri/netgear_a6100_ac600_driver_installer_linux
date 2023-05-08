# netgear_a6100_ac600_driver_installer_linux

Bash script to install the necessary drivers for Netgear's AC600 Dual Band Wireless AC Adapter Model A6100.
The installer installs the rtl8812au drivers from https://github.com/aircrack-ng/rtl8812au automatically for linux based operating systems.
You might need to reboot your system after the installer runs apt dist-upgrade, so that it can find all the necessary headers and install them.

Instructions:

1. Download and extract the file from the ZIP
2. Open terminal
3. Run `sudo su`
4. Locate the file in the terminal
5. Run the bash file:

```
bash NETGEAR_A6100_driver_installer.sh
```

You can try to run the script with the command:

```
sudo bash NETGEAR_A6100_driver_installer.sh
```

but I can't quarantee that to work 100% of the time.
