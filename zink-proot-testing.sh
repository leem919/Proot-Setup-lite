echo 'deb-src [signed-by="/usr/share/keyrings/ubuntu-archive-keyring.gpg"] http://ports.ubuntu.com/ubuntu-ports jammy main universe multiverse
deb-src [signed-by="/usr/share/keyrings/ubuntu-archive-keyring.gpg"] http://ports.ubuntu.com/ubuntu-ports jammy-updates main universe multiverse
deb-src [signed-by="/usr/share/keyrings/ubuntu-archive-keyring.gpg"] http://ports.ubuntu.com/ubuntu-ports jammy-security main universe multiverse' >> /etc/apt/sources.list
apt update -y
apt install -y software-properties-common dirmngr apt-transport-https wget git unzip libxcb-shm0 mesa-utils python3-pip software-properties-common dirmngr apt-transport-https python3-mako libxcb-shm0-dev libpciaccess-dev make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libxml2-dev graphviz doxygen xsltproc xmlto xutils-dev libxkbcommon-dev libvulkan1 mesa-vulkan-drivers vulkan-utils
apt build-dep mesa -y
mkdir ~/zpttmp
cd ~/zpttmp
git clone https://gitlab.freedesktop.org/glvnd/libglvnd
cd libglvnd
meson build
cd build
ninja install
cd ~/zpttmp
wget https://dri.freedesktop.org/libdrm/libdrm-2.4.115.tar.xz
tar -xf libdrm-2.4.115.tar.xz
cd libdrm-2.4.115
mkdir build
cd build
meson setup --prefix=$XORG_PREFIX \
            --buildtype=release   \
            -Dudev=true           \
            -Dvalgrind=disabled   \
            ..                    &&
ninja install
cd ~/zpttmp
git clone https://gitlab.freedesktop.org/mesa/mesa
cd mesa
meson build -D platforms=x11,wayland -D gallium-drivers=swrast,virgl,zink -D vulkan-drivers=freedreno -D dri3=enabled -D egl=enabled -D gles2=enabled -D glvnd=true -D glx=dri -D libunwind=disabled -D osmesa=true -D shared-glapi=enabled -D microsoft-clc=disabled -D valgrind=disabled --prefix /usr -D gles1=disabled -D freedreno-kmds=kgsl -Dbuildtype=release
cd build
ninja install
cd ~/zpttmp
git clone https://github.com/alexvorxx/Zink-Mesa-Xlib
cd Zink-Mesa-Xlib
meson . build -Dgallium-va=disabled -Dgallium-drivers=virgl,zink,swrast -Ddri3=disabled -Dvulkan-drivers= -Dglx=xlib -Dplatforms=x11 -Dbuildtype=release
cd build
ninja install
