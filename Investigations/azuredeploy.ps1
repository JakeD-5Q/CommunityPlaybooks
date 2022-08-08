param(
    [Parameter(Mandatory = $true)]$ResourceGroup
)

$today = Get-Date -Format "MM-dd-yyyy"
$suffix = Get-Random -Maximum 100
$deploySuffix = $today + "_$suffix"

$deploymentName = "Start-MDEAutomatedInvestigation" + $deploySuffix
$remoteUrl = "https://raw.githubusercontent.com/Azure/Azure-Sentinel/master/Playbooks/Start-MDEAutomatedInvestigation/alert-trigger/azuredeploy.json"
$localTemplate = 'Start-MDEAutomatedInvestigation.parameters.json'
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    -TemplateParameterFile $localTemplate

.\Start-MDEAutomatedInvestigation.permissions.ps1 

$deploymentName = "Run-MDEAntivirus" + $deploySuffix
$remoteUrl = "https://raw.githubusercontent.com/Azure/Azure-Sentinel/master/Playbooks/Run-MDEAntivirus/alert-trigger/azuredeploy.json"
$localTemplate = 'Run-MDEAntivirus.parameters.json'
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    -TemplateParameterFile $localTemplate

.\Run-MDEAntivirus.permissions.ps1 

$deploymentName = "Get-MDEInvestigationPackage	" + $deploySuffix
$remoteUrl = "https://raw.githubusercontent.com/Azure/Azure-Sentinel/master/Playbooks/Get-MDEInvestigationPackage/alert-trigger/azuredeploy.json"
$localTemplate = 'Get-MDEInvestigationPackage	.parameters.json'
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    -TemplateParameterFile $localTemplate

.\Get-MDEInvestigationPackage.permissions.ps1 