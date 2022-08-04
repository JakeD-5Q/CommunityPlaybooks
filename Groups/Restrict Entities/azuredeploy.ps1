param(
    [Parameter(Mandatory = $true)]$ResourceGroup
)

$today = Get-Date -Format "MM-dd-yyyy"
$suffix = Get-Random -Maximum 100
$deploySuffix = $today + "_$suffix"


$deploymentName = "Restrict-MDEAppExecution" + $deploySuffix
$remoteUrl = "https://raw.githubusercontent.com/Azure/Azure-Sentinel/master/Playbooks/Restrict-MDEAppExecution/alert-trigger/azuredeploy.json"
$localTemplate = 'Restrict-MDEAppExecution.parameters.json'
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    -TemplateParameterFile $localTemplate

.\Restrict-MDEAppExecution.permissions.ps1


$deploymentName = "Restrict-MDEDomain" + $deploySuffix
$remoteUrl = "https://raw.githubusercontent.com/Azure/Azure-Sentinel/master/Playbooks/Restrict-MDEDomain/alert-trigger/azuredeploy.json"
$localTemplate = 'Restrict-MDEDomain.parameters.json'
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    -TemplateParameterFile $localTemplate

.\Restrict-MDEDomain.permissions.ps1

$deploymentName = "Restrict-MDEFileHash" + $deploySuffix
$remoteUrl = "https://raw.githubusercontent.com/Azure/Azure-Sentinel/master/Playbooks/Restrict-MDEFileHash/alert-trigger/azuredeploy.json"
$localTemplate = 'Restrict-MDEFileHash.parameters.json'
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    -TemplateParameterFile $localTemplate

.\Restrict-MDEFileHash.permissions.ps1


$deploymentName = "Restrict-MDEIPAddress" + $deploySuffix
$remoteUrl = ""
$localTemplate = 'Restrict-MDEIPAddress.parameters.json'
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    -TemplateParameterFile $localTemplate

.\Restrict-MDEIPAddress.permissions.ps1 -SubscriptionId $SubscriptionId -ResourceGroup $ResourceGroup

$deploymentName = "Restrict-MDEUrl" + $deploySuffix
$remoteUrl = ""
$localTemplate = 'Restrict-MDEUrl.parameters.json'
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    -TemplateParameterFile $localTemplate

.\Restrict-MDEUrl.permissions.ps1


