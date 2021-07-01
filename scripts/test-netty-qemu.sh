#!/bin/bash

version=$(make kernelversion)
git clone https://github.com/1Jo1/netty-incubator-transport-io_uring.git

ls -lha

expect -f qemu.exp `pwd` ubuntu.qcow2 ubuntu-seed.iso kernel-image/initrd.img-"${version}" kernel-image/bzImage
