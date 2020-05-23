# We should be having the VM Created before running below command
az vm list-ip-addresses -o table

# Login into the Linux VM
ssh -l kpolanki 13.92.152.38

# Genearize the VM with below command, since we are in Linux machine use the sudo command
sudo waagent -deprovision+user -force
# exit from the VM
exit

#Deallocate the VM before creating the custom image.
az vm deallocate \
    --resource-group="psdemo-rg" \
    --name="psdemo-vm-linux-1"


#Mark the VM as generalized by using below command
az vm generalize \
    --resource-group="psdemo-rg" \
    --name="psdemo-vm-linux-1"    

#create the custom image from the generalized VM
az image create \
    --resource-group="psdemo-rg" \
    --name="psdemo-image-linux-ci" \
    --source="psdemo-vm-linux-1"

#Now create a new VM from the custom image
az vm create \
    -g="psdemo-rg" \
    -n="psdemo-vm-linux-2" \
    --location="eastus" \
    --image="psdemo-image-linux-ci" \
    --authentication-type="ssh" \
    --admin-user="kpolanki" \
    --generate-ssh-keys

# Remove the generalized image
az vm delete \
    --resource-group="psdemo-rg" \
    --name="psdemo-vm-linux-1"    