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
echo "Getting pulseaudio..."
echo "**********************************"
apt-get -y install pulseaudio pulseaudio-module-zeroconf pulseaudio-utils

echo "**********************************"
echo "Getting pavucontrol..."
echo "**********************************"
apt-get -y install pavucontrol

echo "**********************************"
echo "Getting pulsectl..."
echo "**********************************"
# apt-get -y install pulsectl #produces error on Bookworm
apt-get -y install python3-pulsectl

echo "**********************************"
echo "Getting paprefs..."
echo "**********************************"
apt-get -y install paprefs


echo "**********************************"
echo "Some Pulseaudio Setup..."
echo "**********************************"

cp ./pulseaudio.service /etc/systemd/system/pulseaudio.service
systemctl --system enable pulseaudio.service       
systemctl --system start pulseaudio.service       
cp ./client.conf /etc/pulse/client.conf        
sed -i '/^pulse-access:/ s/$/root,pi/' /etc/group




echo "**********************************"
echo " DONE. "
echo " "
echo " Use GUI to configure PAPREFS! "
echo " "
echo " Suggest reboot now ..."
echo "**********************************"
