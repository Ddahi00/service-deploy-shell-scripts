#!/bin/bash

#Only run this on a jump box VM in a subscription
#command syntax : sudo ./verify_deploy.sh -p <VM_Password> -f <Full path of vm list file>

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

for vm in ${vm2zip[@]}
do
vmn="${vm%%:*}"
veri="${vm##*:}"
veri=$(echo $veri | cut -d'/' -f 4)
veri="${veri%.zip}"

echo "verifying $vmn for $veri"
VER=$(sshpass -p $VM_PASSWORD ssh -o StrictHostKeyChecking=no safewayadmin@$vmn ps -ef|grep $veri)

if [[ -z "$VER" ]]; then 
echo "Failed fffff expected version: $veri is not installed on $vmn"
else 
echo "OK installing $veri succeeded on $vmn"
fi
done