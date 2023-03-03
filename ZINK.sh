echo "deb-src [signed-by="/usr/share/keyrings/debian-archive-keyring.gpg"] http://deb.debian.org/debian bullseye main contrib" >> /etc/apt/sources.list
echo "deb-src [signed-by="/usr/share/keyrings/debian-archive-keyring.gpg"] http://deb.debian.org/debian bullseye-updates main contrib" >> /etc/apt/sources.list
echo "deb-src [signed-by="/usr/share/keyrings/debian-archive-keyring.gpg"] http://security.debian.org/debian-security bullseye-security main contrib" >> /etc/apt/sources.list
apt update -y
cd ~
apt build-dep mesa -y
git clone https://github.com/mesa3d/mesa
git clone https://github.com/alexvorxx/Zink-Mesa-Xlib
cp /usr/include/libdrm/drm.h /usr/include/libdrm/drm_mode.h /usr/include
cd mesa
meson build -D platforms=x11,wayland -D gallium-drivers=swrast,virgl,zink -D vulkan-drivers=freedreno -D dri3=enabled  -D egl=enabled  -D gles2=enabled -D glvnd=true -D glx=dri  -D libunwind=disabled -D osmesa=true  -D shared-glapi=enabled -D microsoft-clc=disabled  -D valgrind=disabled --prefix /usr -D gles1=enabled -D freedreno-kgsl=true
ninja -C build install
cd ~
cd ~/Zink-Mesa-Xlib
meson . build -Dgallium-va=false -Ddri-drivers= -Dgallium-drivers=virgl,zink,swrast -Ddri3=true -Dvulkan-drivers= -Dglx=xlib -Dplatforms=x11 -Dbuildtype=release && ninja -C build install
cd ~
