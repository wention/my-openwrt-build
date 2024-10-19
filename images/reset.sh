#!/bin/sh

BASEDIR=$(realpath $(dirname $0))

#rsync -u ~/Git/lede/bin/targets/x86/64/openwrt-x86-64-generic-squashfs-combined-efi.qcow2 $BASEDIR
#qemu-img create -f qcow2 -b $BASEDIR/openwrt-x86-64-generic-squashfs-combined-efi.qcow2 -F qcow2 $BASEDIR/openwrt.qcow2 

rsync -u ~/Git/lede/bin/targets/x86/64/openwrt-x86-64-generic-squashfs-combined.qcow2 $BASEDIR
qemu-img create -f qcow2 -b $BASEDIR/openwrt-x86-64-generic-squashfs-combined.qcow2 -F qcow2 $BASEDIR/openwrt.qcow2 



