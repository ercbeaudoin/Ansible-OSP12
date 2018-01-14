#!/bin/bash
echo "Unregister system"
ansible-playbook unregister_undercloud.yml

echo "remove stack user"
userdel -r stack

echo "Destroy all VMs"
for i in $(virsh list --all |grep osp12- |awk ' { print $2 } ');do virsh destroy $i;virsh undefine $i;done

echo "Remove cloud images"
rm -f /var/lib/libvirt/images/undercloud-osp10.qcow2 /var/lib/libvirt/images/osp12-*

echo "Remove tmp file"
rm -f /tmp/osp12-*

echo "Remove the tmp key"
rm -fr /tmp/osp12-undercloud/
