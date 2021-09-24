qemu-system-x86_64 --enable-kvm \
	-kernel arch/x86/boot/bzImage \
	-append 'root=/dev/sda rw console=ttyS0 net.ifnames=0 biosdevname=0' \
	-nographic \
	-netdev user,id=user.0 -device e1000,netdev=user.0 \
	buster.img
