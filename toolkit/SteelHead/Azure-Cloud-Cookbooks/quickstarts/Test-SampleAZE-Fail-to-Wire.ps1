<#
    .DESCRIPTION
        Riverbed Community Toolkit
        Cloud Community Cookbooks for Acceleration in Azure

        Test Sample AZE

    .EXAMPLE

        # Deploy sample sandbox AZE in westeurope region, with acceleration and fail-to-wire
        Get-AzContext
        .\quickstarts\Test-SampleAZE-Fail-to-Wire.ps1
#>

param(
$ProjectName = "aze",
$Location = "westeurope", 
$subnetPrefix_acceleration = "10.3.82.0/24",
$subnetPrefixISE1="10.3.253.0/26",
$subnetPrefixISE2="10.3.253.64/26",
$subnetPrefixISE3="10.3.253.128/26",
$subnetPrefixISE4="10.3.253.192/26",
$DeployLogicAppsSimple = $true
) 

$startDate = Get-Date

#region Prerequisites

## Create artifacts folder
if (! (Test-Path "artifacts")) { md artifacts }

## Check Azure account and subscription is connected
Get-AzContext

## or Select-AzSubscription -SubscriptionName Dev

##  Deploy sandbox topology without gateway (post-deployment steps required: deploy gateway appliance, ex. sd-wan) - less than 10 min.
.\101-service-chain-gw-appliance\scripts\Deploy-Sandbox.ps1 -ProjectName $ProjectName -Location $Location -CreateVirtualMachine_gateway skip `
    -templateFilePath "101-service-chain-gw-appliance\azuredeploy-sandbox.json" `
    -templateParameterFilePath  "101-service-chain-gw-appliance\sample\azuredeploy-sandbox.parameters.$ProjectName.json" `
    -artifactsDirectory "artifacts"

#endregion

#region Acceleration

## Create the subnet acceleration - approx. 30 secs
.\101-service-chain-gw-appliance\scripts\Create-SubnetAcceleration.ps1 -ProjectName $ProjectName -Location $Location -subnetPrefix_acceleration $subnetPrefix_acceleration

## Deploy acceleration (post-deployment steps required: configure SteelHead appliance) - less than 10 min.
.\101-service-chain-gw-appliance\scripts\Deploy-Acceleration.ps1 -ProjectName $ProjectName -Location $Location -generateKeypair -fetchVirtualNetworkId `
    -templateFilePath "101-service-chain-gw-appliance\azuredeploy-acceleration.json" `
    -templateParameterFilePath  "101-service-chain-gw-appliance\sample\azuredeploy-acceleration.parameters.$ProjectName.json" `
    -artifactsDirectory "artifacts"

## Deploy route tables  - approx 1 min
.\101-service-chain-gw-appliance\scripts\Deploy-RouteTables.ps1 -ProjectName $ProjectName -Location $Location `
    -templateFilePath  "101-service-chain-gw-appliance\azuredeploy-routetables.json" `
    -templateParameterFilePath  "101-service-chain-gw-appliance\sample\azuredeploy-routetables.parameters.$ProjectName.json" `
    -artifactsDirectory "artifacts"

#endregion

#region Automation

## Deploy Runbook (post-deployment steps required: create RunAsAccount in Automation Account)
.\101-service-chain-gw-appliance\scripts\Deploy-Automation.ps1 -ProjectName  $ProjectName -Location $Location

### Create the runbook - approx. 5 min
.\101-service-chain-gw-appliance\scripts\Create-AccelerationRoutes-Runbook.ps1 -ProjectName  $ProjectName -Location $Location -searchResourcesDetailByName `
    -inputTemplateScriptFile "101-service-chain-gw-appliance\scripts\Template-Runbook-AccelerationRoutes.ps1" `
    -artifactsDirectory "artifacts"

## Deploy ISE - up to 2H
.\101-service-chain-gw-appliance\scripts\Deploy-ISE.ps1 -ProjectName $ProjectName -Location $Location `
    -VirtualNetworkResourceGroupName "$ProjectName-hub-$Location" -VirtualNetworkName "$ProjectName-hub-$Location" `
    -NewSubnetsISE `
    -subnetNameISE1 "ISE1" -subnetNameISE2 "ISE2" -subnetNameISE3 "ISE3" -subnetNameISE4 "ISE4" `
    -subnetPrefixISE1 $subnetPrefixISE1 -subnetPrefixISE2 $subnetPrefixISE2 -subnetPrefixISE3 $subnetPrefixISE3 -subnetPrefixISE4 $subnetPrefixISE4 `
    -templateFilePath  "101-service-chain-gw-appliance\azuredeploy-ise.json" `
    -templateParameterFilePath  "101-service-chain-gw-appliance\sample\azuredeploy-ise.parameters.$ProjectName.json" `
    -artifactsDirectory "artifacts"


### Deploy the Logic Apps
.\101-service-chain-gw-appliance\scripts\Deploy-LogicApps-Simple.ps1 -ProjectName $ProjectName -Location $Location `
    -searchIntegrationServiceEnvironmentIdByName "$ProjectName-ise-$Location" `
    -shFQDN "$ProjectName-sh82.your-private-domain.org" `
    -shApiUsername (ConvertTo-SecureString -AsPlainText -Force "api-user") -shApiPassword (ConvertTo-SecureString -AsPlainText -Force "api-user-password") `
    -generateRunbookWebhook `
    -templateFilePath  "101-service-chain-gw-appliance\azuredeploy-logicapps-simple.json" `
    -templateParameterFilePath  "101-service-chain-gw-appliance\sample\azuredeploy-logicapps-simple.parameters.$ProjectName.json" `
    -artifactsDirectory "artifacts"

#endregion

#####################################

#region Post-Deployment

$endDate = Get-Date
Write-Output "Duration: $($endDate - $startDate)"
Write-Output "---"
Write-Output "Post-deployment configuration required:"
Write-Output "1. Deploy Gateway appliance in the VNET"
Write-Output "2. Configure SteelHead"
Write-Output "3. Create RunAsAccount in Automation"
Write-Output "4. Execute the Runbook to set acceleration"
Write-Output "5. Enable the logic apps"

# Execute the Runbook to set acceleration (requires RunAsAccount to be created)
# Start-AzAutomationRunbook -ResourceGroupName "$ProjectName-acceleration-$Location" -AutomationAccountName "$ProjectName-automation-$Location" -Name "$ProjectName-Runbook-AccelerationRoutes"

#endregion