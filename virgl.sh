pkg install x11-repo -y
pkg install virglrenderer-android -y

echo 'virgl_test_server_android &' >> /data/data/com.termux/files/home/.bashrc
echo 'export GALLIUM_DRIVER=virpipe' >> /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/root/.bashrc
echo 'alias gl4="MESA_GL_VERSION_OVERRIDE=4.0"' >> /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/root/.bashrc
echo "Restart Termux to apply the changes, and use 'gl4' before a command or program to use MESA_GL_VERSION_OVERRIDE 4.0."
