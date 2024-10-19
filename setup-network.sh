#!/bin/sh


sudo systemctl stop NetworkManager

sudo brctl addbr br0
sudo brctl addif br0 enp0s31f6
sudo ip link set dev br0 up
sudo ip addr flush br0
sudo ip addr add dev br0 192.168.32.120/24
sudo ip route add default via 192.168.32.1 dev br0 proto static metric 200
