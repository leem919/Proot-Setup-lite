echo "deb-src [signed-by="/usr/share/keyrings/ubuntu-archive-keyring.gpg"] http://ports.ubuntu.com/ubuntu-ports jammy main universe multiverse" >> /etc/apt/sources.list
apt update -y
apt build-dep mesa -y
cd ~
git clone https://github.com/mesa3d/mesa
git clone https://github.com/alexvorxx/Zink-Mesa-Xlib
cp /usr/include/libdrm/drm.h /usr/include/libdrm/drm_mode.h /usr/include
cd ~/mesa
meson build -D platforms=x11,wayland -D gallium-drivers=swrast,virgl,zink -D vulkan-drivers=freedreno -D dri3=enabled  -D egl=enabled  -D gles2=enabled -D glvnd=true -D glx=dri  -D libunwind=disabled -D osmesa=true  -D shared-glapi=enabled -D microsoft-clc=disabled  -D valgrind=disabled --prefix /usr -D gles1=enabled -D freedreno-kgsl=true
ninja -C build install
cd ~/Zink-Mesa-Xlib
meson . build -Dgallium-va=disabled -Ddri-drivers= -Dgallium-drivers=virgl,zink,swrast -Ddri3=true -Dvulkan-drivers= -Dglx=xlib -Dplatforms=x11 -Dbuildtype=release
ninja -C build install
cd ~
