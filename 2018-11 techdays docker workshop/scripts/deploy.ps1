<#

 Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process

 .SYNOPSIS
    Deploys a template to Azure

 .DESCRIPTION
    Deploys an Azure Resource Manager template

 .PARAMETER resourceGroupName
    The resource group where the template will be deployed. Can be the name of an existing or a new resource group.

 .PARAMETER resourceGroupLocation
    Optional, a resource group location. If specified, will try to create a new resource group in this location. If not specified, assumes resource group is existing.


 .PARAMETER templateFilePath
    Optional, path to the template file. Defaults to template.json.

 .PARAMETER parametersFilePath
    Optional, path to the parameters file. Defaults to parameters.json. If file is not found, will prompt for parameter values based on template.
#>

param(
 [Parameter(Mandatory=$True)]
 [string]
 $id,

 [Parameter(Mandatory=$True)]
 [string]
 $person,

 [Parameter(Mandatory=$True)]
 [string]
 $email
)

<#
.SYNOPSIS
    Registers RPs
#>
Function RegisterRP {
    Param(
        [string]$ResourceProviderNamespace
    )

    Write-Host "Registering resource provider '$ResourceProviderNamespace'";
    Register-AzureRmResourceProvider -ProviderNamespace $ResourceProviderNamespace;
}

function sendmail($body, $to)
{

    #.NET-Objekt f�r den SMTP Server wird erstellt
    $SmtpClient = new-object system.net.mail.smtpClient
    #.NET-Objekt f�r die MailMessage wird erstellt
    $MailMessage = New-Object system.net.mail.mailmessage
    #Dort muss der SMTP Server der Firma eingetragen werden
    $SmtpClient.Host = "smtphub.global.fum"
    #Mailadresse von Sript
    $mailmessage.from = "tfenster@infoma.de" 
    #Mailgruppe die erstellt wurde um den Benutzern eine Info zu geben dass die Datenbank nun aufgebaut ist
    $mailmessage.To.add($to)
    $mailmessage.To.add("tobias.fenster@axians-infoma.de")
    #Dort wird der Betreff eingetragen
    $mailmessage.Subject = "Access information for TechDays Docker workshop"
    #Der Mail-Body ist in Html geschrieben
    $MailMessage.IsBodyHtml = $true
    #Body der Html-Datei wird zugewiesen
    $mailmessage.Body = $body
    #Mail wird mit der Konfiguration die in $mailMassage hinterlegt um sie Senden zu k�nnen
    $smtpclient.Send($mailmessage)
}

function randomchar([string]$str)
{
    $rnd = Get-Random -Maximum $str.length
    [string]$str[$rnd]
}

function Get-RandomPassword {
    $cons = 'bcdfghjklmnpqrstvwxz'
    $voc = 'aeiouy'
    $numbers = '0123456789'

    ((randomchar $cons).ToUpper() + `
     (randomchar $voc) + `
     (randomchar $cons) + `
     (randomchar $voc) + `
     (randomchar $cons) + `
     (randomchar $voc) + `
     (randomchar $numbers) + `
     (randomchar $numbers) + `
     (randomchar $numbers) + `
     (randomchar $numbers) + `
     (randomchar $numbers) + `
     (randomchar $numbers))
}



#******************************************************************************
# Script body
# Execution begins here
#******************************************************************************
$ErrorActionPreference = "Stop"

$resourceGroupName = "td18" + $id;
$deploymentName = "deploy" + $resourceGroupName;
$templateFilePath = "template.json";
$resourceGroupLocation = "West Europe";
$bigname = $id + "big";
$smallname = $id + "small";
$password = Get-RandomPassword;
Write-Host $password;
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force

$body = "<p>Hello $person<br />&nbsp;<br />your access information for the Azure VMs provided by <a href=`"https://www.axians.com`">Axians</a>:";
$body += "<br />&nbsp;<br />Big VM (Docker Host) name: ${bigname}.westeurope.cloudapp.azure.com<br />";
$body += "Small VM (Client) name: ${smallname}.westeurope.cloudapp.azure.com<br />";
$body += "User: AdminTechDays, Password: $password<br />";
$body += "<br />&nbsp;<br />Have fun!<br />";
$body += "Tobias</p>"

# sign in
Write-Host "Logging in...";
#Login-AzureRmAccount;
$subscriptionId = "afbfb5e1-6f11-4f0d-86f7-83641110b2aa"; # VS Enterprise
#$subscriptionId = "83c5fb47-3f1e-4e70-9e21-32540ed41437"; # Tobias Fenster

# select subscription
Write-Host "Selecting subscription '$subscriptionId'";
Select-AzureRmSubscription -SubscriptionID $subscriptionId;

# Register RPs
$resourceProviders = @("microsoft.network","microsoft.compute","microsoft.storage");
if($resourceProviders.length) {
    Write-Host "Registering resource providers"
    foreach($resourceProvider in $resourceProviders) {
        RegisterRP($resourceProvider);
    }
}

#Create or check for existing resource group
$resourceGroup = Get-AzureRmResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue
if(!$resourceGroup)
{
    Write-Host "Resource group '$resourceGroupName' does not exist. To create a new resource group, please enter a location.";
    if(!$resourceGroupLocation) {
        $resourceGroupLocation = Read-Host "resourceGroupLocation";
    }
    Write-Host "Creating resource group '$resourceGroupName' in location '$resourceGroupLocation'";
    New-AzureRmResourceGroup -Name $resourceGroupName -Location $resourceGroupLocation
}
else{
    Write-Host "Using existing resource group '$resourceGroupName'";
}

# Start the deployment
Write-Host "Starting big deployment...";
#New-AzureRmResourceGroupDeployment -Name ($deploymentName + "_big") -ResourceGroupName $resourceGroupName -TemplateFile $templateFilePath `
#    -TemplateParameterFile parameters_big.json -adminPassword $securePassword -publicIpAddressDnsLabel $bigname;
Write-Host "Starting small deployment...";
#New-AzureRmResourceGroupDeployment -Name ($deploymentName + "_small") -ResourceGroupName $resourceGroupName -TemplateFile $templateFilePath `
#    -TemplateParameterFile parameters_small.json -adminPassword $securePassword -publicIpAddressDnsLabel $smallname;

Write-Host "Sending mail...";
sendmail($body, $email);

#Get-AzureRmResourceGroup -Name "td18*" | Remove-AzureRmResourceGroup -Verbose -Force -AsJob
