## 12 navcontainerhelper
First step: Install
```PowerShell
PS C:\Windows\system32> install-module navcontainerhelper -force
```
### Example 1: Run your first container
Just run New-NavContainer with the minimum set of parameters: accept_eula, containerName and imageName. This defaults to Windows auth, so it will ask for your password
```PowerShell
PS C:\Windows\system32> New-NavContainer -accept_eula -containerName helper -imageName "mcr.microsoft.com/businesscentral/onprem"
Host is Windows Server 10.0.14393.0 - ltsc2016
Using image mcr.microsoft.com/businesscentral/onprem:latest
Removing C:\ProgramData\NavContainerHelper\Extensions\helper
Creating Nav container helper
NAV Version: 13.0.24630.0-W1
Generic Tag: 0.0.6.6
Container OS Version: 10.0.14393.2430 (ltsc2016)
Host OS Version: 10.0.14393.0 (ltsc2016)
Creating container helper from image mcr.microsoft.com/businesscentral/onprem:latest
12c125e8831bfd17ffcd49dbd21f5b4780947957a3a1edf2d9a2c806a1e9361e
Waiting for container helper to be ready
Initializing...
Starting Container
Hostname is helper
PublicDnsName is helper
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
Container IP Address: 172.18.9.91
Container Hostname  : helper
Container Dns Name  : helper
Web Client          : http://helper/NAV/
Dev. Server         : http://helper
Dev. ServerInstance : NAV

Files:
http://helper:8080/al-2.0.43900.vsix

You are running a container which is 76 days old.
Microsoft recommends that you always run the latest version of our containers.

Initialization took 52 seconds
Ready for connections!
Reading CustomSettings.config from helper
Creating Desktop Shortcuts for helper
Nav container helper successfully created
```
Open http://helper/NAV/ or use the link created on your Desktop to check if it has worked. Also note the other links on your Desktop
### Example 2: Compile an extension in a container
Remove the first container and create a new one, this time mapping the source of our AL demo project to c:\src in the container
```PowerShell
PS C:\Windows\system32> New-NavContainer -accept_eula -containerName compile -AdditionalParameters @("-v C:\Users\AdminTechDays\Documents\AL\ALProject1:c:\src") -imageName "mcr
.microsoft.com/businesscentral/onprem"
Host is Windows Server 10.0.14393.0 - ltsc2016
Using image mcr.microsoft.com/businesscentral/onprem:latest
Removing C:\ProgramData\NavContainerHelper\Extensions\compile
Creating Nav container compile
NAV Version: 13.0.24630.0-W1
Generic Tag: 0.0.6.6
Container OS Version: 10.0.14393.2430 (ltsc2016)
Host OS Version: 10.0.14393.0 (ltsc2016)
Creating container compile from image mcr.microsoft.com/businesscentral/onprem:latest
f2f052505370d65145f634cc9a1a5f64b60691f9128c3f5743c519f3beb1331b
Waiting for container compile to be ready
Initializing...
Starting Container
Hostname is compile
PublicDnsName is compile
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
Container IP Address: 172.18.2.98
Container Hostname  : compile
Container Dns Name  : compile
Web Client          : http://compile/NAV/
Dev. Server         : http://compile
Dev. ServerInstance : NAV

Files:
http://compile:8080/al-2.0.43900.vsix

You are running a container which is 76 days old.
Microsoft recommends that you always run the latest version of our containers.

Initialization took 52 seconds
Ready for connections!
Reading CustomSettings.config from compile
Creating Desktop Shortcuts for compile
Nav container compile successfully created
```
Now we can compile the sources inside of the shared folder
```PowerShell
PS C:\Windows\system32> Compile-AppInNavContainer -containerName compile -appProjectFolder "C:\Users\AdminTechDays\Documents\AL\ALProject1\"
Using Symbols Folder: C:\Users\AdminTechDays\Documents\AL\ALProject1\.alpackages
Downloading symbols: Microsoft_Application_13.0.24630.0.app
Downloading symbols: Microsoft_System_13.0.12929.0.app
Compiling...
Microsoft (R) AL Compiler version 2.0.43900
Copyright (C) Microsoft Corporation. All rights reserved

Compilation started for project 'ALProject1' containing '1' files at '22:25:50.246'.

Compilation ended at '22:25:57.912'.

C:\Users\AdminTechDays\Documents\AL\ALProject1\output\Default publisher_ALProject1_1.0.0.0.app successfully created in 54 seconds
C:\Users\AdminTechDays\Documents\AL\ALProject1\output\Default publisher_ALProject1_1.0.0.0.app
```
Check the output folder to see the results
### Example 3: Publish the extension to a container
Create one more container to make sure it really has never seen the app before. Note that we don't need a file share this time
```PowerShell
PS C:\Windows\system32> New-NavContainer -accept_eula -containerName publish -imageName "mcr.microsoft.com/businesscentral/onprem"
Host is Windows Server 10.0.14393.0 - ltsc2016
Using image mcr.microsoft.com/businesscentral/onprem:latest
Creating Nav container publish
NAV Version: 13.0.24630.0-W1
Generic Tag: 0.0.6.6
Container OS Version: 10.0.14393.2430 (ltsc2016)
Host OS Version: 10.0.14393.0 (ltsc2016)
Creating container publish from image mcr.microsoft.com/businesscentral/onprem:latest
dbd87b4de2a3dbe5519d22a70b0472c628fadbb68410eaa6190a2471b6c375ca
Waiting for container publish to be ready
Initializing...
Starting Container
Hostname is publish
PublicDnsName is publish
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
Container IP Address: 172.18.5.112
Container Hostname  : publish
Container Dns Name  : publish
Web Client          : http://publish/NAV/
Dev. Server         : http://publish
Dev. ServerInstance : NAV

Files:
http://publish:8080/al-2.0.43900.vsix

You are running a container which is 76 days old.
Microsoft recommends that you always run the latest version of our containers.

Initialization took 52 seconds
Ready for connections!
Reading CustomSettings.config from publish
Creating Desktop Shortcuts for publish
Nav container publish successfully created
```
Now publish, sync and install the app file. We also need to "skipValidation" as we didn't sign it
```PowerShell
PS C:\Windows\system32> Publish-NavContainerApp -containerName publish -appFile "C:\Users\AdminTechDays\Documents\AL\ALProject1\output\Default publisher_ALProject1_1.0.0.0.app"
 -skipVerification -sync -install
Copy C:\Users\AdminTechDays\Documents\AL\ALProject1\output\Default publisher_ALProject1_1.0.0.0.app to container publish (c:\run\Default publisher_ALProject1_1.0.0.0.app)
Publishing c:\run\Default publisher_ALProject1_1.0.0.0.app
Synchronizing ALProject1 on tenant default
Installing ALProject1 on tenant default
App successfully published
```
Go to http://publish/NAV/ or use the shortcut on your desktop. Go to customers and you will see the Hello World message. You will also find the app in extension management