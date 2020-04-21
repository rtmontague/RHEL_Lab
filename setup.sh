#!/bin/bash

sudo virsh net-create ./internal_net.xml

python -m http.server &

sudo virt-install --name=server1 \
    --vcpus=1 \
    --memory=2048 \
    --cdrom=/var/lib/libvirt/images/CentOS-Stream-x86_64-dvd1.iso \
    --disk size=10 \
    --disk size=10 \
    --os-variant=centos8 \
    --network=default \
    --network=network:internal \
    --location /var/lib/libvirt/images/CentOS-Stream-x86_64-dvd1.iso \
    --extra-args "ks=http://192.168.1.254:8000/server1-ks.cfg" \
    --unattended &

sudo virt-install --name=server2 \
    --vcpus=1 \
    --memory=2048 \
    --cdrom=/var/lib/libvirt/images/CentOS-Stream-x86_64-dvd1.iso \
    --disk size=10 \
    --disk size=40 \
    --disk size=40 \
    --disk size=40 \
    --disk size=40 \
    --os-variant=centos8 \
    --network=network:internal \
    --location /var/lib/libvirt/images/CentOS-Stream-x86_64-dvd1.iso \
    --extra-args "ks=http://192.168.1.254:8000/server2-ks.cfg" \
    --unattended &

sudo virt-install --name=client \
    --vcpus=1 \
    --memory=2048 \
    --cdrom=/var/lib/libvirt/images/CentOS-Stream-x86_64-dvd1.iso \
    --disk size=50 \
    --os-variant=centos8 \
    --network=network:internal \
    --location /var/lib/libvirt/images/CentOS-Stream-x86_64-dvd1.iso \
    --extra-args "ks=http://192.168.1.254:8000/client-ks.cfg" \
    --unattended &

sleep 60
kill $(ps -ef | grep -m1 "python -m http.server" | awk '{print $2}')
