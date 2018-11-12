## 5 resource limits
On the host show `docker stats` and keep them open to watch CPU usage
```PowerShell
PS C:\Users\AdminTechDays> docker stats
CONTAINER ID        NAME                CPU %               PRIV WORKING SET    NET I/O             BLOCK I/O
```
Lines will appear when we start containers
```PowerShell
PS C:\Users\AdminTechDays> docker run --rm --name sql -e sa_password=Passw0rd*123 -e ACCEPT_EULA=Y microsoft/mssql-server-windows-express
Unable to find image 'microsoft/mssql-server-windows-express:latest' locally
latest: Pulling from microsoft/mssql-server-windows-express
3889bb8d808b: Downloading [=======================>                           ]  1.938GB/4.07GB
449343c9d7e2: Download complete
a336350523ea: Download complete
2c12ef99f411: Download complete
8ebb28bb3276: Download complete
3bb8431b46ce: Download complete
a4a938096b3c: Download complete
656eb837f7e6: Download complete
a3d536b0e79d: Download complete
a0aec5f46615: Download complete
64a0f6512541: Download complete
b900d04a68bd: Download complete
VERBOSE: Starting SQL Server
VERBOSE: Changing SA login credentials
VERBOSE: Started SQL Server.
```
You should see CPU usage go over 10% frequently  
Now stop the container and start it again with a CPU limit to 3% (we can't limit memory as SQL wouldn't even start)  
```PowerShell
PS C:\Users\AdminTechDays> docker stop sql
sql
PS C:\Users\AdminTechDays> docker run --rm --name sql -e sa_password=Passw0rd*123 -e ACCEPT_EULA=Y --cpu-percent 3 microsoft/mssql-server-windows-express
VERBOSE: Starting SQL Server
VERBOSE: Changing SA login credentials
VERBOSE: Started SQL Server.
```
CPU usage should only show quick peaks above 3% but usually stay below