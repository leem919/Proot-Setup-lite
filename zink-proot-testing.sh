echo 'deb-src [signed-by="/usr/share/keyrings/ubuntu-archive-keyring.gpg"] http://ports.ubuntu.com/ubuntu-ports jammy main universe multiverse
deb-src [signed-by="/usr/share/keyrings/ubuntu-archive-keyring.gpg"] http://ports.ubuntu.com/ubuntu-ports jammy-updates main universe multiverse
deb-src [signed-by="/usr/share/keyrings/ubuntu-archive-keyring.gpg"] http://ports.ubuntu.com/ubuntu-ports jammy-security main universe multiverse' >> /etc/apt/sources.list
apt update -y
apt install wiggle dos2unix wget -y
apt build-dep mesa -y
cd
git clone --depth 1 -b mesa-22.3.0 https://gitlab.freedesktop.org/mesa/mesa.git
cd mesa
wget https://pastebin.com/raw/mi22qWN8
mv mi22qWN8 mesa20221011.patch
dos2unix mesa20221011.patch
git apply --reject --whitespace=fix mesa20221011.patch
wiggle --replace src/egl/main/egldisplay.h src/egl/main/egldisplay.h.rej
mkdir build
cd build
LDFLAGS='-l:libandroid-shmem.a -llog' meson .. -Dprefix=/usr/local -Dplatforms=x11 -Dgbm=enabled -Ddri-drivers='' -Dgallium-drivers=zink,swrast -Dllvm=enabled -Dvulkan-drivers='' -Dcpp_rtti=false -Dc_args=-Wno-error=incompatible-function-pointer-types -Dbuildtype=release
rm -rf $PREFIX/lib/libglapi.so* $PREFIX/lib/libGL.so*
ninja install
echo 'alias zink="GALLIUM_DRIVER=zink ZINK_DESCRIPTORS=lazy"' >> ~/.bashrc
