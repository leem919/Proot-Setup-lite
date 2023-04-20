#!/bin/bash

# Enable Multiarch

sudo dpkg --add-architecture armhf
sudo apt update -y
sudo apt upgrade -y

# Install related kits 

sudo apt install -y gpg xz-utils make cmake python3 git libc6:armhf libstdc++6:armhf gcc-arm-linux-gnueabihf

# OpenGL

sudo apt install -y libgl1:armhf libgl1:arm64

# - These packages are needed for running box64/wine-amd64

sudo apt install -y libfreetype6-dev:armhf libfreetype-dev libasound2:arm64 libc6:arm64 libglib2.0-0:arm64 libgphoto2-6:arm64 libgphoto2-port12:arm64 libgstreamer-plugins-base1.0-0:arm64 libgstreamer1.0-0:arm64 libpcap0.8:arm64 libpulse0:arm64 libsane1:arm64 libudev1:arm64 libunwind8:arm64 libusb-1.0-0:arm64 libx11-6:arm64 libxext6:arm64 ocl-icd-libopencl1:arm64 libopencl1:arm64 ocl-icd-libopencl1:arm64 libopencl-1.2-1:arm64 libasound2-plugins:arm64 libncurses6:arm64 libcap2-bin:arm64 libcups2:arm64 libdbus-1-3:arm64 libfontconfig1:arm64 libfreetype6:arm64 libglu1-mesa:arm64 libglu1:arm64 libgnutls30:arm64 libgssapi-krb5-2:arm64 libjpeg8:arm64 libkrb5-3:arm64 libodbc1:arm64 libosmesa6:arm64 libsdl2-2.0-0:arm64 libv4l-0:arm64 libxcomposite1:arm64 libxcursor1:arm64 libxfixes3:arm64 libxi6:arm64 libxinerama1:arm64 libxrandr2:arm64 libxrender1:arm64 libxxf86vm1:arm64 

# sudo apt install -y libasound2:arm64 libc6:arm64 libglib2.0-0:arm64 libgphoto2-6:arm64 libgphoto2-port12:arm64 libgstreamer-plugins-base1.0-0:arm64 libgstreamer1.0-0:arm64 libpcap0.8:arm64 libpulse0:arm64 libsane1:arm64 libudev1:arm64 libunwind8:arm64 libusb-1.0-0:arm64 libx11-6:arm64 libxext6:arm64 ocl-icd-libopencl1:arm64 libopencl1:arm64 ocl-icd-libopencl1:arm64 libopencl-1.2-1:arm64 libasound2-plugins:arm64 libncurses6:arm64 libcap2-bin:arm64 libcups2:arm64 libdbus-1-3:arm64 libfontconfig1:arm64 libfreetype6:arm64 libglu1-mesa:arm64 libglu1:arm64 libgnutls30:arm64 libgssapi-krb5-2:arm64 libjpeg62-turbo:arm64 libkrb5-3:arm64 libodbc1:arm64 libosmesa6:arm64 libsdl2-2.0-0:arm64 libv4l-0:arm64 libxcomposite1:arm64 libxcursor1:arm64 libxfixes3:arm64 libxi6:arm64 libxinerama1:arm64 libxrandr2:arm64 libxrender1:arm64 libxxf86vm1:arm64


# Clean

sudo apt clean
sudo apt autoremove -y
sudo rm -rf ~/wine

# Install Box64

cd
git clone https://github.com/ptitSeb/box64
cd box64; mkdir build; cd build
cmake .. -DARM_DYNAREC=1 -DBAD_SIGNAL=1 -DCMAKE_BUILD_TYPE=RelWithDebInfo
make -j$(nproc)
make install
cd
rm -rf box64

# Wine-amd64

cd
mkdir ~/wine
cd ~/wine
wget https://github.com/Kron4ek/Wine-Builds/releases/download/8.6/wine-8.6-amd64.tar.xz
tar -xvf *.tar.xz
mv ~/wine/wine*/* ~/wine
rm -rf wine*
cd

# Install symlinks
sudo ln -s ~/wine/bin/wine64 /usr/local/bin/wine64
sudo chmod +x /usr/local/bin/wine64

#Install kernel32.dll fix
echo 'alias gst="export WINEDLLOVERRIDES="winegstreamer=""""' >> ~/.bashrc
