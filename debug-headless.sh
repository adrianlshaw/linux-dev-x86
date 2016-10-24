echo "Use Ctrl A h to quit"
sleep 2

tmux new-session -s asdf -n myWindow -d


tmux send-keys -t asdf:myWindow.0 "kvm -s -kernel arch/x86/boot/bzImage \
  -drive file=wheezy.img,if=virtio \
  -net nic,model=virtio,macaddr=52:54:00:12:34:56 \
  -net user,hostfwd=tcp:127.0.0.1:4444-:22 \
  -append 'root=/dev/vda console=hvc0' \
  -chardev stdio,id=stdio,mux=on,signal=off \
  -device virtio-serial-pci \
  -device virtconsole,chardev=stdio \
  -mon chardev=stdio \
  -display none" C-j

tmux split-window -h

tmux send-keys -t 1 '$PWD/start-gdb.sh && pkill tmux' C-j

tmux select-window -t asdf:mywindow

tmux attach -t asdf
