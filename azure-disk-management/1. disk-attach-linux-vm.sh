# Linux VM should be avaialbe before performing the following commands.
az login
# Attach the disk for the existing VM
az vm disk attach \
    --resource-group "psdemo-rg" \
    --vm-name "psdemo-vm-linux-1" \
    --name "psdemo-linux-1c-st0" \
    --new \
    --size-gb 25 \
    --sku "Premium_LRS"

# Get the public ip to ssh into the vm
az vm list-ip-addresses -o table
# Login into the linux VM to perform the partiotion
ssh -l kpolanki 13.82.131.75
# Find the new block device, in linuc we know the dev/sda is OS, dev/sdb is for the temporary and the newly 
#attched disk will be dev/sdc. To list the blocks s use below command inside the linux VM
lsblk

# Partition th edisk with fdisk
sudo fdisk /dev/sdc
m # List the options how to partition
n # Add the new partition
p # Lists the partiotion options like start index end index
1 # Number of parittions
w # Writes the created partitions into the disk.

# Create the file system of type ext4 in the newly created partition dev/sdc1
sudo mkfs -t ext4 /dev/sdc1

# Make a directory to moun the disk under
sudo mkdir /data1

sudo -i blkid | grep sdc1

UUID=125c38df-ebd5-4871-9ae6-6ef654be411b /data1 ext4 defaults 0 0

sudo vi /etc/fstab

sudo mount -a
df -h
# Exit from the VM
exit
