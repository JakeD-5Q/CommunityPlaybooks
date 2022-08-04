param(
    [Parameter(Mandatory = $true)]$ResourceGroup,
    [Parameter(Mandatory = $true)]$SubscriptionId,
    [Parameter(Mandatory = $true)]$Prefix
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

function Concat-PbName(){
    param(
        [Parameter(Mandatory = $true)]$PlaybookName,
        [Parameter(Mandatory = $true)]$Prefix
    )

    $NewName = $Prefix + "$.$PlaybookName"
    return $NewName
}


$deploymentName = "Restrict-MDEAppExecution" + $deploySuffix
$remoteUrl = "https://raw.githubusercontent.com/Azure/Azure-Sentinel/master/Playbooks/Restrict-MDEAppExecution/alert-trigger/azuredeploy.json"
$localTemplate = 'Restrict-MDEAppExecution.parameters.json'
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    -TemplateParameterFile $localTemplate `
    -Verbose

Restrict-MDEAppExecution.permissions.ps1


$deploymentName = "Restrict-MDEDomain" + $deploySuffix
$remoteUrl = "https://raw.githubusercontent.com/Azure/Azure-Sentinel/master/Playbooks/Restrict-MDEDomain/alert-trigger/azuredeploy.json"
$localTemplate = 'Restrict-MDEDomain.parameters.json'
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    -TemplateParameterFile $localTemplate `
    -Verbose

Restrict-MDEDomain.permissions.ps1

$deploymentName = "Restrict-MDEFileHash" + $deploySuffix
$remoteUrl = "https://raw.githubusercontent.com/Azure/Azure-Sentinel/master/Playbooks/Restrict-MDEFileHash/alert-trigger/azuredeploy.json"
$localTemplate = 'Restrict-MDEFileHash.parameters.json'
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    -TemplateParameterFile $localTemplate `
    -Verbose

Restrict-MDEFileHash.permissions.ps1


$deploymentName = "Restrict-MDEIPAddress" + $deploySuffix
$remoteUrl = "https://raw.githubusercontent.com/Azure/Azure-Sentinel/master/Playbooks/Restrict-MDEIPAddress/alert-trigger/azuredeploy.json"
$localTemplate = 'Restrict-MDEIPAddress.parameters.json'
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    -TemplateParameterFile $localTemplate `
    -Verbose

Restrict-MDEIPAddress.permissions.ps1 `
 -SubscriptionId $SubscriptionId `
 -ResourceGroup $ResourceGroup

$deploymentName = "Restrict-MDEUrl" + $deploySuffix
$remoteUrl = "https://raw.githubusercontent.com/Azure/Azure-Sentinel/master/Playbooks/Restrict-MDEUrl/alert-trigger/azuredeploy.json"
$localTemplate = 'Restrict-MDEUrl.parameters.json'
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    -TemplateParameterFile $localTemplate `
    -Verbose

Restrict-MDEUrl.permissions.ps1


