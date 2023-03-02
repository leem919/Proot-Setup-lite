#!/bin/bash

apt update && apt upgrade -y
apt-get install sudo nano wget dbus-x11 awesome tigervnc-standalone-server -y

apt clean && apt autoremove -y

echo 'vncserver -name remote-desktop -geometry 960x540 -localhost no :1' > /usr/local/bin/vnc-start

echo 'vncserver -kill :1' > /usr/local/bin/vnc-stop

chmod +x /usr/local/bin/vnc-start
chmod +x /usr/local/bin/vnc-stop

echo "export DISPLAY=:1" >> /etc/profile
echo "export PULSE_SERVER=127.0.0.1" >> /etc/profile

source /etc/profile

clear