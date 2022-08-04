param(
    [Parameter(Mandatory = $true)]$NamePrefix,
    [Parameter(Mandatory = $true)]$PlaybookName,
    [Parameter(Mandatory = $true)]$ResourceGroup,
    [Parameter(Mandatory = $true)]$Location
)

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
    -TemplateParameterFile $localTemplate