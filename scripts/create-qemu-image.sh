#!/bin/bash

wget https://cloud-images.ubuntu.com/releases/hirsute/release/ubuntu-21.04-server-cloudimg-amd64.img

qemu-img create -f qcow2 -b ubuntu-21.04-server-cloudimg-amd64.img ubuntu.qcow2 70G
genisoimage -output ubuntu-seed.iso -volid cidata -joliet -rock user-data meta-data
