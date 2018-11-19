## Bonus 1: Enable remote access
Create file c:\programdata\docker\config\daemon.json and set the following as content:
```PowerShell
{
    "hosts": ["tcp://0.0.0.0:2375", "npipe://"] 
}
```
Restart the Docker service to implement the new setting and open the firewall port
```PowerShell
PS C:\Users\AdminTechDays> Restart-Service docker
PS C:\Users\AdminTechDays> New-NetFirewallRule -Name "Docker" -DisplayName "Docker" -Enabled True -Direction Inbound -Action Allow -LocalPort 2375 -Protocol TCP

Name                  : Docker
DisplayName           : Docker
Description           :
DisplayGroup          :
Group                 :
Enabled               : True
Profile               : Any
Platform              : {}
Direction             : Inbound
Action                : Allow
EdgeTraversalPolicy   : Block
LooseSourceMapping    : False
LocalOnlyMapping      : False
Owner                 :
PrimaryStatus         : OK
Status                : The rule was parsed successfully from the store. (65536)
EnforcementStatus     : NotApplicable
PolicyStoreSource     : PersistentStore
PolicyStoreSourceType : Local
```
Now go to the small VM and install Docker as seen [here](https://ve.link/t2mre). After that open a cmd (not Powershell!), set the DOCKER_HOST variable and do `docker ps -a` or `docker images` to see that you are connected to the Docker API on the big VM
```PowerShell
Microsoft Windows [Version 10.0.14393]
(c) 2016 Microsoft Corporation. All rights reserved.

C:\Users\AdminTechDays>set DOCKER_HOST=tdbig:2375

C:\Users\AdminTechDays>docker ps -a
CONTAINER ID        IMAGE                                    COMMAND                  CREATED             STATUS                            PORTS               NAMES
30686a2cd522        microsoft/dynamics-nav:2018-gb           "powershell -Command…"   8 hours ago         Exited (1073807364) 7 hours ago                       bc-external_nav_1_e531701a9ccb
6a96e37a7fb6        microsoft/dynamics-nav:2018-gb           "powershell -Command…"   8 hours ago         Exited (1073807364) 7 hours ago                       bc-external_nav-test_1_4a241828df40
7b7b30c6ee97        microsoft/dynamics-nav:2018-gb           "powershell -Command…"   8 hours ago         Exited (1073807364) 7 hours ago                       bc-external_nav-staging_1_4495eeca3b1a
4788f7ca18aa        microsoft/mssql-server-windows-express   "powershell -Command…"   9 hours ago         Exited (1073807364) 7 hours ago                       bc-external_sql-staging_1_466e42b4810d
322c783c76f8        microsoft/mssql-server-windows-express   "powershell -Command…"   9 hours ago         Exited (1073807364) 7 hours ago                       bc-external_sql-test_1_81f791c2b742
1159c7b114f9        microsoft/mssql-server-windows-express   "powershell -Command…"   9 hours ago         Exited (1073807364) 7 hours ago                       bc-external_sql_1_f41f22f8daea

C:\Users\AdminTechDays>docker images
REPOSITORY                               TAG                 IMAGE ID            CREATED             SIZE
microsoft/dynamics-nav                   2018-gb             2b7f66767af6        6 weeks ago         17.8GB
microsoft/mssql-server-windows-express   latest              1986b8a8f950        10 months ago       13.8GB
``` 