#!/bin/bash

wget https://gist.githubusercontent.com/1Jo1/049b60e3ca767e9ad71c676f81f47add/raw/a71dce14d2e16e1944fefd66fa108193a53c466c/linux_5_9-ubu.config
mv linux_5_9-ubu.config .config

make ARCH=x86_64 olddefconfig
make -j$(nproc)
mkdir kernel-build && cp arch/x86/boot/bzImage kernel-build/$1-kernel-qemu-release


