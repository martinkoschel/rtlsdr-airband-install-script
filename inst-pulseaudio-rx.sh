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

# Define the line to add to pulseaudio config file
line_to_add="load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1;10.0.0.1/8"

# Define the file path
file_path="/etc/pulse/default.pa"

# Define the text block after which to add the line
block_marker="### Network access (may be configured with paprefs, so leave this commented)"
end_of_block_marker="^#load-module module-zeroconf-publish$"

# Use sed to insert the line after the specified block
sed -i "/$block_marker/,/$end_of_block_marker/{/$block_marker/n;/^$end_of_block_marker/a\\$line_to_add
}" "$file_path"

echo "Line $line_to_add added to $file_path"

# Define the line to uncomment
line_to_uncomment="#load-module module-rtp-recv"

# Use sed to uncomment the line in the file
sed -i "s|^$line_to_uncomment|load-module module-rtp-recv|" "$file_path"

echo "Line $line_to_uncomment uncommented in $file_path"


echo "**********************************"
echo " DONE. "
echo " "
echo " Use GUI to configure PAPREFS! "
echo " "
echo " Suggest reboot now ..."
echo "**********************************"
