
# Install proot-distro

echo "allow-external-apps = true" >> ~/.termux/termux.properties
echo "hide-soft-keyboard-on-startup = true" >> ~/.termux/termux.properties

termux-setup-storage
pkg clean && yes | pkg update &&
pkg install nano wget proot-distro pulseaudio -y && pkg clean &&
proot-distro install ubuntu &&
proot-distro clear-cache &&

echo 'pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1' >> ~/.shortcuts/login-ubuntu &&
echo 'proot-distro login ubuntu --shared-tmp --no-sysvipc' >> ~/.shortcuts/login-ubuntu &&
echo 'alias ubuntu="source ~/.shortcuts/login-ubuntu"' >> ~/.bashrc

source ~/.shortcuts/login-ubuntu

# Install proot 

curl https://raw.githubusercontent.com/leem919/Proot-Setup-lite/main/Proot-Distro.sh | bash

# Install box86/box64

curl https://raw.githubusercontent.com/leem919/Proot-Setup-lite/main/Box86-64_Wine86-64.sh | bash

echo "DONE"
echo "Restart Termux, and then run ubuntu to login to the proot. In the proot, run vnc-start to open the vnc server, and vnc-stop to close it. Once logged into vnc, run wine-desktop to start it up. You can run both at once with wine-vnc"
