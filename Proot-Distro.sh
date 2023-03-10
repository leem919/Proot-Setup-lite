#!/bin/bash

apt update && apt upgrade -y
apt-get install sudo nano wget xterm dbus-x11 tigervnc-standalone-server -y

apt clean && apt autoremove -y

mkdir ~/.vnc
echo '#!/bin/bash
xrdb $HOME/.Xresources
xterm' > ~/.vnc/xstartup

echo 'vncserver -name wine-proot -geometry 960x540 -localhost no :1
termux-open-url vnc://127.0.0.1:5901' > /usr/local/bin/vnc-start

echo 'vncserver -kill :1' > /usr/local/bin/vnc-stop

echo 'box64 wine64 explorer /desktop=wine,960x540 explorer' > /usr/local/bin/wine-desktop

chmod +x ~/.vnc/xstartup
chmod +x /usr/local/bin/vnc-start
chmod +x /usr/local/bin/vnc-stop
chmod +x /usr/local/bin/wine-desktop

echo "export DISPLAY=:1" >> /etc/profile
echo "export PULSE_SERVER=127.0.0.1" >> /etc/profile

source /etc/profile

clear
