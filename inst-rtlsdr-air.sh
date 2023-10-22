#!/bin/bash

# Script to install RTL-SDR with all dependencies
# Assumes RTL-SDR, Raspberry Pi
# gets RTLSDR-Airband v4.2.0

clear

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

echo "RTLSDR-Air Dependencies"
echo "Getting build_essential:"
apt-get -y install build-essential

echo "Getting cmake:"
apt-get -y install cmake

echo "Getting pkg-config:"
apt-get -y install pkg-config

echo "Getting libmp3lame-dev:"
apt-get -y install libmp3lame-dev

echo "Getting libshout3-dev:"
apt-get -y install libshout3-dev

echo "Getting libconfig++-dev:"
apt-get -y install 'libconfig++-dev'

# The below is for Raspberry v1, v2, v3
# echo "Getting libraspberrypi-dev:"
# apt-get -y install libraspberrypi-dev

echo "Getting libfftw3-dev:"
apt-get -y install libfftw3-dev

echo "Getting librtlsdr-dev:"
apt-get -y install librtlsdr-dev

echo "Getting libpulse-dev:"
apt-get -y install libpulse-dev

echo "SOAPY Dependencies"

# SOAPY also has cmake as a dependency...

echo "Getting g++:"
apt-get -y install 'g++'

echo "Getting libpython3-dev:"
apt-get -y install libpython3-dev

echo "Getting python3-numpy:"
apt-get -y install python3-numpy 

echo "Getting swig:"
apt-get -y install swig


echo "Get RTL-SDR as a serialization tool"
apt-get -y install rtl-sdr


echo "**********************************"
echo "Get, build, install  SOAPY..."
echo "**********************************"

git clone "https://github.com/pothosware/SoapySDR.git"

cd SoapySDR
mkdir build
cd build
cmake ..
make -j`nproc`
make install -j`nproc`
ldconfig #needed on debian systems
SoapySDRUtil --info
cd ~/

echo "**********************************"
echo "SOAPY Install Complete! Going on with RTL-SDR..."
echo "**********************************"

echo "**********************************"
echo "Getting the RTLSDR-Airband Code..."
echo "**********************************"

cd
wget -O RTLSDR-Airband-4.2.0.tar.gz https://github.com/szpajder/RTLSDR-Airband/archive/v4.2.0.tar.gz
tar xvfz RTLSDR-Airband-4.2.0.tar.gz
rm RTLSDR-Airband-4.2.0.tar.gz
cd RTLSDR-Airband-4.2.0

echo "**********************************"
echo "Compiling..."
echo "**********************************"
mkdir build
cd build

# The below seemed to have issues, producing a "Kernel Driver Detached" error when invoking rtlsdr-air -f
# trying plain cmake ../
# Writing all options in cmake parameters to cancel out prior settings from potential earlier build
# cmake -DPLATFORM=native -DNFM=ON -DRTLSDR=ON -DMIRISDR=OFF -DSOAPYSDR=ON -DPULSEAUDIO=ON -DPROFILING=OFF -DCMAKE_BUILD_TYPE=Release ../

cmake ../
make
make install

cd ~/

echo "**********************************"
echo "Done with RTLSDR-Airband. Next: Icecast Server"
echo "**********************************"

echo "**********************************"
echo "Installing Icecast"
echo "**********************************"

apt install -y  icecast2

echo "**********************************"
echo "**********************************"
echo "DONE!"
echo "**********************************"
echo "**********************************"
echo "Remember to edit the config files:"
echo " /usr/local/etc/rtl_airband.conf "
echo " /etc/icecast2/icecast.xml "
echo "                                 "
echo "Consider a reboot.               "
echo "**********************************"
