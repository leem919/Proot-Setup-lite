cd
pkg install x11-repo clang lld binutils cmake autoconf automake libtool ndk-sysroot ndk-multilib make python git libandroid-shmem-static vulkan-tools vulkan-loader vulkan-loader-android vulkan-extension-layer ninja llvm bison flex libx11 xorgproto libdrm libpixman libxfixes libjpeg-turbo xtrans libxxf86vm xorg-xrandr xorg-font-util xorg-util-macros libxfont2 libxkbfile libpciaccess xcb-util-renderutil xcb-util-image xcb-util-keysyms xcb-util-wm xorg-xkbcomp xkeyboard-config libxdamage libxinerama -y
pip install meson mako
curl https://raw.githubusercontent.com/leem919/Proot-Setup-lite/main/virglrenderer-android_0.10.4.deb -O
dpkg -i virglrenderer-android_0.10.4.deb
rm virglrenderer-android_0.10.4.deb
LD_PRELOAD='' git clone --depth 1 -b mesa-22.0.5 https://gitlab.freedesktop.org/mesa/mesa.git
LD_PRELOAD='' git clone --depth 1 -b libxshmfence-1.3 https://gitlab.freedesktop.org/xorg/lib/libxshmfence.git
LD_PRELOAD='' git clone --depth 1 -b mesa-22.0.5 https://gitlab.freedesktop.org/mesa/mesa.git
cd libxshmfence
./autogen.sh --prefix=$PREFIX --with-shared-memory-dir=$TMPDIR;
sed -i s/values.h/limits.h/ ./src/xshmfence_futex.h;
make -j8 install CPPFLAGS=-DMAXINT=INT_MAX;
cd
cd mesa
sed -i '40s+^$+#include "X11/Xlib.h"+' src/egl/main/egldisplay.h;
sed -i 's/^import os$/import os, shutil\ndef link(src, dest):\n shutil.copyfile(src, dest)\ndef unlink(src):\n os.remove(src)\nos.link = link\nos.unlink = unlink/' bin/install_megadrivers.py;
mkdir build
cd build
LDFLAGS='-l:libandroid-shmem.a -llog' meson .. -Dprefix=$PREFIX -Dplatforms=x11 -Dgbm=enabled -Ddri-drivers='' -Dgallium-drivers=zink,swrast -Dllvm=disabled -Dvulkan-drivers='' -Dcpp_rtti=false -Dc_args=-Wno-error=incompatible-function-pointer-types -Dbuildtype=release
rm $PREFIX/lib/libglapi.so*
rm $PREFIX/lib/libGL.so*
rm $PREFIX/lib/libGLES*
rm $PREFIX/lib/libEGL*
rm $PREFIX/lib/libgbm*
ninja install


echo 'alias gl="virgl_test_server_android"' >> /data/data/com.termux/files/home/.bashrc
echo 'alias gl="GALLIUM_DRIVER=virpipe"' >> /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/root/.bashrc
