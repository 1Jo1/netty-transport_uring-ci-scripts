#!/bin/bash

wget https://gist.githubusercontent.com/1Jo1/57346c0d695adb5974a7f4e53f9ac2ac/raw/fb1fe4d8286192d429631edceae53f031c667c8a/linux-5_8-generic-config
mv linux-5_8-generic-config .config

version=$(make kernelversion)

make ARCH=x86_64 olddefconfig
make -j$(nproc)
make modules_install
update-initramfs -c -k "${version}"

mkdir kernel-build && cp arch/x86/boot/bzImage kernel-build/$1-kernel-qemu-release
mv /boot/initrd.img-"${version}" kernel-build/$1-initrd.img