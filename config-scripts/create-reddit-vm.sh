#!/bin/bash
if [ -z "$1" ];
then
   echo "Please provide ssh-key path: ./create-reddit-vm.sh /path/to/your/key/1.pub"
else
   yc compute instance create --name reddit-app --hostname reddit-app --memory=2 --create-boot-disk image-family=reddit-full,size=10GB --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 --metadata serial-port-enable=1 --ssh-key $1
fi
