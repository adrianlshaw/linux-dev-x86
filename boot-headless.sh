echo "Use Ctrl A h to quit"
sleep 1

qemu-system-x86_64 --enable-kvm -kernel linux/arch/x86/boot/bzImage -append 'root=/dev/sda console=ttyS0' -nographic buster.img
