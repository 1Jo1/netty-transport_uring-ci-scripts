#!/bin/bash

wget https://cloud-images.ubuntu.com/releases/hirsute/release/ubuntu-21.04-server-cloudimg-amd64.img
qemu-img create -f qcow2 -b Fedora-Cloud-Base-34-1.2.x86_64.qcow2 ubuntu.qcow2 70G
genisoimage -output ubuntu-seed.iso -volid cidata -joliet -rock ubuntu-cloud/user-data ubuntu-cloud/meta-data

mkdir ubuntu-kernel-image
wget https://raw.githubusercontent.com/1Jo1/netty-transport_uring-ci-scripts/netty-kernel-testing/scripts/build-kernel.exp && chmod +x build-kernel.exp
expect -f build-kernel.exp `pwd`/ubuntu-kernel-image ubuntu.qcow2 ubuntu-seed.iso
