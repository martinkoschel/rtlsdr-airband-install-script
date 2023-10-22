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


echo "Getting Dependencies..."
apt-get -y install build-essential
apt-get -y install cmake
apt-get -y install pkg-config
apt-get -y install libmp3lame-dev
apt-get -y install libshout3-dev
apt-get -y install 'libconfig++-dev'
apt-get -y install libraspberrypi-dev
apt-get -y install libfftw3-dev
apt-get -y install librtlsdr-dev
apt-get -y install libpulse-dev
apt-get -y install g++ 
apt-get -y install libpython3-dev 
apt-get -y install python3-numpy 
apt-get -y install swig


echo "**********************************"
echo "Get, build, install  SOAPY..."
echo "**********************************"
git clone "https://github.com/pothosware/SoapySDR.git"
cd SoapySDR
mkdir build
cd build
cmake ..
make -j`nproc`
sudo make install -j`nproc`
# sudo ldconfig #needed on debian systems
SoapySDRUtil --info
cd

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
# Writing all options in cmake parameters to cancel out prior settings from potential earlier build
cmake -DPLATFORM=native -DNFM=ON -DRTLSDR=ON -DMIRISDR=OFF -DSOAPYSDR=ON -DPULSEAUDIO=ON -DPROFILING=OFF -DCMAKE_BUILD_TYPE=Release ../
make
make install

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
echo "**********************************"
