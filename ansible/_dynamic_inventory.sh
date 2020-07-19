#!/bin/bash

#Export you IAM token and folder id before using yhis script
#How to get IAM token: https://cloud.yandex.ru/docs/iam/operations/iam-token/create-for-sa
#How to get folder id "yc resource-manager folder list"
#Example:
# export FOLDER_ID="b1grhssq464f0h111111"
# export IAM_TOKEN="CggVAgAAABoBMxKA...."

if [ -n "$FOLDER_ID" ]
 then
  if [ -n "$IAM_TOKEN" ]
   then
     HOST1=$(curl -s -H "Authorization: Bearer ${IAM_TOKEN}" "https://compute.api.cloud.yandex.net/compute/v1/instances?folderId=${FOLDER_ID}" | jq -r ".instances[1].labels.tags")
     HOST1_IP=$(curl -s -H "Authorization: Bearer ${IAM_TOKEN}" "https://compute.api.cloud.yandex.net/compute/v1/instances?folderId=${FOLDER_ID}" | jq -r ".instances[1].networkInterfaces[0].primaryV4Address.oneToOneNat.address")
     HOST2=$(curl -s -H "Authorization: Bearer ${IAM_TOKEN}" "https://compute.api.cloud.yandex.net/compute/v1/instances?folderId=${FOLDER_ID}" | jq -r ".instances[0].labels.tags")
     HOST2_IP=$(curl -s -H "Authorization: Bearer ${IAM_TOKEN}" "https://compute.api.cloud.yandex.net/compute/v1/instances?folderId=${FOLDER_ID}" | jq -r ".instances[0].networkInterfaces[0].primaryV4Address.oneToOneNat.address")
   else
     echo "IAM_TOKEN variable missing!"
  fi
  else
    echo "Export FOLDER_ID variable missing!"
fi

if [ "$1" == "--list" ]; then
cat <<EOF
{
  "app": {
    "hosts": ["$HOST1_IP"]
    },
  "db": {
    "hosts": ["$HOST2_IP"]
      }
}
EOF
elif [ "$1" == "--host" ]; then
  echo '{"_meta": {hostvars": {}}}'
else
  echo "{ }"
fi
