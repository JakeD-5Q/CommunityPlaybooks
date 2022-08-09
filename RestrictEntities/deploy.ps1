param(
    [Parameter(Mandatory = $true)]$ResourceGroup,
    [Parameter(Mandatory = $true)]$SubscriptionId,
    [Parameter(Mandatory = $true)]$Prefix
)

Connect-AzureAD

# check is RG exists, create one with the provided name if False
Get-AzResourceGroup -Name $ResourceGroup -ErrorVariable notPresent -ErrorAction SilentlyContinue

if ($notPresent) {
    Write-Host "This resource group does not exist. To create new resource group"
    
    $Location = Read-Host "Enter the location:"
    
    New-AzResourceGroup -Name $ResourceGroup `
        -Location $Location `
        # -Verbose
}

# Create unique deployment name
$today = Get-Date -Format "MM-dd-yyyy"
$suffix = Get-Random -Maximum 100
$deploySuffix = $today + "_$suffix"

function New-PbName(){
    param(
        [Parameter(Mandatory = $true)]$PlaybookName,
        [Parameter(Mandatory = $true)]$Prefix
    )

    $NewName = $Prefix + "$.$PlaybookName"
    return $NewName
}


$Name = "Restrict-MDEAppExecution"
$deploymentName = $Name  + $deploySuffix
$remoteUrl = "https://raw.githubusercontent.com/Azure/Azure-Sentinel/master/Playbooks/Restrict-MDEAppExecution/alert-trigger/azuredeploy.json"
$localTemplate = 'Restrict-MDEAppExecution.parameters.json'
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    -TemplateParameterFile $localTemplate `
    -Verbose

$NewName = New-PbName($Name, $Prefix)
.\Restrict-MDEAppExecution.permissions.ps1 -PlaybookName $NewName


$Name = "Restrict-MDEDomain"
$deploymentName = $Name + $deploySuffix
$remoteUrl = "https://raw.githubusercontent.com/Azure/Azure-Sentinel/master/Playbooks/Restrict-MDEDomain/alert-trigger/azuredeploy.json"
$localTemplate = 'Restrict-MDEDomain.parameters.json'
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    -TemplateParameterFile $localTemplate `
    -Verbose

$NewName = New-PbName($Name, $Prefix)
.\Restrict-MDEDomain.permissions.ps1 -PlaybookName $NewName


$Name = "Restrict-MDEFileHash"
$deploymentName = $Name + $deploySuffix
$remoteUrl = "https://raw.githubusercontent.com/Azure/Azure-Sentinel/master/Playbooks/Restrict-MDEFileHash/alert-trigger/azuredeploy.json"
$localTemplate = 'Restrict-MDEFileHash.parameters.json'
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    -TemplateParameterFile $localTemplate `
    -Verbose

$NewName = New-PbName($Name, $Prefix)
.\Restrict-MDEFileHash.permissions.ps1 -PlaybookName $NewName


$Name = "Restrict-MDEIPAddress"
$deploymentName = $Name + $deploySuffix
$remoteUrl = "https://raw.githubusercontent.com/Azure/Azure-Sentinel/master/Playbooks/Restrict-MDEIPAddress/alert-trigger/azuredeploy.json"
$localTemplate = 'Restrict-MDEIPAddress.parameters.json'
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    -TemplateParameterFile $localTemplate `
    -Verbose

$NewName = New-PbName($Name, $Prefix)
.\Restrict-MDEIPAddress.permissions.ps1 `
 -PlaybookName $NewName `
 -SubscriptionId $SubscriptionId `
 -ResourceGroup $ResourceGroup


$Name = "Restrict-MDEUrl"
$deploymentName = $Name + $deploySuffix
$remoteUrl = "https://raw.githubusercontent.com/Azure/Azure-Sentinel/master/Playbooks/Restrict-MDEUrl/alert-trigger/azuredeploy.json"
$localTemplate = 'Restrict-MDEUrl.parameters.json'
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    -TemplateParameterFile $localTemplate `
    -Verbose

$NewName = New-PbName($Name, $Prefix)
.\Restrict-MDEUrl.permissions.ps1 `
 -PlaybookName $NewName


