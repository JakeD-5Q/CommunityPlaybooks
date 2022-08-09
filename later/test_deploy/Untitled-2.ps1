# Playbooks this script deploys:
# Reset-AADUserPassword	
# Block-AADUserOrAdmin	
# Revoke-AADSignInSessions

# additional playbook parameters (parameters found in the local ARM template param file)
# subscriptionId (Reset-password)
# resourcegroup  (Reset-password)

param(
    [Parameter(Mandatory = $true)]$ResourceGroup,
    [Parameter(Mandatory = $true)]$Prefix
)

# check resource group
Get-AzResourceGroup -Name $ResourceGroup -ErrorVariable notPresent -ErrorAction SilentlyContinue

if ($notPresent) {
    Write-Warning "This resource group does not exist! Would you like to create it?" -WarningAction Inquire
    
    $Location = Read-Host "Enter the location:"
    
    New-AzResourceGroup -Name $ResourceGroup `
        -Location $Location `
        -Verbose   

}

