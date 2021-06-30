#!/bin/bash
wget https://cloud-images.ubuntu.com/releases/hirsute/release/ubuntu-21.04-server-cloudimg-amd64.img

wget https://gist.githubusercontent.com/1Jo1/cb1d0dc3ef5b824f5f7db3736d89c688/raw/d88759776bc99787a35784d2cf64f2b7de306425/ubuntu-config
mv ubuntu-config .config

mkdir kernel-image
make olddefconfig
make -j 24

cp arch/x86/boot/bzImage kernel-image/
