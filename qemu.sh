#!/bin/sh

BASEDIR=$(realpath $(dirname $0))

#rm -f openwrt.qcow2
#qemu-img create -f qcow2 -b /home/wention/Git/lede/bin/targets/x87/64/openwrt-x86-64-generic-squashfs-combined-efi.qcow2 -F qcow2 openwrt.qcow2



sudo qemu-system-x86_64 \
  -accel kvm \
  -cpu host,migratable=on \
  -smp 2 \
  -m 4096 \
  -no-user-config \
  -nodefaults \
  -nographic \
  -serial mon:stdio \
  -device virtio-net-pci,netdev=n1 \
  -netdev tap,id=n1,helper=/usr/lib/qemu/qemu-bridge-helper \
  -drive file=$BASEDIR/images/openwrt.qcow2
