
# Install proot-distro

echo "allow-external-apps = true" >> ~/.termux/termux.properties
echo "hide-soft-keyboard-on-startup = true" >> ~/.termux/termux.properties

termux-setup-storage
pkg clean && yes | pkg update &&
pkg install nano wget proot-distro pulseaudio -y && pkg clean &&
proot-distro install ubuntu &&
proot-distro clear-cache &&

mkdir ~/.shortcuts
echo 'pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1' >> ~/.shortcuts/login-ubuntu &&
echo 'proot-distro login ubuntu --shared-tmp --no-sysvipc' >> ~/.shortcuts/login-ubuntu &&
echo 'alias ubuntu="source ~/.shortcuts/login-ubuntu"' >> ~/.bashrc

source ~/.shortcuts/login-ubuntu

# Install proot 

curl https://raw.githubusercontent.com/leem919/Proot-Setup-lite/main/Proot-Distro.sh | bash

# Install box86 and box64

curl https://raw.githubusercontent.com/leem919/Proot-Setup-lite/main/Box86-64_Wine86-64.sh | bash

echo "SCRIPT COMPLETE"
echo "First restart Termux, and then run 'ubuntu' to log into the proot.
Commands in proot:
vnc-start: starts the vnc server
vnc-stop: stops the vnc server
wine-desktop: starts the wine desktop on display 1
wine-vnc: starts the vnc server and then wine, the vnc server stops when wine is closed"