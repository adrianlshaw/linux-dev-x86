kvm -kernel arch/x86/boot/bzImage \
  -drive file=wheezy.img,if=virtio \
  -append root=/dev/vda \
  -net nic,model=virtio,macaddr=52:54:00:12:34:56 \
  -net user,hostfwd=tcp:127.0.0.1:4444-:22 \
