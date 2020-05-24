# Gets the disks avaible for the vm
az disk list -o table | grep psdemo-vm-linux-1

# Create the snapshot of the OS disk
az snapshot create \
    -g="psdemo-rg" \
    -n="psdemo-linux-os-disk-snap-1" \
    --source="psdemo-vm-linux-1_OsDisk_1_c62f29a452cc4691b51a39345c016c07"

# Create a disk from the snapshot
az disk create \
    -g="psdemo-rg" \
    -n="psdemo-os-disk-linux-1" \
    --size-gb="64" \
    --source="psdemo-linux-os-disk-snap-1"

# Create the VM from the newly created disk snapshot    
az vm create \
    -g="psdemo-rg" \
    -n="psdemo-vm-linux-2" \
    --attach-os-disk="psdemo-os-disk-linux-1" \
    --os-type="linux"

# We can delete the snapshot
az snapshot delete \
    -g="psdemo-rg" \
    -n="psdemo-linux-os-disk-snap-1"   

az group delete -n="psdemo-rg"     