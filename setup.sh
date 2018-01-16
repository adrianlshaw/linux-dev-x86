INSTALLDEB=/opt/wheezy
mkdir $INSTALLDEB
debootstrap --arch=amd64 wheezy $INSTALLDEB && \
sed -i '/^root/ { s/:x:/::/ }' $INSTALLDEB/etc/passwd && \
echo 'V0:23:respawn:/sbin/getty 115200 hvc0' | tee -a $INSTALLDEB/etc/inittab && \
printf '\nauto eth0\niface eth0 inet dhcp\n' | tee -a $INSTALLDEB/etc/network/interfaces && \
mkdir $INSTALLDEB/root/.ssh/ && \
cat ~/.ssh/id_rsa.pub | tee $INSTALLDEB/root/.ssh/authorized_keys

# Build a disk image
dd if=/dev/zero of=wheezy.img bs=1M seek=4095 count=1
mkfs.ext4 -F wheezy.img
mkdir -p /mnt/wheezy
mount -o loop wheezy.img /mnt/wheezy
cp -a $INSTALLDEB/. /mnt/wheezy/.
umount /mnt/wheezy
