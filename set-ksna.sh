#!/bin/bash

# script to switch config file to KSNA-Airband.conf

cd ~/

echo "Create RTLSDR-AIRBAND config file based on example file....."
user_home=$(eval echo ~$SUDO_USER)
source_file="$user_home/rtlsdr-airband-install-script/ksna-airband.conf"
destination_file=/usr/local/etc/rtl_airband.conf
cp "$source_file" "$destination_file"
echo "KSNA Configuration File copied over. Adjust as necessary!"
echo "Continuing...."
echo " "
echo "Restarting rtlsdr-air "
echo " "

systemctl restart rtl_airband