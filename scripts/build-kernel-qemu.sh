#!/bin/bash

version=$(make kernelversion)

wget https://cloud-images.ubuntu.com/releases/hirsute/release/ubuntu-21.04-server-cloudimg-amd64.img

wget https://raw.githubusercontent.com/1Jo1/netty-transport_uring-ci-scripts/netty-kernel-testing/scripts/ubuntu-cloud/user-data
wget https://raw.githubusercontent.com/1Jo1/netty-transport_uring-ci-scripts/netty-kernel-testing/scripts/ubuntu-cloud/meta-data
wget https://raw.githubusercontent.com/1Jo1/netty-transport_uring-ci-scripts/netty-kernel-testing/scripts/qemu.exp

qemu-img create -f qcow2 -b ubuntu-21.04-server-cloudimg-amd64.img ubuntu.qcow2 70G
genisoimage -output ubuntu-seed.iso -volid cidata -joliet -rock user-data meta-data

#wget https://gist.githubusercontent.com/1Jo1/cb1d0dc3ef5b824f5f7db3736d89c688/raw/746794634a628facd34c327fa6a4bf90d9a76ce6/ubuntu-config
#mv ubuntu-config .config

mkdir kernel-image
#make olddefconfig
#make -j 24

#cp arch/x86/boot/bzImage kernel-image/
wget https://raw.githubusercontent.com/1Jo1/netty-transport_uring-ci-scripts/netty-kernel-testing/scripts/build-kernel.exp && chmod +x build-kernel.exp
echo $version
expect -f build-kernel.exp `pwd` ubuntu.qcow2 ubuntu-seed.iso 24 $version
ls -lah kernel-image


rm -rf user-data meta-data ubuntu.qcow2 ubuntu-seed.iso
wget https://raw.githubusercontent.com/1Jo1/netty-transport_uring-ci-scripts/netty-kernel-testing/scripts/user-data
wget https://raw.githubusercontent.com/1Jo1/netty-transport_uring-ci-scripts/netty-kernel-testing/scripts/meta-data
qemu-img create -f qcow2 -b ubuntu-21.04-server-cloudimg-amd64.img ubuntu.qcow2 70G
genisoimage -output ubuntu-seed.iso -volid cidata -joliet -rock user-data meta-data

expect -f qemu.exp `pwd` ubuntu.qcow2 ubuntu-seed.iso kernel-image/initrd.img-"${version}" kernel-image/bzImage


