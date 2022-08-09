param(
    [Parameter(Mandatory = $true)]$Prefix
)

function New-PbName() {
    param(
        [Parameter(Mandatory = $true)]$Prefix
    )

    $NewName = $Prefix + "$.$PlaybookName"
    return $NewName
}

$Name = "Isolate-MDEMachine"
$NewName = New-PbName($Name, $Prefix)
.\Isolate-MDEMachine.permissions.ps1 -PlaybookName $NewName

$Name = "Unisolate-MDEMachine"
$NewName = New-PbName($Name, $Prefix)
.\Unisolate-MDEMachine.permissions.ps1 -PlaybookName $NewName

$Name = "Remove-MDEAppExecution"
$NewName = New-PbName($Name, $Prefix)
.\Remove-MDEAppExecution.permissions.ps1 -PlaybookName $NewName