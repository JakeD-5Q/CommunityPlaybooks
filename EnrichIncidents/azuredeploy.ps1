param(
    [Parameter(Mandatory = $true)]$ResourceGroup
)

Get-AzResourceGroup -Name $ResourceGroup -ErrorVariable notPresent -ErrorAction SilentlyContinue

if ($notPresent) {
    Write-Host "This resource group does not exist. To create new resource group"
    
    $Location = Read-Host "Enter the location:"
    
    New-AzResourceGroup -Name $ResourceGroup `
    -Location $Location `
    -Verbose
}


$today = Get-Date -Format "MM-dd-yyyy"
$suffix = Get-Random -Maximum 100
$deploySuffix = $today + "_$suffix"


$deploymentName = "Get-AlienVault_OTX" + $deploySuffix
$remoteUrl = "https://raw.githubusercontent.com/JakeD-5Q/CommunityPlaybooks/main/Groups/Enrich%20Incidents/Alienvault-OTX/azuredeploy.json"
$localTemplate = 'alienvaultOTX.parameters.json'
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    -TemplateParameterFile $localTemplate `
    -Verbose

    
$deploymentName = "" + $deploySuffix
$remoteUrl = ""
$localTemplate = '.parameters.json'
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    -TemplateParameterFile $localTemplate

.\.permissions.ps1

$deploymentName = "" + $deploySuffix
$remoteUrl = ""
$localTemplate = '.parameters.json'
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    -TemplateParameterFile $localTemplate

.\.permissions.ps1

$deploymentName = "" + $deploySuffix
$remoteUrl = ""
$localTemplate = '.parameters.json'
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    -TemplateParameterFile $localTemplate

.\.permissions.ps1

$deploymentName = "" + $deploySuffix
$remoteUrl = ""
$localTemplate = '.parameters.json'
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    -TemplateParameterFile $localTemplate

.\.permissions.ps1