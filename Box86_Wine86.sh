#!/bin/bash

# Enable Multiarch

sudo dpkg --add-architecture armhf
sudo apt update -y
sudo apt upgrade -y

# Install related kits 

sudo apt install -y gpg xz-utils 

# OpenGL

sudo apt install -y libgl1:armhf libgl1:arm64

# - These packages are needed for running box86/wine-i386 

sudo apt install -y libfreetype6-dev:armhf libfreetype-dev libasound2:armhf libc6:armhf libglib2.0-0:armhf libgphoto2-6:armhf libgphoto2-port12:armhf libgstreamer-plugins-base1.0-0:armhf libgstreamer1.0-0:armhf libpcap0.8:armhf libpulse0:armhf libsane1:armhf libudev1:armhf libunwind8:armhf libusb-1.0-0:armhf libx11-6:armhf libxext6:armhf ocl-icd-libopencl1:armhf libopencl1:armhf ocl-icd-libopencl1:armhf libopencl-1.2-1:armhf libasound2-plugins:armhf libncurses6:armhf libcap2-bin:armhf libcups2:armhf libdbus-1-3:armhf libfontconfig1:armhf libfreetype6:armhf libglu1-mesa:armhf libglu1:armhf libgnutls30:armhf libgssapi-krb5-2:armhf libjpeg8:armhf libkrb5-3:armhf libodbc1:armhf libosmesa6:armhf libsdl2-2.0-0:armhf libv4l-0:armhf libxcomposite1:armhf libxcursor1:armhf libxfixes3:armhf libxi6:armhf libxinerama1:armhf libxrandr2:armhf libxrender1:armhf libxxf86vm1:armhf 

# sudo apt install -y libasound2:armhf libc6:armhf libglib2.0-0:armhf libgphoto2-6:armhf libgphoto2-port12:armhf libgstreamer-plugins-base1.0-0:armhf libgstreamer1.0-0:armhf libpcap0.8:armhf libpulse0:armhf libsane1:armhf libudev1:armhf libunwind8:armhf libusb-1.0-0:armhf libx11-6:armhf libxext6:armhf ocl-icd-libopencl1:armhf libopencl1:armhf ocl-icd-libopencl1:armhf libopencl-1.2-1:armhf libasound2-plugins:armhf libncurses6:armhf libcap2-bin:armhf libcups2:armhf libdbus-1-3:armhf libfontconfig1:armhf libfreetype6:armhf libglu1-mesa:armhf libglu1:armhf libgnutls30:armhf libgssapi-krb5-2:armhf libjpeg62-turbo:armhf libkrb5-3:armhf libodbc1:armhf libosmesa6:armhf libsdl2-2.0-0:armhf libv4l-0:armhf libxcomposite1:armhf libxcursor1:armhf libxfixes3:armhf libxi6:armhf libxinerama1:armhf libxrandr2:armhf libxrender1:armhf libxxf86vm1:armhf


# Clean

sudo apt clean
sudo apt autoremove -y
sudo rm -rf ~/wine

# Install Box86

cd
apt install make cmake python3 git libc6:armhf libstdc++6:armhf gcc-arm-linux-gnueabihf -y
git clone https://github.com/ptitSeb/box86
cd box86; mkdir build; cd build
cmake .. -DRPI4ARM64=1 -DARM_DYNAREC=ON -DBAD_SIGNAL=ON -DCMAKE_BUILD_TYPE=RelWithDebInfo
make -j$(nproc)
make install
cd
rm -rf box86

# Wine-i386

cd
mkdir ~/wine
cd ~/wine
wget https://www.playonlinux.com/wine/binaries/phoenicis/cx-linux-x86/PlayOnLinux-winecx-21.0.0-cx-linux-x86.tar.gz
tar -xvf *.tar.gz
mv ~/wine/wine*/* ~/wine
rm -rf wine*
cd

# Install symlinks
sudo ln -s ~/wine/bin/wine /usr/local/bin/wine
sudo chmod +x /usr/local/bin/wine

#Install kernel32.dll fix
cd
rm -rf ~/.wine
rm -rf ~/wine-8.0.tar.xz
wget https://github.com/ThieuMinh26/Proot-Setup/releases/download/1.0.0/wine-8.0.tar.xz
tar -xf wine-8.0.tar.xz
echo 'alias gst="WINEDLLOVERRIDES=\"winegstreamer=\""' >> ~/.bashrc

clear
