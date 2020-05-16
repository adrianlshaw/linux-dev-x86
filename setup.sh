#!/usr/bin/env bash
set -e

command -v debootstrap >/dev/null 2>&1 || { echo >&2 "Install debootstrap.  Aborting."; exit 1; }

INSTALLDEB=/opt/buster
mkdir $INSTALLDEB
sudo debootstrap --arch=amd64 buster $INSTALLDEB && \
sudo sed -i '/^root/ { s/:x:/::/ }' $INSTALLDEB/etc/passwd && \
echo 'V0:23:respawn:/sbin/getty 115200 hvc0' | sudo tee -a $INSTALLDEB/etc/inittab && \
printf '\nauto eth0\niface eth0 inet dhcp\n' | sudo tee -a $INSTALLDEB/etc/network/interfaces && \
sudo mkdir $INSTALLDEB/root/.ssh/ && \
cat ~/.ssh/id_rsa.pub | sudo tee $INSTALLDEB/root/.ssh/authorized_keys

# Build a disk image
dd if=/dev/zero of=buster.img bs=1M seek=4095 count=1
mkfs.ext4 -F buster.img
sudo mkdir -p /mnt/buster
sudo mount -o loop buster.img /mnt/buster
sudo cp -a $INSTALLDEB/. /mnt/buster/.
sudo echo "mount -t securityfs securityfs /sys/kernel/security" >> /mnt/buster/root/.bashrc
sudo umount /mnt/buster
