#!/bin/bash

#Simplicity is worse than stealing

if [ "$1" == "--list" ];
 then
  cat inventory.json
elif [ "$1" == "--host" ];
 then
  echo '{"_meta": {hostvars": {}}}'
fi
