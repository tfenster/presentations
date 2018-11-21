## 7 Docker compose
Download docker compose from github
```PowerShell
PS C:\Users\AdminTechDays\dockerfiles> [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
PS C:\Users\AdminTechDays\dockerfiles> Invoke-WebRequest "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-Windows-x86_64.exe" -UseBasicParsing -OutFile $Env:ProgramFiles\docker\docker-compose.exe
```
Open signup/docker-compose.yml in VS Code and inspect it  
Then right click docker-compose.yml --> Compose Up
```PowerShell
Windows PowerShell
Copyright (C) 2016 Microsoft Corporation. All rights reserved.

PS C:\Users\AdminTechDays\dockerfiles> cd "c:\Users\AdminTechDays\dockerfiles"
PS C:\Users\AdminTechDays\dockerfiles> docker-compose -f "signup\docker-compose.yml" up -d --build
Building signup-web
Step 1/14 : FROM dockersamples/mta-dev-web-builder:4.7.1 AS builder
4.7.1: Pulling from dockersamples/mta-dev-web-builder
3889bb8d808b: Already exists
449343c9d7e2: Already exists
ccd8f322a2de: Pull complete
cd71d3c881fa: Pull complete
f7356b03456c: Pull complete
d16a90a9aac6: Pull complete
716e6b9c5958: Pull complete
c3f40e4cf785: Pull complete
8e4e48e328d2: Pull complete
6926cc2d3d40: Pull complete
4c0edc6df9a4: Pull complete
3664af384f40: Pull complete
Digest: sha256:95af8cbc395cf5b8ed10812c6c58c76b7517463cb483a287dc40832461b73f2c
Status: Downloaded newer image for dockersamples/mta-dev-web-builder:4.7.1
 ---> 9d9f2d520aa8
Step 2/14 : WORKDIR C:\src\SignUp.Web
 ---> Running in 131e5006702b
Removing intermediate container 131e5006702b
 ---> f7ddbb7156b0
Step 3/14 : COPY src\SignUp.Web\packages.config .
 ---> 8852aaeae9ae
Step 4/14 : RUN nuget restore packages.config -PackagesDirectory ..\packages
 ---> Running in de2a6006344a
Restoring NuGet package AspNet.ScriptManager.jQuery.1.10.2.
Restoring NuGet package Modernizr.2.6.2.
Restoring NuGet package Microsoft.AspNet.FriendlyUrls.1.0.2.
Restoring NuGet package Antlr.3.4.1.9004.
Restoring NuGet package bootstrap.3.0.0.
Restoring NuGet package AspNet.ScriptManager.bootstrap.3.0.0.
Restoring NuGet package Microsoft.AspNet.ScriptManager.WebForms.5.0.0.
Restoring NuGet package Microsoft.AspNet.ScriptManager.MSAjax.5.0.0.
Restoring NuGet package Microsoft.AspNet.Web.Optimization.1.1.3.
Restoring NuGet package Microsoft.AspNet.FriendlyUrls.Core.1.0.2.
Restoring NuGet package jQuery.1.10.2.
Restoring NuGet package Microsoft.AspNet.Web.Optimization.WebForms.1.1.3.
Restoring NuGet package Microsoft.Web.Infrastructure.1.0.0.
Restoring NuGet package Newtonsoft.Json.10.0.2.
Restoring NuGet package NATS.Client.0.7.1.
Restoring NuGet package EntityFramework.6.1.3.
  GET https://api.nuget.org/v3-flatcontainer/newtonsoft.json/10.0.2/newtonsoft.json.10.0.2.nupkg
  GET https://api.nuget.org/v3-flatcontainer/microsoft.aspnet.friendlyurls.core/1.0.2/microsoft.aspnet.friendlyurls.core.1.0.2.nupkg
  GET https://api.nuget.org/v3-flatcontainer/bootstrap/3.0.0/bootstrap.3.0.0.nupkg
  GET https://api.nuget.org/v3-flatcontainer/nats.client/0.7.1/nats.client.0.7.1.nupkg
  GET https://api.nuget.org/v3-flatcontainer/microsoft.aspnet.scriptmanager.webforms/5.0.0/microsoft.aspnet.scriptmanager.webforms.5.0.0.nupkg
  GET https://api.nuget.org/v3-flatcontainer/microsoft.aspnet.scriptmanager.msajax/5.0.0/microsoft.aspnet.scriptmanager.msajax.5.0.0.nupkg
  GET https://api.nuget.org/v3-flatcontainer/aspnet.scriptmanager.jquery/1.10.2/aspnet.scriptmanager.jquery.1.10.2.nupkg
  GET https://api.nuget.org/v3-flatcontainer/entityframework/6.1.3/entityframework.6.1.3.nupkg
  GET https://api.nuget.org/v3-flatcontainer/antlr/3.4.1.9004/antlr.3.4.1.9004.nupkg
  GET https://api.nuget.org/v3-flatcontainer/microsoft.web.infrastructure/1.0.0/microsoft.web.infrastructure.1.0.0.nupkg
  GET https://api.nuget.org/v3-flatcontainer/modernizr/2.6.2/modernizr.2.6.2.nupkg
  GET https://api.nuget.org/v3-flatcontainer/microsoft.aspnet.web.optimization/1.1.3/microsoft.aspnet.web.optimization.1.1.3.nupkg
  GET https://api.nuget.org/v3-flatcontainer/jquery/1.10.2/jquery.1.10.2.nupkg
  GET https://api.nuget.org/v3-flatcontainer/microsoft.aspnet.web.optimization.webforms/1.1.3/microsoft.aspnet.web.optimization.webforms.1.1.3.nupkg
  GET https://api.nuget.org/v3-flatcontainer/microsoft.aspnet.friendlyurls/1.0.2/microsoft.aspnet.friendlyurls.1.0.2.nupkg
  GET https://api.nuget.org/v3-flatcontainer/aspnet.scriptmanager.bootstrap/3.0.0/aspnet.scriptmanager.bootstrap.3.0.0.nupkg
  OK https://api.nuget.org/v3-flatcontainer/newtonsoft.json/10.0.2/newtonsoft.json.10.0.2.nupkg 10ms
  OK https://api.nuget.org/v3-flatcontainer/bootstrap/3.0.0/bootstrap.3.0.0.nupkg 42ms
  OK https://api.nuget.org/v3-flatcontainer/microsoft.web.infrastructure/1.0.0/microsoft.web.infrastructure.1.0.0.nupkg 43ms
  OK https://api.nuget.org/v3-flatcontainer/modernizr/2.6.2/modernizr.2.6.2.nupkg 43ms
  OK https://api.nuget.org/v3-flatcontainer/entityframework/6.1.3/entityframework.6.1.3.nupkg 43ms
  OK https://api.nuget.org/v3-flatcontainer/microsoft.aspnet.web.optimization/1.1.3/microsoft.aspnet.web.optimization.1.1.3.nupkg 45ms
  OK https://api.nuget.org/v3-flatcontainer/jquery/1.10.2/jquery.1.10.2.nupkg 49ms
Installing Modernizr 2.6.2.
Installing EntityFramework 6.1.3.
Installing Newtonsoft.Json 10.0.2.
Installing Microsoft.Web.Infrastructure 1.0.0.0.
Installing bootstrap 3.0.0.
Installing jQuery 1.10.2.
Installing Microsoft.AspNet.Web.Optimization 1.1.3.
Adding package 'Microsoft.AspNet.Web.Optimization.1.1.3' to folder 'C:\src\packages'
Adding package 'Modernizr.2.6.2' to folder 'C:\src\packages'
Adding package 'Microsoft.Web.Infrastructure.1.0.0' to folder 'C:\src\packages'
Adding package 'bootstrap.3.0.0' to folder 'C:\src\packages'
  OK https://api.nuget.org/v3-flatcontainer/microsoft.aspnet.friendlyurls.core/1.0.2/microsoft.aspnet.friendlyurls.core.1.0.2.nupkg 144ms
Installing Microsoft.AspNet.FriendlyUrls.Core 1.0.2.
  OK https://api.nuget.org/v3-flatcontainer/aspnet.scriptmanager.jquery/1.10.2/aspnet.scriptmanager.jquery.1.10.2.nupkg 149ms
Installing AspNet.ScriptManager.jQuery 1.10.2.
  OK https://api.nuget.org/v3-flatcontainer/microsoft.aspnet.scriptmanager.webforms/5.0.0/microsoft.aspnet.scriptmanager.webforms.5.0.0.nupkg 152ms
  OK https://api.nuget.org/v3-flatcontainer/microsoft.aspnet.web.optimization.webforms/1.1.3/microsoft.aspnet.web.optimization.webforms.1.1.3.nupkg 151ms
Installing Microsoft.AspNet.ScriptManager.WebForms 5.0.0.
Installing Microsoft.AspNet.Web.Optimization.WebForms 1.1.3.
Adding package 'jQuery.1.10.2' to folder 'C:\src\packages'
Adding package 'AspNet.ScriptManager.jQuery.1.10.2' to folder 'C:\src\packages'
Adding package 'Microsoft.AspNet.Web.Optimization.WebForms.1.1.3' to folder 'C:\src\packages'
Adding package 'Microsoft.AspNet.FriendlyUrls.Core.1.0.2' to folder 'C:\src\packages'
Adding package 'Microsoft.AspNet.ScriptManager.WebForms.5.0.0' to folder 'C:\src\packages'
Added package 'Microsoft.Web.Infrastructure.1.0.0' to folder 'C:\src\packages'
Added package 'Microsoft.AspNet.Web.Optimization.1.1.3' to folder 'C:\src\packages'
Added package 'AspNet.ScriptManager.jQuery.1.10.2' to folder 'C:\src\packages'
Added package 'Microsoft.AspNet.Web.Optimization.WebForms.1.1.3' to folder 'C:\src\packages'
Restoring NuGet package WebGrease.1.5.2.
Restoring NuGet package Respond.1.2.0.
  GET https://api.nuget.org/v3-flatcontainer/webgrease/1.5.2/webgrease.1.5.2.nupkg
  GET https://api.nuget.org/v3-flatcontainer/respond/1.2.0/respond.1.2.0.nupkg
  OK https://api.nuget.org/v3-flatcontainer/respond/1.2.0/respond.1.2.0.nupkg 3ms
Installing Respond 1.2.0.
Added package 'Microsoft.AspNet.FriendlyUrls.Core.1.0.2' to folder 'C:\src\packages'
Added package 'Modernizr.2.6.2' to folder 'C:\src\packages'
  OK https://api.nuget.org/v3-flatcontainer/webgrease/1.5.2/webgrease.1.5.2.nupkg 6ms
Installing WebGrease 1.5.2.
Adding package 'Respond.1.2.0' to folder 'C:\src\packages'
Added package 'jQuery.1.10.2' to folder 'C:\src\packages'
Added package 'bootstrap.3.0.0' to folder 'C:\src\packages'
Added package 'Respond.1.2.0' to folder 'C:\src\packages'
Added package 'Microsoft.AspNet.ScriptManager.WebForms.5.0.0' to folder 'C:\src\packages'
Adding package 'WebGrease.1.5.2' to folder 'C:\src\packages'
Added package 'WebGrease.1.5.2' to folder 'C:\src\packages'
  OK https://api.nuget.org/v3-flatcontainer/microsoft.aspnet.scriptmanager.msajax/5.0.0/microsoft.aspnet.scriptmanager.msajax.5.0.0.nupkg 442ms
Installing Microsoft.AspNet.ScriptManager.MSAjax 5.0.0.
Adding package 'Newtonsoft.Json.10.0.2' to folder 'C:\src\packages'
  OK https://api.nuget.org/v3-flatcontainer/microsoft.aspnet.friendlyurls/1.0.2/microsoft.aspnet.friendlyurls.1.0.2.nupkg 448ms
Installing Microsoft.AspNet.FriendlyUrls 1.0.2.
  OK https://api.nuget.org/v3-flatcontainer/aspnet.scriptmanager.bootstrap/3.0.0/aspnet.scriptmanager.bootstrap.3.0.0.nupkg 446ms
Installing AspNet.ScriptManager.bootstrap 3.0.0.
  OK https://api.nuget.org/v3-flatcontainer/nats.client/0.7.1/nats.client.0.7.1.nupkg 447ms
Installing NATS.Client 0.7.1.
Adding package 'AspNet.ScriptManager.bootstrap.3.0.0' to folder 'C:\src\packages'
Adding package 'Microsoft.AspNet.FriendlyUrls.1.0.2' to folder 'C:\src\packages'
Added package 'AspNet.ScriptManager.bootstrap.3.0.0' to folder 'C:\src\packages'
Adding package 'NATS.Client.0.7.1' to folder 'C:\src\packages'
Adding package 'Microsoft.AspNet.ScriptManager.MSAjax.5.0.0' to folder 'C:\src\packages'
Added package 'Microsoft.AspNet.FriendlyUrls.1.0.2' to folder 'C:\src\packages'
Added package 'NATS.Client.0.7.1' to folder 'C:\src\packages'
Added package 'Newtonsoft.Json.10.0.2' to folder 'C:\src\packages'
Added package 'Microsoft.AspNet.ScriptManager.MSAjax.5.0.0' to folder 'C:\src\packages'
Adding package 'EntityFramework.6.1.3' to folder 'C:\src\packages'
Added package 'EntityFramework.6.1.3' to folder 'C:\src\packages'
  OK https://api.nuget.org/v3-flatcontainer/antlr/3.4.1.9004/antlr.3.4.1.9004.nupkg 3029ms
Installing Antlr 3.4.1.9004.
Adding package 'Antlr.3.4.1.9004' to folder 'C:\src\packages'
Added package 'Antlr.3.4.1.9004' to folder 'C:\src\packages'

NuGet Config files used:
    C:\Users\ContainerAdministrator\AppData\Roaming\NuGet\NuGet.Config

Feeds used:
    https://api.nuget.org/v3/index.json

Installed:
    18 package(s) to packages.config projects
Removing intermediate container de2a6006344a
 ---> 40c8b0f8aeec
Step 5/14 : COPY src C:\src
 ---> 418dc7fbcebc
Step 6/14 : RUN msbuild SignUp.Web.csproj /p:OutputPath=c:\out /p:DeployOnBuild=true
 ---> Running in ee9c5f562ada
Microsoft (R) Build Engine version 15.5.180.51428 for .NET Framework
Copyright (C) Microsoft Corporation. All rights reserved.

Build started 11/13/2018 8:42:47 AM.
Project "C:\src\SignUp.Web\SignUp.Web.csproj" on node 1 (default targets).
PrepareForBuild:
  Creating directory "c:\out\".
  Creating directory "obj\Debug\".
Project "C:\src\SignUp.Web\SignUp.Web.csproj" (1) is building "C:\src\SignUp.Entities\SignUp.Entities.csproj" (2:2) on node 1 (default targets).
PrepareForBuild:
  Creating directory "obj\Debug\".
CoreCompile:
  C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin\Roslyn\csc.exe /noconfig /nowarn:1701,1702 /nostdlib+ /errorreport:prompt /warn:4 /define:DEBUG;TRACE /highentropyva+ /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.5.2\Microsoft.CSharp.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.5.2\mscorlib.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.5.2\System.Core.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.5.2\System.Data.DataSetExtensions.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.5.2\System.Data.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.5.2\System.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.5.2\System.Net.Http.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.5.2\System.Xml.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.5.2\System.Xml.Linq.dll" /debug+ /debug:full /filealign:512 /optimize- /out:obj\Debug\SignUp.Entities.dll /subsystemversion:6.00 /target:library /utf8output Country.cs Properties\AssemblyInfo.cs Prospect.cs Role.cs "C:\Users\ContainerAdministrator\AppData\Local\Temp\.NETFramework,Version=v4.5.2.AssemblyAttributes.cs"
  Using shared compilation with compiler from directory: C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin\Roslyn
CopyFilesToOutputDirectory:
  Copying file from "obj\Debug\SignUp.Entities.dll" to "c:\out\SignUp.Entities.dll".
  SignUp.Entities -> c:\out\SignUp.Entities.dll
  Copying file from "obj\Debug\SignUp.Entities.pdb" to "c:\out\SignUp.Entities.pdb".
Done Building Project "C:\src\SignUp.Entities\SignUp.Entities.csproj" (default targets).
Project "C:\src\SignUp.Web\SignUp.Web.csproj" (1) is building "C:\src\SignUp.Messaging\SignUp.Messaging.csproj" (3:2) on node 1 (default targets).
PrepareForBuild:
  Creating directory "obj\Debug\".
GenerateTargetFrameworkMonikerAttribute:
Skipping target "GenerateTargetFrameworkMonikerAttribute" because all output files are up-to-date with respect to the input files.
CoreCompile:
  C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin\Roslyn\csc.exe /noconfig /nowarn:1701,1702 /nostdlib+ /errorreport:prompt /warn:4 /define:DEBUG;TRACE /highentropyva+ /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.5.2\Microsoft.CSharp.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.5.2\mscorlib.dll" /reference:C:\src\packages\NATS.Client.0.7.1\lib\net45\NATS.Client.DLL /reference:C:\src\packages\Newtonsoft.Json.10.0.2\lib\net45\Newtonsoft.Json.dll /reference:c:\out\SignUp.Entities.dll /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.5.2\System.Core.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.5.2\System.Data.DataSetExtensions.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.5.2\System.Data.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.5.2\System.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.5.2\System.Net.Http.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.5.2\System.Runtime.Serialization.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.5.2\System.Xml.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.5.2\System.Xml.Linq.dll" /debug+ /debug:full /filealign:512 /optimize- /out:obj\Debug\SignUp.Messaging.dll /subsystemversion:6.00 /target:library /utf8output Config.cs MessageHelper.cs MessageQueue.cs
Messages\Events\ProspectSignedUpEvent.cs Messages\Message.cs Properties\AssemblyInfo.cs "C:\Users\ContainerAdministrator\AppData\Local\Temp\.NETFramework,Version=v4.5.2.AssemblyAttributes.cs"
  Using shared compilation with compiler from directory: C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin\Roslyn
_CopyFilesMarkedCopyLocal:
  Copying file from "C:\src\packages\NATS.Client.0.7.1\lib\net45\NATS.Client.DLL" to "c:\out\NATS.Client.DLL".
  Copying file from "C:\src\packages\Newtonsoft.Json.10.0.2\lib\net45\Newtonsoft.Json.dll" to "c:\out\Newtonsoft.Json.dll".
  Copying file from "C:\src\packages\NATS.Client.0.7.1\lib\net45\NATS.Client.xml" to "c:\out\NATS.Client.xml".
  Copying file from "C:\src\packages\Newtonsoft.Json.10.0.2\lib\net45\Newtonsoft.Json.xml" to "c:\out\Newtonsoft.Json.xml".
  Creating "C:\src\SignUp.Messaging\obj\Debug\SignUp.Messaging.csproj.CopyComplete" because "AlwaysCreate" was specified.
CopyFilesToOutputDirectory:
  Copying file from "obj\Debug\SignUp.Messaging.dll" to "c:\out\SignUp.Messaging.dll".
  SignUp.Messaging -> c:\out\SignUp.Messaging.dll
  Copying file from "obj\Debug\SignUp.Messaging.pdb" to "c:\out\SignUp.Messaging.pdb".
Done Building Project "C:\src\SignUp.Messaging\SignUp.Messaging.csproj" (default targets).
Project "C:\src\SignUp.Web\SignUp.Web.csproj" (1) is building "C:\src\SignUp.Model\SignUp.Model.csproj" (4:2) on node 1 (default targets).
PrepareForBuild:
  Creating directory "obj\Debug\".
GenerateTargetFrameworkMonikerAttribute:
Skipping target "GenerateTargetFrameworkMonikerAttribute" because all output files are up-to-date with respect to the input files.
CoreCompile:
  C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin\Roslyn\csc.exe /noconfig /nowarn:1701,1702 /nostdlib+ /errorreport:prompt /warn:4 /define:DEBUG;TRACE /highentropyva+ /reference:C:\src\packages\EntityFramework.6.1.3\lib\net45\EntityFramework.dll /reference:C:\src\packages\EntityFramework.6.1.3\lib\net45\EntityFramework.SqlServer.dll /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.5.2\Microsoft.CSharp.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.5.2\mscorlib.dll" /reference:c:\out\SignUp.Entities.dll /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.5.2\System.ComponentModel.DataAnnotations.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.5.2\System.Configuration.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.5.2\System.Core.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.5.2\System.Data.DataSetExtensions.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.5.2\System.Data.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.5.2\System.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.5.2\System.Net.Http.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.5.2\System.Xml.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.5.2\System.Xml.Linq.dll" /debug+ /debug:full /filealign:512 /optimize- /out:obj\Debug\SignUp.Model.dll /subsystemversion:6.00 /target:library /utf8output Config.cs Initializers\StaticDataInitializer.cs ProductLaunchConfiguration.cs ProductLaunchContext.cs Properties\AssemblyInfo.cs "C:\Users\ContainerAdministrator\AppData\Local\Temp\.NETFramework,Version=v4.5.2.AssemblyAttributes.cs"
  Using shared compilation with compiler from directory: C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin\Roslyn
_CopyFilesMarkedCopyLocal:
  Copying file from "C:\src\packages\EntityFramework.6.1.3\lib\net45\EntityFramework.dll" to "c:\out\EntityFramework.dll".
  Copying file from "C:\src\packages\EntityFramework.6.1.3\lib\net45\EntityFramework.SqlServer.dll" to "c:\out\EntityFramework.SqlServer.dll".
  Copying file from "C:\src\packages\EntityFramework.6.1.3\lib\net45\EntityFramework.xml" to "c:\out\EntityFramework.xml".
  Copying file from "C:\src\packages\EntityFramework.6.1.3\lib\net45\EntityFramework.SqlServer.xml" to "c:\out\EntityFramework.SqlServer.xml".
  Creating "C:\src\SignUp.Model\obj\Debug\SignUp.Model.csproj.CopyComplete" because "AlwaysCreate" was specified.
_CopyAppConfigFile:
  Copying file from "App.config" to "c:\out\SignUp.Model.dll.config".
CopyFilesToOutputDirectory:
  Copying file from "obj\Debug\SignUp.Model.dll" to "c:\out\SignUp.Model.dll".
  SignUp.Model -> c:\out\SignUp.Model.dll
  Copying file from "obj\Debug\SignUp.Model.pdb" to "c:\out\SignUp.Model.pdb".
Done Building Project "C:\src\SignUp.Model\SignUp.Model.csproj" (default targets).
CoreCompile:
  C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin\Roslyn\csc.exe /noconfig /nowarn:1701,1702 /nostdlib+ /errorreport:prompt /warn:4 /define:DEBUG;TRACE /highentropyva+ /reference:C:\src\packages\Antlr.3.4.1.9004\lib\Antlr3.Runtime.dll /reference:C:\src\packages\AspNet.ScriptManager.bootstrap.3.0.0\lib\net45\AspNet.ScriptManager.bootstrap.dll /reference:C:\src\packages\AspNet.ScriptManager.jQuery.1.10.2\lib\net45\AspNet.ScriptManager.jQuery.dll /reference:C:\src\packages\EntityFramework.6.1.3\lib\net45\EntityFramework.dll /reference:C:\src\packages\EntityFramework.6.1.3\lib\net45\EntityFramework.SqlServer.dll /reference:C:\src\packages\Microsoft.AspNet.FriendlyUrls.Core.1.0.2\lib\net45\Microsoft.AspNet.FriendlyUrls.dll /reference:C:\src\packages\Microsoft.AspNet.Web.Optimization.WebForms.1.1.3\lib\net45\Microsoft.AspNet.Web.Optimization.WebForms.dll /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.1\Microsoft.CSharp.dll" /reference:C:\src\packages\Microsoft.AspNet.ScriptManager.MSAjax.5.0.0\lib\net45\Microsoft.ScriptManager.MSAjax.dll /reference:C:\src\packages\Microsoft.AspNet.ScriptManager.WebForms.5.0.0\lib\net45\Microsoft.ScriptManager.WebForms.dll /reference:C:\src\packages\Microsoft.Web.Infrastructure.1.0.0.0\lib\net40\Microsoft.Web.Infrastructure.dll /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.1\mscorlib.dll" /reference:C:\src\packages\NATS.Client.0.7.1\lib\net45\NATS.Client.DLL /reference:C:\src\packages\Newtonsoft.Json.10.0.2\lib\net45\Newtonsoft.Json.dll /reference:c:\out\SignUp.Entities.dll /reference:c:\out\SignUp.Messaging.dll /reference:c:\out\SignUp.Model.dll /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.1\System.ComponentModel.DataAnnotations.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.1\System.Configuration.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.1\System.Core.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.1\System.Data.DataSetExtensions.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.1\System.Data.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.1\System.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.1\System.Drawing.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.1\System.EnterpriseServices.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.1\System.Runtime.Serialization.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.1\System.Web.ApplicationServices.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.1\System.Web.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.1\System.Web.DynamicData.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.1\System.Web.Entity.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.1\System.Web.Extensions.dll" /reference:C:\src\packages\Microsoft.AspNet.Web.Optimization.1.1.3\lib\net40\System.Web.Optimization.dll /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.1\System.Web.Services.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.1\System.Xml.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.1\System.Xml.Linq.dll" /reference:C:\src\packages\WebGrease.1.5.2\lib\WebGrease.dll /debug+ /debug:full /optimize- /out:obj\Debug\SignUp.Web.dll /subsystemversion:6.00 /target:library /utf8output App_Start\BundleConfig.cs About.aspx.cs About.aspx.designer.cs App_Start\RouteConfig.cs Config.cs Contact.aspx.cs Contact.aspx.designer.cs SignUp.aspx.cs SignUp.aspx.designer.cs Default.aspx.cs Default.aspx.designer.cs Global.asax.cs Properties\AssemblyInfo.cs Site.Master.cs Site.Master.designer.cs Site.Mobile.Master.cs Site.Mobile.Master.designer.cs ThankYou.aspx.cs ThankYou.aspx.designer.cs ViewSwitcher.ascx.cs ViewSwitcher.ascx.designer.cs "C:\Users\ContainerAdministrator\AppData\Local\Temp\.NETFramework,Version=v4.7.1.AssemblyAttributes.cs"
  Using shared compilation with compiler from directory: C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin\Roslyn
_CopyFilesMarkedCopyLocal:
  Copying file from "C:\src\packages\Antlr.3.4.1.9004\lib\Antlr3.Runtime.dll" to "c:\out\Antlr3.Runtime.dll".
  Copying file from "C:\src\packages\AspNet.ScriptManager.bootstrap.3.0.0\lib\net45\AspNet.ScriptManager.bootstrap.dll" to "c:\out\AspNet.ScriptManager.bootstrap.dll".
  Copying file from "C:\src\packages\AspNet.ScriptManager.jQuery.1.10.2\lib\net45\AspNet.ScriptManager.jQuery.dll" to "c:\out\AspNet.ScriptManager.jQuery.dll".
  Copying file from "C:\src\packages\Microsoft.AspNet.FriendlyUrls.Core.1.0.2\lib\net45\Microsoft.AspNet.FriendlyUrls.dll" to "c:\out\Microsoft.AspNet.FriendlyUrls.dll".
  Copying file from "C:\src\packages\Microsoft.AspNet.Web.Optimization.WebForms.1.1.3\lib\net45\Microsoft.AspNet.Web.Optimization.WebForms.dll" to "c:\out\Microsoft.AspNet.Web.Optimization.WebForms.dll".
  Copying file from "C:\src\packages\Microsoft.AspNet.ScriptManager.MSAjax.5.0.0\lib\net45\Microsoft.ScriptManager.MSAjax.dll" to "c:\out\Microsoft.ScriptManager.MSAjax.dll".
  Copying file from "C:\src\packages\Microsoft.AspNet.ScriptManager.WebForms.5.0.0\lib\net45\Microsoft.ScriptManager.WebForms.dll" to "c:\out\Microsoft.ScriptManager.WebForms.dll".
  Copying file from "C:\src\packages\Microsoft.Web.Infrastructure.1.0.0.0\lib\net40\Microsoft.Web.Infrastructure.dll" to "c:\out\Microsoft.Web.Infrastructure.dll".
  Copying file from "C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.1\System.Data.dll" to "c:\out\System.Data.dll".
  Copying file from "C:\src\packages\Microsoft.AspNet.Web.Optimization.1.1.3\lib\net40\System.Web.Optimization.dll" to "c:\out\System.Web.Optimization.dll".
  Copying file from "C:\src\packages\WebGrease.1.5.2\lib\WebGrease.dll" to "c:\out\WebGrease.dll".
  Copying file from "C:\src\packages\Microsoft.AspNet.Web.Optimization.1.1.3\lib\net40\System.Web.Optimization.xml" to "c:\out\System.Web.Optimization.xml".
  Copying file from "C:\src\packages\Antlr.3.4.1.9004\lib\Antlr3.Runtime.pdb" to "c:\out\Antlr3.Runtime.pdb".
  Copying file from "C:\src\packages\Microsoft.AspNet.FriendlyUrls.Core.1.0.2\lib\net45\Microsoft.AspNet.FriendlyUrls.xml" to "c:\out\Microsoft.AspNet.FriendlyUrls.xml".
  Creating "C:\src\SignUp.Web\obj\Debug\SignUp.Web.csproj.CopyComplete" because "AlwaysCreate" was specified.
_CopyOutOfDateSourceItemsToOutputDirectory:
  Copying file from "C:\src\SignUp.Web\ApplicationInsights.config" to "c:\out\ApplicationInsights.config".
_CopyAppConfigFile:
  Copying file from "Web.config" to "c:\out\SignUp.Web.dll.config".
CopyFilesToOutputDirectory:
  Copying file from "obj\Debug\SignUp.Web.dll" to "c:\out\SignUp.Web.dll".
  SignUp.Web -> c:\out\SignUp.Web.dll
  Copying file from "obj\Debug\SignUp.Web.pdb" to "c:\out\SignUp.Web.pdb".
_CopyWebApplicationLegacy:
  Copying Web Application Project Files for SignUp.Web
  Creating directory "c:\out\_PublishedWebsites\SignUp.Web\bin".
  Copying file from "obj\Debug\SignUp.Web.dll" to "c:\out\_PublishedWebsites\SignUp.Web\bin\SignUp.Web.dll".
  Copying file from "obj\Debug\SignUp.Web.pdb" to "c:\out\_PublishedWebsites\SignUp.Web\bin\SignUp.Web.pdb".
  Copying file from "C:\src\packages\Antlr.3.4.1.9004\lib\Antlr3.Runtime.dll" to "c:\out\_PublishedWebsites\SignUp.Web\bin\Antlr3.Runtime.dll".
  Copying file from "C:\src\packages\AspNet.ScriptManager.bootstrap.3.0.0\lib\net45\AspNet.ScriptManager.bootstrap.dll" to "c:\out\_PublishedWebsites\SignUp.Web\bin\AspNet.ScriptManager.bootstrap.dll".
  Copying file from "C:\src\packages\AspNet.ScriptManager.jQuery.1.10.2\lib\net45\AspNet.ScriptManager.jQuery.dll" to "c:\out\_PublishedWebsites\SignUp.Web\bin\AspNet.ScriptManager.jQuery.dll".
  Copying file from "C:\src\packages\EntityFramework.6.1.3\lib\net45\EntityFramework.dll" to "c:\out\_PublishedWebsites\SignUp.Web\bin\EntityFramework.dll".
  Copying file from "C:\src\packages\EntityFramework.6.1.3\lib\net45\EntityFramework.SqlServer.dll" to "c:\out\_PublishedWebsites\SignUp.Web\bin\EntityFramework.SqlServer.dll".
  Copying file from "C:\src\packages\Microsoft.AspNet.FriendlyUrls.Core.1.0.2\lib\net45\Microsoft.AspNet.FriendlyUrls.dll" to "c:\out\_PublishedWebsites\SignUp.Web\bin\Microsoft.AspNet.FriendlyUrls.dll".
  Copying file from "C:\src\packages\Microsoft.AspNet.Web.Optimization.WebForms.1.1.3\lib\net45\Microsoft.AspNet.Web.Optimization.WebForms.dll" to "c:\out\_PublishedWebsites\SignUp.Web\bin\Microsoft.AspNet.Web.Optimization.WebForms.dll".
  Copying file from "C:\src\packages\Microsoft.AspNet.ScriptManager.MSAjax.5.0.0\lib\net45\Microsoft.ScriptManager.MSAjax.dll" to "c:\out\_PublishedWebsites\SignUp.Web\bin\Microsoft.ScriptManager.MSAjax.dll".
  Copying file from "C:\src\packages\Microsoft.AspNet.ScriptManager.WebForms.5.0.0\lib\net45\Microsoft.ScriptManager.WebForms.dll" to "c:\out\_PublishedWebsites\SignUp.Web\bin\Microsoft.ScriptManager.WebForms.dll".
  Copying file from "C:\src\packages\Microsoft.Web.Infrastructure.1.0.0.0\lib\net40\Microsoft.Web.Infrastructure.dll" to "c:\out\_PublishedWebsites\SignUp.Web\bin\Microsoft.Web.Infrastructure.dll".
  Copying file from "C:\src\packages\NATS.Client.0.7.1\lib\net45\NATS.Client.DLL" to "c:\out\_PublishedWebsites\SignUp.Web\bin\NATS.Client.DLL".
  Copying file from "C:\src\packages\Newtonsoft.Json.10.0.2\lib\net45\Newtonsoft.Json.dll" to "c:\out\_PublishedWebsites\SignUp.Web\bin\Newtonsoft.Json.dll".
  Copying file from "c:\out\SignUp.Entities.dll" to "c:\out\_PublishedWebsites\SignUp.Web\bin\SignUp.Entities.dll".
  Copying file from "c:\out\SignUp.Messaging.dll" to "c:\out\_PublishedWebsites\SignUp.Web\bin\SignUp.Messaging.dll".
  Copying file from "c:\out\SignUp.Model.dll" to "c:\out\_PublishedWebsites\SignUp.Web\bin\SignUp.Model.dll".
  Copying file from "C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.1\System.Data.dll" to "c:\out\_PublishedWebsites\SignUp.Web\bin\System.Data.dll".
  Copying file from "C:\src\packages\Microsoft.AspNet.Web.Optimization.1.1.3\lib\net40\System.Web.Optimization.dll" to "c:\out\_PublishedWebsites\SignUp.Web\bin\System.Web.Optimization.dll".
  Copying file from "C:\src\packages\WebGrease.1.5.2\lib\WebGrease.dll" to "c:\out\_PublishedWebsites\SignUp.Web\bin\WebGrease.dll".
  Copying file from "c:\out\SignUp.Entities.pdb" to "c:\out\_PublishedWebsites\SignUp.Web\bin\SignUp.Entities.pdb".
  Copying file from "c:\out\SignUp.Messaging.pdb" to "c:\out\_PublishedWebsites\SignUp.Web\bin\SignUp.Messaging.pdb".
  Copying file from "c:\out\SignUp.Model.pdb" to "c:\out\_PublishedWebsites\SignUp.Web\bin\SignUp.Model.pdb".
  Copying file from "c:\out\SignUp.Model.dll.config" to "c:\out\_PublishedWebsites\SignUp.Web\bin\SignUp.Model.dll.config".
  Copying file from "C:\src\packages\EntityFramework.6.1.3\lib\net45\EntityFramework.xml" to "c:\out\_PublishedWebsites\SignUp.Web\bin\EntityFramework.xml".
  Copying file from "C:\src\packages\EntityFramework.6.1.3\lib\net45\EntityFramework.SqlServer.xml" to "c:\out\_PublishedWebsites\SignUp.Web\bin\EntityFramework.SqlServer.xml".
  Copying file from "C:\src\packages\NATS.Client.0.7.1\lib\net45\NATS.Client.xml" to "c:\out\_PublishedWebsites\SignUp.Web\bin\NATS.Client.xml".
  Copying file from "C:\src\packages\Newtonsoft.Json.10.0.2\lib\net45\Newtonsoft.Json.xml" to "c:\out\_PublishedWebsites\SignUp.Web\bin\Newtonsoft.Json.xml".
  Copying file from "C:\src\packages\Microsoft.AspNet.Web.Optimization.1.1.3\lib\net40\System.Web.Optimization.xml" to "c:\out\_PublishedWebsites\SignUp.Web\bin\System.Web.Optimization.xml".
  Copying file from "C:\src\packages\Antlr.3.4.1.9004\lib\Antlr3.Runtime.pdb" to "c:\out\_PublishedWebsites\SignUp.Web\bin\Antlr3.Runtime.pdb".
  Copying file from "C:\src\packages\Microsoft.AspNet.FriendlyUrls.Core.1.0.2\lib\net45\Microsoft.AspNet.FriendlyUrls.xml" to "c:\out\_PublishedWebsites\SignUp.Web\bin\Microsoft.AspNet.FriendlyUrls.xml".
  Copying file from "About.aspx" to "c:\out\_PublishedWebsites\SignUp.Web\About.aspx".
  Copying file from "Contact.aspx" to "c:\out\_PublishedWebsites\SignUp.Web\Contact.aspx".
  Copying file from "SignUp.aspx" to "c:\out\_PublishedWebsites\SignUp.Web\SignUp.aspx".
  Copying file from "ApplicationInsights.config" to "c:\out\_PublishedWebsites\SignUp.Web\ApplicationInsights.config".
  Copying file from "Default.aspx" to "c:\out\_PublishedWebsites\SignUp.Web\Default.aspx".
  Copying file from "favicon.ico" to "c:\out\_PublishedWebsites\SignUp.Web\favicon.ico".
  Copying file from "Global.asax" to "c:\out\_PublishedWebsites\SignUp.Web\Global.asax".
  Copying file from "Site.Master" to "c:\out\_PublishedWebsites\SignUp.Web\Site.Master".
  Copying file from "ThankYou.aspx" to "c:\out\_PublishedWebsites\SignUp.Web\ThankYou.aspx".
  Copying file from "ViewSwitcher.ascx" to "c:\out\_PublishedWebsites\SignUp.Web\ViewSwitcher.ascx".
  Copying file from "Web.config" to "c:\out\_PublishedWebsites\SignUp.Web\Web.config".
  Copying file from "Bundle.config" to "c:\out\_PublishedWebsites\SignUp.Web\Bundle.config".
  Copying file from "packages.config" to "c:\out\_PublishedWebsites\SignUp.Web\packages.config".
  Copying file from "Site.Mobile.Master" to "c:\out\_PublishedWebsites\SignUp.Web\Site.Mobile.Master".
  Creating directory "c:\out\_PublishedWebsites\SignUp.Web\Content".
  Copying file from "Content\bootstrap.css" to "c:\out\_PublishedWebsites\SignUp.Web\Content\bootstrap.css".
  Copying file from "Content\bootstrap.min.css" to "c:\out\_PublishedWebsites\SignUp.Web\Content\bootstrap.min.css".
  Copying file from "Content\Site.css" to "c:\out\_PublishedWebsites\SignUp.Web\Content\Site.css".
  Creating directory "c:\out\_PublishedWebsites\SignUp.Web\img".
  Copying file from "img\dockercon-us-2018.png" to "c:\out\_PublishedWebsites\SignUp.Web\img\dockercon-us-2018.png".
  Creating directory "c:\out\_PublishedWebsites\SignUp.Web\fonts".
  Copying file from "fonts\glyphicons-halflings-regular.svg" to "c:\out\_PublishedWebsites\SignUp.Web\fonts\glyphicons-halflings-regular.svg".
  Copying file from "fonts\glyphicons-halflings-regular.woff" to "c:\out\_PublishedWebsites\SignUp.Web\fonts\glyphicons-halflings-regular.woff".
  Copying file from "fonts\glyphicons-halflings-regular.ttf" to "c:\out\_PublishedWebsites\SignUp.Web\fonts\glyphicons-halflings-regular.ttf".
  Copying file from "fonts\glyphicons-halflings-regular.eot" to "c:\out\_PublishedWebsites\SignUp.Web\fonts\glyphicons-halflings-regular.eot".
  Creating directory "c:\out\_PublishedWebsites\SignUp.Web\fonts\geomanist".
  Copying file from "fonts\geomanist\hinted-Geomanist-Book.woff2" to "c:\out\_PublishedWebsites\SignUp.Web\fonts\geomanist\hinted-Geomanist-Book.woff2".
  Creating directory "c:\out\_PublishedWebsites\SignUp.Web\Scripts".
  Copying file from "Scripts\bootstrap.js" to "c:\out\_PublishedWebsites\SignUp.Web\Scripts\bootstrap.js".
  Copying file from "Scripts\bootstrap.min.js" to "c:\out\_PublishedWebsites\SignUp.Web\Scripts\bootstrap.min.js".
  Copying file from "Scripts\jquery-1.10.2.js" to "c:\out\_PublishedWebsites\SignUp.Web\Scripts\jquery-1.10.2.js".
  Copying file from "Scripts\jquery-1.10.2.min.js" to "c:\out\_PublishedWebsites\SignUp.Web\Scripts\jquery-1.10.2.min.js".
  Copying file from "Scripts\modernizr-2.6.2.js" to "c:\out\_PublishedWebsites\SignUp.Web\Scripts\modernizr-2.6.2.js".
  Copying file from "Scripts\respond.js" to "c:\out\_PublishedWebsites\SignUp.Web\Scripts\respond.js".
  Copying file from "Scripts\respond.min.js" to "c:\out\_PublishedWebsites\SignUp.Web\Scripts\respond.min.js".
  Copying file from "Scripts\_references.js" to "c:\out\_PublishedWebsites\SignUp.Web\Scripts\_references.js".
  Copying file from "Scripts\jquery-1.10.2.min.map" to "c:\out\_PublishedWebsites\SignUp.Web\Scripts\jquery-1.10.2.min.map".
  Creating directory "c:\out\_PublishedWebsites\SignUp.Web\Scripts\WebForms".
  Copying file from "Scripts\WebForms\DetailsView.js" to "c:\out\_PublishedWebsites\SignUp.Web\Scripts\WebForms\DetailsView.js".
  Copying file from "Scripts\WebForms\Focus.js" to "c:\out\_PublishedWebsites\SignUp.Web\Scripts\WebForms\Focus.js".
  Copying file from "Scripts\WebForms\GridView.js" to "c:\out\_PublishedWebsites\SignUp.Web\Scripts\WebForms\GridView.js".
  Copying file from "Scripts\WebForms\Menu.js" to "c:\out\_PublishedWebsites\SignUp.Web\Scripts\WebForms\Menu.js".
  Copying file from "Scripts\WebForms\MenuStandards.js" to "c:\out\_PublishedWebsites\SignUp.Web\Scripts\WebForms\MenuStandards.js".
  Copying file from "Scripts\WebForms\SmartNav.js" to "c:\out\_PublishedWebsites\SignUp.Web\Scripts\WebForms\SmartNav.js".
  Copying file from "Scripts\WebForms\TreeView.js" to "c:\out\_PublishedWebsites\SignUp.Web\Scripts\WebForms\TreeView.js".
  Copying file from "Scripts\WebForms\WebForms.js" to "c:\out\_PublishedWebsites\SignUp.Web\Scripts\WebForms\WebForms.js".
  Copying file from "Scripts\WebForms\WebParts.js" to "c:\out\_PublishedWebsites\SignUp.Web\Scripts\WebForms\WebParts.js".
  Copying file from "Scripts\WebForms\WebUIValidation.js" to "c:\out\_PublishedWebsites\SignUp.Web\Scripts\WebForms\WebUIValidation.js".
  Creating directory "c:\out\_PublishedWebsites\SignUp.Web\Scripts\WebForms\MSAjax".
  Copying file from "Scripts\WebForms\MSAjax\MicrosoftAjax.js" to "c:\out\_PublishedWebsites\SignUp.Web\Scripts\WebForms\MSAjax\MicrosoftAjax.js".
  Copying file from "Scripts\WebForms\MSAjax\MicrosoftAjaxApplicationServices.js" to "c:\out\_PublishedWebsites\SignUp.Web\Scripts\WebForms\MSAjax\MicrosoftAjaxApplicationServices.js".
  Copying file from "Scripts\WebForms\MSAjax\MicrosoftAjaxComponentModel.js" to "c:\out\_PublishedWebsites\SignUp.Web\Scripts\WebForms\MSAjax\MicrosoftAjaxComponentModel.js".
  Copying file from "Scripts\WebForms\MSAjax\MicrosoftAjaxCore.js" to "c:\out\_PublishedWebsites\SignUp.Web\Scripts\WebForms\MSAjax\MicrosoftAjaxCore.js".
  Copying file from "Scripts\WebForms\MSAjax\MicrosoftAjaxGlobalization.js" to "c:\out\_PublishedWebsites\SignUp.Web\Scripts\WebForms\MSAjax\MicrosoftAjaxGlobalization.js".
  Copying file from "Scripts\WebForms\MSAjax\MicrosoftAjaxHistory.js" to "c:\out\_PublishedWebsites\SignUp.Web\Scripts\WebForms\MSAjax\MicrosoftAjaxHistory.js".
  Copying file from "Scripts\WebForms\MSAjax\MicrosoftAjaxNetwork.js" to "c:\out\_PublishedWebsites\SignUp.Web\Scripts\WebForms\MSAjax\MicrosoftAjaxNetwork.js".
  Copying file from "Scripts\WebForms\MSAjax\MicrosoftAjaxSerialization.js" to "c:\out\_PublishedWebsites\SignUp.Web\Scripts\WebForms\MSAjax\MicrosoftAjaxSerialization.js".
  Copying file from "Scripts\WebForms\MSAjax\MicrosoftAjaxTimer.js" to "c:\out\_PublishedWebsites\SignUp.Web\Scripts\WebForms\MSAjax\MicrosoftAjaxTimer.js".
  Copying file from "Scripts\WebForms\MSAjax\MicrosoftAjaxWebForms.js" to "c:\out\_PublishedWebsites\SignUp.Web\Scripts\WebForms\MSAjax\MicrosoftAjaxWebForms.js".
  Copying file from "Scripts\WebForms\MSAjax\MicrosoftAjaxWebServices.js" to "c:\out\_PublishedWebsites\SignUp.Web\Scripts\WebForms\MSAjax\MicrosoftAjaxWebServices.js".
  Copying file from "C:\src\SignUp.Web\ApplicationInsights.config" to "c:\out\_PublishedWebsites\SignUp.Web\bin\ApplicationInsights.config".
ValidateGlobalPackageSetting:
  $(PackageAsSingleFile) is True
  $(PackageFileName) is c:\out\_PublishedWebsites\SignUp.Web_Package\SignUp.Web.zip. Validating...
CollectFilesFromIntermediateAssembly:
  Gather all files from Project items @(IntermediateAssembly). Adding:
  c:\out\SignUp.Web.dll to bin\SignUp.Web.dll
  c:\out\SignUp.Web.pdb to bin\SignUp.Web.pdb
CollectFilesFromContent:
  Gather all files from Project items @(Content). Adding:
  About.aspx;Contact.aspx;Content\bootstrap.css;Content\bootstrap.min.css;Content\Site.css;img\dockercon-us-2018.png;SignUp.aspx;fonts\glyphicons-halflings-regular.svg;fonts\glyphicons-halflings-regular.woff;fonts\glyphicons-halflings-regular.ttf;fonts\glyphicons-halflings-regular.eot;ApplicationInsights.config;fonts\geomanist\hinted-Geomanist-Book.woff2;Scripts\bootstrap.js;Scripts\bootstrap.min.js;Scripts\jquery-1.10.2.js;Scripts\jquery-1.10.2.min.js;Scripts\modernizr-2.6.2.js;Scripts\respond.js;Scripts\respond.min.js;Scripts\WebForms\DetailsView.js;Scripts\WebForms\Focus.js;Scripts\WebForms\GridView.js;Scripts\WebForms\Menu.js;Scripts\WebForms\MenuStandards.js;Scripts\WebForms\MSAjax\MicrosoftAjax.js;Scripts\WebForms\MSAjax\MicrosoftAjaxApplicationServices.js;Scripts\WebForms\MSAjax\MicrosoftAjaxComponentModel.js;Scripts\WebForms\MSAjax\MicrosoftAjaxCore.js;Scripts\WebForms\MSAjax\MicrosoftAjaxGlobalization.js;Scripts\WebForms\MSAjax\MicrosoftAjaxHistory.js;Scripts\WebForms\MSAjax\MicrosoftAjaxNetwork.js;Scripts\WebForms\MSAjax\MicrosoftAjaxSerialization.js;Scripts\WebForms\MSAjax\MicrosoftAjaxTimer.js;Scripts\WebForms\MSAjax\MicrosoftAjaxWebForms.js;Scripts\WebForms\MSAjax\MicrosoftAjaxWebServices.js;Scripts\WebForms\SmartNav.js;Scripts\WebForms\TreeView.js;Scripts\WebForms\WebForms.js;Scripts\WebForms\WebParts.js;Scripts\WebForms\WebUIValidation.js;Scripts\_references.js;Default.aspx;favicon.ico;Global.asax;Site.Master;ThankYou.aspx;ViewSwitcher.ascx;Web.config;Bundle.config;packages.config;Scripts\jquery-1.10.2.min.map;Site.Mobile.Master
CollectFilesFromIntermediateSatelliteAssembliesWithTargetPath:
  Gather all files from Project output (IntermediateSatelliteAssembliesWithTargetPath). Adding:
CollectFilesFromReference:
  Gather all files from Project items @(ReferenceCopyLocalPaths,ReferenceComWrappersToCopyLocal,ResolvedIsolatedComModules,_DeploymentLooseManifestFile,NativeReferenceFile).
CollectFilesFromAllExtraReferenceFiles:
  Gather all files from Project items @(AllExtraReferenceFiles). Adding:
CollectFilesFrom_SourceItemsToCopyToOutputDirectory:
  Gather all files from Project items @(_SourceItemsToCopyToOutputDirectoryAlways,_SourceItemsToCopyToOutputDirectory). Adding:
  bin\ApplicationInsights.config
CollectFilesFrom_binDeployableAssemblies:
  Gather all files from Project items @(_binDeployableAssemblies). Adding:
PipelineCollectFilesPhase:
  Publish Pipeline Collect Files Phase
PreTransformWebConfig:
  Found The following for Config tranformation:
  Web.config
  Creating directory "C:\src\SignUp.Web\obj\Debug\TransformWebConfig\transformed\".
  Copying Web.config to obj\Debug\TransformWebConfig\original\Web.config.
  Copying C:\src\SignUp.Web\Web.Debug.config to obj\Debug\TransformWebConfig\assist\Web.config.
TransformWebConfigCore:
  Transforming Source File: C:\src\SignUp.Web\Web.config
    Applying Transform File: C:\src\SignUp.Web\Web.Debug.config
    Output File: obj\Debug\TransformWebConfig\transformed\Web.config
  Transformation succeeded
PostTransformWebConfig:
  Transformed Web.config using C:\src\SignUp.Web\Web.Debug.config into obj\Debug\TransformWebConfig\transformed\Web.config.
PipelineTransformPhase:
  Publish Pipeline Transform Phase
PreAutoParameterizationWebConfigConnectionStrings:
  Creating directory "C:\src\SignUp.Web\obj\Debug\CSAutoParameterize\transformed\".
  Copying obj\Debug\TransformWebConfig\transformed\Web.config to obj\Debug\CSAutoParameterize\original\Web.config.
AutoParameterizationWebConfigConnectionStringsCore:
  Transforming Source File: C:\src\SignUp.Web\obj\Debug\TransformWebConfig\transformed\Web.config
    No element in the source document matches '/configuration/connectionStrings'
    Not executing SetTokenizedAttributes (transform line 6, 15)
    Output File: obj\Debug\CSAutoParameterize\transformed\Web.config
  Transformation succeeded
PostAutoParameterizationWebConfigConnectionStrings:
  Auto ConnectionString Transformed obj\Debug\TransformWebConfig\transformed\Web.config into obj\Debug\CSAutoParameterize\transformed\Web.config.
PipelineMsdeploySpecificTransformPhase:
  Publish Pipeline Deploy phase Stage PipelineMsdeploySpecificTransformPhase
CopyAllFilesToSingleFolderForMsdeploy:
  Creating directory "obj\Debug\Package\PackageTmp".
  Copying all files to temporary location below for package/publish:
  obj\Debug\Package\PackageTmp.
  Copying c:\out\SignUp.Web.dll to obj\Debug\Package\PackageTmp\bin\SignUp.Web.dll.
  Copying c:\out\SignUp.Web.pdb to obj\Debug\Package\PackageTmp\bin\SignUp.Web.pdb.
  Copying About.aspx to obj\Debug\Package\PackageTmp\About.aspx.
  Copying Contact.aspx to obj\Debug\Package\PackageTmp\Contact.aspx.
  Copying Content\bootstrap.css to obj\Debug\Package\PackageTmp\Content\bootstrap.css.
  Copying Content\bootstrap.min.css to obj\Debug\Package\PackageTmp\Content\bootstrap.min.css.
  Copying Content\Site.css to obj\Debug\Package\PackageTmp\Content\Site.css.
  Copying img\dockercon-us-2018.png to obj\Debug\Package\PackageTmp\img\dockercon-us-2018.png.
  Copying SignUp.aspx to obj\Debug\Package\PackageTmp\SignUp.aspx.
  Copying fonts\glyphicons-halflings-regular.svg to obj\Debug\Package\PackageTmp\fonts\glyphicons-halflings-regular.svg.
  Copying fonts\glyphicons-halflings-regular.woff to obj\Debug\Package\PackageTmp\fonts\glyphicons-halflings-regular.woff.
  Copying fonts\glyphicons-halflings-regular.ttf to obj\Debug\Package\PackageTmp\fonts\glyphicons-halflings-regular.ttf.
  Copying fonts\glyphicons-halflings-regular.eot to obj\Debug\Package\PackageTmp\fonts\glyphicons-halflings-regular.eot.
  Copying ApplicationInsights.config to obj\Debug\Package\PackageTmp\ApplicationInsights.config.
  Copying fonts\geomanist\hinted-Geomanist-Book.woff2 to obj\Debug\Package\PackageTmp\fonts\geomanist\hinted-Geomanist-Book.woff2.
  Copying Scripts\bootstrap.js to obj\Debug\Package\PackageTmp\Scripts\bootstrap.js.
  Copying Scripts\bootstrap.min.js to obj\Debug\Package\PackageTmp\Scripts\bootstrap.min.js.
  Copying Scripts\jquery-1.10.2.js to obj\Debug\Package\PackageTmp\Scripts\jquery-1.10.2.js.
  Copying Scripts\jquery-1.10.2.min.js to obj\Debug\Package\PackageTmp\Scripts\jquery-1.10.2.min.js.
  Copying Scripts\modernizr-2.6.2.js to obj\Debug\Package\PackageTmp\Scripts\modernizr-2.6.2.js.
  Copying Scripts\respond.js to obj\Debug\Package\PackageTmp\Scripts\respond.js.
  Copying Scripts\respond.min.js to obj\Debug\Package\PackageTmp\Scripts\respond.min.js.
  Copying Scripts\WebForms\DetailsView.js to obj\Debug\Package\PackageTmp\Scripts\WebForms\DetailsView.js.
  Copying Scripts\WebForms\Focus.js to obj\Debug\Package\PackageTmp\Scripts\WebForms\Focus.js.
  Copying Scripts\WebForms\GridView.js to obj\Debug\Package\PackageTmp\Scripts\WebForms\GridView.js.
  Copying Scripts\WebForms\Menu.js to obj\Debug\Package\PackageTmp\Scripts\WebForms\Menu.js.
  Copying Scripts\WebForms\MenuStandards.js to obj\Debug\Package\PackageTmp\Scripts\WebForms\MenuStandards.js.
  Copying Scripts\WebForms\MSAjax\MicrosoftAjax.js to obj\Debug\Package\PackageTmp\Scripts\WebForms\MSAjax\MicrosoftAjax.js.
  Copying Scripts\WebForms\MSAjax\MicrosoftAjaxApplicationServices.js to obj\Debug\Package\PackageTmp\Scripts\WebForms\MSAjax\MicrosoftAjaxApplicationServices.js.
  Copying Scripts\WebForms\MSAjax\MicrosoftAjaxComponentModel.js to obj\Debug\Package\PackageTmp\Scripts\WebForms\MSAjax\MicrosoftAjaxComponentModel.js.
  Copying Scripts\WebForms\MSAjax\MicrosoftAjaxCore.js to obj\Debug\Package\PackageTmp\Scripts\WebForms\MSAjax\MicrosoftAjaxCore.js.
  Copying Scripts\WebForms\MSAjax\MicrosoftAjaxGlobalization.js to obj\Debug\Package\PackageTmp\Scripts\WebForms\MSAjax\MicrosoftAjaxGlobalization.js.
  Copying Scripts\WebForms\MSAjax\MicrosoftAjaxHistory.js to obj\Debug\Package\PackageTmp\Scripts\WebForms\MSAjax\MicrosoftAjaxHistory.js.
  Copying Scripts\WebForms\MSAjax\MicrosoftAjaxNetwork.js to obj\Debug\Package\PackageTmp\Scripts\WebForms\MSAjax\MicrosoftAjaxNetwork.js.
  Copying Scripts\WebForms\MSAjax\MicrosoftAjaxSerialization.js to obj\Debug\Package\PackageTmp\Scripts\WebForms\MSAjax\MicrosoftAjaxSerialization.js.
  Copying Scripts\WebForms\MSAjax\MicrosoftAjaxTimer.js to obj\Debug\Package\PackageTmp\Scripts\WebForms\MSAjax\MicrosoftAjaxTimer.js.
  Copying Scripts\WebForms\MSAjax\MicrosoftAjaxWebForms.js to obj\Debug\Package\PackageTmp\Scripts\WebForms\MSAjax\MicrosoftAjaxWebForms.js.
  Copying Scripts\WebForms\MSAjax\MicrosoftAjaxWebServices.js to obj\Debug\Package\PackageTmp\Scripts\WebForms\MSAjax\MicrosoftAjaxWebServices.js.
  Copying Scripts\WebForms\SmartNav.js to obj\Debug\Package\PackageTmp\Scripts\WebForms\SmartNav.js.
  Copying Scripts\WebForms\TreeView.js to obj\Debug\Package\PackageTmp\Scripts\WebForms\TreeView.js.
  Copying Scripts\WebForms\WebForms.js to obj\Debug\Package\PackageTmp\Scripts\WebForms\WebForms.js.
  Copying Scripts\WebForms\WebParts.js to obj\Debug\Package\PackageTmp\Scripts\WebForms\WebParts.js.
  Copying Scripts\WebForms\WebUIValidation.js to obj\Debug\Package\PackageTmp\Scripts\WebForms\WebUIValidation.js.
  Copying Scripts\_references.js to obj\Debug\Package\PackageTmp\Scripts\_references.js.
  Copying Default.aspx to obj\Debug\Package\PackageTmp\Default.aspx.
  Copying favicon.ico to obj\Debug\Package\PackageTmp\favicon.ico.
  Copying Global.asax to obj\Debug\Package\PackageTmp\Global.asax.
  Copying Site.Master to obj\Debug\Package\PackageTmp\Site.Master.
  Copying ThankYou.aspx to obj\Debug\Package\PackageTmp\ThankYou.aspx.
  Copying ViewSwitcher.ascx to obj\Debug\Package\PackageTmp\ViewSwitcher.ascx.
  Copying Bundle.config to obj\Debug\Package\PackageTmp\Bundle.config.
  Copying packages.config to obj\Debug\Package\PackageTmp\packages.config.
  Copying Scripts\jquery-1.10.2.min.map to obj\Debug\Package\PackageTmp\Scripts\jquery-1.10.2.min.map.
  Copying Site.Mobile.Master to obj\Debug\Package\PackageTmp\Site.Mobile.Master.
  Copying C:\src\packages\Antlr.3.4.1.9004\lib\Antlr3.Runtime.dll to obj\Debug\Package\PackageTmp\bin\Antlr3.Runtime.dll.
  Copying C:\src\packages\AspNet.ScriptManager.bootstrap.3.0.0\lib\net45\AspNet.ScriptManager.bootstrap.dll to obj\Debug\Package\PackageTmp\bin\AspNet.ScriptManager.bootstrap.dll.
  Copying C:\src\packages\AspNet.ScriptManager.jQuery.1.10.2\lib\net45\AspNet.ScriptManager.jQuery.dll to obj\Debug\Package\PackageTmp\bin\AspNet.ScriptManager.jQuery.dll.
  Copying C:\src\packages\EntityFramework.6.1.3\lib\net45\EntityFramework.dll to obj\Debug\Package\PackageTmp\bin\EntityFramework.dll.
  Copying C:\src\packages\EntityFramework.6.1.3\lib\net45\EntityFramework.SqlServer.dll to obj\Debug\Package\PackageTmp\bin\EntityFramework.SqlServer.dll.
  Copying C:\src\packages\Microsoft.AspNet.FriendlyUrls.Core.1.0.2\lib\net45\Microsoft.AspNet.FriendlyUrls.dll to obj\Debug\Package\PackageTmp\bin\Microsoft.AspNet.FriendlyUrls.dll.
  Copying C:\src\packages\Microsoft.AspNet.Web.Optimization.WebForms.1.1.3\lib\net45\Microsoft.AspNet.Web.Optimization.WebForms.dll to obj\Debug\Package\PackageTmp\bin\Microsoft.AspNet.Web.Optimization.WebForms.dll.
  Copying C:\src\packages\Microsoft.AspNet.ScriptManager.MSAjax.5.0.0\lib\net45\Microsoft.ScriptManager.MSAjax.dll to obj\Debug\Package\PackageTmp\bin\Microsoft.ScriptManager.MSAjax.dll.
  Copying C:\src\packages\Microsoft.AspNet.ScriptManager.WebForms.5.0.0\lib\net45\Microsoft.ScriptManager.WebForms.dll to obj\Debug\Package\PackageTmp\bin\Microsoft.ScriptManager.WebForms.dll.
  Copying C:\src\packages\Microsoft.Web.Infrastructure.1.0.0.0\lib\net40\Microsoft.Web.Infrastructure.dll to obj\Debug\Package\PackageTmp\bin\Microsoft.Web.Infrastructure.dll.
  Copying C:\src\packages\NATS.Client.0.7.1\lib\net45\NATS.Client.DLL to obj\Debug\Package\PackageTmp\bin\NATS.Client.DLL.
  Copying C:\src\packages\Newtonsoft.Json.10.0.2\lib\net45\Newtonsoft.Json.dll to obj\Debug\Package\PackageTmp\bin\Newtonsoft.Json.dll.
  Copying c:\out\SignUp.Entities.dll to obj\Debug\Package\PackageTmp\bin\SignUp.Entities.dll.
  Copying c:\out\SignUp.Messaging.dll to obj\Debug\Package\PackageTmp\bin\SignUp.Messaging.dll.
  Copying c:\out\SignUp.Model.dll to obj\Debug\Package\PackageTmp\bin\SignUp.Model.dll.
  Copying C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.1\System.Data.dll to obj\Debug\Package\PackageTmp\bin\System.Data.dll.
  Copying C:\src\packages\Microsoft.AspNet.Web.Optimization.1.1.3\lib\net40\System.Web.Optimization.dll to obj\Debug\Package\PackageTmp\bin\System.Web.Optimization.dll.
  Copying C:\src\packages\WebGrease.1.5.2\lib\WebGrease.dll to obj\Debug\Package\PackageTmp\bin\WebGrease.dll.
  Copying c:\out\SignUp.Entities.pdb to obj\Debug\Package\PackageTmp\bin\SignUp.Entities.pdb.
  Copying c:\out\SignUp.Messaging.pdb to obj\Debug\Package\PackageTmp\bin\SignUp.Messaging.pdb.
  Copying c:\out\SignUp.Model.pdb to obj\Debug\Package\PackageTmp\bin\SignUp.Model.pdb.
  Copying c:\out\SignUp.Model.dll.config to obj\Debug\Package\PackageTmp\bin\SignUp.Model.dll.config.
  Copying C:\src\packages\Antlr.3.4.1.9004\lib\Antlr3.Runtime.pdb to obj\Debug\Package\PackageTmp\bin\Antlr3.Runtime.pdb.
  Copying C:\src\SignUp.Web\ApplicationInsights.config to obj\Debug\Package\PackageTmp\bin\ApplicationInsights.config.
  Copying obj\Debug\CSAutoParameterize\transformed\Web.config to obj\Debug\Package\PackageTmp\Web.config.
PipelineCopyAllFilesToOneFolderForMsdeploy:
  Publish Pipeline Deploy phase Stage PipelineCopyAllFilesToOneFolderForMsdeploy
Package:
  Invoking Web Deploy to generate the package with the following settings:
  $(LocalIisVersion) is 0
  $(DestinationIisVersion) is 0
  $(UseIis) is True
  $(IisUrl) is http://localhost:57120/
  $(IncludeIisSettings) is False
  $(_DeploymentUseIis) is False
  $(DestinationUseIis) is False
  Creating directory "c:\out\_PublishedWebsites\SignUp.Web_Package\".
GetMSDeployInstalledVersionPath:
  $(_DefaultMSDeployMaxVersion) is 3
  $(_MSDeployVersionsToTry) is 9.0
  $(MSDeployPath) is C:\Program Files (x86)\IIS\Microsoft Web Deploy V3\
GenerateMsdeployManifestFiles:
  Generate source manifest file for Web Deploy package/publish ...
PackageUsingManifest:
  Packaging into c:\out\_PublishedWebsites\SignUp.Web_Package\SignUp.Web.zip.
  Starting Web deployment task from source: manifest(c:\out\_PublishedWebsites\SignUp.Web_Package\SignUp.Web.SourceManifest.xml) to Destination: package(c:\out\_PublishedWebsites\SignUp.Web_Package\SignUp.Web.zip).
  Adding sitemanifest (sitemanifest).
  Adding IIS Application (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp)
  Creating application (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp)
  Adding virtual path (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp)
  Adding directory (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\About.aspx).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\ApplicationInsights.config).
  Adding directory (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\bin).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\bin\Antlr3.Runtime.dll).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\bin\Antlr3.Runtime.pdb).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\bin\ApplicationInsights.config).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\bin\AspNet.ScriptManager.bootstrap.dll).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\bin\AspNet.ScriptManager.jQuery.dll).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\bin\EntityFramework.dll).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\bin\EntityFramework.SqlServer.dll).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\bin\Microsoft.AspNet.FriendlyUrls.dll).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\bin\Microsoft.AspNet.Web.Optimization.WebForms.dll).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\bin\Microsoft.ScriptManager.MSAjax.dll).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\bin\Microsoft.ScriptManager.WebForms.dll).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\bin\Microsoft.Web.Infrastructure.dll).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\bin\NATS.Client.DLL).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\bin\Newtonsoft.Json.dll).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\bin\SignUp.Entities.dll).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\bin\SignUp.Entities.pdb).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\bin\SignUp.Messaging.dll).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\bin\SignUp.Messaging.pdb).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\bin\SignUp.Model.dll).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\bin\SignUp.Model.dll.config).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\bin\SignUp.Model.pdb).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\bin\SignUp.Web.dll).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\bin\SignUp.Web.pdb).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\bin\System.Data.dll).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\bin\System.Web.Optimization.dll).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\bin\WebGrease.dll).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Bundle.config).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Contact.aspx).
  Adding directory (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Content).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Content\bootstrap.css).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Content\bootstrap.min.css).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Content\Site.css).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Default.aspx).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\favicon.ico).
  Adding directory (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\fonts).
  Adding directory (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\fonts\geomanist).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\fonts\geomanist\hinted-Geomanist-Book.woff2).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\fonts\glyphicons-halflings-regular.eot).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\fonts\glyphicons-halflings-regular.svg).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\fonts\glyphicons-halflings-regular.ttf).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\fonts\glyphicons-halflings-regular.woff).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Global.asax).
  Adding directory (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\img).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\img\dockercon-us-2018.png).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\packages.config).
  Adding directory (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Scripts).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Scripts\bootstrap.js).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Scripts\bootstrap.min.js).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Scripts\jquery-1.10.2.js).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Scripts\jquery-1.10.2.min.js).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Scripts\jquery-1.10.2.min.map).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Scripts\modernizr-2.6.2.js).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Scripts\respond.js).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Scripts\respond.min.js).
  Adding directory (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Scripts\WebForms).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Scripts\WebForms\DetailsView.js).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Scripts\WebForms\Focus.js).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Scripts\WebForms\GridView.js).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Scripts\WebForms\Menu.js).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Scripts\WebForms\MenuStandards.js).
  Adding directory (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Scripts\WebForms\MSAjax).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Scripts\WebForms\MSAjax\MicrosoftAjax.js).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Scripts\WebForms\MSAjax\MicrosoftAjaxApplicationServices.js).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Scripts\WebForms\MSAjax\MicrosoftAjaxComponentModel.js).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Scripts\WebForms\MSAjax\MicrosoftAjaxCore.js).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Scripts\WebForms\MSAjax\MicrosoftAjaxGlobalization.js).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Scripts\WebForms\MSAjax\MicrosoftAjaxHistory.js).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Scripts\WebForms\MSAjax\MicrosoftAjaxNetwork.js).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Scripts\WebForms\MSAjax\MicrosoftAjaxSerialization.js).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Scripts\WebForms\MSAjax\MicrosoftAjaxTimer.js).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Scripts\WebForms\MSAjax\MicrosoftAjaxWebForms.js).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Scripts\WebForms\MSAjax\MicrosoftAjaxWebServices.js).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Scripts\WebForms\SmartNav.js).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Scripts\WebForms\TreeView.js).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Scripts\WebForms\WebForms.js).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Scripts\WebForms\WebParts.js).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Scripts\WebForms\WebUIValidation.js).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Scripts\_references.js).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\SignUp.aspx).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Site.Master).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Site.Mobile.Master).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\ThankYou.aspx).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\ViewSwitcher.ascx).
  Adding file (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp\Web.config).
  Adding ACLs for path (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp)
  Adding ACLs for path (C:\src\SignUp.Web\obj\Debug\Package\PackageTmp)
  Adding declared parameter 'IIS Web Application Name'.
  Successfully executed Web deployment task.
  Package "SignUp.Web.zip" is successfully created as single file at the following location:
  file:///c:/out/_PublishedWebsites/SignUp.Web_Package
  To get the instructions on how to deploy the web package please visit the following link:
  https://go.microsoft.com/fwlink/?LinkId=124618
GenerateSampleDeployScript:
  Sample script for deploying this package is generated at the following location:
  c:\out\_PublishedWebsites\SignUp.Web_Package\SignUp.Web.deploy.cmd
  For this sample script, you can change the deploy parameters by changing the following file:
  c:\out\_PublishedWebsites\SignUp.Web_Package\SignUp.Web.SetParameters.xml
PipelineDeployPhase:
3889bb8d808b: Already exists
Done Building Project "C:\src\SignUp.Web\SignUp.Web.csproj" (default targets).

Build succeeded.
    0 Warning(s)
    0 Error(s)

Time Elapsed 00:00:15.30
Removing intermediate container ee9c5f562ada
 ---> 5ed012494e13
Step 7/14 : FROM microsoft/aspnet:4.7.1-windowsservercore-ltsc2016
4.7.1-windowsservercore-ltsc2016: Pulling from microsoft/aspnet
c0f6863f3dd4: Already exists
d2629f42eccc: Pull complete
908453fb0702: Pull complete
7720ff77ad0c: Pull complete
7a788d0e9347: Pull complete
f153ca62095a: Pull complete
90db3fe4823b: Pull complete
ba9029de84a0: Pull complete
bccf2a0f1ba2: Pull complete
c13d1add2862: Pull complete
f967e8355459: Pull complete
Digest: sha256:ecc0832b36be693b287b0a9192a8b57266206b3c0f3e8993b20ad90ea55550e0
Status: Downloaded newer image for microsoft/aspnet:4.7.1-windowsservercore-ltsc2016
 ---> 3b5cbec4eca1
Step 8/14 : SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
 ---> Running in 1ffb84fc4162
Removing intermediate container 1ffb84fc4162
 ---> 409fd13e1403
Step 9/14 : RUN Remove-Website -Name 'Default Web Site';    New-Item -Path 'C:\web-app' -Type Directory;     New-Website -Name 'web-app' -Port 80 -PhysicalPath 'C:\web-app'
 ---> Running in a417c1e2369b


    Directory: C:\


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----       11/13/2018   8:47 AM                web-app

Name         : web-app
ID           : 1973811730
State        : Stopped
PhysicalPath : C:\web-app
Bindings     : Microsoft.IIs.PowerShell.Framework.ConfigurationElement



Removing intermediate container a417c1e2369b
 ---> 74bf6478772c
Step 10/14 : HEALTHCHECK --interval=5s  CMD powershell -command     try {      $response = iwr http://localhost/SignUp -UseBasicParsing;      if ($response.StatusCode -eq 200) { return 0}      else {return 1};     } catch { return 1 }
 ---> Running in 33919affcdbc
Removing intermediate container 33919affcdbc
 ---> 40f4b4455ec6
Step 11/14 : ENTRYPOINT ["powershell", "C:\\bootstrap.ps1"]
 ---> Running in 29cb50543ddc
Removing intermediate container 29cb50543ddc
 ---> e9fc8d40ba6c
Step 12/14 : COPY .\docker\bootstrap.ps1 C:\
 ---> c63c760c1823
Step 13/14 : COPY --from=builder C:\out\_PublishedWebsites\SignUp.Web C:\web-app
 ---> be0fdf2bf6af
Step 14/14 : RUN Add-LocalGroupMember -Group 'Administrators' -Member 'IIS AppPool\DefaultAppPool';
 ---> Running in 2c59571d61d8
Removing intermediate container 2c59571d61d8
 ---> cebcbe0b354d
Successfully built cebcbe0b354d
Successfully tagged signup_signup-web:latest
Creating signup_signup-db_1_2217344a2e70 ... done
Creating signup_signup-web_1_799b5e72dbe6 ... done
```
Get the IP address for the web container and open http://&lt;ip&gt; --> This should show you the signup app  
If you want, register and use standard SQL tooling like the [Azure Data Studio](https://docs.microsoft.com/en-us/sql/azure-data-studio/download?view=sql-server-2017) to connect to the SQL database and verify the data is written (connect to the IP with user SA and password TechDays!!!)  