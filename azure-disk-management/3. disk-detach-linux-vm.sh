# Login into the VM and unmoun the disk added with UUID in #1 script
az vm list-ip-addresses  -o table
ssh -l kpolanki 104.211.55.206

sudo vi /etc/fstab
sudo umount /data1

exit

# Now detach the disk from the VM
az vm disk detach \
    -g="psdemo-rg" \
    -n="psdemo-linux-1c-st0" \
    --vm-name="psdemo-vm-linux-1"

# Delete the disk
az disk delete \
    -g="psdemo-rg" \
    -n="psdemo-linux-1c-st0"