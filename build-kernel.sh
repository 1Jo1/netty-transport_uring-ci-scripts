#!/bin/bash

#sudo apt-get install gcc-arm-linux-gnueabi

wget https://gist.githubusercontent.com/1Jo1/3b03e8a159f5b61b886fdcd3f90fed9e/raw/7b5a5022df4b8467c1a7366194731adede448dc7/linux_5_9-localyesconfig
mv linux_5_9-localyesconfig .config

make ARCH=x86_64 olddefconfig
make -j$(nproc)
mkdir kernel-build && cp arch/x86/boot/bzImage kernel-build/$1-kernel-qemu-release


