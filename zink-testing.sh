pkg install -y x11-repo; 
pkg install -y clang lld binutils cmake autoconf automake libtool ndk-sysroot ndk-multilib make python git libandroid-shmem-static vulkan-tools vulkan-loader vulkan-loader-android vulkan-extension-layer ninja llvm bison flex libx11 xorgproto libdrm libpixman libxfixes libjpeg-turbo xtrans libxxf86vm xorg-xrandr xorg-font-util xorg-util-macros libxfont2 libxkbfile libpciaccess xcb-util-renderutil xcb-util-image xcb-util-keysyms xcb-util-wm xorg-xkbcomp xkeyboard-config libxdamage libxinerama;
pip install meson mako;
mkdir ~/tmp;
cd ~/tmp;
LD_PRELOAD='' git clone --depth 1 -b libxshmfence-1.3 https://gitlab.freedesktop.org/xorg/lib/libxshmfence.git;
LD_PRELOAD='' git clone --depth 1 -b mesa-22.3.0 https://gitlab.freedesktop.org/mesa/mesa.git
LD_PRELOAD='' git clone --depth 1 -b 1.5.10 https://github.com/anholt/libepoxy.git;
curl https://gitlab.freedesktop.org/virgl/virglrenderer/-/archive/0.10.4/virglrenderer-0.10.4.zip -O
unzip virglrenderer-0.10.4.zip
mv virglrenderer-0.10.4 virglrenderer
rm virglrenderer-0.10.4.zip
cd ~/tmp/libxshmfence;
./autogen.sh --prefix=$PREFIX --with-shared-memory-dir=$TMPDIR;
sed -i s/values.h/limits.h/ ./src/xshmfence_futex.h;
make -j8 install CPPFLAGS=-DMAXINT=INT_MAX;
cd ~/tmp/mesa-turnip-kgsl;
sed -i '40s+^$+#include "X11/Xlib.h"+' src/egl/main/egldisplay.h;
sed -i 's/^import os$/import os, shutil\ndef link(src, dest):\n shutil.copyfile(src, dest)\ndef unlink(src):\n os.remove(src)\nos.link = link\nos.unlink = unlink/' bin/install_megadrivers.py;
mkdir b;
cd b;
LDFLAGS='-l:libandroid-shmem.a -llog' meson .. -Dprefix=$PREFIX -Dplatforms=x11 -Dgbm=enabled -Ddri-drivers='' -Dgallium-drivers=zink,swrast -Dllvm=disabled -Dvulkan-drivers='' -Dcpp_rtti=false -Dc_args=-Wno-error=incompatible-function-pointer-types -Dbuildtype=release;
rm $PREFIX/lib/libglapi.so*;
rm $PREFIX/lib/libGL.so*;
rm $PREFIX/lib/libGLES*;
rm $PREFIX/lib/libEGL*;
rm $PREFIX/lib/libgbm*;
ninja install;
cd ~/tmp/libepoxy;
mkdir b;
cd b;
meson -Dprefix=$PREFIX -Dbuildtype=release -Dglx=yes -Degl=yes -Dtests=false -Dc_args=-U__ANDROID__ ..;
rm $PREFIX/lib/libepoxy.so*;
ninja install;
cd ~/tmp/virglrenderer;
git checkout -f dd301caf7e05ec9c09634fb7872067542aad89b7~2;
sed -i 's+"/tmp+"/data/data/com.termux/files/usr/tmp+' vtest/vtest_protocol.h;
mkdir b;
cd b;
meson -Dbuildtype=release -Dprefix=$PREFIX -Dplatforms=egl ..;
ninja install;
cd

echo 'alias zink="ZINK_DESCRIPTORS=lazy MESA_NO_ERROR=1 MESA_GL_VERSION_OVERRIDE=3.3 GALLIUM_DRIVER=zink virgl_test_server --use-egl-surfaceless"' >> /data/data/com.termux/files/home/.bashrc
echo 'alias zink="WINEDEBUG=-all MESA_NO_ERROR=1 MESA_GL_VERSION_OVERRIDE=3.3 GALLIUM_DRIVER=virpipe"' >> /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/root/.bashrc
