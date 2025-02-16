#!/bin/sh

NAME="openwrt"
VCPUS="2"
MEMORY="1024"
DISK=""
BRIDGE="br0"
UEFI="0"

while [ $# -gt 1 ]
do
  case "$1" in 
    --name)
      NAME=$2
      shift
      shift
      ;;
    --vcpus)
      VCPUS=$2
      shift
      shift
      ;;
    --memory)
      MEMORY=$2
      shift
      shift
      ;;
    --disk)
      DISK=$2
      shift
      shift
      ;;
    --bridge)
      BRIDGE=$2
      shift
      shift
      ;;
    --uefi)
      UEFI="1"
      shift
      ;;
    *)
      DISK=$1
      shift
      ;;
    esac
done

#sudo chown libvirt-qemu:libvirt-qemu images/*.qcow2

OPTS=()
if [ $UEFI -gt 0 ];then
  OPTS+=('--boot uefi')
fi

set -x
exec virt-install \
  --import \
  --name openwrt2 \
  ${OPTS} \
  --os-variant linux2022 \
  --vcpus ${VCPUS} \
  --cpu host-passthrough \
  --ram ${MEMORY} \
  --disk images/openwrt.qcow2 \
  --network bridge=${BRIDGE} \
  --graphics spice \
  --check path_in_use=off \
  --noautoconsole \
  --serial pty
