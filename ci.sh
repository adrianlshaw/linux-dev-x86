#!/bin/bash
echo "Starting the VM"
./boot-headless-network.sh > /dev/null 2>&1  &
sleep 6
echo "Testing the network"
ssh root@127.0.0.1 -p 4444  -o StrictHostKeyChecking=no -t "echo hello"
exit $?
