## 8 Business Central parameters
### Example 1: Use Windows authentication and enable ClickOnce
Start a container with windows auth, give it your local username and password and enable ClickOnce
```PowerShell
PS C:\Users\AdminTechDays\dockerfiles> docker run -e accept_eula=y -e auth=windows -e username=AdminTechDays -e password=Passw0rd*123 -e clickonce=y microsoft/dynamics-nav:2018-gb
Unable to find image 'microsoft/dynamics-nav:2018-gb' locally
2018-gb: Pulling from microsoft/dynamics-nav
3889bb8d808b: Already exists
6631c2d2a60c: Already exists
b09a40692579: Already exists
4c7043fb7dcf: Already exists
441033c6fa66: Already exists
5c137b6fb78e: Already exists
c5690c9b6567: Already exists
783086f9dfcf: Already exists
eec8ca706f18: Already exists
2fa2abf24848: Already exists
af0072000551: Already exists
1dc934206b95: Already exists
f89b887cfa8c: Already exists
037a25574f02: Already exists
9b81ed866659: Pull complete
8cd020b224e5: Pull complete
948c25f3b573: Pull complete
bfce454a6b51: Pull complete
9747363ab1c1: Pull complete
2324a877d043: Pull complete
cbc6f2d8517c: Pull complete
44b3df1a0540: Pull complete
Digest: sha256:1bf68de3fcaadec5f1bda5bacd16efdcd41a798a226f5a085607a2ae276f4ccd
Status: Downloaded newer image for microsoft/dynamics-nav:2018-gb
Initializing...
Starting Container
Hostname is 4327d66c1e57
PublicDnsName is 4327d66c1e57
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
Creating ClickOnce Manifest
Container IP Address: 172.29.94.127
Container Hostname  : 4327d66c1e57
Container Dns Name  : 4327d66c1e57
Web Client          : http://4327d66c1e57/NAV/
Dev. Server         : http://4327d66c1e57
Dev. ServerInstance : NAV
ClickOnce Manifest  : http://4327d66c1e57:8080/NAV

Files:
http://4327d66c1e57:8080/al-0.12.28462.vsix

You are running a container which is 72 days old.
Microsoft recommends that you always run the latest version of our containers.

Initialization took 80 seconds
Ready for connections!
```
Test SSO by opening http://4327d66c1e57/NAV/ in your browser and install the Windows Client by going to http://4327d66c1e57:8080/NAV with IE and install it through ClickOnce. You can also install and use C/SIDE through ClickOnce including table schema syncs as we are using win auth. Make sure to install the Visual C++ 2013 Redistributable (x86) from https://download.microsoft.com/download/2/E/6/2E61CFA4-993B-4DD4-91DA-3737CD5CD6E3/vcredist_x86.exe and the SQL native client from the ClickOnce site. Connect it to 4327d66c1e57 as server  
Don't stop the container as we'll use the database in the next example
## Example 2: Connect the container to an external SQL Server
We want to use the database from our previous container, so let's enter it and stop SQL server so that we can savely copy the files
```PowerShell
PS C:\Users\AdminTechDays> docker exec -ti 43 powershell
Windows PowerShell
Copyright (C) 2016 Microsoft Corporation. All rights reserved.

PS C:\> stop-service MSSQL`$SQLEXPRESS
PS C:\> exit
```
Create a folder on the host for the databases and copy the files, make sure they were copied
```PowerShell
PS C:\Users\AdminTechDays> docker cp 43:c:\databases\ .
PS C:\Users\AdminTechDays> dir .\databases\CronusGB\

    Directory: C:\Users\AdminTechDays\databases\CronusGB

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----       11/13/2018   9:42 PM      261554176 Demo Database NAV (11-0)_Data.mdf
-a----       11/13/2018   9:42 PM       22675456 Demo Database NAV (11-0)_Log.ldf

