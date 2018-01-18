#!/bin/bash

./boot-headless-network.sh > /dev/null 2>&1  &
sleep 6
ssh root@127.0.0.1 -p 4444  -o StrictHostKeyChecking=no -t "echo hello"
exit $?
