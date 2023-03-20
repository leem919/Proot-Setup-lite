pkg install x11-repo 
pkg install virglrenderer-android

echo 'alias gl="MESA_NO_ERROR=1 MESA_GLES_VERSION_OVERRIDE=3.2 virgl_test_server_android &"' >> /data/data/com.termux/files/home/.bashrc
echo 'alias gl="MESA_NO_ERROR=1 MESA_GL_VERSION_OVERRIDE=4.4COMPAT GALLIUM_DRIVER=virpipe"' >> /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/root/.bashrc
