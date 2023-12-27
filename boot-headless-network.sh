echo "Use Ctrl A h to quit"
sleep 2

qemu-system-x86_64 --enable-kvm -kernel linux/arch/x86/boot/bzImage -append 'root=/dev/sda rw console=ttyS0 net.ifnames=0 biosdevname=0' -nographic \
-netdev user,id=user.0 -device e1000,netdev=user.0 \
buster.img
#  -net nic,model=virtio,macaddr=52:54:00:12:34:56 \
#  -net user,hostfwd=tcp:127.0.0.1:4444-:22 \

