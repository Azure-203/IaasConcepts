# We cannot do the resize as online operation, we need to deallocate the VM
az vm deallocate \
    --resource-group "psdemo-rg" \
    --name "psdemo-vm-linux-1"

az disk list -o table    
# Update the disk
az disk update \
    -g="psdemo-rg" \
    -n="psdemo-linux-1c-st0" \
    --size-gb="100"
# start the VM
az vm start \
    -g="psdemo-rg" \
    -n="psdemo-vm-linux-1"