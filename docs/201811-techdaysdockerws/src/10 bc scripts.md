## 10 Overwrite files
### Example 1: Persists database files to volume
First run: The custom [SetupDatabase.ps1](https://github.com/tfenster/nav-docker-samples/blob/simple-volume-persistence/SetupDatabase.ps1) script sees an empty volume folder and moves the database files there
```PowerShell
PS C:\Users\AdminTechDays> mkdir databasevol

    Directory: C:\Users\AdminTechDays

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----       11/15/2018   8:36 PM                databasevol

PS C:\Users\AdminTechDays> docker run -e accept_eula=y -e volPath=c:\databasevol -e folders="c:\run\my=https://github.com/tfenster/nav-docker-samples/archive/simple-volume-persistence.zip\nav-docker-samples-simple-volume-persistence" -v C:\Users\AdminTechDays\databasevol:c:\databasevol mcr.microsoft.com/businesscentral/onprem
Setting up folders...
Downloading https://github.com/tfenster/nav-docker-samples/archive/simple-volume-persistence.zip to c:\run\my
Extracting file in temp folder
Moving nav-docker-samples-simple-volume-persistence to target folder c:\run\my
Setting up folders took 1 seconds
Initializing...
Starting Container
Hostname is 98362e0a327c
PublicDnsName is 98362e0a327c
Using NavUserPassword Authentication
Starting Local SQL Server
Starting Internet Information Server
Move database to volume
Creating Self Signed Certificate
Self Signed Certificate Thumbprint 2B85482588545DFAE30BD1145099C9FF112446A5
Modifying Service Tier Config File with Instance Specific Settings
Starting NAV Service Tier
Creating DotNetCore Web Server Instance
Creating http download site
Creating Windows user admin
Setting SA Password and enabling SA
Creating admin as SQL User and add to sysadmin
Creating SUPER user
Container IP Address: 172.29.87.24
Container Hostname  : 98362e0a327c
Container Dns Name  : 98362e0a327c
Web Client          : https://98362e0a327c/NAV/
NAV Admin Username  : admin
NAV Admin Password  : Bodi7813
Dev. Server         : https://98362e0a327c
Dev. ServerInstance : NAV

Files:
http://98362e0a327c:8080/al-2.0.43900.vsix
http://98362e0a327c:8080/certificate.cer

You are running a container which is 74 days old.
Microsoft recommends that you always run the latest version of our containers.

Initialization took 63 seconds
Ready for connections!
```
Check C:\Users\AdminTechDays\databasevol to see a new folder with the name of the database and the database files inside it
```PowerShell
PS C:\Users\AdminTechDays> dir .\databasevol\

    Directory: C:\Users\AdminTechDays\databasevol

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----       11/15/2018   8:37 PM                CRONUS

PS C:\Users\AdminTechDays> dir .\databasevol\CRONUS\

    Directory: C:\Users\AdminTechDays\databasevol\CRONUS

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----       11/15/2018   8:37 PM      304414720 Demo Database NAV (13-0)_Data.mdf
-a----       11/15/2018   8:37 PM       22675456 Demo Database NAV (13-0)_Log.ldf
```
- Post an invoice or do something else to change the data
- Remove the container
- Create a new one, referencing the CRONUS folder as database volume

```PowerShell
PS C:\Users\AdminTechDays> docker run -e accept_eula=y -e volPath=c:\databasevol -e folders="c:\run\my=https://github.com/tfenster/nav-docker-samples/archive/simple-volume-persistence.zip\nav-docker-samples-simple-volume-persistence" -v C:\Users\AdminTechDays\databasevol\CRONUS:c:\databasevol mcr.microsoft.com/businesscentral/onprem
Setting up folders...
Downloading https://github.com/tfenster/nav-docker-samples/archive/simple-volume-persistence.zip to c:\run\my
Extracting file in temp folder
Moving nav-docker-samples-simple-volume-persistence to target folder c:\run\my
Setting up folders took 1 seconds
Initializing...
Starting Container
Hostname is 135ea059b854
PublicDnsName is 135ea059b854
Using NavUserPassword Authentication
Starting Local SQL Server
Starting Internet Information Server
Attach database CRONUS
Creating Self Signed Certificate
Self Signed Certificate Thumbprint CB5ACF8513D76FC8576B1FFAA470400290C8A0E2
Modifying Service Tier Config File with Instance Specific Settings
Starting NAV Service Tier
Creating DotNetCore Web Server Instance
Creating http download site
Creating Windows user admin
Setting SA Password and enabling SA
Creating admin as SQL User and add to sysadmin
Container IP Address: 172.29.82.162
Container Hostname  : 135ea059b854
Container Dns Name  : 135ea059b854
Web Client          : https://135ea059b854/NAV/
NAV Admin Username  : admin
NAV Admin Password  : Qaba6747
Dev. Server         : https://135ea059b854
Dev. ServerInstance : NAV

Files:
http://135ea059b854:8080/al-2.0.43900.vsix
http://135ea059b854:8080/certificate.cer

You are running a container which is 74 days old.
Microsoft recommends that you always run the latest version of our containers.

Initialization took 56 seconds
Ready for connections!
```
Open the WebClient with the old (!) password as we have reused the database and see that your changes are still there
### Example 2: Use a LetsEncrypt certificate
Download the [SetupCertificate.ps1](https://github.com/Azure/azure-quickstart-templates/blob/master/101-aci-dynamicsnav/scripts/SetupCertificate.ps1) script through the folders param and pass the public DNS name and the contact eMail for LetsEncrypt in as env params
```PowerShell
PS C:\Users\AdminTechDays> docker run -e accept_eula=y -p 80:80 -p 443:443 -e publicdnsname=preptest.westeurope.cloudapp.azure.com -e contactemailforletsencrypt=tobias.fenster@axians-infoma.de -e folders="c:\run\my=https://github.com/Azure/azure-quickstart-templates/raw/master/101-aci-dynamicsnav/scripts/SetupCertificate.zip" mcr.microsoft.com/businesscentral/onprem
Setting up folders...
Downloading https://github.com/Azure/azure-quickstart-templates/raw/master/101-aci-dynamicsnav/scripts/SetupCertificate.zip to c:\run\my
Extracting file in temp folder
Moving all extracted files to target folder c:\run\my
Setting up folders took 2 seconds
Initializing...
Starting Container
Hostname is d7b0b3ed06d9
PublicDnsName is preptest.westeurope.cloudapp.azure.com
Using NavUserPassword Authentication
Starting Local SQL Server
Starting Internet Information Server
Using LetsEncrypt to create SSL Certificate
Using default website for LetsEncrypt
Installing NuGet PackageProvider
Installing ACMESharp PowerShell modules
Initializing ACMEVault
Registering Contact EMail address and accept Terms Of Service
Creating new dns Identifier
Performing Lets Encrypt challenge to default web site
Requesting certificate
Importing Certificate to LocalMachine\my
DNS identity preptest.westeurope.cloudapp.azure.com
Modifying Service Tier Config File with Instance Specific Settings
Starting NAV Service Tier
Creating DotNetCore Web Server Instance
Creating http download site
Creating Windows user admin
Setting SA Password and enabling SA
Creating admin as SQL User and add to sysadmin
Creating SUPER user
Container IP Address: 172.29.82.237
Container Hostname  : d7b0b3ed06d9
Container Dns Name  : preptest.westeurope.cloudapp.azure.com
Web Client          : https://preptest.westeurope.cloudapp.azure.com/NAV/
NAV Admin Username  : admin
NAV Admin Password  : Zyry4947
Dev. Server         : https://preptest.westeurope.cloudapp.azure.com
Dev. ServerInstance : NAV

Files:
http://preptest.westeurope.cloudapp.azure.com:8080/al-2.0.43900.vsix

You are running a container which is 74 days old.
Microsoft recommends that you always run the latest version of our containers.

Initialization took 154 seconds
Ready for connections!
```
Open the browser on your laptop and go to https://xyz.westeurope.cloudapp.azure.com/NAV/ and validate that you have a valid SSL certificate