# warehouse_pipelines_handling
Deployment of a warehouse data warehouse infrastructure on azure with data pipelines to fetch a sql database

## Deployment of azure initial resources
To deploy the first resources I went with a powershell command on azure cli, simply because the goal here is to practice github branches, data engineering skills related to pandas and software development skills. Therefore this initial step was done with a powershell code. The main goal is to create a resource group and a storage account to be able to store terraform state file.

Template used:


**Note**: Declared Variables can and should be changed for your liking.

### Powershell
```powershell
# Declare variables
$resourceGroup = "resource group name"
$location = "West Europe"
$storageAccountName = "storage account name"
$containerName = "container name for terraform"

# Create Azure Resource Group
New-AzResourceGroup -Name $resourceGroup -Location $location

# Create an Azure Storage Account
New-AzStorageAccount -ResourceGroupName $resourceGroup -Name $storageAccountName -Location $location -SkuName Standard_LRS -Kind StorageV2 -AllowBlobPublicAccess $false

# Gather information about the storage account
$storageAccountKey = (Get-AzStorageAccountKey -ResourceGroupName $resourceGroup -AccountName $storageAccountName).Value[0]

$ctx = New-AzureStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storageAccountKey

# Create an Azure storage container inside the storage account
New-AzureStorageContainer -Name $containerName -Context $ctx

$OutputObject = [PSCustomObject]@{
    resourceGroup = $resourceGroup
    storageaccountname = $storageAccountName
    containername = $containerName
}

$OutputObject | ConvertTo-Json
```
- The output of this is all the information we need to move forward with the terraform code.

After creating the resource group, storage account and terraform container for storing terraform state we move forward to create the service principal. Service principal is necessary since it is going to be the user created to use to create resources using terraform.
 
### Powershell
```powershell
## Declare variables
$ServicePrincipalName = "anyname-terraform-sp"
$AzSubscriptionName = "name of Azure subscription"
$endDate = "10/10/2024"

New-AzADServicePrincipal -DisplayName $ServicePrincipalName

Connect-AzureAD

$Subscription = (Get-AzSubscription -SubscriptionName $AzSubscriptionName)
$ServicePrincipal = Get-AzADServicePrincipal -DisplayName $ServicePrincipalName
$AzureADApplication = Get-AzureADApplication -SearchString $ServicePrincipalName
$clientSecret = New-AzureADApplicationPasswordCredential -ObjectID $AzureADApplication.ObjectId -EndDate $endDate

$OutputObject = [PSCustomObject]@{
    clientId = $ServicePrincipal.AppId
    subscriptionId = $Subscription.Id
    clientsecret = $clientSecret.value
    tenantId = $Subscription.TenantId
}

$OutputObject | ConvertTo-Json
```

Last thing to do manually on the shell is to assign a proper role to the Service principal, in this case we would like to provide it with Contributor role.

### Powershell

```PowerShell
## Declare variables
$ServicePrincipalName = "anyname-terraform-sp"
New-AzRoleAssignment -ObjectId $servicePrincipal.id -RoleDefinitionName "Contributor"
```