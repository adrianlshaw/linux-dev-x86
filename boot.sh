qemu-system-x86_64 -kernel arch/x86/boot/bzImage \
  -drive file=wheezy.img,if=virtio \
  -append root=/dev/vda \
