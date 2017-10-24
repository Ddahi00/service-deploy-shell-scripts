# service-deploy-shell-scripts
Bash shell scripts for deploy and verify nimbus service on VMs
1.Build VM list file and copy the script files on a subscription's jump box VM
The vm_list file should be a plain text file that contains lines of vm name:service artifact zip name.
The following example shows the possible information that will guide the script to deploy service on VMs

"Clipping-2-2-0-VM-2:emju-clip/emju-clip/2.11.2/emju-clip-2.11.2.zip"  
"Clipping-2-2-0-VM-3:emju-clip/emju-clip/2.11.2/emju-clip-2.11.2.zip"  
"Clipping-2-2-2-VM-0:emju-clip/emju-clip/2.11.2/emju-clip-2.11.2.zip"  
"Clipping-2-2-2-VM-1:emju-clip/emju-clip/2.11.2/emju-clip-2.11.2.zip"  
"CoreServices-2-2-0-VM-0:emju-coreservices/emju-coreservices/2.10.0/emju-coreservices-2.10.0.zip"  
"CoreServices-2-2-0-VM-1:emju-coreservices/emju-coreservices/2.10.0/emju-coreservices-2.10.0.zip"  
"CoreServices-2-2-0-VM-2:emju-coreservices/emju-coreservices/2.10.0/emju-coreservices-2.10.0.zip"  
"CoreServices-2-2-0-VM-3:emju-coreservices/emju-coreservices/2.10.0/emju-coreservices-2.10.0.zip"  
"CoreServices-2-9-0-VM-0:emju-coreservices/emju-coreservices/2.10.0/emju-coreservices-2.10.0.zip"
Note: each line must end with a(or more) space

2.Deploy service on VMs
Run the deploy_service.sh on a subscription's jump box VM
The command syntax : sudo ./deploy_service.sh -p <VM_Password> -f <Full path of vm_list file>

3.Verify deployed service
Run the verify_deploy.sh on the same teminal window
The command syntax : sudo ./verify_deploy.sh -p <VM_Password> -f <Full path of vm_list file>
