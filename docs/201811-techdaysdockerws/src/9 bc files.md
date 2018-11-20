## 9 Add files in BC
### Examples 1: Add-in DLLs
```PowerShell
PS C:\Users\AdminTechDays> wget https://www.nuget.org/api/v2/package/RestSharp/106.5.4 -OutFile RestSharp.106.5.4.zip
PS C:\Users\AdminTechDays> Expand-Archive -Path .\RestSharp.106.5.4.zip -DestinationPath RestSharp.106.5.4
PS C:\Users\AdminTechDays> docker run -e accept_eula=y -e auth=windows -e username=AdminTechDays -e password=Passw0rd*123 -v c:\users\AdminTechDays\RestSharp.106.5.4\lib\:c:\run\Add-ins microsoft/dynamics-nav:2018-gb
Initializing...
Starting Container
Hostname is 8f46d676b81b
PublicDnsName is 8f46d676b81b
Using Windows Authentication
Starting Local SQL Server
Starting Internet Information Server
Modifying Service Tier Config File with Instance Specific Settings
Starting NAV Service Tier
Creating DotNetCore Web Server Instance
Creating http download site
Creating Windows user AdminTechDays
Setting SA Password and enabling SA
Creating SUPER user
Container IP Address: 172.29.93.82
Container Hostname  : 8f46d676b81b
Container Dns Name  : 8f46d676b81b
Web Client          : http://8f46d676b81b/NAV/
Dev. Server         : http://8f46d676b81b
Dev. ServerInstance : NAV

Files:
http://8f46d676b81b:8080/al-0.12.28462.vsix

You are running a container which is 74 days old.
Microsoft recommends that you always run the latest version of our containers.

Initialization took 83 seconds
Ready for connections!
```
- Open the previously installed C/SIDE and connect it to the new server to open CronusGB
- Import a dev license
- Create a .NET variable, go to the Assembly List and see "RestSharp" in the Server tab

## Example 2: Download script from GitHub to activate APIs
The zip contains an AdditionalSetup.ps1 which runs COD5465 and that initializes the API ([see here](https://github.com/tfenster/nav-docker-samples/blob/initialize-api/AdditionalSetup.ps1))
```PowerShell
PS C:\Users\AdminTechDays> docker run -e usessl=n -e accept_eula=y -e customNavSettings="ApiServicesEnabled=true" -e folders="c:\run\my=https://github.com/tfenster/nav-docker-samples/archive/initialize-api.zip\nav-docker-samples-initialize-api" microsoft/dynamics-nav:2018-gb
Setting up folders...
Downloading https://github.com/tfenster/nav-docker-samples/archive/initialize-api.zip to c:\run\my
Extracting file in temp folder
Moving nav-docker-samples-initialize-api to target folder c:\run\my
Setting up folders took 1 seconds
Initializing...
Starting Container
Hostname is c9ab8d3bcc03
PublicDnsName is c9ab8d3bcc03
Using NavUserPassword Authentication
Starting Local SQL Server
Starting Internet Information Server
Creating Self Signed Certificate
Self Signed Certificate Thumbprint 50BEE8992C80D592495504EF8C0E7B6D878CC9F1
Modifying Service Tier Config File with Instance Specific Settings
Modifying Service Tier Config File with settings from environment variable
Setting ApiServicesEnabled to true
Starting NAV Service Tier
Creating DotNetCore Web Server Instance
Creating http download site
Creating Windows user admin
Setting SA Password and enabling SA
Creating admin as SQL User and add to sysadmin
Creating SUPER user
Welcome to the NAV Container PowerShell prompt

initialize API Services
Container IP Address: 172.29.93.34
Container Hostname  : c9ab8d3bcc03
Container Dns Name  : c9ab8d3bcc03
Web Client          : http://c9ab8d3bcc03/NAV/
NAV Admin Username  : admin
NAV Admin Password  : Toze1005
Dev. Server         : http://c9ab8d3bcc03
Dev. ServerInstance : NAV

Files:
http://c9ab8d3bcc03:8080/accessdata.html
http://c9ab8d3bcc03:8080/al-0.12.28462.vsix

You are running a container which is 74 days old.
Microsoft recommends that you always run the latest version of our containers.

Initialization took 77 seconds
Ready for connections!
```
For a quick test of the API do the following:
- Download my "ALRunner" extension in VS Code which can also generate an API client
- Call the command "ALRunner: Generate an API client for Business Central" in VS Code
- Enter https://c9ab8d3bcc03:7048/nav for the OData url and username / password from the container log
- Wait for half a minute, the you should get a sample.http file which contains API calls. Click on "send request" e.g. in line 13 to test the API