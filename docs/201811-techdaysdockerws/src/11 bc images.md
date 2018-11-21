## 11 Custom BC image
### Example: Create an image with the API activation script
Go to dockerfiles\api-activate and run docker build
```PowerShell
PS C:\Users\AdminTechDays> cd .\dockerfiles\api-activate\
PS C:\Users\AdminTechDays\dockerfiles\api-activate> docker build -t mybc .
Sending build context to Docker daemon  6.144kB
Step 1/3 : FROM microsoft/dynamics-nav:2018-gb
 ---> c7eafac19823
Step 2/3 : RUN mkdir c:/run/my
 ---> Running in 2cc82e621df8


    Directory: C:\run


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----       11/15/2018   9:00 PM                my


Removing intermediate container 2cc82e621df8
 ---> 2e436ae5b396
Step 3/3 : COPY AdditionalSetup.ps1 c:/run/my
 ---> fa0c419b1483
Successfully built fa0c419b1483
Successfully tagged mybc:latest
```
Use that image with the same parameters as before (see [here](https://tfenster.github.io/presentations/201811-techdaysdockerws/src/9 bc files), example 2) but don't reference the additional script through the folders param as it now is part of the image
```PowerShell
PS C:\Users\AdminTechDays\dockerfiles\db-persistence> docker run -e usessl=n -e accept_eula=y --name api2 --hostname api2 -e customNavSettings="ApiServicesEnabled=true" mybc
Initializing...
Starting Container
Hostname is api2
PublicDnsName is api2
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
Container Hostname  : api2
Container Dns Name  : api2
Web Client          : http://api2/NAV/
NAV Admin Username  : admin
NAV Admin Password  : Toze1005
Dev. Server         : http://api2
Dev. ServerInstance : NAV

Files:
http://api2:8080/al-0.12.28462.vsix

Microsoft recommends that you always run the latest version of our containers.

Initialization took 77 seconds
Ready for connections!
```
Take the same steps as last time to verify that the API service is running and initialized