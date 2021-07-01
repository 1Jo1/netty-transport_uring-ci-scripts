#!/bin/bash

wget https://cloud-images.ubuntu.com/releases/hirsute/release/ubuntu-21.04-server-cloudimg-amd64.img

wget https://raw.githubusercontent.com/1Jo1/netty-transport_uring-ci-scripts/netty-kernel-testing/scripts/ubuntu-cloud/user-data
wget https://raw.githubusercontent.com/1Jo1/netty-transport_uring-ci-scripts/netty-kernel-testing/scripts/ubuntu-cloud/meta-data

version=$(make kernelversion)
ls -lah
pwd
wget https://raw.githubusercontent.com/1Jo1/netty-transport_uring-ci-scripts/netty-kernel-testing/scripts/build-kernel.exp && chmod +x build-kernel.exp
expect -f build-kernel.exp `pwd` ubuntu.qcow2 ubuntu-seed.iso 24 $version
ls -lah kernel-image
