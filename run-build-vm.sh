#!/bin/sh

qemu-system-x86_64 \
  -enable-kvm \
  -smp 8 \
  -m 8192 \
  -smbios type=0,uefi=on \
  -bios /usr/share/edk2/x64/OVMF_CODE.fd \
  -drive file=/home/wention/Downloads/linuxmint-21.3-cinnamon-64bit.iso \
  -drive file=/dev/sda
