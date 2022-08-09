param(
    [Parameter(Mandatory = $true)]$ResourceGroup
)

$today = Get-Date -Format "MM-dd-yyyy"
$suffix = Get-Random -Maximum 100
$deploySuffix = $today + "_$suffix"


$name = "Reset-AADUserPassword"
$deploymentName = $name + $deploySuffix
$remoteUrl = "https://raw.githubusercontent.com/Azure/Azure-Sentinel/master/Playbooks/Reset-AADUserPassword/alert-trigger/azuredeploy.json"
$localTemplate = "Parameters\$name.json"
New-AzResourceGroupDeployment -Name $deploymentName `
-ResourceGroupName $ResourceGroup `
-TemplateUri $remoteUrl `
-TemplateParameterFile $localTemplate `
-Verbose

Permissions\$name.ps1

$name = "Revoke-AADSignInSessions"
$deploymentName = $name + $deploySuffix
$remoteUrl = "https://raw.githubusercontent.com/Azure/Azure-Sentinel/master/Playbooks/Revoke-AADSignInSessions/alert-trigger/azuredeploy.json"
$localTemplate = "Parameters\$name.json"
New-AzResourceGroupDeployment -Name $deploymentName `
-ResourceGroupName $ResourceGroup `
-TemplateUri $remoteUrl `
-TemplateParameterFile $localTemplate `
-Verbose

Permissions\$name.ps1

$name = "Block-AADUserOrAdmin"
$deploymentName = $name + $deploySuffix
$remoteUrl = "https://raw.githubusercontent.com/Azure/Azure-Sentinel/master/Playbooks/Block-AADUserOrAdmin/alert-trigger/azuredeploy.json"
$localTemplate = "Parameters\$name.json"
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    -TemplateParameterFile $localTemplate `
    -Verbose

Permissions\$name.ps1
