#!/bin/bash

# script to set up the Raspberry Pi to receive audio stream from RTLSDR-Airband via Pulse Audio
# script by Martin Koschel 2023
# rtlsdr-airband by charlie-foxtrot


clear


echo "***********************************"
echo "***********************************"
echo "****   Installing Pulse Audio   ***"
echo "****         S E R V E R        ***"
echo "****                            ***"
echo "**** that means the audio will  ***"
echo "**** play on the speakers       ***"
echo "**** attached to this device.   ***"
echo "***********************************"
echo "***********************************"

echo " "
echo " "

echo "**********************************"
echo "First Things First - Update and Upgrade..."
echo "**********************************"
apt update
apt full-upgrade -y

echo "**********************************"
echo " Getting Git......"
echo "**********************************"
apt-get -y install git

echo "**********************************"
echo "Getting Dependencies..."
echo "**********************************"
echo " Oops, looks like there are none..."

echo "**********************************"
echo " setting up PAPREFS tool.."
echo "**********************************"
apt-get -y install paprefs

echo " paprefs is looking for its setting file in the wrong place."
echo " fixing that, creating a symlink to point to the right spot..."

# Find the directory starting with "pulse" in /etc/lib
pulse_dir=$(find /etc/lib -type d -name 'pulse*' -print -quit)

# Check if a matching directory was found
if [ -n "$pulse_dir" ]; then
    # Create a symlink to /etc/lib/pulse-13.99
    ln -s "$pulse_dir" /etc/lib/pulse-13.99
    echo "Symlink created successfully."
else
    echo "No directory starting with 'pulse' found in /etc/lib."
fi

echo "**********************************"
echo " DONE. "
echo " "
echo " Use GUI to configure PAPREFS! "
echo " "
echo " Suggest reboot now ..."
echo "**********************************"
