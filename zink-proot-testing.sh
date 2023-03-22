echo 'deb-src [signed-by="/usr/share/keyrings/ubuntu-archive-keyring.gpg"] http://ports.ubuntu.com/ubuntu-ports jammy main universe multiverse
deb-src [signed-by="/usr/share/keyrings/ubuntu-archive-keyring.gpg"] http://ports.ubuntu.com/ubuntu-ports jammy-updates main universe multiverse
deb-src [signed-by="/usr/share/keyrings/ubuntu-archive-keyring.gpg"] http://ports.ubuntu.com/ubuntu-ports jammy-security main universe multiverse' >> /etc/apt/sources.list
apt update -y
