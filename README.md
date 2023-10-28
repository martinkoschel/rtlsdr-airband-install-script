# Airband-Listener
Install script for a Raspberry-Pi + RTLSDR -based device to serve airband radio on a network. 

## Acknowledgements
The present script utilizes the excellent RTLSDR-Airband from Charlie-Foxtrot https://github.com/charlie-foxtrot/RTLSDR-Airband

# Instructions

## Copy repo to the target device (raspberry)

On the target device, in the command line, run: 
'sudo curl -L -O https://github.com/martinkoschel/rtlsdr-airband-install-script/archive/main.zip'

Then Unzip:
`unzip -j main.zip` unzips it without the archive folder structure, i.e. into the current directory. 

## Install

Just run inst-RTLSDR-Air.sh
Once run complete, edit the config files as necessary, see instructions in https://github.com/charlie-foxtrot/RTLSDR-Airband. 

Note: Set location for IceCast2 server as 127.0.0.1 in the RTLSDR-Airband config file.

Caution: Make sure that the ports for the icecast2 are consistent (e.g. all set to 8080, or 8080, or ...)

Config Files are at:

`/usr/local/etc/rtl_airband.conf`  

`/etc/icecast2/icecast.xml`




# Running

`sudo /usr/local/bin/rtl_airband -f`

The Icecast server should start itself once it sees incoming data.
