pkg install x11-repo 
curl https://raw.githubusercontent.com/leem919/Proot-Setup-lite/main/virglrenderer-android_0.10.4.deb -O
dpkg -i virglrenderer-android_0.10.4.deb
rm virglrenderer-android_0.10.4.deb

echo 'alias gl="MESA_GLES_VERSION_OVERRIDE=3.1 virgl_test_server_android"' >> /data/data/com.termux/files/home/.bashrc
echo 'alias gl="GALLIUM_DRIVER=virpipe"' >> /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/root/.bashrc
