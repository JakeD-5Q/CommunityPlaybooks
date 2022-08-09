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



$Name = ""
$NewName = New-PbName $Prefix $Name
Write-Host $NewName

$ID = (Get-AzResource -Name $NewName -ResourceType Microsoft.Logic/workflows).Identity.PrincipalId
Write-Host $ID

.\Permissions\$Name.ps1 -MIGuid $ID

$Name = ""
$NewName = New-PbName $Prefix $Name
Write-Host $NewName

$ID = (Get-AzResource -Name $NewName -ResourceType Microsoft.Logic/workflows).Identity.PrincipalId
Write-Host $ID

# This will change with the requirements for the permissions script
.\Permissions\$Name.ps1 -MIGuid $ID


.\GrantPermissions\Reset-AADPassword.permissions.ps1

.\GrantPermissions\Revoke-AADSignInSessions.permissions.ps1



-ResourceGroup $ResourceGroup -SubscriptionId $SubscriptionId -MIGuid $ID

RiskyUser\Permissions\Block-AADUserOrAdmin.ps1
RiskyUser\Permissions\Reset-AADPassword.permissions.ps1