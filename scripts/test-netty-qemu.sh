rm -rf user-data meta-data ubuntu.qcow2 ubuntu-seed.iso
wget https://raw.githubusercontent.com/1Jo1/netty-transport_uring-ci-scripts/netty-kernel-testing/scripts/user-data
wget https://raw.githubusercontent.com/1Jo1/netty-transport_uring-ci-scripts/netty-kernel-testing/scripts/meta-data
qemu-img create -f qcow2 -b ubuntu-21.04-server-cloudimg-amd64.img ubuntu.qcow2 70G
genisoimage -output ubuntu-seed.iso -volid cidata -joliet -rock user-data meta-data

git clone https://github.com/1Jo1/netty-incubator-transport-io_uring.git

expect -f qemu.exp `pwd` ubuntu.qcow2 ubuntu-seed.iso kernel-image/initrd.img-"${version}" kernel-image/bzImage
