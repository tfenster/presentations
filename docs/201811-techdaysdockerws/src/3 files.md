## 3 Working with files and volumes
Create a file on your host and copy it into the container
```PowerShell
PS C:\Users\AdminTechDays> "This is a TechDays workshop" | Out-File temp.txt
PS C:\Users\AdminTechDays> docker cp temp.txt techdays:c:\temp.txt
PS C:\Users\AdminTechDays> docker exec -ti techdays powershell
Windows PowerShell
Copyright (C) 2016 Microsoft Corporation. All rights reserved.

PS C:\> get-content temp.txt
This is a TechDays workshop
```
Change it inside the container and copy it back to your host
```PowerShell
PS C:\> "Hello from inside the container" | Out-File temp.txt
PS C:\> exit
PS C:\Users\AdminTechDays> docker cp techdays:c:\temp.txt temp.txt
PS C:\Users\AdminTechDays> cat .\temp.txt
Hello from inside the container
```
To see files and changes "live" without copying, we need to use volumes. This is only possible on startup, so we create a new container with param `-v`
```PowerShell
PS C:\Users\AdminTechDays> mkdir shared_volume


    Directory: C:\Users\AdminTechDays


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----       11/12/2018   2:37 PM                shared_volume


PS C:\Users\AdminTechDays> docker run --name techdays --rm -ti -v c:\users\admintechdays\shared_volume:c:\shared microsoft/nanoserver:sac2016 powershell
Windows PowerShell
(c) 2016 Microsoft Corporation. All rights reserved.

PS C:\>dir c:
 Volume in drive C has no label.
 Volume Serial Number is B235-ACA7

 Directory of C:\

11/20/2016  11:32 AM             1,894 License.txt
07/16/2016  12:20 PM    <DIR>          Program Files
07/16/2016  12:09 PM    <DIR>          Program Files (x86)
11/12/2018  02:39 PM    <SYMLINKD>     shared [\\?\ContainerMappedDirectories\49EAD473-6B8C-447A-8108-700454C48785]
11/12/2018  02:39 PM    <DIR>          Users
11/12/2018  02:39 PM    <DIR>          Windows
               1 File(s)          1,894 bytes
               5 Dir(s)  21,242,667,008 bytes free

PS C:\>dir c:\shared
 Volume in drive C has no label.
 Volume Serial Number is B235-ACA7

 Directory of c:\shared

11/12/2018  02:39 PM    <DIR>          .
11/12/2018  02:39 PM    <DIR>          ..
               0 File(s)              0 bytes
               2 Dir(s)  117,590,142,976 bytes free

```
Create a file in the shared folder on your host in the second powershell
```PowerShell
PS C:\Users\AdminTechDays> cd .\shared_volume\
PS C:\Users\AdminTechDays\shared_volume> "Hello from the host" | Out-File temp.txt
```
Verify in the container that the file has appeared with the correct content. After that, overwrite it with new content
```PowerShell
PS C:\> dir c:\shared

    Directory: C:\shared

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----       11/12/2018   2:44 PM             44 temp.txt

PS C:\> get-content C:\shared\temp.txt
Hello from the host
PS C:\> "Hello from the container" | Out-File c:\shared\temp.txt
```
Verify on the host that the content has changed
```PowerShell
PS C:\Users\AdminTechDays\shared_volume> get-content .\temp.txt
Hello from the container
```