# Airband-Listener Install Script
Install script for a Raspberry-Pi + RTLSDR -based device to serve airband radio on a network.
The present script installs RTLSDR-Airband, activates the Icecast2 server, and makes basic configurations.

I have created the script for these two reasons:

a. Create a record of how I reached a working configuration.

b. Be able to replicate the setup quickly. 

# Acknowledgements
The excellent RTLSDR-Airband is from Charlie-Foxtrot https://github.com/charlie-foxtrot/RTLSDR-Airband.
I am not the author of, nor a contributor to, RTLSDR-Airband.

# Instructions

## Copy repo to the target device (raspberry)

On the target device, in the command line, run:

`sudo curl -L -O https://github.com/martinkoschel/rtlsdr-airband-install-script/archive/main.zip`

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




## Running

`sudo /usr/local/bin/rtl_airband -f`

The Icecast server should start itself once it sees incoming data.

## Auto-Start on Boot

`sudo cp rtl_airband.service /etc/systemd/system`

`sudo chown root.root /etc/systemd/system/rtl_airband.service`

`sudo systemctl daemon-reload`

`sudo systemctl enable rtl_airband`

## Start, Stop, Restart the Service

`sudo systemctl start rtl_airband`

`sudo systemctl stop rtl_airband`

`sudo systemctl restart rtl_airband`


Check the logs to see what's going on: 

`journalctl -u rtl_airband`
