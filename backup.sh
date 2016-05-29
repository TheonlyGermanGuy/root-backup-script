#!/bin/bash

echo "Starting tunnel"

killall itnl

itnl --iport 22 --lport 2222 &>/dev/null &

echo
echo "1. backup root"
echo "2. restore root"
echo
read -p "Choose: " choice

case $choice in

1)
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@localhost -p 2222 'dd if=/dev/rdisk0s1s1 bs=4096' 2>&1 | pv --wait | dd of=rdisk0s1s1
;;

2)
dd if=rdisk0s1s1 bs=4096 | pv --wait | ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@localhost -p 2222 'dd of=/dev/rdisk0s1s1 bs=4096'
;;

esac

killall itnl
