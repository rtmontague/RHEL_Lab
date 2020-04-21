#!/bin/bash

kill $(ps -ef | grep -m1 "python -m http.server" | awk '{print $2}')

sudo virsh destroy server1
sudo virsh undefine server1
sudo rm -rf /var/lib/libvirt/images/server1-1.qcow2
sudo rm -rf /var/lib/libvirt/images/server1.qcow2

sudo virsh destroy server2
sudo virsh undefine server2
sudo rm -rf /var/lib/libvirt/images/server2-1.qcow2
sudo rm -rf /var/lib/libvirt/images/server2-2.qcow2
sudo rm -rf /var/lib/libvirt/images/server2-3.qcow2
sudo rm -rf /var/lib/libvirt/images/server2-4.qcow2
sudo rm -rf /var/lib/libvirt/images/server2.qcow2

sudo virsh destroy client
sudo virsh undefine client
sudo rm -rf /var/lib/libvirt/images/client.qcow2

sudo virsh net-destroy internal
sudo ip link set dev internal down
sudo brctl delbr internal