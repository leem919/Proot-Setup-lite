echo 'deb-src [signed-by="/usr/share/keyrings/ubuntu-archive-keyring.gpg"] http://ports.ubuntu.com/ubuntu-ports jammy main universe multiverse
deb-src [signed-by="/usr/share/keyrings/ubuntu-archive-keyring.gpg"] http://ports.ubuntu.com/ubuntu-ports jammy-updates main universe multiverse
deb-src [signed-by="/usr/share/keyrings/ubuntu-archive-keyring.gpg"] http://ports.ubuntu.com/ubuntu-ports jammy-security main universe multiverse' >> /etc/apt/sources.list
apt update -y
apt build-dep mesa -y
cd
git clone --depth 1 -b mesa-22.3.0 https://gitlab.freedesktop.org/mesa/mesa.git
cd mesa
mkdir build
cd build
meson .. -Dprefix=/usr/local -Dplatforms=x11 -Dgbm=enabled -Ddri-drivers='' -Dgallium-drivers=zink,swrast -Dllvm=disabled -Dvulkan-drivers='' -Dcpp_rtti=false -Dc_args=-Wno-error=incompatible-pointer-types -Dbuildtype=release
rm -rf /usr/local/lib/libglapi.so* /usr/local/lib/libGL.so*
ninja install
echo 'alias zink="GALLIUM_DRIVER=zink ZINK_DESCRIPTORS=lazy"' >> ~/.bashrc
