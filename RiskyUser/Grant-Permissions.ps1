param(
    [Parameter(Mandatory = $true)]$ResourceGroup,
    [Parameter(Mandatory = $true)]$Prefix
)

Connect-AzureAD

# Concatenate the customer-supplied prefix and the playbook name
function New-PbName() {
    param(
        [Parameter(Mandatory = $true)]$Prefix,
        [Parameter(Mandatory = $true)]$PlaybookName
    )

    $NewName = $Prefix + "." + $PlaybookName
    return $NewName
}

# Connect to your Azure Active Directory
Connect-AzureAD

# Retrieve the Subscription ID for permission scripts
$SubscriptionId = (Get-AzContext).Subscription.id
Write-Host $SubscriptionId

$Name = "Revoke-AADSignInSessions"	
$NewName = New-PbName $Prefix $Name
Write-Host $NewName

$ID = (Get-AzResource -Name $NewName -ResourceType Microsoft.Logic/workflows).Identity.PrincipalId
Write-Host $ID

.\Permissions\$Name.ps1 -MIGuid $ID


$Name = "Reset-AADUserPassword"
$NewName = New-PbName $Prefix $Name
Write-Host $NewName

$ID = (Get-AzResource -Name $NewName -ResourceType Microsoft.Logic/workflows).Identity.PrincipalId
Write-Host $ID

# This will change with the requirements for the permissions script
.\Permissions\$Name.ps1 -MIGuid $ID


$Name = "Block-AADUserOrAdmin"	
$NewName = New-PbName $Prefix $Name
Write-Host $NewName

$ID = (Get-AzResource -Name $NewName -ResourceType Microsoft.Logic/workflows).Identity.PrincipalId
Write-Host $ID

# This will change with the requirements for the permissions script
.\Permissions\$Name.ps1 -MIGuid $ID


$Name = "Confirm-AADRiskyUser"
$NewName = New-PbName $Prefix $Name
Write-Host $NewName

$ID = (Get-AzResource -Name $NewName -ResourceType Microsoft.Logic/workflows).Identity.PrincipalId
Write-Host $ID

# This will change with the requirements for the permissions script
.\Permissions\$Name.ps1 -MIGuid $ID


$Name = "Dismiss-AADRiskyUser"
$NewName = New-PbName $Prefix $Name
Write-Host $NewName

$ID = (Get-AzResource -Name $NewName -ResourceType Microsoft.Logic/workflows).Identity.PrincipalId
Write-Host $ID

# This will change with the requirements for the permissions script
.\Permissions\$Name.ps1 -MIGuid $ID


-ResourceGroup $ResourceGroup -SubscriptionId $SubscriptionId -MIGuid $ID
