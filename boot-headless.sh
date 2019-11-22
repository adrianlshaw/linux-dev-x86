echo "Use Ctrl A h to quit"
sleep 1

kvm -kernel arch/x86/boot/bzImage \
  -drive file=buster.img,if=virtio \
  -append 'root=/dev/vda console=hvc0' \
  -chardev stdio,id=stdio,mux=on,signal=off \
  -device virtio-serial-pci \
  -device virtconsole,chardev=stdio \
  -mon chardev=stdio \
  -display none
