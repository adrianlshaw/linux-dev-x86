qemu-system-x86_64 --enable-kvm -kernel linux/arch/x86/boot/bzImage \
  -drive file=buster.img,if=virtio \
  -append root=/dev/vda \
