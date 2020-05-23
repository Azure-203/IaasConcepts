# Login into the Azure Account.
az login
 #Set the Proper subscription account.
 az account set --subscription="Free Trial"
 
 #To display the account/subscription
 az account show -o table

 # Create the resource group
 az group create --name="psdemo-rg" --location="eastus"

 #Create the VNET and SUBNET and assign the ip addresses.
 az network vnet create --resource-group="psdemo-rg" --name="psdemo-vnet-1" --address-prefixes="10.0.0.1/16" --subnet-name="psdemo-subnet-1" --address-prefixes="10.0.1.0/24"

#Displays the VNET status
 az network vnet show --resource-group="psdemo-rg" --name="psdemo-vnet-1" -o table

 #Create the public address
 az network public-ip create --resource-group="psdemo-rg" --name="psdemo-pip-win-1"

 # Displays the Public ip for the resource group.
 az network public-ip show --name="psdemo-pip-win-1" --resource-group="psdemo-rg" -o table

 #Create the network security group for the resource
 az network nsg create --resource-group="psdemo-rg" --name="psdemo-nsg-win-1"
 
 # Displays the NSG for the resource group.
 az network nsg show -g="psdemo-rg" -n="psdemo-nsg-win-1" -o table

 #Create the network interface for the resource by assigning vnet,subnet,pip and nsg
 az network nic create -g="psdemo-rg" -n="psdemo-nic-win-1" --vnet-name="psdemo-vnet-1" --subnet="psdemo-subnet-1" --public-ip-address="psdemo-pip-win-1" --network-security-group="psdemo-nsg-win-1"

#Create the VM 
az vm create -g="psdemo-rg" -n="psdemo-vm-win-1" --location="eastus" --nics="psdemo-nic-win-1" --admin-user="kpolanki" --admin-password="Password3637*" --image="win2016datacenter"
az vm list -o table

#Open the port for RDP for the VM
az vm open-port -g="psdemo-rg" -n="psdemo-vm-win-1" --port="3389"