az login

az account set \
    --subscription="Free Trial"

az group create \
    --name="psdemo-rg" \
    --location="eastus"

az network vnet create \
    --resource-group="psdemo-rg" \
    --name="psdemo-vnet-linux-1" \
    --address-prefix="10.0.0.0/16" \
    --subnet-name="psdemo-subnet-linux-1" \
    --address-prefix="10.0.1.0/24"

az network public-ip create \
    --resource-group="psdemo-rg" \
    --name="psdemo-pip-linux-1"

az network nsg create \
    --resource-group="psdemo-rg" \
    --name="psdemo-nsg-linux-1"

az network nic create \
    -g="psdemo-rg" \
    -n="psdemo-nic-linux-1" \
    --vnet-name="psdemo-vnet-linux-1" \
    --subnet="psdemo-subnet-linux-1" \
    --public-ip-address="psdemo-pip-linux-1" \
    --network-security-group="psdemo-nsg-linux-1"

az vm create \
    -g="psdemo-rg" \
    -n="psdemo-vm-linux-1" \
    --nics="psdemo-nic-linux-1" \
    --image="RHEL" \
    --authentication-type="ssh" \
    --admin-user="kpolanki" \
    --generate-ssh-keys

az vm open-port \
    -g="psdemo-rg" \
    --name="psdemo-vm-linux-1" \
    --port="22"

az vm list-ip-addresses -o table

ssh -l kpolanki x.x.x.x

