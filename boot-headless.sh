echo "Use Ctrl A h to quit"
sleep 1

qemu-system-x86_64 -enable-kvm -kernel arch/x86/boot/bzImage \
  -drive file=wheezy.img,if=virtio \
  -append 'root=/dev/vda console=hvc0' \
  -chardev stdio,id=stdio,mux=on,signal=off \
  -device virtio-serial-pci \
  -device virtconsole,chardev=stdio \
  -mon chardev=stdio \
  -display none
