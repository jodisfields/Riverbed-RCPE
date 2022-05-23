# Riverbed Community Cookbooks - AppResponse Simple Demo

[![Deploy to Azure](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Friverbed%2FRiverbed-Community-Toolkit%2Fmaster%2FAppResponse%2FAzure-Cloud-Cookbooks%2F101-appresponse-simple-demo%2Fazuredeploy.json) [![Deploy to Azure Gov](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazuregov.svg?sanitize=true)](https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Friverbed%2FRiverbed-Community-Toolkit%2Fmaster%2FAppResponse%2FAzure-Cloud-Cookbooks%2F101-appresponse-simple-demo%2Fazuredeploy.json)

Deploy a simple demo topology for [Riverbed AppResponse](https://www.riverbed.com/products/npm/appresponse) in your own Azure Cloud subscription in just few clicks with the Riverbed Community Toolkit provided by the [Riverbed Community](https://community.riverbed.com/).

Have a try and join the [Riverbed Community](https://community.riverbed.com/) to discuss.

![Topology diagram](images/appresponse-simple-demo.svg)

## Deployment Steps

1. Hit the "Deploy to Azure" button above
2. Fill usual fields:
    - Subscription
    - Resource Group: create a new, e.g. Riverbed-AppResponse-Demo
    - Region: Select an Azure Region
3. Fill the parameters
    - Version: Select the AppResponse version among the version supported by the template
    - Appliance Source Image Blob Uri: uri of the Blob containing the VHD of AppResponse. Contact [Riverbed TAC](https://support.riverbed.com) to get a standard uri with a temporary SAS Token.
    - Appliance Size: Size of the Azure VM, Standard_B8ms is a minimum
    - Demo Jumpbox Username: Default is riverbed-community
    - Demo Jumpbox Password: Set a password with enough complexity (8 characters lengths, 1 or more numeric, 1 or more special characters)
4. Hit "Review + create", then hit "Create"
5. Wait for the deployment, approximately 5 to 10 min depending on the region.

## Usage

When the deployment is done, you can grab the the default admin credential from the deployment outputs. They will be required next to log on the appliance webconsole

![Grab outputs](images/appresponse-simple-demo-outputs.png)

In the Azure Portal, navigate to the resource group. Then find the virtual machine named "Visibility" and connect via the Bastion using the Jumpbox username and password set in the deployment steps.

![Bastion](images/visibility-connect-bastion.png)

On the Jumpbox you can launch the web browser, navigate to the AppResponse webconsole url https://10.100.5.51 and log in with the initial admin credential of the appliance (previously grabbed from the deployment outputs).

![AppResponse first login inside Bastion](images/appresponse-simple-demo-bastion-login.png)


## Notes

`Tags: Riverbed,Visibility,NPM,Network,Performance,Monitoring,AppResponse,Packet,Capture`
