######################################################
##################### DEPLOY.PS1 #####################
######################################################
# Playbooks this script deploys:
# 
# 
# 

# additional playbook parameters (parameters found in the local ARM template param file)
# subscriptionId (Reset-password)
# resourcegroup  (Reset-password)


param(
    [Parameter(Mandatory = $true)]$ResourceGroup
)

Connect-AzureAD

# check resource group
Get-AzResourceGroup -Name $ResourceGroup -ErrorVariable notPresent -ErrorAction SilentlyContinue

if ($notPresent) {
    Write-Host "This resource group does not exist. To create new resource group"
    
    $Location = Read-Host "Enter the location:"
    
    New-AzResourceGroup -Name $ResourceGroup `
        -Location $Location `
        -Verbose
}

# build playbook name
$DeployedName = $NamePrefix + ".$PlaybookName"

# to get value from file and use it within the template
# https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/deploy-powershell#deploy-template-spec


# get the object id of the playbook
$ID = (Get-AzResource -Name $DeployedName -ResourceType Microsoft.Logic/workflows).Identity.PrincipalId
$MIGuid = $ID
$MI = Get-AzureADServicePrincipal -ObjectId $MIGuid


# Deploy all of these playbooks without downloading or cloning this repository
$today = Get-Date -Format "MM-dd-yyyy"
$suffix = Get-Random -Maximum 100
$deploySuffix = $today + "_$suffix"


# finally deploy resources
$deploymentName = "" + $deploySuffix
$remoteUrl = ""
$remotetemplate = ""
$localTemplate = '.parameters.json'
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    -TemplateParameterFile $localTemplate `
    -Verbose

######################################################
############## Grant-Permissions.ps1 #################
######################################################
param(
    [Parameter(Mandatory = $true)]$ResourceGroup,
    [Parameter(Mandatory = $true)]$Prefix
)

function New-PbName() {
    param(s
        [Parameter(Mandatory = $true)]$Prefix,
        [Parameter(Mandatory = $true)]$PlaybookName
        )
        
        $NewName = $Prefix + "." + $PlaybookName
        return $NewName
    }
    
Connect-AzureAD

# Retrieve the Subscription ID for permission scripts
$SubscriptionId = (Get-AzContext).Subscription.id
Write-Host $SubscriptionId

$Name = "PlaybookName"
$NewName = New-PbName $Prefix $Name
Write-Host $NewName

$ID = (Get-AzResource -Name $NewName -ResourceType Microsoft.Logic/workflows).Identity.PrincipalId
Write-Host $ID

.\Permissions\$Name.ps1 -MIGuid $ID

######################################################
############# Permissions\Playbook.ps1 ###############
######################################################
param(
    [Parameter(Mandatory = $true)]$MIGuid
)

Connect-AzureAD -TenantId xxxxx-xxxx-xxxx-etc
$app = Get-AzureADServicePrincipal -SearchString "display name of app"

foreach ($AD_group_name in $list_of_names_to_map) {
    $AADGroup = Get-AzureADGroup -SearchString $AD_group_name
    $AppRole = $App.AppRoles | ? { $_.value -like $AADGroup.DisplayName }


$NewAssignmentParams = @{
    'id'          = $AppRole.Id;
    'objectid'    = $AADGroup.ObjectId;
    'PrincipalId' = $AADGroup.ObjectId;
    'ResourceId'  = $App.ObjectId;
}

New-AzureADGroupAppRoleAssignment @NewAssignmentParams

