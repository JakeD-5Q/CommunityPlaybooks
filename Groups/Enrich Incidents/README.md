# Enrichment Playbooks

These are the playbooks that add information to incidents in the form of tags and comments which assists the analysts' investigations.

## Contents

- ARM template parameter files
- PowerShell deploy script
- additional PowerShell scripts (as needed)

For simplicity, you will only find the template parameter file for the playbooks listed below. The deploy script uses these parameters files (with the target tenant's info) and the ARM template found on the Microsoft Sentinel [community Github repository](https://github.com/Azure/Azure-Sentinel) for deployment.

This script is designed to create the resource group if it does not yet exist.

## Instructions

1. Open the Cloud Shell from within the Azure portal
2. Clone this repository
3. Fill out each parameter file with the appropriate information
4. run the deploy script (must know the target resource group name)

**OR** to deploy a single playbook user the buttons below.

### Quick deploy buttons

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FAzure-Sentinel%2Fmaster%2FPlaybooks%2FGet-AlienVault_OTX%2Fazuredeploy.json)

Get-AlienVault-OTX

### temp raw link

https://raw.githubusercontent.com/Azure/Azure-Sentinel/master/Playbooks/Get-AlienVault_OTX/azuredeploy.json


