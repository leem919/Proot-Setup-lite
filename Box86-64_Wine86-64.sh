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

sudo apt install -y libasound2:armhf libc6:armhf libglib2.0-0:armhf libgphoto2-6:armhf libgphoto2-port12:armhf libgstreamer-plugins-base1.0-0:armhf libgstreamer1.0-0:armhf libpcap0.8:armhf libpulse0:armhf libsane1:armhf libudev1:armhf libunwind8:armhf libusb-1.0-0:armhf libx11-6:armhf libxext6:armhf ocl-icd-libopencl1:armhf libopencl1:armhf ocl-icd-libopencl1:armhf libopencl-1.2-1:armhf libasound2-plugins:armhf libncurses6:armhf libcap2-bin:armhf libcups2:armhf libdbus-1-3:armhf libfontconfig1:armhf libfreetype6:armhf libglu1-mesa:armhf libglu1:armhf libgnutls30:armhf libgssapi-krb5-2:armhf libjpeg8:armhf libkrb5-3:armhf libodbc1:armhf libosmesa6:armhf libsdl2-2.0-0:armhf libv4l-0:armhf libxcomposite1:armhf libxcursor1:armhf libxfixes3:armhf libxi6:armhf libxinerama1:armhf libxrandr2:armhf libxrender1:armhf libxxf86vm1:armhf 

# sudo apt install -y libasound2:armhf libc6:armhf libglib2.0-0:armhf libgphoto2-6:armhf libgphoto2-port12:armhf libgstreamer-plugins-base1.0-0:armhf libgstreamer1.0-0:armhf libpcap0.8:armhf libpulse0:armhf libsane1:armhf libudev1:armhf libunwind8:armhf libusb-1.0-0:armhf libx11-6:armhf libxext6:armhf ocl-icd-libopencl1:armhf libopencl1:armhf ocl-icd-libopencl1:armhf libopencl-1.2-1:armhf libasound2-plugins:armhf libncurses6:armhf libcap2-bin:armhf libcups2:armhf libdbus-1-3:armhf libfontconfig1:armhf libfreetype6:armhf libglu1-mesa:armhf libglu1:armhf libgnutls30:armhf libgssapi-krb5-2:armhf libjpeg62-turbo:armhf libkrb5-3:armhf libodbc1:armhf libosmesa6:armhf libsdl2-2.0-0:armhf libv4l-0:armhf libxcomposite1:armhf libxcursor1:armhf libxfixes3:armhf libxi6:armhf libxinerama1:armhf libxrandr2:armhf libxrender1:armhf libxxf86vm1:armhf

# - These packages are needed for running box64/wine-amd64

sudo apt install -y libfreetype6-dev:armhf libfreetype-dev libasound2:arm64 libc6:arm64 libglib2.0-0:arm64 libgphoto2-6:arm64 libgphoto2-port12:arm64 libgstreamer-plugins-base1.0-0:arm64 libgstreamer1.0-0:arm64 libpcap0.8:arm64 libpulse0:arm64 libsane1:arm64 libudev1:arm64 libunwind8:arm64 libusb-1.0-0:arm64 libx11-6:arm64 libxext6:arm64 ocl-icd-libopencl1:arm64 libopencl1:arm64 ocl-icd-libopencl1:arm64 libopencl-1.2-1:arm64 libasound2-plugins:arm64 libncurses6:arm64 libcap2-bin:arm64 libcups2:arm64 libdbus-1-3:arm64 libfontconfig1:arm64 libfreetype6:arm64 libglu1-mesa:arm64 libglu1:arm64 libgnutls30:arm64 libgssapi-krb5-2:arm64 libjpeg8:arm64 libkrb5-3:arm64 libodbc1:arm64 libosmesa6:arm64 libsdl2-2.0-0:arm64 libv4l-0:arm64 libxcomposite1:arm64 libxcursor1:arm64 libxfixes3:arm64 libxi6:arm64 libxinerama1:arm64 libxrandr2:arm64 libxrender1:arm64 libxxf86vm1:arm64 

# sudo apt install -y libasound2:arm64 libc6:arm64 libglib2.0-0:arm64 libgphoto2-6:arm64 libgphoto2-port12:arm64 libgstreamer-plugins-base1.0-0:arm64 libgstreamer1.0-0:arm64 libpcap0.8:arm64 libpulse0:arm64 libsane1:arm64 libudev1:arm64 libunwind8:arm64 libusb-1.0-0:arm64 libx11-6:arm64 libxext6:arm64 ocl-icd-libopencl1:arm64 libopencl1:arm64 ocl-icd-libopencl1:arm64 libopencl-1.2-1:arm64 libasound2-plugins:arm64 libncurses6:arm64 libcap2-bin:arm64 libcups2:arm64 libdbus-1-3:arm64 libfontconfig1:arm64 libfreetype6:arm64 libglu1-mesa:arm64 libglu1:arm64 libgnutls30:arm64 libgssapi-krb5-2:arm64 libjpeg62-turbo:arm64 libkrb5-3:arm64 libodbc1:arm64 libosmesa6:arm64 libsdl2-2.0-0:arm64 libv4l-0:arm64 libxcomposite1:arm64 libxcursor1:arm64 libxfixes3:arm64 libxi6:arm64 libxinerama1:arm64 libxrandr2:arm64 libxrender1:arm64 libxxf86vm1:arm64


# Clean

sudo apt clean
sudo apt autoremove -y
sudo rm -rf ~/wine

# Install Box86

sudo wget https://ryanfortner.github.io/box86-debs/box86.list -O /etc/apt/sources.list.d/box86.list
wget -O- https://ryanfortner.github.io/box86-debs/KEY.gpg | sudo gpg --dearmor -o /usr/share/keyrings/box86-debs-archive-keyring.gpg
sudo apt update && sudo apt install box86-generic-arm -y

# Install Box64

sudo wget https://ryanfortner.github.io/box64-debs/box64.list -O /etc/apt/sources.list.d/box64.list
wget -O- https://ryanfortner.github.io/box64-debs/KEY.gpg | sudo gpg --dearmor -o /usr/share/keyrings/box64-debs-archive-keyring.gpg
sudo apt update && sudo apt install box64-generic-arm -y

# Wine-amd64

cd
mkdir ~/wine
cd ~/wine
wget https://github.com/leem919/Proot-Setup-lite/raw/main/winecx-22.1.0.tar.xz
tar -xvf *.tar.xz
mv ~/wine/wine*/* ~/wine
rm -rf wine*
cd

# Install symlinks
sudo ln -s ~/wine/bin/wine /usr/local/bin/wine
sudo ln -s ~/wine/bin/wine64 /usr/local/bin/wine64
sudo chmod +x /usr/local/bin/wine /usr/local/bin/wine64

#Install kernel32.dll fix
rm -rf ~/.wine
echo 'alias gst="export WINEDLLOVERRIDES="winegstreamer=""""' >> ~/.bashrc
