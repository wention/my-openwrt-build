#!/bin/sh

sudo chown libvirt-qemu:libvirt-qemu images/*.qcow2

sudo virt-install \
  --import \
  --name openwrt \
  --os-variant ubuntu22.04 \
  --vcpus 1 \
  --ram 1024 \
  --disk images/openwrt.qcow2 \
  --network bridge=br0 \
  --serial pty