```
Remove our previous container and start a SQL Server container that uses our files
```PowerShell
PS C:\Users\AdminTechDays> docker rm -f 43
PS C:\Users\AdminTechDays> docker run --hostname sql --rm -v C:/Users/AdminTechDays/databases/:C:/databases/ -e sa_password=Passw0rd*123 -e ACCEPT_EULA=Y -e attach_dbs="[{'dbName':'CronusGB','dbFiles':['C:\\databases\\CronusGB\\Demo Database NAV (11-0)_Data.mdf','C:\\databases\\CronusGB\\Demo Database NAV (11-0)_Log.ldf']}]" microsoft/mssql-server-windows-express
VERBOSE: Starting SQL Server
VERBOSE: Changing SA login credentials
VERBOSE: Attaching 1 database(s)
VERBOSE: Invoke-Sqlcmd -Query IF EXISTS (SELECT 1 FROM SYS.DATABASES WHERE NAME
 = 'CronusGB') BEGIN EXEC sp_detach_db [CronusGB] END;CREATE DATABASE
[CronusGB] ON (FILENAME = N'C:\databases\CronusGB\Demo Database NAV
(11-0)_Data.mdf'),(FILENAME = N'C:\databases\CronusGB\Demo Database NAV
(11-0)_Log.ldf') FOR ATTACH;
VERBOSE: Started SQL Server.
```
Start the container with the same config as above, but now tell it to connect to the existing SQL server
```PowerShell
PS C:\Users\AdminTechDays> docker run -e accept_eula=y -e auth=windows -e username=AdminTechDays -e password=Passw0rd*123 -e databaseusername=sa -e databasepassword=Passw0rd*123 -e databaseserver=sql -e databasename=CronusGB microsoft/dynamics-nav:2018-gb
Initializing...
Starting Container
Hostname is f3eb3ae0b0b1
PublicDnsName is f3eb3ae0b0b1
Using Windows Authentication
Starting Internet Information Server
Import Encryption Key
Modifying Service Tier Config File with Instance Specific Settings
Starting NAV Service Tier
Creating DotNetCore Web Server Instance
Creating http download site
Creating Windows user AdminTechDays
Container IP Address: 172.29.92.179
Container Hostname  : f3eb3ae0b0b1
Container Dns Name  : f3eb3ae0b0b1
Web Client          : http://f3eb3ae0b0b1/NAV/
Dev. Server         : http://f3eb3ae0b0b1
Dev. ServerInstance : NAV

Files:
http://f3eb3ae0b0b1:8080/al-0.12.28462.vsix

You are running a container which is 72 days old.
Microsoft recommends that you always run the latest version of our containers.

Initialization took 31 seconds
Ready for connections!
```
Notice how quick the initialization now is as we are using an already up and running SQL server. Open http://f3eb3ae0b0b1/NAV/ again to verify the connection. Use the task manager to verify that only one sqlservr.exe is running. If you want, make a change like posting a sales order, remove the NAV container and start a new one to verify that your change is still there
```PowerShell
PS C:\Users\AdminTechDays> docker rm -f f3
f3
PS C:\Users\AdminTechDays> docker run -e accept_eula=y -e auth=windows -e username=AdminTechDays -e password=Passw0rd*123 -e databaseusername=sa -e databasepassword=Passw0rd*123 -e databaseserver=sql -e databasename=CronusGB microsoft/dynamics-nav:2018-gb
Initializing...
Starting Container
Hostname is d5776d8007de
PublicDnsName is d5776d8007de
Using Windows Authentication
Starting Internet Information Server
Import Encryption Key
Modifying Service Tier Config File with Instance Specific Settings
Starting NAV Service Tier
Creating DotNetCore Web Server Instance
Creating http download site
Creating Windows user AdminTechDays
Container IP Address: 172.29.82.156
Container Hostname  : d5776d8007de
Container Dns Name  : d5776d8007de
Web Client          : http://d5776d8007de/NAV/
Dev. Server         : http://d5776d8007de
Dev. ServerInstance : NAV

Files:
http://d5776d8007de:8080/al-0.12.28462.vsix

You are running a container which is 72 days old.
Microsoft recommends that you always run the latest version of our containers.

Initialization took 29 seconds
Ready for connections!
```
Open http://d5776d8007de/NAV/ and you will see that your change is still there.  
Now let's put this into a compose file. You find one prepared under dockerfiles\bc-external. Stop the running containers, then go there and do a `docker-compose up`. Wait until it has started, test the connection and stop it again by pressing Ctrl-C in the compose process
```PowerShell
 docker-compose.exe up
Creating documents_sql_1_8ad18e6e3f29 ... done
Creating documents_nav_1_dcde7ae0bf2b ... done
Attaching to documents_sql_1_495e804e64cd, documents_nav_1_647b459e6a44
sql_1_495e804e64cd | VERBOSE: Starting SQL Server
sql_1_495e804e64cd | VERBOSE: Changing SA login credentials
sql_1_495e804e64cd | VERBOSE: Attaching 1 database(s)
sql_1_495e804e64cd | VERBOSE: Invoke-Sqlcmd -Query IF EXISTS (SELECT 1 FROM SYS.DATABASES WHERE NAME
sql_1_495e804e64cd |  = 'CronusGB') BEGIN EXEC sp_detach_db [CronusGB] END;CREATE DATABASE
sql_1_495e804e64cd | [CronusGB] ON (FILENAME = N'C:\databases\CronusGB\Demo Database NAV
sql_1_495e804e64cd | (11-0)_Data.mdf'),(FILENAME = N'C:\databases\CronusGB\Demo Database NAV
sql_1_495e804e64cd | (11-0)_Log.ldf') FOR ATTACH;
sql_1_495e804e64cd | Converting database 'CronusGB' from version 852 to the current version 869.
sql_1_495e804e64cd | Database 'CronusGB' running the upgrade step from version 852 to version 853.
sql_1_495e804e64cd | Database 'CronusGB' running the upgrade step from version 853 to version 854.
sql_1_495e804e64cd | Database 'CronusGB' running the upgrade step from version 854 to version 855.
sql_1_495e804e64cd | Database 'CronusGB' running the upgrade step from version 855 to version 856.
sql_1_495e804e64cd | Database 'CronusGB' running the upgrade step from version 856 to version 857.
sql_1_495e804e64cd | Database 'CronusGB' running the upgrade step from version 857 to version 858.
sql_1_495e804e64cd | Database 'CronusGB' running the upgrade step from version 858 to version 859.
sql_1_495e804e64cd | Database 'CronusGB' running the upgrade step from version 859 to version 860.
sql_1_495e804e64cd | Database 'CronusGB' running the upgrade step from version 860 to version 861.
sql_1_495e804e64cd | Database 'CronusGB' running the upgrade step from version 861 to version 862.
sql_1_495e804e64cd | Database 'CronusGB' running the upgrade step from version 862 to version 863.
sql_1_495e804e64cd | Database 'CronusGB' running the upgrade step from version 863 to version 864.
sql_1_495e804e64cd | Database 'CronusGB' running the upgrade step from version 864 to version 865.
sql_1_495e804e64cd | Database 'CronusGB' running the upgrade step from version 865 to version 866.
sql_1_495e804e64cd | Database 'CronusGB' running the upgrade step from version 866 to version 867.
sql_1_495e804e64cd | Database 'CronusGB' running the upgrade step from version 867 to version 868.
sql_1_495e804e64cd | Database 'CronusGB' running the upgrade step from version 868 to version 869.
sql_1_495e804e64cd | VERBOSE: Started SQL Server.
sql_1_495e804e64cd |
nav_1_647b459e6a44 | Initializing...
nav_1_647b459e6a44 | Starting Container
nav_1_647b459e6a44 | Hostname is a32291789fba
nav_1_647b459e6a44 | PublicDnsName is a32291789fba
nav_1_647b459e6a44 | Using Windows Authentication
nav_1_647b459e6a44 | Starting Internet Information Server
nav_1_647b459e6a44 | Import Encryption Key
sql_1_495e804e64cd | TimeGenerated            EntryType Message
sql_1_495e804e64cd | -------------            --------- -------
sql_1_495e804e64cd | 11/17/2018 11:26:26 PM Information Parallel redo is shutdown for database 'C...
sql_1_495e804e64cd | 11/17/2018 11:26:26 PM Information 0 transactions rolled back in database 'C...
sql_1_495e804e64cd | 11/17/2018 11:26:26 PM Information 1 transactions rolled forward in database...
sql_1_495e804e64cd | 11/17/2018 11:26:26 PM Information Parallel redo is started for database 'Cr...
sql_1_495e804e64cd | 11/17/2018 11:26:26 PM Information Starting up database 'CronusGB'.
sql_1_495e804e64cd | 11/17/2018 11:26:32 PM Information Parallel redo is shutdown for database 'C...
sql_1_495e804e64cd | 11/17/2018 11:26:32 PM Information Parallel redo is started for database 'Cr...
sql_1_495e804e64cd | 11/17/2018 11:26:32 PM Information Starting up database 'CronusGB'.
nav_1_647b459e6a44 | Modifying Service Tier Config File with Instance Specific Settings
nav_1_647b459e6a44 | Starting NAV Service Tier
sql_1_495e804e64cd | 11/17/2018 11:26:33 PM Information Parallel redo is shutdown for database 'C...
sql_1_495e804e64cd | 11/17/2018 11:26:33 PM Information Parallel redo is started for database 'Cr...
sql_1_495e804e64cd | 11/17/2018 11:26:33 PM Information Starting up database 'CronusGB'.
nav_1_647b459e6a44 | Creating DotNetCore Web Server Instance
nav_1_647b459e6a44 | Creating http download site
nav_1_647b459e6a44 | Creating Windows user AdminTechDays
nav_1_647b459e6a44 | Container IP Address: 172.18.13.32
nav_1_647b459e6a44 | Container Hostname  : a32291789fba
nav_1_647b459e6a44 | Container Dns Name  : a32291789fba
nav_1_647b459e6a44 | Web Client          : http://a32291789fba/NAV/
nav_1_647b459e6a44 | Dev. Server         : http://a32291789fba
nav_1_647b459e6a44 | Dev. ServerInstance : NAV
nav_1_647b459e6a44 |
nav_1_647b459e6a44 | Files:
nav_1_647b459e6a44 | http://a32291789fba:8080/al-0.12.28462.vsix
nav_1_647b459e6a44 |
nav_1_647b459e6a44 | You are running a container which is 76 days old.
nav_1_647b459e6a44 | Microsoft recommends that you always run the latest version of our containers.
nav_1_647b459e6a44 |
nav_1_647b459e6a44 | Initialization took 28 seconds
nav_1_647b459e6a44 | Ready for connections!
nav_1_647b459e6a44 |
nav_1_647b459e6a44 |
nav_1_647b459e6a44 | TimeGenerated : 11/17/2018 11:27:40 PM
nav_1_647b459e6a44 | EntryType     : Warning
nav_1_647b459e6a44 | Message       : Server instance: NAV
nav_1_647b459e6a44 |                 Category: Runtime
nav_1_647b459e6a44 |                 ClientSessionId: d03f077a-6195-4e77-bc33-d1e0945000ea
nav_1_647b459e6a44 |                 ClientActivityId: 83fb0399-781a-4401-bc3d-084a83dd4309
nav_1_647b459e6a44 |                 ServerSessionUniqueId: 70615c80-172e-451d-80fe-d5b9b0904cd8
nav_1_647b459e6a44 |                 ServerActivityId: 0df7ae62-802a-4f6c-b6b7-632273776850
nav_1_647b459e6a44 |                 EventTime: 11/17/2018 23:27:40
nav_1_647b459e6a44 |                 Message Action completed successfully, but it took longer than
nav_1_647b459e6a44 |                 the given threshold.
nav_1_647b459e6a44 |                   Execution time: 5901 ms
nav_1_647b459e6a44 |                   Threshold: 1000 ms
nav_1_647b459e6a44 |                   Message: InvokeOpenCompany
nav_1_647b459e6a44 |                 ProcessId: 13184
nav_1_647b459e6a44 |                 Tag: 00000MA
nav_1_647b459e6a44 |                 ThreadId: 6
nav_1_647b459e6a44 |                 CounterInformation:
nav_1_647b459e6a44 |
nav_1_647b459e6a44 |
nav_1_647b459e6a44 |
Gracefully stopping... (press Ctrl+C again to force)
Stopping documents_nav_1_647b459e6a44 ... done
Stopping documents_sql_1_495e804e64cd ... done
```
If that was our production environment, how could we get a copy, e.g. as staging environment? Copy the database files and also the compose file
```PowerShell
PS C:\Users\AdminTechDays> copy -r .\databases\ databases_staging
PS C:\Users\AdminTechDays> cd dockerfiles\bc-external
PS C:\Users\AdminTechDays\dockerfiles\bc-external> copy .\docker-compose.yml .\docker-compose.staging.yml
```
Now edit the docker-compose.staging.yml so that the two services are called sql-staging and nav-staging, the sql hostname is sql-staging, the volume in sql points to databases_staging and the database server and depends in NAV is called sql-staging. With that, let's do a compose up again, this time with `-d` to start it in the background. After the creation has started we also start our regular environment as well
```PowerShell
PS C:\Users\AdminTechDays\dockerfiles\bc-external> docker-compose.exe -f .\docker-compose.staging.yml up -d
Creating bc-external_sql-staging_1_d5aa48bd4288 ... done
Creating bc-external_nav-staging_1_3604e1238e4f ... done
PS C:\Users\AdminTechDays\dockerfiles\bc-external> docker-compose.exe -f .\docker-compose.yml up -d
WARNING: Found orphan containers (bc-external_nav-staging_1_1dad5992619f, bc-external_sql-staging_1_7108a74a56cf) for this project. If you removed or renamed this service in your compose file, you can run this command with the --remove-orphans flag to clean it up.
Creating bc-external_sql_1_36a21b991a41 ... done
Creating bc-external_nav_1_157a079f1100 ... done
```
Now we have four containers: Two SQL Servers and two NAV Servers, one each for production and staging. Connect to those WebClients to make sure you can change the data independently
```PowerShell
PS C:\Users\AdminTechDays\dockerfiles\bc-external> docker ps
CONTAINER ID        IMAGE                                    COMMAND                  CREATED             STATUS                   PORTS                                                NAMES
31b3b4fb1a1f        microsoft/dynamics-nav:2018-gb           "powershell -Command…"   2 minutes ago       Up 2 minutes (healthy)   80/tcp, 443/tcp, 1433/tcp, 7045-7049/tcp, 8080/tcp   bc-external_nav_1_7d478c994631
456a31e39ccc        microsoft/mssql-server-windows-express   "powershell -Command…"   2 minutes ago       Up 2 minutes                                                                  bc-external_sql_1_d28b0ce49dc1
4b38889c11e6        microsoft/dynamics-nav:2018-gb           "powershell -Command…"   2 minutes ago       Up 2 minutes (healthy)   80/tcp, 443/tcp, 1433/tcp, 7045-7049/tcp, 8080/tcp   bc-external_nav-staging_1_1dad5992619f
b55edd6a1318        microsoft/mssql-server-windows-express   "powershell -Command…"   2 minutes ago       Up 2 minutes                                                                  bc-external_sql-staging_1_7108a74a56cf
PS C:\Users\AdminTechDays\dockerfiles\bc-external> docker logs 31
Initializing...
Starting Container
Hostname is 31b3b4fb1a1f
PublicDnsName is 31b3b4fb1a1f
Using Windows Authentication
Starting Internet Information Server
Import Encryption Key
Modifying Service Tier Config File with Instance Specific Settings
Starting NAV Service Tier
Creating DotNetCore Web Server Instance
Creating http download site
Creating Windows user AdminTechDays
Container IP Address: 172.18.3.140
Container Hostname  : 31b3b4fb1a1f
Container Dns Name  : 31b3b4fb1a1f
Web Client          : http://31b3b4fb1a1f/NAV/
Dev. Server         : http://31b3b4fb1a1f
Dev. ServerInstance : NAV

Files:
http://31b3b4fb1a1f:8080/al-0.12.28462.vsix

You are running a container which is 76 days old.
Microsoft recommends that you always run the latest version of our containers.

Initialization took 31 seconds
Ready for connections!
PS C:\Users\AdminTechDays\dockerfiles\bc-external> docker logs 4b
Initializing...
Starting Container
Hostname is 4b38889c11e6
PublicDnsName is 4b38889c11e6
Using Windows Authentication
Starting Internet Information Server
Import Encryption Key
Modifying Service Tier Config File with Instance Specific Settings
Starting NAV Service Tier
Creating DotNetCore Web Server Instance
Creating http download site
Creating Windows user AdminTechDays
Container IP Address: 172.18.2.221
Container Hostname  : 4b38889c11e6
Container Dns Name  : 4b38889c11e6
Web Client          : http://4b38889c11e6/NAV/
Dev. Server         : http://4b38889c11e6
Dev. ServerInstance : NAV

Files:
http://4b38889c11e6:8080/al-0.12.28462.vsix

You are running a container which is 76 days old.
Microsoft recommends that you always run the latest version of our containers.

Initialization took 32 seconds
Ready for connections!
PS C:\Users\AdminTechDays\dockerfiles\bc-external>
```
## Example 3: Change ports
Create a new BC sandbox container with port 7050 for the developer services and disabled SSL so that we don't have to tinker with cert files
```PowerShell
PS C:\Users\AdminTechDays> docker run -e accept_eula=y -e developerServicesPort=7050 microsoft/bcsandbox:us
Initializing...
Starting Container
Hostname is 7186f3f519bb
PublicDnsName is 7186f3f519bb
Using NavUserPassword Authentication
Starting Local SQL Server
Starting Internet Information Server
Creating Self Signed Certificate
Self Signed Certificate Thumbprint 3544BA82651F0B0F1D2E6A1AAF5CE4D2BE3201EA
Modifying Service Tier Config File with Instance Specific Settings
Starting Service Tier
Creating DotNetCore Web Server Instance
Enabling Financials User Experience
Creating http download site
Creating Windows user admin
Setting SA Password and enabling SA
Creating admin as SQL User and add to sysadmin
Creating SUPER user
Container IP Address: 172.29.90.253
Container Hostname  : 7186f3f519bb
Container Dns Name  : 7186f3f519bb
Web Client          : http://7186f3f519bb/NAV/
Admin Username      : admin
Admin Password      : Ciro9165
Dev. Server         : http://7186f3f519bb
Dev. ServerInstance : NAV

Files:
http://7186f3f519bb:8080/al-2.0.48254.vsix

Initialization took 73 seconds
Ready for connections!
```
Download http://7186f3f519bb:8080/al-2.0.48254.vsix and install it in VS Code. Run command "AL: Go!" in VS code and select "Your own server" when asked to choose a server. Change the server in launch.json to http://7186f3f519bb, add a new setting for port 7050 and set the serverInstance to NAV
```JSON
{
    "version": "0.2.0",
    "configurations": [
        {
            "type": "al",
            "request": "launch",
            "name": "Your own server",
            "server": "http://7186f3f519bb",
            "port": 7050,
            "serverInstance": "NAV",
            "authentication": "UserPassword",
            "startupObjectId": 22,
            "startupObjectType": "Page",
            "breakOnError": true
        }
    ]
}
```
Hit F5 to publish your application and enter the username and password from your container log
## Example 4: Bring your own licensefile
Share your licensefile somewhere accessible and add that URL as env param to your docker run command. We are also enabling ClickOnce for easy access to the license information through C/SIDE
```PowerShell
PS C:\Users\AdminTechDays> docker run -e accept_eula=y -e licensefile=https://dl.dropboxusercontent.com/s/u0pop17ruouk8xl/BCDev20181012.flf -e clickonce=y mcr.microsoft.com/businesscentral/onprem
Unable to find image 'mcr.microsoft.com/businesscentral/onprem:latest' locally
latest: Pulling from businesscentral/onprem
3889bb8d808b: Already exists
6631c2d2a60c: Already exists
b09a40692579: Already exists
4c7043fb7dcf: Already exists
441033c6fa66: Already exists
5c137b6fb78e: Already exists
c5690c9b6567: Already exists
783086f9dfcf: Already exists
eec8ca706f18: Already exists
2fa2abf24848: Already exists
af0072000551: Already exists
1dc934206b95: Already exists
f89b887cfa8c: Already exists
037a25574f02: Already exists
844f63f71ea9: Already exists
471567da4404: Already exists
d5a84de5a425: Already exists
d5e80be3d5de: Already exists
Digest: sha256:87ff32982ddd6357e61c7924e3f67cc979e9ff02bebb9624a462498b48eabbfe
Status: Downloaded newer image for mcr.microsoft.com/businesscentral/onprem:latest
Initializing...
Starting Container
Hostname is 74bd7bd18296
PublicDnsName is 74bd7bd18296
Using NavUserPassword Authentication
Starting Local SQL Server
Starting Internet Information Server
Creating Self Signed Certificate
Self Signed Certificate Thumbprint 0D1FCCEA03D4545106C92042D461C8005FB03149
Modifying Service Tier Config File with Instance Specific Settings
Starting NAV Service Tier
Downloading license file 'https://dl.dropboxusercontent.com/s/u0pop17ruouk8xl/BCDev20181012.flf'
Import License
Creating DotNetCore Web Server Instance
Creating http download site
Creating Windows user admin
Setting SA Password and enabling SA
Creating admin as SQL User and add to sysadmin
Creating SUPER user
Creating ClickOnce Manifest
Container IP Address: 172.29.83.174
Container Hostname  : 74bd7bd18296
Container Dns Name  : 74bd7bd18296
Web Client          : https://74bd7bd18296/NAV/
NAV Admin Username  : admin
NAV Admin Password  : Gogi0605
Dev. Server         : https://74bd7bd18296
Dev. ServerInstance : NAV
ClickOnce Manifest  : http://74bd7bd18296:8080/NAV

Files:
http://74bd7bd18296:8080/al-2.0.43900.vsix
http://74bd7bd18296:8080/certificate.cer

You are running a container which is 72 days old.
Microsoft recommends that you always run the latest version of our containers.

Initialization took 119 seconds
Ready for connections!
```
Go to http://74bd7bd18296:8080/NAV and install C/SIDE or the Windows Client and use them to get the license information
## Example 5: custom NST and Web settings
Configure the container to disable Excel export (NST setting) and change the name of the product visible in the Web Client (Web setting)
```PowerShell
PS C:\Users\AdminTechDays> docker run -e accept_eula=y -e customNavSettings=EnableSaveToExcelForRdlcReports=false -e customWebSettings=Productname=TechDays mcr.microsoft.com/businesscentral/onprem
Initializing...
Starting Container
Hostname is b3314515b95a
PublicDnsName is b3314515b95a
Using NavUserPassword Authentication
Starting Local SQL Server
Starting Internet Information Server
Creating Self Signed Certificate
Self Signed Certificate Thumbprint 094F29D88730E55261105D3A14B4806238628DD1
Modifying Service Tier Config File with Instance Specific Settings
Modifying Service Tier Config File with settings from environment variable
Setting EnableSaveToExcelForRdlcReports to false
Starting NAV Service Tier
Creating DotNetCore Web Server Instance
Modifying Web Client config with settings from environment variable
Creating Productname and setting it to TechDays
Creating http download site
Creating Windows user admin
Setting SA Password and enabling SA
Creating admin as SQL User and add to sysadmin
Creating SUPER user
Container IP Address: 172.29.89.63
Container Hostname  : b3314515b95a
Container Dns Name  : b3314515b95a
Web Client          : https://b3314515b95a/NAV/
NAV Admin Username  : admin
NAV Admin Password  : Kaga9565
Dev. Server         : https://b3314515b95a
Dev. ServerInstance : NAV

Files:
http://b3314515b95a:8080/al-2.0.43900.vsix
http://b3314515b95a:8080/certificate.cer

You are running a container which is 74 days old.
Microsoft recommends that you always run the latest version of our containers.

Initialization took 63 seconds
Ready for connections!
```
- Open the WebClient at https://b3314515b95a/NAV/ and check the product name (top left corner) --> should be "TechDays"
- Take an arbitrary report, open the request page and check the send to menu --> should not include Excel