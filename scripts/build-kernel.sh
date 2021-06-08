#!/bin/bash

wget https://gist.githubusercontent.com/1Jo1/57346c0d695adb5974a7f4e53f9ac2ac/raw/51b85551deaae3064b2de93252296a3f0932fed7/linux-5_8-generic-config
mv linux-5_8-generic-config .config

version=$(make kernelversion)

make ARCH=x86_64 olddefconfig
make -j$(nproc)
make modules_install
dracut /boot/initrd.img-"${version}" $version

mkdir kernel-build && cp arch/x86/boot/bzImage kernel-build/$1-kernel-qemu-release
mv /boot/initrd.img-"${version}" kernel-build/$1-initrd.img

wget https://raw.githubusercontent.com/1Jo1/netty-transport_uring-ci-scripts/netty-kernel-testing/scripts/qemu.exp
wget https://raw.githubusercontent.com/1Jo1/netty-transport_uring-ci-scripts/netty-kernel-testing/scripts/user-data
wget https://raw.githubusercontent.com/1Jo1/netty-transport_uring-ci-scripts/netty-kernel-testing/scripts/meta-data

wget https://download.fedoraproject.org/pub/fedora/linux/releases/34/Cloud/x86_64/images/Fedora-Cloud-Base-34-1.2.x86_64.qcow2

qemu-img create -f qcow2 -b Fedora-Cloud-Base-34-1.2.x86_64.qcow2 my-disk.qcow2 20G
genisoimage -output my-seed.iso -volid cidata -joliet -rock user-data meta-data

expect -f qemu.exp `pwd` my-disk.qcow2 my-seed.iso `pwd`/netty-incubator-transport-io_uring
