echo 'deb-src [signed-by="/usr/share/keyrings/ubuntu-archive-keyring.gpg"] http://ports.ubuntu.com/ubuntu-ports jammy main universe multiverse' >> /etc/apt/sources.list
echo 'deb-src [signed-by="/usr/share/keyrings/ubuntu-archive-keyring.gpg"] http://ports.ubuntu.com/ubuntu-ports jammy-updates main universe multiverse' >> /etc/apt/sources.list
echo 'deb-src [signed-by="/usr/share/keyrings/ubuntu-archive-keyring.gpg"] http://ports.ubuntu.com/ubuntu-ports jammy-security main universe multiverse' >> /etc/apt/sources.list
apt update -y
apt build-dep mesa -y
cp /usr/include/libdrm/* /usr/include
cd
git clone https://github.com/Heasterian/mesa
wget https://github.com/alexvorxx/Zink-Mesa-Xlib/archive/refs/tags/v0.0.1-alpha.zip
unzip v0.0.1-alpha.zip
rm v0.0.1-alpha.zip
cd mesa
meson build -D platforms=x11,wayland -D gallium-drivers=swrast,virgl,zink -D vulkan-drivers=freedreno -D dri3=enabled -D egl=enabled -D gles2=enabled -D glvnd=true -D glx=dri -D libunwind=disabled -D osmesa=true -D shared-glapi=enabled -D microsoft-clc=disabled -D valgrind=disabled --prefix /usr -D gles1=disabled -D freedreno-kgsl=true -Dbuildtype=release
cd build
ninja install
cd
cd Zink-Mesa-Xlib-0.0.1-alpha
meson build -Dgallium-va=disabled -Dgallium-drivers=virgl,zink,swrast -Ddri3=disabled -Dvulkan-drivers= -Dglx=xlib -Dplatforms=x11 -Dbuildtype=release
cd build
ninja install
echo 'export GALLIUM_DRIVER=zink ZINK_DESCRIPTORS=lazy ZINK_DEBUG=compact' >> ~/.bashrc
