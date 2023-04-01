pkg install x11-repo -y
pkg install virglrenderer-android -y

echo 'MESA_NO_ERROR=1 MESA_GL_VERSION_OVERRIDE=4.3COMPAT MESA_GLES_VERSION_OVERRIDE=3.2 virgl_test_server_android &' >> /data/data/com.termux/files/home/.bashrc
echo 'export MESA_NO_ERROR=1 MESA_GL_VERSION_OVERRIDE=3.3COMPAT GALLIUM_DRIVER=virpipe WINEDEBUG=-all' >> /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/root/.bashrc
