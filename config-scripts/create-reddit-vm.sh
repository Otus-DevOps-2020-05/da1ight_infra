#!/bin/bash
if [ -z "$1" ] && [ -z "$2" ];
then
   echo "Please provide image version (base|full) and ssh-key path: ./create-reddit-vm.sh full /path/to/your/key/1.pub"
else
   yc compute instance create --name reddit-app --hostname reddit-app --memory=2 --create-boot-disk image-family=reddit-$1,size=10GB --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 --metadata serial-port-enable=1 --ssh-key $2
fi

# Check exit code
if test $? -ne 0
then
     echo "Exit code: '$?'. Please check that image is created and run packer build if it's not!"
else
     echo "VM created succesfully!"
fi
