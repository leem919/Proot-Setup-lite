#!/bin/bash

apt update && apt upgrade -y
apt-get install sudo nano wget xterm dbus-x11 libxdamage1 libxfont2 x11-xkb-utils -y
wget https://versaweb.dl.sourceforge.net/project/tigervnc/stable/1.13.1/ubuntu-22.04LTS/arm64/tigervncserver_1.13.1-1ubuntu1_arm64.deb
dpkg -i tigervncserver_1.13.1-1ubuntu1_arm64.deb
rm tigervncserver_1.13.1-1ubuntu1_arm64.deb

apt clean && apt autoremove -y

mkdir ~/.vnc
echo '#!/bin/bash
xrdb $HOME/.Xresources
xterm' > ~/.vnc/xstartup

echo 'vncserver -name wine-proot -geometry 1024x576 -localhost no :1
termux-open-url vnc://127.0.0.1:5901' > /usr/local/bin/vnc-start

echo 'vncserver -kill :1' > /usr/local/bin/vnc-stop

echo 'box64 wine64 explorer /desktop=wine,1024x576 explorer' > /usr/local/bin/wine-desktop

echo 'source /usr/local/bin/vnc-start; source /usr/local/bin/wine-desktop; source /usr/local/bin/vnc-stop' > /usr/local/bin/wine-vnc

chmod +x ~/.vnc/xstartup
chmod +x /usr/local/bin/vnc-start
chmod +x /usr/local/bin/vnc-stop
chmod +x /usr/local/bin/wine-desktop
chmod +x /usr/local/bin/wine-vnc

echo "export DISPLAY=:1" >> /etc/profile
echo "export PULSE_SERVER=127.0.0.1" >> /etc/profile

source /etc/profile
