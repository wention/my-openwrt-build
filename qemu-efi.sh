#!/bin/sh

BASEDIR=$(realpath $(dirname $0))

EFIROM=/usr/share/OVMF/OVMF_CODE.ms.fd

sudo qemu-system-x86_64 \
  -accel kvm \
  -cpu host,migratable=on \
  -smp 2 \
  -m 4096 \
  -no-user-config \
  -nodefaults \
  -nographic \
  -serial stdio \
  -smbios type=0,uefi=on \
  -bios $EFIROM \
  -device virtio-net-pci,netdev=n1 \
  -netdev tap,id=n1,helper=/usr/lib/qemu/qemu-bridge-helper \
  -drive file=$BASEDIR/images/openwrt-efi.qcow2
