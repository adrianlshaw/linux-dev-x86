echo "Use Ctrl A h to quit"
sleep 2

kvm -kernel arch/x86/boot/bzImage \
  -drive file=buster.img,if=virtio \
  -net nic,model=virtio,macaddr=52:54:00:12:34:56 \
  -net user,hostfwd=tcp:127.0.0.1:4444-:22 \
  -append 'root=/dev/vda console=hvc0' \
  -chardev stdio,id=stdio,mux=on,signal=off \
  -device virtio-serial-pci \
  -device virtconsole,chardev=stdio \
  -mon chardev=stdio \
  -display none
