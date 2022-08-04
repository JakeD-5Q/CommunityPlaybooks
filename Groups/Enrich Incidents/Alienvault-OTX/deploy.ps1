param(
    [Parameter(Mandatory = $true)]$NamePrefix,
    [Parameter(Mandatory = $true)]$ResourceGroup
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

$PlaybookName = "AlienVault-OTX"

# build playbook name
$DeployedName = $NamePrefix + ".$PlaybookName"

# Deploy all of these playbooks without downloading or cloning this repository
$today = Get-Date -Format "MM-dd-yyyy"
$suffix = Get-Random -Maximum 100
$deploySuffix = $today + "_$suffix"


# finally deploy resources
$deploymentName = $PlaybookName + $deploySuffix
$remoteUrl = "https://raw.githubusercontent.com/JakeD-5Q/CommunityPlaybooks/main/Groups/Enrich%20Incidents/Alienvault-OTX/azuredeploy.json"
$localTemplate = $PlaybookName + '.parameters.json'
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    -TemplateParameterFile $localTemplate `
    -Verbose