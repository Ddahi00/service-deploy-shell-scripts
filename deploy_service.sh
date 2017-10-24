#!/bin/bash

#Only run this on a jump box VM in a subscription
#command syntax : sudo ./deploy_services.sh -p <VM_Password> -f <Full path of vm list file>

echo "Start to deploy service"

while getopts ":p:f:" opt; do
  echo "Option $opt set with value $OPTARG"
  case $opt in
    p) 
      # Password to access VMs for the services
      VM_PASSWORD=$OPTARG
      ;;
    f)
      # Deploy VM list file path
      VM_LIST_FILE=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      ;;
  esac
done
#echo "password: "$VM_PASSWORD   "vm_list_file: "$VM_LIST_FILE
IFS=$'\n' read -d '' -r -a vm2zip < $VM_LIST_FILE

URL="http://albertsons-binrepo.westus.cloudapp.azure.com/artifactory/libs-release-local/"
DEPLOY="sudo /share/scripts/deploy "$URL

for vm in ${vm2zip[@]}
do
vmn="${vm%%:*}"
zip="${vm##*:}"
echo "=======>>>>> installing $vmn"
sshpass -p $VM_PASSWORD ssh -o StrictHostKeyChecking=no safewayadmin@$vmn  $DEPLOY$zip
echo "=======>>>>> install $vmn ended"
done
