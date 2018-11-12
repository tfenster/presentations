## 2 Container handling basics
Show running containers
```PowerShell
PS C:\Users\AdminTechDays> docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
```
Show all containers (param `-a`), notice generated names and ids
```PowerShell
PS C:\Users\AdminTechDays> docker ps -a
CONTAINER ID        IMAGE                                                   COMMAND                  CREATED             STATUS                         PORTS               NAMES
8b333518eece        microsoft/dotnet-samples:dotnetapp-nanoserver-sac2016   "dotnet dotnetapp.dll"   About an hour ago   Exited (0) About an hour ago                       amazing_fermi
```
Start container with param `-ti` creates a terminal inside that container and `powershell` in the end tells it to use powershell as process to start
```PowerShell
docker run -ti microsoft/nanoserver:sac2016 powershell
PS C:\Users\AdminTechDays> docker run microsoft/nanoserver:sac2016 powershell
Unable to find image 'microsoft/nanoserver:sac2016' locally
sac2016: Pulling from microsoft/nanoserver
bce2fbc256ea: Already exists
6f2071dcd729: Already exists
Digest: sha256:2b783310e6c82de737e893abd53ae238ca56b5a96e2861558fb9a111d6691ddb
Status: Downloaded newer image for microsoft/nanoserver:sac2016

Windows PowerShell
Copyright (C) 2016 Microsoft Corporation. All rights reserved.

PS C:\> dir

    Directory: C:\

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----       11/12/2018   1:11 PM                Program Files
d-----        7/16/2016  12:09 PM                Program Files (x86)
d-r---       11/12/2018   1:11 PM                Users
d-----       11/12/2018   1:11 PM                Windows
-a----       11/20/2016  11:32 AM           1894 License.txt

```
Open a second PowerShell as admin on the host, see the running container and it's resource consumption
```PowerShell
PS C:\Users\AdminTechDays> docker ps
CONTAINER ID        IMAGE                          COMMAND             CREATED             STATUS              PORTS               NAMES
e4f17ed032da        microsoft/nanoserver:sac2016   "powershell"        6 minutes ago       Up 6 minutes                            eloquent_lovelace

PS C:\Users\AdminTechDays> docker stats
CONTAINER ID        NAME                CPU %               PRIV WORKING SET    NET I/O             BLOCK I/O
e4f17ed032da        eloquent_lovelace   0.00%               87.65MiB            951kB / 34.2kB      15.6MB / 19.8MB
```
Hit ctrl-c to exit the stats  
See containers with `docker ps -a again`
```PowerShell
PS C:\Users\AdminTechDays> docker ps -a
CONTAINER ID        IMAGE                                                   COMMAND                  CREATED             STATUS                         PORTS               NAMES
e4f17ed032da        microsoft/nanoserver:sac2016                            "powershell"             8 minutes ago       Up 8 minutes                                       eloquent_lovelace
8b333518eece        microsoft/dotnet-samples:dotnetapp-nanoserver-sac2016   "dotnet dotnetapp.dll"   About an hour ago   Exited (0) About an hour ago                       amazing_fermi
```
See logs from running container with `docker logs e4` (use first two letters of the id)
```PowerShell
PS C:\Users\AdminTechDays> docker logs e4
Windows PowerShell
Copyright (C) 2016 Microsoft Corporation. All rights reserved.

PS C:\> dir

    Directory: C:\

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----       11/12/2018   1:11 PM                Program Files
d-----        7/16/2016  12:09 PM                Program Files (x86)
d-r---       11/12/2018   1:11 PM                Users
d-----       11/12/2018   1:11 PM                Windows
-a----       11/20/2016  11:32 AM           1894 License.txt
```
Get a second session into the container, exit it and see that the container is still running
```
docker exec -ti e4 powershell
Windows PowerShell
Copyright (C) 2016 Microsoft Corporation. All rights reserved.

PS C:\> exit
PS C:\Users\AdminTechDays> docker ps
CONTAINER ID        IMAGE                          COMMAND             CREATED             STATUS              PORTS               NAMES
e4f17ed032da        microsoft/nanoserver:sac2016   "powershell"        13 minutes ago      Up 13 minutes                           eloquent_lovelace
```
Get back to the first powershell and exit there, see that the container now stops (main process has ended)
```PowerShell
PS C:\> exit
PS C:\Users\AdminTechDays> docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
```
Remove the containers using id and name
```PowerShell
PS C:\Users\AdminTechDays> docker ps -a
CONTAINER ID        IMAGE                                                   COMMAND                  CREATED             STATUS                          PORTS               NAMES
e4f17ed032da        microsoft/nanoserver:sac2016                            "powershell"             15 minutes ago      Exited (0) About a minute ago                       eloquent_lovelace
8b333518eece        microsoft/dotnet-samples:dotnetapp-nanoserver-sac2016   "dotnet dotnetapp.dll"   About an hour ago   Exited (0) About an hour ago                        amazing_fermi
PS C:\Users\AdminTechDays> docker rm e4
e4
PS C:\Users\AdminTechDays> docker rm amazing_fermi
8b
```
List and remove the images using id and name
```PowerShell
PS C:\Users\AdminTechDays> docker images
REPOSITORY                 TAG                            IMAGE ID            CREATED             SIZE
microsoft/dotnet-samples   dotnetapp-nanoserver-sac2016   76ac0714814b        4 weeks ago         1.27GB
microsoft/nanoserver       sac2016                        4c872414bf9d        4 weeks ago         1.17GB
PS C:\Users\AdminTechDays> docker rmi 76
Untagged: microsoft/dotnet-samples:dotnetapp-nanoserver-sac2016
Untagged: microsoft/dotnet-samples@sha256:a8e2ff0d77e77e17ca7b2ecb75a5852e2bb3583deed500aff2f5e8622884c3d3
Deleted: sha256:76ac0714814b2a92a2fd001a4a25edf02a4039798e772e05aa1f19e460d4e804
Deleted: sha256:de9ab9d67229ea12feb42f7553ab91d81cc5a97a60a17a6bd9c6c74985017652
Deleted: sha256:cb57c916b9fb084ad2767ba420586ae91919d47a10f5fc33b5c8cdf7df7806d3
Deleted: sha256:1e52fa04720b4ffc74038005cadd656840ec208b387907abaf5dc6e5975750f7
Deleted: sha256:d8d80f7d551407513e75cf94fa64d07c49ca4c1e9d4db561b40a7d1bf54f3ec6
Deleted: sha256:9d2a92fd04d94a95987c41879a2075da38b641fb40ffbb74a787a3d190f2791b
Deleted: sha256:03ad2677ad76cfc761cc09b2f907b02885bc21ddaeab8dcec8a0542857a9421d
Deleted: sha256:8e5c114a80586c039062c734d38086da5de44028f3adb8581601a9a5615d4145
Deleted: sha256:a2b2fdfbe2d1f2470243be908c1cc0d7ade01db35abef33065056de222baa77c
PS C:\Users\AdminTechDays> docker rmi microsoft/nanoserver:sac2016
Untagged: microsoft/nanoserver:sac2016
Untagged: microsoft/nanoserver@sha256:2b783310e6c82de737e893abd53ae238ca56b5a96e2861558fb9a111d6691ddb
Deleted: sha256:4c872414bf9dccef8dab0cc483169dfd722e0ed5d2442354af72cd78e1dfad31
Deleted: sha256:bad9906b1e05dcf2be1806a63033ab52643cc928e3497d136dde3ff804a85f6e
Deleted: sha256:6c357baed9f5177e8c8fd1fa35b39266f329535ec8801385134790eb08d8787d
```
Run a nanoserver container again
```PowerShell
PS C:\Users\AdminTechDays> docker run -ti microsoft/nanoserver:sac2016 powershell
Unable to find image 'microsoft/nanoserver:sac2016' locally
sac2016: Pulling from microsoft/nanoserver
bce2fbc256ea: Pull complete
6f2071dcd729: Pull complete
Digest: sha256:2b783310e6c82de737e893abd53ae238ca56b5a96e2861558fb9a111d6691ddb
Status: Downloaded newer image for microsoft/nanoserver:sac2016

Windows PowerShell
Copyright (C) 2016 Microsoft Corporation. All rights reserved.

PS C:\>
```
Go to the other powershell and try to delete it
```PowerShell
PS C:\Users\AdminTechDays> docker ps
CONTAINER ID        IMAGE                          COMMAND             CREATED             STATUS              PORTS               NAMES
a7cb76c331ec        microsoft/nanoserver:sac2016   "powershell"        40 seconds ago      Up 34 seconds                           mystifying_burnell
PS C:\Users\AdminTechDays> docker rm a7
Error response from daemon: You cannot remove a running container a7cb76c331ecd9fa5cbe531b2ebd62d64a6728b55d0f955fb6f3cd6a797d81a0. Stop the container before attempting removal or force remove
```
Either stop it with `docker stop a7` and then remove it or force removal 
```PowerShell
PS C:\Users\AdminTechDays> docker rm -f a7
a7
```
Give the container a name to allow easier identification (param `--name`) and tell it to autoremove when it stops (param `--rm`)
```PowerShell
PS C:\Users\AdminTechDays> docker run --name techdays -ti --rm microsoft/nanoserver:sac2016

Microsoft Windows [Version 10.0.14393]
(c) 2016 Microsoft Corporation. All rights reserved.

C:\>
```
See it in the other powershell, now with your name
```PowerShell
PS C:\Users\AdminTechDays> docker ps
CONTAINER ID        IMAGE                          COMMAND                    CREATED             STATUS              PORTS               NAMES
9ccda08c574f        microsoft/nanoserver:sac2016   "c:\\windows\\system32…"   5 seconds ago       Up 2 seconds                            techdays
```
Stop the container and see that it has been removed completely
```PowerShell
PS C:\Users\AdminTechDays> docker stop techdays
techdays
PS C:\Users\AdminTechDays> docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
PS C:\Users\AdminTechDays>
```
Run the container once more
```PowerShell
PS C:\Users\AdminTechDays> docker run --name techdays -ti --rm microsoft/nanoserver:sac2016

Microsoft Windows [Version 10.0.14393]
(c) 2016 Microsoft Corporation. All rights reserved.

C:\>
```
Use the other powershell to enter the container using Enter-PSSession
```PowerShell
PS C:\Users\AdminTechDays> Enter-PSSession -ContainerId (docker ps --no-trunc -qf "name=techdays")
[b6eb22aa0850...]: PS C:\Users\ContainerUser\Documents> dir c:\


    Directory: C:\


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----       11/12/2018   1:43 PM                Program Files
d-----        7/16/2016  12:09 PM                Program Files (x86)
d-r---       11/12/2018   1:43 PM                Users
d-----       11/12/2018   1:42 PM                Windows
-a----       11/20/2016  11:32 AM           1894 License.txt


[b6eb22aa0850...]: PS C:\Users\ContainerUser\Documents>
```
And try again, this time connect as administrator
```PowerShell
[b6eb22aa0850...]: PS C:\Users\ContainerUser\Documents> exit
PS C:\Users\AdminTechDays> Enter-PSSession -ContainerId (docker ps --no-trunc -qf "name=techdays") -RunAsAdministrator
[b6eb22aa0850...]: PS C:\Users\ContainerAdministrator\Documents>
```