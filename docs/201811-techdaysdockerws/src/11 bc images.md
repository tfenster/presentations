## 11 Custom BC image
### Example: Create an image with the database persistence script
Go to dockerfiles\db-persistence and run docker build
```PowerShell
PS C:\Users\AdminTechDays> cd .\dockerfiles\db-persistence\
PS C:\Users\AdminTechDays\dockerfiles\db-persistence> docker build -t mybc .
Sending build context to Docker daemon  6.144kB
Step 1/3 : FROM mcr.microsoft.com/businesscentral/onprem
 ---> c7eafac19823
Step 2/3 : RUN mkdir c:/run/my
 ---> Running in 2cc82e621df8


    Directory: C:\run


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----       11/15/2018   9:00 PM                my


Removing intermediate container 2cc82e621df8
 ---> 2e436ae5b396
Step 3/3 : COPY SetupDatabase.ps1 c:/run/my
 ---> fa0c419b1483
Successfully built fa0c419b1483
Successfully tagged mybc:latest
```
Use that image with the same parameters as before but don't reference the additional script through the folders param as it now is part of the image
```PowerShell
PS C:\Users\AdminTechDays\dockerfiles\db-persistence> docker run -e accept_eula=y -e volPath=c:\databasevol -v C:\Users\AdminTechDays\databasevol\CRONUS:c:\databasevol mybc
Initializing...
Starting Container
Hostname is 6111771493a1
PublicDnsName is 6111771493a1
Using NavUserPassword Authentication
Starting Local SQL Server
Starting Internet Information Server
Attach database CRONUS
Creating Self Signed Certificate
Self Signed Certificate Thumbprint 9B0293154DF5DB4C00D249AA0EEE7C74E5009C24
Modifying Service Tier Config File with Instance Specific Settings
Starting NAV Service Tier
Creating DotNetCore Web Server Instance
Creating http download site
Creating Windows user admin
Setting SA Password and enabling SA
Creating admin as SQL User and add to sysadmin
Container IP Address: 172.29.93.116
Container Hostname  : 6111771493a1
Container Dns Name  : 6111771493a1
Web Client          : https://6111771493a1/NAV/
NAV Admin Username  : admin
NAV Admin Password  : Xazi6277
Dev. Server         : https://6111771493a1
Dev. ServerInstance : NAV

Files:
http://6111771493a1:8080/al-2.0.43900.vsix
http://6111771493a1:8080/certificate.cer

You are running a container which is 74 days old.
Microsoft recommends that you always run the latest version of our containers.

Initialization took 55 seconds
Ready for connections!
```
Open the WebClient and log in (again with the old password) to verify that the persistent database was attached and your changes are still there