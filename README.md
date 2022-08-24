# Azure Site Recovery Demonstration



### Prerequisites
1. You must hold at least the [Contributor RBAC role](https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#contributor) at the subscription scope in the subscription the resources will be deployed to.

2. You must be capable of deploying resources to a set of paired regions. The templates are configured to allow deployment to regions within the US geopolitical region and that have regional pairs. If you wish to deploy to another geopolitical region, you will need to modify the azuredeploy.json template.

3. The virtual machines created in this deployment are deployed into availability zones. The region(s) you deploy the resources to [must support availability zones](https://docs.microsoft.com/en-us/azure/availability-zones/az-region).

### Installation with Azure Portal

Click the Deploy To Azure button below.

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmattfeltonma%2Fazure-site-recovery-demo%2Fv1%2Fazuredeploy.json)

### Installation with Azure CLI
1. Set the following variables:
   * DEPLOYMENT_NAME - The name of the location
   * DEPLOYMENT_LOCATION - The location to create the deployment
   * LOCATION - The primary region to deploy resources to
   * SEC_LOCATION - The secondary paired region to deploy resources to. This is used to demonstrate the cross region restore feature.
   * ADMIN_USER_NAME - The name to set for the VM administrator username
   * SUBSCRIPTION- The name or id of the subscription you wish to deploy the resources to

2. Set the CLI to the subscription you wish to deploy the resources to:

   * **az account set --subscription SUBSCRIPTION**

3. Deploy the lab using the command (tags parameter is optional): 

   * **az deployment sub create --name $DEPLOYMENT_NAME --location $DEPLOYMENT_LOCATION --template-uri https://raw.githubusercontent.com/mattfeltonma/azure-backup-demo/main/azuredeploy.json --parameters location=$LOCATION secLocation=$SEC_LOCATION vmAdminUsername=$ADMIN_USER_NAME tags='{"mytag":"value"}'**

4.  You will be prompted to provide a password for the local administrator of the virtual machine.

### Post Installation
Once the lab is deployed, you can RDP or SSH into the virtual machines using Azure Bastion.

### Removal of Resources
It is very important you follow the instructions below when you are done with the lab. If you do not follow these instructions, it could result in shadow resources which will require you to work with support to remove.

1. Follow the [instructions here](https://docs.microsoft.com/en-us/azure/backup/backup-azure-delete-vault?tabs=portal) to delete the Recovery Services Vault.

2. Follow the [instructions here](https://docs.microsoft.com/en-us/azure/backup/backup-vault-overview#delete-a-backup-vault) to delete the Backup Vault.

3. DO NOT proceed to this step until you have done steps 1 and 2. Once those steps are complete and both vaults are deleted, you can delete the resource groups containing the resources created as part of this lab.

