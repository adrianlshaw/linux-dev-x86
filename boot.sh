kvm -kernel arch/x86/boot/bzImage \
  -drive file=wheezy.img,if=virtio \
  -append root=/dev/vda \
