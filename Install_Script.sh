
# Install proot-distro

echo "allow-external-apps = true" >> ~/.termux/termux.properties
echo "hide-soft-keyboard-on-startup = true" >> ~/.termux/termux.properties


pkg clean && yes | pkg update && termux-setup-storage && 
pkg install nano wget proot-distro pulseaudio -y && pkg clean &&
proot-distro install ubuntu &&
proot-distro clear-cache &&
echo 'pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1' >> ~/.bashrc &&        
echo 'proot-distro login ubuntu --shared-tmp --no-sysvipc' >> ~/.bashrc &&
source ~/.bashrc

# Install awesome 

wget https://raw.githubusercontent.com/leem919/Proot-Setup-lite/main/Proot-Distro.sh &&
chmod +x Proot-Distro.sh &&
./Proot-Distro.sh

# Install box86/box64

wget https://raw.githubusercontent.com/ThieuMinh26/Proot-Setup/main/Box86-64_Wine86-64.sh && 
chmod +x Box86-64_Wine86-64.sh && 
./Box86-64_Wine86-64.sh


# Kernel32.dll fix

wget https://raw.githubusercontent.com/ThieuMinh26/Proot-Setup/main/Kernel32.dll-fix.sh &&
chmod +x Kernel32.dll-fix.sh &&
./Kernel32.dll-fix.sh
