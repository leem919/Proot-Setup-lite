
# Install proot-distro

echo "allow-external-apps = true" >> ~/.termux/termux.properties
echo "hide-soft-keyboard-on-startup = true" >> ~/.termux/termux.properties

termux-setup-storage
pkg clean && yes | pkg update &&
pkg install nano wget proot-distro pulseaudio -y && pkg clean &&
proot-distro install ubuntu &&
proot-distro clear-cache &&
echo 'pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1' >> ~/.bashrc &&        
echo 'proot-distro login ubuntu --shared-tmp --no-sysvipc' >> ~/.bashrc &&
source ~/.bashrc

# Install proot 

wget https://raw.githubusercontent.com/leem919/Proot-Setup-lite/cx-testing/Proot-Distro.sh &&
chmod +x Proot-Distro.sh &&
./Proot-Distro.sh

# Install box86/box64

wget https://raw.githubusercontent.com/leem919/Proot-Setup-lite/cx-tesing/Box86_Wine86.sh && 
chmod +x Box86_Wine86.sh && 
./Box86_Wine86.sh

echo "Restart Termux, and then run vnc-start to open the vnc server, and vnc-stop to close it. Once logged into vnc, run wine-desktop to start it up. If it fails, delete ~/.wine and try running gst wine-desktop instead."
