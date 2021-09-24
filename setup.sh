#!/usr/bin/env bash
set -ex

DEBVERSION="buster"

wget https://ftp-master.debian.org/keys/release-10.asc -qO- | gpg --import --no-default-keyring --keyring ./debian-release-10.gpg

command -v debootstrap >/dev/null 2>&1 || { echo >&2 "Install debootstrap.  Aborting."; exit 1; }

INSTALLDEB=/opt/$DEBVERSION
mkdir $INSTALLDEB
sudo debootstrap --keyring=./debian-release-10.gpg --arch=amd64 $DEBVERSION $INSTALLDEB && \
sudo sed -i '/^root/ { s/:x:/::/ }' $INSTALLDEB/etc/passwd && \
echo 'V0:23:respawn:/sbin/getty 115200 hvc0' | sudo tee -a $INSTALLDEB/etc/inittab && \
printf '\nauto eth0\niface eth0 inet dhcp\n' | sudo tee -a $INSTALLDEB/etc/network/interfaces && \
sudo mkdir $INSTALLDEB/root/.ssh/ && \
cat ~/.ssh/id_rsa.pub | sudo tee $INSTALLDEB/root/.ssh/authorized_keys

# Build a disk image
dd if=/dev/zero of=$DEBVERSION.img bs=1M seek=4095 count=1
mkfs.ext4 -F $DEBVERSION.img
sudo mkdir -p /mnt/$DEBVERSION
sudo mount -o loop $DEBVERSION.img /mnt/$DEBVERSION
sudo cp -a $INSTALLDEB/. /mnt/$DEBVERSION/.
sudo echo "mount -t securityfs securityfs /sys/kernel/security" >> /mnt/$DEBVERSION/root/.bashrc
sudo umount /mnt/$DEBVERSION
