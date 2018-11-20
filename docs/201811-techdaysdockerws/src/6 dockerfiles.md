## 6 Dockerfiles
### Example 1: Apache image
Download files from [here](https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/tfenster/presentations/tree/master/docs/201811-techdaysdockerws/src/dockerfiles) or if that doesn't work from [here](https://ve.link/td18) (use "download" in the top left corner) and extract them to c:\users\admintechdays  
Download and install Visual Studio Code from [here](https://code.visualstudio.com/download)  
Open the downloaded folder in VS Code  
Go to apache-http, open the Dockerfile and follow the VS Code recommendation to install the Docker extension including a restart for VS Code in the end  
After restart, open the Dockerfile again and inspect it  
Open a Terminal in VS Code (menu "Terminal" -> "New Terminal")
```PowerShell
PS C:\Users\AdminTechDays\dockerfiles> cd .\apache-http\
PS C:\Users\AdminTechDays\dockerfiles\apache-http> docker build -t mypache .
Sending build context to Docker daemon  32.42MB
Step 1/7 : FROM microsoft/windowsservercore
latest: Pulling from microsoft/windowsservercore
3889bb8d808b: Already exists
c0f6863f3dd4: Pull complete
Digest: sha256:9081c52809e4a7e66b6746137a6172eff36c30d52a30ee8f185829f6a867235c
Status: Downloaded newer image for microsoft/windowsservercore:latest
 ---> f8dc15f55717
Step 2/7 : LABEL Description="Apache" Vendor="Apache Software Foundation" Version="2.4.23"
 ---> Running in 5ec5c183daee
Removing intermediate container 5ec5c183daee
 ---> 820f28db9ee9
Step 3/7 : COPY httpd-2.4.33-win64-VC15.zip /
 ---> 83449f82e442
Step 4/7 : COPY vc_redist.x64.exe /
 ---> f513ea909e41
Step 5/7 : RUN powershell -Command      $ErrorActionPreference = 'Stop';        Expand-Archive -Path c:\httpd-2.4.33-win64-VC15.zip -DestinationPath c:\ ;      Remove-Item c:\httpd-2.4.33-win64-VC15.zip -Force
 ---> Running in 7ad47c616e49
Removing intermediate container 7ad47c616e49
 ---> 298667d444d9
Step 6/7 : RUN powershell -Command      $ErrorActionPreference = 'Stop';        start-Process c:\vc_redist.x64.exe -ArgumentList '/quiet' -Wait ;       Remove-Item c:\vc_redist.x64.exe -Force
 ---> Running in c9f1a8744d10
Removing intermediate container c9f1a8744d10
 ---> cb4746062a7e
Step 7/7 : CMD /Apache24/bin/httpd.exe -w
 ---> Running in 0ce0c034d379
Removing intermediate container 0ce0c034d379
 ---> 308ec09b0068
Successfully built 308ec09b0068
Successfully tagged mypache:latest
```
Run a container using the new image
```PowerShell
PS C:\Users\AdminTechDays\dockerfiles\apache-http> docker run mypache
```
Go to the Docker bar on the left, expand Containers, maybe hit refresh on the top  
Right click your container --> Attach shell and run ipconfig  
```PowerShell
Windows PowerShell
Copyright (C) 2016 Microsoft Corporation. All rights reserved.

PS C:\> ipconfig

Windows IP Configuration

Ethernet adapter vEthernet (Container NIC d2c58221):

   Connection-specific DNS Suffix  . : dmfn1rjxqpnubaf5pkj5g4xped.ax.internal.cloudapp.net
   Link-local IPv6 Address . . . . . : fe80::3414:d64b:36b4:cde0%25
   IPv4 Address. . . . . . . . . . . : 172.29.83.213
   Subnet Mask . . . . . . . . . . . : 255.255.240.0
   Default Gateway . . . . . . . . . : 172.29.80.1
PS C:\>
```
Point your browser at http://&lt;ip&gt; again, in my case http://172.29.83.213 --> you should see the apache start page "It works!"  
Right click on the container in VS Code --> Remove container
Right click in the image in VS Code --> Remove image
### Example 2: Custom image using sources
In VS Code go to hostname-app, open the Dockerfile and inspect it  
Right click on the Dockerfile --> Build image  
Enter a name or just keep the default  
You might be asked if you want to switch the rendering type --> do that, way faster on Windows  
```PowerShell
Windows PowerShell
Copyright (C) 2016 Microsoft Corporation. All rights reserved.

PS C:\Users\AdminTechDays\dockerfiles> docker build --rm -f "hostname-app\Dockerfile" -t hostname-app:latest hostname-app
Sending build context to Docker daemon   5.12kB
Step 1/4 : FROM microsoft/aspnet:4.7.2-windowsservercore-ltsc2016
4.7.2-windowsservercore-ltsc2016: Pulling from microsoft/aspnet
3889bb8d808b: Already exists
6e046b8e194c: Pull complete
86cd12ca3051: Pull complete
50ba44bc1b58: Pull complete
c4e5b90c2f36: Pull complete
4727e73844f3: Pull complete
5c18b051bfd8: Pull complete
0c9ce0c7505c: Pull complete
c710173c2bc4: Pull complete
c2cde60b69fa: Pull complete
1b63ad51afa6: Pull complete
61eb591d8e69: Pull complete
Digest: sha256:eac2818ce9c66ac9f66fc56872919110e47f2bfb08b3a44bcd64de7c4c63297a
Status: Downloaded newer image for microsoft/aspnet:4.7.2-windowsservercore-ltsc2016
 ---> 7b1f2f42da1d
Step 2/4 : COPY default.aspx C:/inetpub/wwwroot
 ---> a2475841d193
Step 3/4 : SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
 ---> Running in 34f1c39915e2
Removing intermediate container 34f1c39915e2
 ---> dbec405c6a91
Step 4/4 : RUN Add-LocalGroupMember -Group 'Administrators' -Member 'IIS AppPool\DefaultAppPool';
 ---> Running in 6865e5591039
Removing intermediate container 6865e5591039
 ---> f6f17c14b559
Successfully built f6f17c14b559
Successfully tagged hostname-app:latest
```
Run the container. The app returns the hostname, so we'll give it a meaningful one
```PowerShell
docker run --hostname techdays hostname-app
```
As it now has a hostname, open http://techdays  
Remove the container and image  
### Example 3: Multi-stage image
In VS Code go to aspnetapp, open the Dockerfile and inspect it  
Right click on the Dockerfile --> Build image  
Enter a name or just keep the default  
```PowerShell
Windows PowerShell
Copyright (C) 2016 Microsoft Corporation. All rights reserved.

PS C:\Users\AdminTechDays\dockerfiles> docker build --rm -f "aspnetapp\Dockerfile" -t aspnetapp:latest aspnetapp
Sending build context to Docker daemon  1.718MB
Step 1/12 : FROM microsoft/dotnet-framework:4.7.2-sdk-windowsservercore-ltsc2016 AS build
4.7.2-sdk-windowsservercore-ltsc2016: Pulling from microsoft/dotnet-framework
3889bb8d808b: Already exists
c0f6863f3dd4: Already exists
9a814ae47929: Pull complete
3e49870a56ec: Pull complete
2098ddeb5d57: Pull complete
d78f368c4670: Pull complete
ec2d1032aac6: Pull complete
e92901a4f12e: Pull complete
e79c4850a48e: Pull complete
f0ffcb0f5016: Pull complete
6211910c48b5: Pull complete
86d720c972c9: Pull complete
737e249dfb40: Pull complete
e19a0e60d9b1: Pull complete
7097f7799ee6: Pull complete
69e42a551055: Pull complete
3b62420ad22d: Pull complete
Digest: sha256:dcdd5a039026a21c80cadf62c63678b7e89a83e09fe8f528840cf17e76e48eb7
Status: Downloaded newer image for microsoft/dotnet-framework:4.7.2-sdk-windowsservercore-ltsc2016
 ---> a4b4c70c517f
Step 2/12 : WORKDIR /app
 ---> Running in f8e8baac58b5
Removing intermediate container f8e8baac58b5
 ---> c7fd848c7e82
Step 3/12 : COPY *.sln .
 ---> 995c32eb5f3c
Step 4/12 : COPY aspnetapp/*.csproj ./aspnetapp/
 ---> c5b5ad185598
Step 5/12 : COPY aspnetapp/*.config ./aspnetapp/
 ---> 0d18b7aca092
Step 6/12 : RUN nuget restore
 ---> Running in b0f25141a842
MSBuild auto-detection: using msbuild version '15.8.169.51996' from 'C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\bin'.
Restoring NuGet package Microsoft.AspNet.ScriptManager.WebForms.5.0.0.
Restoring NuGet package Microsoft.AspNet.FriendlyUrls.1.0.2.
Restoring NuGet package Microsoft.ApplicationInsights.WindowsServer.2.2.0.
Restoring NuGet package AspNet.ScriptManager.bootstrap.3.0.0.
Restoring NuGet package Microsoft.ApplicationInsights.DependencyCollector.2.2.0.
Restoring NuGet package Microsoft.AspNet.ScriptManager.MSAjax.5.0.0.
Restoring NuGet package bootstrap.3.0.0.
Restoring NuGet package Microsoft.AspNet.FriendlyUrls.Core.1.0.2.
Restoring NuGet package Microsoft.ApplicationInsights.2.2.0.
Restoring NuGet package AspNet.ScriptManager.jQuery.1.10.2.
Restoring NuGet package Microsoft.ApplicationInsights.WindowsServer.TelemetryChannel.2.2.0.
Restoring NuGet package Microsoft.ApplicationInsights.Web.2.2.0.
Restoring NuGet package Antlr.3.4.1.9004.
Restoring NuGet package Microsoft.ApplicationInsights.Agent.Intercept.2.0.6.
Restoring NuGet package Microsoft.ApplicationInsights.PerfCounterCollector.2.2.0.
Restoring NuGet package jQuery.1.10.2.
  GET https://api.nuget.org/v3-flatcontainer/bootstrap/3.0.0/bootstrap.3.0.0.nupkg
  GET https://api.nuget.org/v3-flatcontainer/microsoft.applicationinsights.windowsserver.telemetrychannel/2.2.0/microsoft.applicationinsights.windowsserver.telemetrychannel.2.2.0.nupkg
  GET https://api.nuget.org/v3-flatcontainer/microsoft.aspnet.friendlyurls/1.0.2/microsoft.aspnet.friendlyurls.1.0.2.nupkg
  GET https://api.nuget.org/v3-flatcontainer/aspnet.scriptmanager.bootstrap/3.0.0/aspnet.scriptmanager.bootstrap.3.0.0.nupkg
  GET https://api.nuget.org/v3-flatcontainer/microsoft.applicationinsights.perfcountercollector/2.2.0/microsoft.applicationinsights.perfcountercollector.2.2.0.nupkg
  GET https://api.nuget.org/v3-flatcontainer/microsoft.applicationinsights.agent.intercept/2.0.6/microsoft.applicationinsights.agent.intercept.2.0.6.nupkg
  GET https://api.nuget.org/v3-flatcontainer/microsoft.applicationinsights/2.2.0/microsoft.applicationinsights.2.2.0.nupkg
  GET https://api.nuget.org/v3-flatcontainer/microsoft.aspnet.scriptmanager.webforms/5.0.0/microsoft.aspnet.scriptmanager.webforms.5.0.0.nupkg
  GET https://api.nuget.org/v3-flatcontainer/microsoft.applicationinsights.web/2.2.0/microsoft.applicationinsights.web.2.2.0.nupkg
  GET https://api.nuget.org/v3-flatcontainer/aspnet.scriptmanager.jquery/1.10.2/aspnet.scriptmanager.jquery.1.10.2.nupkg
  GET https://api.nuget.org/v3-flatcontainer/antlr/3.4.1.9004/antlr.3.4.1.9004.nupkg
  GET https://api.nuget.org/v3-flatcontainer/microsoft.aspnet.scriptmanager.msajax/5.0.0/microsoft.aspnet.scriptmanager.msajax.5.0.0.nupkg
  GET https://api.nuget.org/v3-flatcontainer/microsoft.applicationinsights.windowsserver/2.2.0/microsoft.applicationinsights.windowsserver.2.2.0.nupkg
  GET https://api.nuget.org/v3-flatcontainer/microsoft.applicationinsights.dependencycollector/2.2.0/microsoft.applicationinsights.dependencycollector.2.2.0.nupkg
  GET https://api.nuget.org/v3-flatcontainer/microsoft.aspnet.friendlyurls.core/1.0.2/microsoft.aspnet.friendlyurls.core.1.0.2.nupkg
  GET https://api.nuget.org/v3-flatcontainer/jquery/1.10.2/jquery.1.10.2.nupkg
  OK https://api.nuget.org/v3-flatcontainer/bootstrap/3.0.0/bootstrap.3.0.0.nupkg 12ms
  OK https://api.nuget.org/v3-flatcontainer/jquery/1.10.2/jquery.1.10.2.nupkg 27ms
  OK https://api.nuget.org/v3-flatcontainer/antlr/3.4.1.9004/antlr.3.4.1.9004.nupkg 32ms
Installing jQuery 1.10.2.
Installing Antlr 3.4.1.9004.
Installing bootstrap 3.0.0.
Adding package 'Antlr.3.4.1.9004' to folder 'C:\app\packages'
Adding package 'bootstrap.3.0.0' to folder 'C:\app\packages'
Adding package 'jQuery.1.10.2' to folder 'C:\app\packages'
Added package 'Antlr.3.4.1.9004' to folder 'C:\app\packages'
Restoring NuGet package Microsoft.AspNet.Web.Optimization.1.1.3.
  GET https://api.nuget.org/v3-flatcontainer/microsoft.aspnet.web.optimization/1.1.3/microsoft.aspnet.web.optimization.1.1.3.nupkg
  OK https://api.nuget.org/v3-flatcontainer/aspnet.scriptmanager.jquery/1.10.2/aspnet.scriptmanager.jquery.1.10.2.nupkg 132ms
Installing AspNet.ScriptManager.jQuery 1.10.2.
  OK https://api.nuget.org/v3-flatcontainer/microsoft.applicationinsights.web/2.2.0/microsoft.applicationinsights.web.2.2.0.nupkg 134ms
Installing Microsoft.ApplicationInsights.Web 2.2.0.
  OK https://api.nuget.org/v3-flatcontainer/microsoft.aspnet.web.optimization/1.1.3/microsoft.aspnet.web.optimization.1.1.3.nupkg 4ms
Installing Microsoft.AspNet.Web.Optimization 1.1.3.
  OK https://api.nuget.org/v3-flatcontainer/microsoft.aspnet.friendlyurls/1.0.2/microsoft.aspnet.friendlyurls.1.0.2.nupkg 137ms
Installing Microsoft.AspNet.FriendlyUrls 1.0.2.
  OK https://api.nuget.org/v3-flatcontainer/microsoft.aspnet.scriptmanager.msajax/5.0.0/microsoft.aspnet.scriptmanager.msajax.5.0.0.nupkg 139ms
Installing Microsoft.AspNet.ScriptManager.MSAjax 5.0.0.
  OK https://api.nuget.org/v3-flatcontainer/microsoft.applicationinsights/2.2.0/microsoft.applicationinsights.2.2.0.nupkg 142ms
Installing Microsoft.ApplicationInsights 2.2.0.
  OK https://api.nuget.org/v3-flatcontainer/microsoft.aspnet.scriptmanager.webforms/5.0.0/microsoft.aspnet.scriptmanager.webforms.5.0.0.nupkg 143ms
  OK https://api.nuget.org/v3-flatcontainer/microsoft.applicationinsights.windowsserver/2.2.0/microsoft.applicationinsights.windowsserver.2.2.0.nupkg 143ms
Installing Microsoft.AspNet.ScriptManager.WebForms 5.0.0.
Installing Microsoft.ApplicationInsights.WindowsServer 2.2.0.
Added package 'jQuery.1.10.2' to folder 'C:\app\packages'
Restoring NuGet package Microsoft.AspNet.Web.Optimization.WebForms.1.1.3.
  OK https://api.nuget.org/v3-flatcontainer/microsoft.applicationinsights.dependencycollector/2.2.0/microsoft.applicationinsights.dependencycollector.2.2.0.nupkg 145ms
Installing Microsoft.ApplicationInsights.DependencyCollector 2.2.0.
  GET https://api.nuget.org/v3-flatcontainer/microsoft.aspnet.web.optimization.webforms/1.1.3/microsoft.aspnet.web.optimization.webforms.1.1.3.nupkg
Added package 'bootstrap.3.0.0' to folder 'C:\app\packages'
Restoring NuGet package Microsoft.CodeDom.Providers.DotNetCompilerPlatform.1.0.8.
  GET https://api.nuget.org/v3-flatcontainer/microsoft.codedom.providers.dotnetcompilerplatform/1.0.8/microsoft.codedom.providers.dotnetcompilerplatform.1.0.8.nupkg
Adding package 'AspNet.ScriptManager.jQuery.1.10.2' to folder 'C:\app\packages'
Adding package 'Microsoft.AspNet.Web.Optimization.1.1.3' to folder 'C:\app\packages'
  OK https://api.nuget.org/v3-flatcontainer/aspnet.scriptmanager.bootstrap/3.0.0/aspnet.scriptmanager.bootstrap.3.0.0.nupkg 178ms
Installing AspNet.ScriptManager.bootstrap 3.0.0.
Added package 'AspNet.ScriptManager.jQuery.1.10.2' to folder 'C:\app\packages'
Adding package 'Microsoft.AspNet.FriendlyUrls.1.0.2' to folder 'C:\app\packages'
Restoring NuGet package Microsoft.Net.Compilers.2.4.0.
  GET https://api.nuget.org/v3-flatcontainer/microsoft.net.compilers/2.4.0/microsoft.net.compilers.2.4.0.nupkg
Added package 'Microsoft.AspNet.Web.Optimization.1.1.3' to folder 'C:\app\packages'
Restoring NuGet package Microsoft.Web.Infrastructure.1.0.0.
  GET https://api.nuget.org/v3-flatcontainer/microsoft.web.infrastructure/1.0.0/microsoft.web.infrastructure.1.0.0.nupkg
  OK https://api.nuget.org/v3-flatcontainer/microsoft.web.infrastructure/1.0.0/microsoft.web.infrastructure.1.0.0.nupkg 4ms
Installing Microsoft.Web.Infrastructure 1.0.0.0.
Adding package 'Microsoft.ApplicationInsights.WindowsServer.2.2.0' to folder 'C:\app\packages'
Adding package 'AspNet.ScriptManager.bootstrap.3.0.0' to folder 'C:\app\packages'
Adding package 'Microsoft.ApplicationInsights.DependencyCollector.2.2.0' to folder 'C:\app\packages'
Adding package 'Microsoft.ApplicationInsights.Web.2.2.0' to folder 'C:\app\packages'
Adding package 'Microsoft.AspNet.ScriptManager.WebForms.5.0.0' to folder 'C:\app\packages'
Adding package 'Microsoft.AspNet.ScriptManager.MSAjax.5.0.0' to folder 'C:\app\packages'
Adding package 'Microsoft.Web.Infrastructure.1.0.0' to folder 'C:\app\packages'
Added package 'AspNet.ScriptManager.bootstrap.3.0.0' to folder 'C:\app\packages'
Restoring NuGet package Modernizr.2.6.2.
  GET https://api.nuget.org/v3-flatcontainer/modernizr/2.6.2/modernizr.2.6.2.nupkg
Added package 'Microsoft.AspNet.FriendlyUrls.1.0.2' to folder 'C:\app\packages'
  OK https://api.nuget.org/v3-flatcontainer/modernizr/2.6.2/modernizr.2.6.2.nupkg 5ms
Restoring NuGet package Newtonsoft.Json.6.0.4.
Installing Modernizr 2.6.2.
  GET https://api.nuget.org/v3-flatcontainer/newtonsoft.json/6.0.4/newtonsoft.json.6.0.4.nupkg
Added package 'Microsoft.Web.Infrastructure.1.0.0' to folder 'C:\app\packages'
Restoring NuGet package Respond.1.2.0.
  GET https://api.nuget.org/v3-flatcontainer/respond/1.2.0/respond.1.2.0.nupkg
Added package 'Microsoft.ApplicationInsights.DependencyCollector.2.2.0' to folder 'C:\app\packages'
Restoring NuGet package WebGrease.1.5.2.
  GET https://api.nuget.org/v3-flatcontainer/webgrease/1.5.2/webgrease.1.5.2.nupkg
Added package 'Microsoft.ApplicationInsights.WindowsServer.2.2.0' to folder 'C:\app\packages'
  OK https://api.nuget.org/v3-flatcontainer/webgrease/1.5.2/webgrease.1.5.2.nupkg 6ms
Installing WebGrease 1.5.2.
Adding package 'Modernizr.2.6.2' to folder 'C:\app\packages'
Added package 'Microsoft.AspNet.ScriptManager.WebForms.5.0.0' to folder 'C:\app\packages'
Added package 'Microsoft.AspNet.ScriptManager.MSAjax.5.0.0' to folder 'C:\app\packages'
Added package 'Microsoft.ApplicationInsights.Web.2.2.0' to folder 'C:\app\packages'
Added package 'Modernizr.2.6.2' to folder 'C:\app\packages'
Adding package 'Microsoft.ApplicationInsights.2.2.0' to folder 'C:\app\packages'
Added package 'Microsoft.ApplicationInsights.2.2.0' to folder 'C:\app\packages'
Adding package 'WebGrease.1.5.2' to folder 'C:\app\packages'
Added package 'WebGrease.1.5.2' to folder 'C:\app\packages'
  OK https://api.nuget.org/v3-flatcontainer/newtonsoft.json/6.0.4/newtonsoft.json.6.0.4.nupkg 111ms
Installing Newtonsoft.Json 6.0.4.
  OK https://api.nuget.org/v3-flatcontainer/microsoft.net.compilers/2.4.0/microsoft.net.compilers.2.4.0.nupkg 161ms
Installing Microsoft.Net.Compilers 2.4.0.
  OK https://api.nuget.org/v3-flatcontainer/microsoft.applicationinsights.agent.intercept/2.0.6/microsoft.applicationinsights.agent.intercept.2.0.6.nupkg 450ms
  OK https://api.nuget.org/v3-flatcontainer/microsoft.aspnet.friendlyurls.core/1.0.2/microsoft.aspnet.friendlyurls.core.1.0.2.nupkg 449ms
Installing Microsoft.AspNet.FriendlyUrls.Core 1.0.2.
Installing Microsoft.ApplicationInsights.Agent.Intercept 2.0.6.
  OK https://api.nuget.org/v3-flatcontainer/microsoft.applicationinsights.windowsserver.telemetrychannel/2.2.0/microsoft.applicationinsights.windowsserver.telemetrychannel.2.2.0.nupkg 452ms
Installing Microsoft.ApplicationInsights.WindowsServer.TelemetryChannel 2.2.0.
Adding package 'Microsoft.AspNet.FriendlyUrls.Core.1.0.2' to folder 'C:\app\packages'
Added package 'Microsoft.AspNet.FriendlyUrls.Core.1.0.2' to folder 'C:\app\packages'
Adding package 'Microsoft.ApplicationInsights.WindowsServer.TelemetryChannel.2.2.0' to folder 'C:\app\packages'
Added package 'Microsoft.ApplicationInsights.WindowsServer.TelemetryChannel.2.2.0' to folder 'C:\app\packages'
Adding package 'Newtonsoft.Json.6.0.4' to folder 'C:\app\packages'
  OK https://api.nuget.org/v3-flatcontainer/microsoft.aspnet.web.optimization.webforms/1.1.3/microsoft.aspnet.web.optimization.webforms.1.1.3.nupkg 428ms
Installing Microsoft.AspNet.Web.Optimization.WebForms 1.1.3.
  OK https://api.nuget.org/v3-flatcontainer/microsoft.codedom.providers.dotnetcompilerplatform/1.0.8/microsoft.codedom.providers.dotnetcompilerplatform.1.0.8.nupkg 428ms
Installing Microsoft.CodeDom.Providers.DotNetCompilerPlatform 1.0.8.
Adding package 'Microsoft.AspNet.Web.Optimization.WebForms.1.1.3' to folder 'C:\app\packages'
Added package 'Newtonsoft.Json.6.0.4' to folder 'C:\app\packages'
Added package 'Microsoft.AspNet.Web.Optimization.WebForms.1.1.3' to folder 'C:\app\packages'
Adding package 'Microsoft.CodeDom.Providers.DotNetCompilerPlatform.1.0.8' to folder 'C:\app\packages'
Adding package 'Microsoft.ApplicationInsights.Agent.Intercept.2.0.6' to folder 'C:\app\packages'
Added package 'Microsoft.CodeDom.Providers.DotNetCompilerPlatform.1.0.8' to folder 'C:\app\packages'
  OK https://api.nuget.org/v3-flatcontainer/respond/1.2.0/respond.1.2.0.nupkg 430ms
Installing Respond 1.2.0.
Added package 'Microsoft.ApplicationInsights.Agent.Intercept.2.0.6' to folder 'C:\app\packages'
Adding package 'Respond.1.2.0' to folder 'C:\app\packages'
Added package 'Respond.1.2.0' to folder 'C:\app\packages'
Adding package 'Microsoft.Net.Compilers.2.4.0' to folder 'C:\app\packages'
Added package 'Microsoft.Net.Compilers.2.4.0' to folder 'C:\app\packages'
  OK https://api.nuget.org/v3-flatcontainer/microsoft.applicationinsights.perfcountercollector/2.2.0/microsoft.applicationinsights.perfcountercollector.2.2.0.nupkg 3141ms
Installing Microsoft.ApplicationInsights.PerfCounterCollector 2.2.0.
Adding package 'Microsoft.ApplicationInsights.PerfCounterCollector.2.2.0' to folder 'C:\app\packages'
Added package 'Microsoft.ApplicationInsights.PerfCounterCollector.2.2.0' to folder 'C:\app\packages'

NuGet Config files used:
    C:\Users\ContainerAdministrator\AppData\Roaming\NuGet\NuGet.Config

Feeds used:
    https://api.nuget.org/v3/index.json

Installed:
    25 package(s) to packages.config projects
Removing intermediate container b0f25141a842
 ---> 49d4493eba7f
Step 7/12 : COPY aspnetapp/. ./aspnetapp/
 ---> 3f5d7c6eeec1
Step 8/12 : WORKDIR /app/aspnetapp
 ---> Running in ec94b01d74b6
Removing intermediate container ec94b01d74b6
 ---> 7d3aac4fa371
Step 9/12 : RUN msbuild /p:Configuration=Release
 ---> Running in 09e26abb38cd
Microsoft (R) Build Engine version 15.8.169+g1ccb72aefa for .NET Framework
Copyright (C) Microsoft Corporation. All rights reserved.

Build started 11/13/2018 7:30:27 AM.
Project "C:\app\aspnetapp\aspnetapp.csproj" on node 1 (default targets).
PrepareForBuild:
  Creating directory "bin\".
  Creating directory "obj\Release\".
CoreCompile:
  C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\csc.exe /noconfig /nowarn:1701,1702 /nostdlib+ /errorreport:prompt /warn:4 /define:TRACE /highentropyva+ /reference:C:\app\packages\Antlr.3.4.1.9004\lib\Antlr3.Runtime.dll /reference:C:\app\packages\AspNet.ScriptManager.bootstrap.3.0.0\lib\net45\AspNet.ScriptManager.bootstrap.dll /reference:C:\app\packages\AspNet.ScriptManager.jQuery.1.10.2\lib\net45\AspNet.ScriptManager.jQuery.dll /reference:C:\app\packages\Microsoft.ApplicationInsights.Agent.Intercept.2.0.6\lib\net45\Microsoft.AI.Agent.Intercept.dll /reference:C:\app\packages\Microsoft.ApplicationInsights.DependencyCollector.2.2.0\lib\net45\Microsoft.AI.DependencyCollector.dll /reference:C:\app\packages\Microsoft.ApplicationInsights.PerfCounterCollector.2.2.0\lib\net45\Microsoft.AI.PerfCounterCollector.dll /reference:C:\app\packages\Microsoft.ApplicationInsights.WindowsServer.TelemetryChannel.2.2.0\lib\net45\Microsoft.AI.ServerTelemetryChannel.dll /reference:C:\app\packages\Microsoft.ApplicationInsights.Web.2.2.0\lib\net45\Microsoft.AI.Web.dll /reference:C:\app\packages\Microsoft.ApplicationInsights.WindowsServer.2.2.0\lib\net45\Microsoft.AI.WindowsServer.dll /reference:C:\app\packages\Microsoft.ApplicationInsights.2.2.0\lib\net45\Microsoft.ApplicationInsights.dll /reference:C:\app\packages\Microsoft.AspNet.FriendlyUrls.Core.1.0.2\lib\net45\Microsoft.AspNet.FriendlyUrls.dll /reference:C:\app\packages\Microsoft.AspNet.Web.Optimization.WebForms.1.1.3\lib\net45\Microsoft.AspNet.Web.Optimization.WebForms.dll /reference:C:\app\packages\Microsoft.CodeDom.Providers.DotNetCompilerPlatform.1.0.8\lib\net45\Microsoft.CodeDom.Providers.DotNetCompilerPlatform.dll /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\Microsoft.CSharp.dll" /reference:C:\app\packages\Microsoft.AspNet.ScriptManager.MSAjax.5.0.0\lib\net45\Microsoft.ScriptManager.MSAjax.dll /reference:C:\app\packages\Microsoft.AspNet.ScriptManager.WebForms.5.0.0\lib\net45\Microsoft.ScriptManager.WebForms.dll /reference:C:\app\packages\Microsoft.Web.Infrastructure.1.0.0.0\lib\net40\Microsoft.Web.Infrastructure.dll /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\mscorlib.dll" /reference:C:\app\packages\Newtonsoft.Json.6.0.4\lib\net45\Newtonsoft.Json.dll /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\System.ComponentModel.DataAnnotations.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\System.Configuration.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\System.Core.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\System.Data.DataSetExtensions.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\System.Data.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\System.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\System.Drawing.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\System.EnterpriseServices.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\System.Web.ApplicationServices.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\System.Web.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\System.Web.DynamicData.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\System.Web.Entity.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\System.Web.Extensions.dll" /reference:C:\app\packages\Microsoft.AspNet.Web.Optimization.1.1.3\lib\net40\System.Web.Optimization.dll /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\System.Web.Services.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\System.Xml.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\System.Xml.Linq.dll" /reference:C:\app\packages\WebGrease.1.5.2\lib\WebGrease.dll /debug+ /debug:pdbonly /optimize+ /out:obj\Release\aspnetapp.dll /subsystemversion:6.00 /target:library /utf8output App_Start\BundleConfig.cs About.aspx.cs About.aspx.designer.cs App_Start\RouteConfig.cs Contact.aspx.cs Contact.aspx.designer.cs Default.aspx.cs Default.aspx.designer.cs Global.asax.cs Properties\AssemblyInfo.cs Site.Master.cs Site.Master.designer.cs Site.Mobile.Master.cs Site.Mobile.Master.designer.cs ViewSwitcher.ascx.cs ViewSwitcher.ascx.designer.cs "C:\Users\ContainerAdministrator\AppData\Local\Temp\.NETFramework,Version=v4.7.2.AssemblyAttributes.cs"
_CopyFilesMarkedCopyLocal:
  Copying file from "C:\app\packages\Microsoft.ApplicationInsights.PerfCounterCollector.2.2.0\lib\net45\Microsoft.AI.PerfCounterCollector.dll" to "bin\Microsoft.AI.PerfCounterCollector.dll".
  Copying file from "C:\app\packages\Microsoft.ApplicationInsights.Agent.Intercept.2.0.6\lib\net45\Microsoft.AI.Agent.Intercept.dll" to "bin\Microsoft.AI.Agent.Intercept.dll".
  Copying file from "C:\app\packages\AspNet.ScriptManager.bootstrap.3.0.0\lib\net45\AspNet.ScriptManager.bootstrap.dll" to "bin\AspNet.ScriptManager.bootstrap.dll".
  Copying file from "C:\app\packages\AspNet.ScriptManager.jQuery.1.10.2\lib\net45\AspNet.ScriptManager.jQuery.dll" to "bin\AspNet.ScriptManager.jQuery.dll".
  Copying file from "C:\app\packages\Antlr.3.4.1.9004\lib\Antlr3.Runtime.dll" to "bin\Antlr3.Runtime.dll".
  Copying file from "C:\app\packages\Microsoft.ApplicationInsights.DependencyCollector.2.2.0\lib\net45\Microsoft.AI.DependencyCollector.dll" to "bin\Microsoft.AI.DependencyCollector.dll".
  Copying file from "C:\app\packages\Microsoft.ApplicationInsights.Web.2.2.0\lib\net45\Microsoft.AI.Web.dll" to "bin\Microsoft.AI.Web.dll".
  Copying file from "C:\app\packages\Microsoft.ApplicationInsights.WindowsServer.TelemetryChannel.2.2.0\lib\net45\Microsoft.AI.ServerTelemetryChannel.dll" to "bin\Microsoft.AI.ServerTelemetryChannel.dll".
  Copying file from "C:\app\packages\Microsoft.ApplicationInsights.2.2.0\lib\net45\Microsoft.ApplicationInsights.dll" to "bin\Microsoft.ApplicationInsights.dll".
  Copying file from "C:\app\packages\Microsoft.AspNet.FriendlyUrls.Core.1.0.2\lib\net45\Microsoft.AspNet.FriendlyUrls.dll" to "bin\Microsoft.AspNet.FriendlyUrls.dll".
  Copying file from "C:\app\packages\Microsoft.ApplicationInsights.WindowsServer.2.2.0\lib\net45\Microsoft.AI.WindowsServer.dll" to "bin\Microsoft.AI.WindowsServer.dll".
  Copying file from "C:\app\packages\Microsoft.AspNet.Web.Optimization.WebForms.1.1.3\lib\net45\Microsoft.AspNet.Web.Optimization.WebForms.dll" to "bin\Microsoft.AspNet.Web.Optimization.WebForms.dll".
  Copying file from "C:\app\packages\Microsoft.AspNet.ScriptManager.MSAjax.5.0.0\lib\net45\Microsoft.ScriptManager.MSAjax.dll" to "bin\Microsoft.ScriptManager.MSAjax.dll".
  Copying file from "C:\app\packages\Microsoft.CodeDom.Providers.DotNetCompilerPlatform.1.0.8\lib\net45\Microsoft.CodeDom.Providers.DotNetCompilerPlatform.dll" to "bin\Microsoft.CodeDom.Providers.DotNetCompilerPlatform.dll".
  Copying file from "C:\app\packages\Microsoft.Web.Infrastructure.1.0.0.0\lib\net40\Microsoft.Web.Infrastructure.dll" to "bin\Microsoft.Web.Infrastructure.dll".
  Copying file from "C:\app\packages\Microsoft.AspNet.ScriptManager.WebForms.5.0.0\lib\net45\Microsoft.ScriptManager.WebForms.dll" to "bin\Microsoft.ScriptManager.WebForms.dll".
  Copying file from "C:\app\packages\Newtonsoft.Json.6.0.4\lib\net45\Newtonsoft.Json.dll" to "bin\Newtonsoft.Json.dll".
  Copying file from "C:\app\packages\Microsoft.AspNet.Web.Optimization.1.1.3\lib\net40\System.Web.Optimization.dll" to "bin\System.Web.Optimization.dll".
  Copying file from "C:\app\packages\WebGrease.1.5.2\lib\WebGrease.dll" to "bin\WebGrease.dll".
  Copying file from "C:\app\packages\Microsoft.AspNet.Web.Optimization.1.1.3\lib\net40\System.Web.Optimization.xml" to "bin\System.Web.Optimization.xml".
  Copying file from "C:\app\packages\Microsoft.CodeDom.Providers.DotNetCompilerPlatform.1.0.8\lib\net45\Microsoft.CodeDom.Providers.DotNetCompilerPlatform.xml" to "bin\Microsoft.CodeDom.Providers.DotNetCompilerPlatform.xml".
  Copying file from "C:\app\packages\Antlr.3.4.1.9004\lib\Antlr3.Runtime.pdb" to "bin\Antlr3.Runtime.pdb".
  Copying file from "C:\app\packages\Newtonsoft.Json.6.0.4\lib\net45\Newtonsoft.Json.xml" to "bin\Newtonsoft.Json.xml".
  Copying file from "C:\app\packages\Microsoft.AspNet.FriendlyUrls.Core.1.0.2\lib\net45\Microsoft.AspNet.FriendlyUrls.xml" to "bin\Microsoft.AspNet.FriendlyUrls.xml".
  Copying file from "C:\app\packages\Microsoft.ApplicationInsights.2.2.0\lib\net45\Microsoft.ApplicationInsights.xml" to "bin\Microsoft.ApplicationInsights.xml".
  Copying file from "C:\app\packages\Microsoft.ApplicationInsights.DependencyCollector.2.2.0\lib\net45\Microsoft.AI.DependencyCollector.xml" to "bin\Microsoft.AI.DependencyCollector.xml".
  Copying file from "C:\app\packages\Microsoft.ApplicationInsights.WindowsServer.TelemetryChannel.2.2.0\lib\net45\Microsoft.AI.ServerTelemetryChannel.xml" to "bin\Microsoft.AI.ServerTelemetryChannel.xml".
  Copying file from "C:\app\packages\Microsoft.ApplicationInsights.WindowsServer.2.2.0\lib\net45\Microsoft.AI.WindowsServer.xml" to "bin\Microsoft.AI.WindowsServer.xml".
  Copying file from "C:\app\packages\Microsoft.ApplicationInsights.Web.2.2.0\lib\net45\Microsoft.AI.Web.xml" to "bin\Microsoft.AI.Web.xml".
  Creating "C:\app\aspnetapp\obj\Release\aspnetapp.csproj.CopyComplete" because "AlwaysCreate" was specified.
_CopyOutOfDateSourceItemsToOutputDirectory:
  Copying file from "C:\app\aspnetapp\ApplicationInsights.config" to "bin\ApplicationInsights.config".
_CopyAppConfigFile:
  Copying file from "Web.config" to "bin\aspnetapp.dll.config".
CopyFilesToOutputDirectory:
  Copying file from "obj\Release\aspnetapp.dll" to "bin\aspnetapp.dll".
  aspnetapp -> C:\app\aspnetapp\bin\aspnetapp.dll
  Copying file from "obj\Release\aspnetapp.pdb" to "bin\aspnetapp.pdb".
CopyRoslynCompilerFilesToOutputDirectory:
  Creating directory "C:\app\aspnetapp\bin\roslyn".
  Creating directory "C:\app\aspnetapp\bin\roslyn".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\csc.exe" to "C:\app\aspnetapp\bin\roslyn\csc.exe".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\csc.exe.config" to "C:\app\aspnetapp\bin\roslyn\csc.exe.config".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\csi.exe.config" to "C:\app\aspnetapp\bin\roslyn\csi.exe.config".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\csi.exe" to "C:\app\aspnetapp\bin\roslyn\csi.exe".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\csi.rsp" to "C:\app\aspnetapp\bin\roslyn\csi.rsp".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\csc.rsp" to "C:\app\aspnetapp\bin\roslyn\csc.rsp".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\Microsoft.Build.Tasks.CodeAnalysis.dll" to "C:\app\aspnetapp\bin\roslyn\Microsoft.Build.Tasks.CodeAnalysis.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\Microsoft.CodeAnalysis.CSharp.dll" to "C:\app\aspnetapp\bin\roslyn\Microsoft.CodeAnalysis.CSharp.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\Microsoft.CodeAnalysis.dll" to "C:\app\aspnetapp\bin\roslyn\Microsoft.CodeAnalysis.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\Microsoft.CodeAnalysis.CSharp.Scripting.dll" to "C:\app\aspnetapp\bin\roslyn\Microsoft.CodeAnalysis.CSharp.Scripting.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\Microsoft.CodeAnalysis.Scripting.dll" to "C:\app\aspnetapp\bin\roslyn\Microsoft.CodeAnalysis.Scripting.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\Microsoft.CodeAnalysis.VisualBasic.dll" to "C:\app\aspnetapp\bin\roslyn\Microsoft.CodeAnalysis.VisualBasic.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\Microsoft.CSharp.Core.targets" to "C:\app\aspnetapp\bin\roslyn\Microsoft.CSharp.Core.targets".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\Microsoft.DiaSymReader.Native.amd64.dll" to "C:\app\aspnetapp\bin\roslyn\Microsoft.DiaSymReader.Native.amd64.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\Microsoft.DiaSymReader.Native.x86.dll" to "C:\app\aspnetapp\bin\roslyn\Microsoft.DiaSymReader.Native.x86.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\Microsoft.VisualBasic.Core.targets" to "C:\app\aspnetapp\bin\roslyn\Microsoft.VisualBasic.Core.targets".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\Microsoft.Win32.Primitives.dll" to "C:\app\aspnetapp\bin\roslyn\Microsoft.Win32.Primitives.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.AppContext.dll" to "C:\app\aspnetapp\bin\roslyn\System.AppContext.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Collections.Immutable.dll" to "C:\app\aspnetapp\bin\roslyn\System.Collections.Immutable.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Console.dll" to "C:\app\aspnetapp\bin\roslyn\System.Console.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Diagnostics.FileVersionInfo.dll" to "C:\app\aspnetapp\bin\roslyn\System.Diagnostics.FileVersionInfo.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Diagnostics.Process.dll" to "C:\app\aspnetapp\bin\roslyn\System.Diagnostics.Process.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Diagnostics.StackTrace.dll" to "C:\app\aspnetapp\bin\roslyn\System.Diagnostics.StackTrace.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.IO.Compression.dll" to "C:\app\aspnetapp\bin\roslyn\System.IO.Compression.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.IO.FileSystem.dll" to "C:\app\aspnetapp\bin\roslyn\System.IO.FileSystem.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.IO.FileSystem.DriveInfo.dll" to "C:\app\aspnetapp\bin\roslyn\System.IO.FileSystem.DriveInfo.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.IO.FileSystem.Primitives.dll" to "C:\app\aspnetapp\bin\roslyn\System.IO.FileSystem.Primitives.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.IO.Pipes.dll" to "C:\app\aspnetapp\bin\roslyn\System.IO.Pipes.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Reflection.Metadata.dll" to "C:\app\aspnetapp\bin\roslyn\System.Reflection.Metadata.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Security.AccessControl.dll" to "C:\app\aspnetapp\bin\roslyn\System.Security.AccessControl.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Security.Claims.dll" to "C:\app\aspnetapp\bin\roslyn\System.Security.Claims.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Security.Cryptography.Algorithms.dll" to "C:\app\aspnetapp\bin\roslyn\System.Security.Cryptography.Algorithms.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Security.Cryptography.Encoding.dll" to "C:\app\aspnetapp\bin\roslyn\System.Security.Cryptography.Encoding.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Security.Cryptography.Primitives.dll" to "C:\app\aspnetapp\bin\roslyn\System.Security.Cryptography.Primitives.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Security.Cryptography.X509Certificates.dll" to "C:\app\aspnetapp\bin\roslyn\System.Security.Cryptography.X509Certificates.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Security.Principal.Windows.dll" to "C:\app\aspnetapp\bin\roslyn\System.Security.Principal.Windows.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Text.Encoding.CodePages.dll" to "C:\app\aspnetapp\bin\roslyn\System.Text.Encoding.CodePages.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Threading.Thread.dll" to "C:\app\aspnetapp\bin\roslyn\System.Threading.Thread.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.ValueTuple.dll" to "C:\app\aspnetapp\bin\roslyn\System.ValueTuple.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Xml.ReaderWriter.dll" to "C:\app\aspnetapp\bin\roslyn\System.Xml.ReaderWriter.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Xml.XmlDocument.dll" to "C:\app\aspnetapp\bin\roslyn\System.Xml.XmlDocument.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Xml.XPath.dll" to "C:\app\aspnetapp\bin\roslyn\System.Xml.XPath.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Xml.XPath.XDocument.dll" to "C:\app\aspnetapp\bin\roslyn\System.Xml.XPath.XDocument.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\vbc.exe" to "C:\app\aspnetapp\bin\roslyn\vbc.exe".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\vbc.exe.config" to "C:\app\aspnetapp\bin\roslyn\vbc.exe.config".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\vbc.rsp" to "C:\app\aspnetapp\bin\roslyn\vbc.rsp".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\VBCSCompiler.exe" to "C:\app\aspnetapp\bin\roslyn\VBCSCompiler.exe".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\VBCSCompiler.exe.config" to "C:\app\aspnetapp\bin\roslyn\VBCSCompiler.exe.config".
Done Building Project "C:\app\aspnetapp\aspnetapp.csproj" (default targets).

Build succeeded.
    0 Warning(s)
    0 Error(s)

Time Elapsed 00:00:08.08
Removing intermediate container 09e26abb38cd
 ---> 91c84688d4fc
Step 10/12 : FROM microsoft/aspnet:4.7.2-windowsservercore-ltsc2016 AS runtime
 ---> 7b1f2f42da1d
Step 11/12 : WORKDIR /inetpub/wwwroot
 ---> Running in 841235b4e7fc
Removing intermediate container 841235b4e7fc
 ---> 393b6215832a
Step 12/12 : COPY --from=build /app/aspnetapp/. ./
 ---> 9bc2dd260ec0
Successfully built 9bc2dd260ec0
Successfully tagged aspnetapp:latest
```
Run the container with hostname aspnetapp
```PowerShell
docker run --hostname aspnetapp aspnetapp
```
Open http://aspnetapp --> You should see the app  
Change a file to see the layering mechanism, e.g. aspnetapp/aspnetapp/Default.aspx,line 6:  
Change `<h1>ASP.NET presented at TechDays</h1>` to `<h1>ASP.NET presented at TechDays, run in a container</h1>`  
Run the build again --> all steps until 7 use the cache as nothing changed  
```PowerShell
Windows PowerShell
Copyright (C) 2016 Microsoft Corporation. All rights reserved.

PS C:\Users\AdminTechDays\dockerfiles> docker build --rm -f "aspnetapp\Dockerfile" -t aspnetapp:latest aspnetapp
Sending build context to Docker daemon  1.718MB
Step 1/12 : FROM microsoft/dotnet-framework:4.7.2-sdk-windowsservercore-ltsc2016 AS build
 ---> a4b4c70c517f
Step 2/12 : WORKDIR /app
 ---> Using cache
 ---> c7fd848c7e82
Step 3/12 : COPY *.sln .
 ---> Using cache
 ---> 995c32eb5f3c
Step 4/12 : COPY aspnetapp/*.csproj ./aspnetapp/
 ---> Using cache
 ---> c5b5ad185598
Step 5/12 : COPY aspnetapp/*.config ./aspnetapp/
 ---> Using cache
 ---> 0d18b7aca092
Step 6/12 : RUN nuget restore
 ---> Using cache
 ---> 49d4493eba7f
Step 7/12 : COPY aspnetapp/. ./aspnetapp/
 ---> d9d8f9f0872f
Step 8/12 : WORKDIR /app/aspnetapp
 ---> Running in e286ccb5d54f
Removing intermediate container e286ccb5d54f
 ---> dcf30e9abeb3
Step 9/12 : RUN msbuild /p:Configuration=Release
 ---> Running in 13fd80c94f6a
Microsoft (R) Build Engine version 15.8.169+g1ccb72aefa for .NET Framework
Copyright (C) Microsoft Corporation. All rights reserved.

Build started 11/13/2018 7:53:18 AM.
Project "C:\app\aspnetapp\aspnetapp.csproj" on node 1 (default targets).
PrepareForBuild:
  Creating directory "bin\".
  Creating directory "obj\Release\".
CoreCompile:
  C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\csc.exe /noconfig /nowarn:1701,1702 /nostdlib+ /errorreport:prompt /warn:4 /define:TRACE /highentropyva+ /reference:C:\app\packages\Antlr.3.4.1.9004\lib\Antlr3.Runtime.dll /reference:C:\app\packages\AspNet.ScriptManager.bootstrap.3.0.0\lib\net45\AspNet.ScriptManager.bootstrap.dll /reference:C:\app\packages\AspNet.ScriptManager.jQuery.1.10.2\lib\net45\AspNet.ScriptManager.jQuery.dll /reference:C:\app\packages\Microsoft.ApplicationInsights.Agent.Intercept.2.0.6\lib\net45\Microsoft.AI.Agent.Intercept.dll /reference:C:\app\packages\Microsoft.ApplicationInsights.DependencyCollector.2.2.0\lib\net45\Microsoft.AI.DependencyCollector.dll /reference:C:\app\packages\Microsoft.ApplicationInsights.PerfCounterCollector.2.2.0\lib\net45\Microsoft.AI.PerfCounterCollector.dll /reference:C:\app\packages\Microsoft.ApplicationInsights.WindowsServer.TelemetryChannel.2.2.0\lib\net45\Microsoft.AI.ServerTelemetryChannel.dll /reference:C:\app\packages\Microsoft.ApplicationInsights.Web.2.2.0\lib\net45\Microsoft.AI.Web.dll /reference:C:\app\packages\Microsoft.ApplicationInsights.WindowsServer.2.2.0\lib\net45\Microsoft.AI.WindowsServer.dll /reference:C:\app\packages\Microsoft.ApplicationInsights.2.2.0\lib\net45\Microsoft.ApplicationInsights.dll /reference:C:\app\packages\Microsoft.AspNet.FriendlyUrls.Core.1.0.2\lib\net45\Microsoft.AspNet.FriendlyUrls.dll /reference:C:\app\packages\Microsoft.AspNet.Web.Optimization.WebForms.1.1.3\lib\net45\Microsoft.AspNet.Web.Optimization.WebForms.dll /reference:C:\app\packages\Microsoft.CodeDom.Providers.DotNetCompilerPlatform.1.0.8\lib\net45\Microsoft.CodeDom.Providers.DotNetCompilerPlatform.dll /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\Microsoft.CSharp.dll" /reference:C:\app\packages\Microsoft.AspNet.ScriptManager.MSAjax.5.0.0\lib\net45\Microsoft.ScriptManager.MSAjax.dll /reference:C:\app\packages\Microsoft.AspNet.ScriptManager.WebForms.5.0.0\lib\net45\Microsoft.ScriptManager.WebForms.dll /reference:C:\app\packages\Microsoft.Web.Infrastructure.1.0.0.0\lib\net40\Microsoft.Web.Infrastructure.dll /reference:"C:\Program
Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\mscorlib.dll" /reference:C:\app\packages\Newtonsoft.Json.6.0.4\lib\net45\Newtonsoft.Json.dll /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\System.ComponentModel.DataAnnotations.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\System.Configuration.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\System.Core.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\System.Data.DataSetExtensions.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\System.Data.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\System.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\System.Drawing.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\System.EnterpriseServices.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\System.Web.ApplicationServices.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\System.Web.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\System.Web.DynamicData.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\System.Web.Entity.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\System.Web.Extensions.dll" /reference:C:\app\packages\Microsoft.AspNet.Web.Optimization.1.1.3\lib\net40\System.Web.Optimization.dll /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\System.Web.Services.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\System.Xml.dll" /reference:"C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\System.Xml.Linq.dll" /reference:C:\app\packages\WebGrease.1.5.2\lib\WebGrease.dll /debug+ /debug:pdbonly /optimize+ /out:obj\Release\aspnetapp.dll /subsystemversion:6.00 /target:library /utf8output App_Start\BundleConfig.cs About.aspx.cs About.aspx.designer.cs App_Start\RouteConfig.cs Contact.aspx.cs Contact.aspx.designer.cs Default.aspx.cs Default.aspx.designer.cs Global.asax.cs Properties\AssemblyInfo.cs Site.Master.cs Site.Master.designer.cs Site.Mobile.Master.cs Site.Mobile.Master.designer.cs ViewSwitcher.ascx.cs ViewSwitcher.ascx.designer.cs "C:\Users\ContainerAdministrator\AppData\Local\Temp\.NETFramework,Version=v4.7.2.AssemblyAttributes.cs"
_CopyFilesMarkedCopyLocal:
  Copying file from "C:\app\packages\AspNet.ScriptManager.bootstrap.3.0.0\lib\net45\AspNet.ScriptManager.bootstrap.dll" to "bin\AspNet.ScriptManager.bootstrap.dll".
  Copying file from "C:\app\packages\Microsoft.ApplicationInsights.Agent.Intercept.2.0.6\lib\net45\Microsoft.AI.Agent.Intercept.dll" to "bin\Microsoft.AI.Agent.Intercept.dll".
  Copying file from "C:\app\packages\Microsoft.ApplicationInsights.PerfCounterCollector.2.2.0\lib\net45\Microsoft.AI.PerfCounterCollector.dll" to "bin\Microsoft.AI.PerfCounterCollector.dll".
  Copying file from "C:\app\packages\Microsoft.ApplicationInsights.DependencyCollector.2.2.0\lib\net45\Microsoft.AI.DependencyCollector.dll" to "bin\Microsoft.AI.DependencyCollector.dll".
  Copying file from "C:\app\packages\AspNet.ScriptManager.jQuery.1.10.2\lib\net45\AspNet.ScriptManager.jQuery.dll" to "bin\AspNet.ScriptManager.jQuery.dll".
  Copying file from "C:\app\packages\Antlr.3.4.1.9004\lib\Antlr3.Runtime.dll" to "bin\Antlr3.Runtime.dll".
  Copying file from "C:\app\packages\Microsoft.ApplicationInsights.2.2.0\lib\net45\Microsoft.ApplicationInsights.dll" to "bin\Microsoft.ApplicationInsights.dll".
  Copying file from "C:\app\packages\Microsoft.AspNet.FriendlyUrls.Core.1.0.2\lib\net45\Microsoft.AspNet.FriendlyUrls.dll" to "bin\Microsoft.AspNet.FriendlyUrls.dll".
  Copying file from "C:\app\packages\Microsoft.ApplicationInsights.WindowsServer.TelemetryChannel.2.2.0\lib\net45\Microsoft.AI.ServerTelemetryChannel.dll" to "bin\Microsoft.AI.ServerTelemetryChannel.dll".
  Copying file from "C:\app\packages\Microsoft.ApplicationInsights.WindowsServer.2.2.0\lib\net45\Microsoft.AI.WindowsServer.dll" to "bin\Microsoft.AI.WindowsServer.dll".
  Copying file from "C:\app\packages\Microsoft.ApplicationInsights.Web.2.2.0\lib\net45\Microsoft.AI.Web.dll" to "bin\Microsoft.AI.Web.dll".
  Copying file from "C:\app\packages\Microsoft.AspNet.Web.Optimization.WebForms.1.1.3\lib\net45\Microsoft.AspNet.Web.Optimization.WebForms.dll" to "bin\Microsoft.AspNet.Web.Optimization.WebForms.dll".
  Copying file from "C:\app\packages\Microsoft.CodeDom.Providers.DotNetCompilerPlatform.1.0.8\lib\net45\Microsoft.CodeDom.Providers.DotNetCompilerPlatform.dll" to "bin\Microsoft.CodeDom.Providers.DotNetCompilerPlatform.dll".
  Copying file from "C:\app\packages\Microsoft.AspNet.ScriptManager.MSAjax.5.0.0\lib\net45\Microsoft.ScriptManager.MSAjax.dll" to "bin\Microsoft.ScriptManager.MSAjax.dll".
  Copying file from "C:\app\packages\Microsoft.AspNet.ScriptManager.WebForms.5.0.0\lib\net45\Microsoft.ScriptManager.WebForms.dll" to "bin\Microsoft.ScriptManager.WebForms.dll".
  Copying file from "C:\app\packages\Microsoft.Web.Infrastructure.1.0.0.0\lib\net40\Microsoft.Web.Infrastructure.dll" to "bin\Microsoft.Web.Infrastructure.dll".
  Copying file from "C:\app\packages\Newtonsoft.Json.6.0.4\lib\net45\Newtonsoft.Json.dll" to "bin\Newtonsoft.Json.dll".
  Copying file from "C:\app\packages\Microsoft.AspNet.Web.Optimization.1.1.3\lib\net40\System.Web.Optimization.dll" to "bin\System.Web.Optimization.dll".
  Copying file from "C:\app\packages\WebGrease.1.5.2\lib\WebGrease.dll" to "bin\WebGrease.dll".
  Copying file from "C:\app\packages\Microsoft.CodeDom.Providers.DotNetCompilerPlatform.1.0.8\lib\net45\Microsoft.CodeDom.Providers.DotNetCompilerPlatform.xml" to "bin\Microsoft.CodeDom.Providers.DotNetCompilerPlatform.xml".
  Copying file from "C:\app\packages\Microsoft.AspNet.Web.Optimization.1.1.3\lib\net40\System.Web.Optimization.xml" to "bin\System.Web.Optimization.xml".
  Copying file from "C:\app\packages\Antlr.3.4.1.9004\lib\Antlr3.Runtime.pdb" to "bin\Antlr3.Runtime.pdb".
  Copying file from "C:\app\packages\Microsoft.AspNet.FriendlyUrls.Core.1.0.2\lib\net45\Microsoft.AspNet.FriendlyUrls.xml" to "bin\Microsoft.AspNet.FriendlyUrls.xml".
  Copying file from "C:\app\packages\Newtonsoft.Json.6.0.4\lib\net45\Newtonsoft.Json.xml" to "bin\Newtonsoft.Json.xml".
  Copying file from "C:\app\packages\Microsoft.ApplicationInsights.2.2.0\lib\net45\Microsoft.ApplicationInsights.xml" to "bin\Microsoft.ApplicationInsights.xml".
  Copying file from "C:\app\packages\Microsoft.ApplicationInsights.WindowsServer.2.2.0\lib\net45\Microsoft.AI.WindowsServer.xml" to "bin\Microsoft.AI.WindowsServer.xml".
  Copying file from "C:\app\packages\Microsoft.ApplicationInsights.WindowsServer.TelemetryChannel.2.2.0\lib\net45\Microsoft.AI.ServerTelemetryChannel.xml" to "bin\Microsoft.AI.ServerTelemetryChannel.xml".
  Copying file from "C:\app\packages\Microsoft.ApplicationInsights.DependencyCollector.2.2.0\lib\net45\Microsoft.AI.DependencyCollector.xml" to "bin\Microsoft.AI.DependencyCollector.xml".
  Copying file from "C:\app\packages\Microsoft.ApplicationInsights.Web.2.2.0\lib\net45\Microsoft.AI.Web.xml" to "bin\Microsoft.AI.Web.xml".
  Creating "C:\app\aspnetapp\obj\Release\aspnetapp.csproj.CopyComplete" because "AlwaysCreate" was specified.
_CopyOutOfDateSourceItemsToOutputDirectory:
  Copying file from "C:\app\aspnetapp\ApplicationInsights.config" to "bin\ApplicationInsights.config".
_CopyAppConfigFile:
  Copying file from "Web.config" to "bin\aspnetapp.dll.config".
CopyFilesToOutputDirectory:
  Copying file from "obj\Release\aspnetapp.dll" to "bin\aspnetapp.dll".
  aspnetapp -> C:\app\aspnetapp\bin\aspnetapp.dll
  Copying file from "obj\Release\aspnetapp.pdb" to "bin\aspnetapp.pdb".
CopyRoslynCompilerFilesToOutputDirectory:
  Creating directory "C:\app\aspnetapp\bin\roslyn".
  Creating directory "C:\app\aspnetapp\bin\roslyn".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\csc.exe.config" to "C:\app\aspnetapp\bin\roslyn\csc.exe.config".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\csi.rsp" to "C:\app\aspnetapp\bin\roslyn\csi.rsp".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\csi.exe" to "C:\app\aspnetapp\bin\roslyn\csi.exe".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\csc.rsp" to "C:\app\aspnetapp\bin\roslyn\csc.rsp".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\csc.exe" to "C:\app\aspnetapp\bin\roslyn\csc.exe".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\csi.exe.config" to "C:\app\aspnetapp\bin\roslyn\csi.exe.config".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\Microsoft.Build.Tasks.CodeAnalysis.dll" to "C:\app\aspnetapp\bin\roslyn\Microsoft.Build.Tasks.CodeAnalysis.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\Microsoft.CodeAnalysis.CSharp.dll" to "C:\app\aspnetapp\bin\roslyn\Microsoft.CodeAnalysis.CSharp.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\Microsoft.CodeAnalysis.CSharp.Scripting.dll" to "C:\app\aspnetapp\bin\roslyn\Microsoft.CodeAnalysis.CSharp.Scripting.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\Microsoft.CodeAnalysis.dll" to "C:\app\aspnetapp\bin\roslyn\Microsoft.CodeAnalysis.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\Microsoft.CSharp.Core.targets" to "C:\app\aspnetapp\bin\roslyn\Microsoft.CSharp.Core.targets".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\Microsoft.CodeAnalysis.Scripting.dll" to "C:\app\aspnetapp\bin\roslyn\Microsoft.CodeAnalysis.Scripting.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\Microsoft.CodeAnalysis.VisualBasic.dll" to "C:\app\aspnetapp\bin\roslyn\Microsoft.CodeAnalysis.VisualBasic.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\Microsoft.DiaSymReader.Native.amd64.dll" to "C:\app\aspnetapp\bin\roslyn\Microsoft.DiaSymReader.Native.amd64.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\Microsoft.DiaSymReader.Native.x86.dll" to "C:\app\aspnetapp\bin\roslyn\Microsoft.DiaSymReader.Native.x86.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\Microsoft.VisualBasic.Core.targets" to "C:\app\aspnetapp\bin\roslyn\Microsoft.VisualBasic.Core.targets".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Collections.Immutable.dll" to "C:\app\aspnetapp\bin\roslyn\System.Collections.Immutable.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.AppContext.dll" to "C:\app\aspnetapp\bin\roslyn\System.AppContext.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\Microsoft.Win32.Primitives.dll" to "C:\app\aspnetapp\bin\roslyn\Microsoft.Win32.Primitives.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Console.dll" to "C:\app\aspnetapp\bin\roslyn\System.Console.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Diagnostics.FileVersionInfo.dll" to "C:\app\aspnetapp\bin\roslyn\System.Diagnostics.FileVersionInfo.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.IO.FileSystem.dll" to "C:\app\aspnetapp\bin\roslyn\System.IO.FileSystem.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.IO.FileSystem.Primitives.dll" to "C:\app\aspnetapp\bin\roslyn\System.IO.FileSystem.Primitives.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Diagnostics.Process.dll" to "C:\app\aspnetapp\bin\roslyn\System.Diagnostics.Process.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.IO.FileSystem.DriveInfo.dll" to "C:\app\aspnetapp\bin\roslyn\System.IO.FileSystem.DriveInfo.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.IO.Compression.dll" to "C:\app\aspnetapp\bin\roslyn\System.IO.Compression.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Diagnostics.StackTrace.dll" to "C:\app\aspnetapp\bin\roslyn\System.Diagnostics.StackTrace.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Reflection.Metadata.dll" to "C:\app\aspnetapp\bin\roslyn\System.Reflection.Metadata.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.IO.Pipes.dll" to "C:\app\aspnetapp\bin\roslyn\System.IO.Pipes.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Security.Cryptography.Primitives.dll" to "C:\app\aspnetapp\bin\roslyn\System.Security.Cryptography.Primitives.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Security.AccessControl.dll" to "C:\app\aspnetapp\bin\roslyn\System.Security.AccessControl.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Security.Claims.dll" to "C:\app\aspnetapp\bin\roslyn\System.Security.Claims.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Security.Cryptography.Encoding.dll" to "C:\app\aspnetapp\bin\roslyn\System.Security.Cryptography.Encoding.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Security.Cryptography.X509Certificates.dll" to "C:\app\aspnetapp\bin\roslyn\System.Security.Cryptography.X509Certificates.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Security.Cryptography.Algorithms.dll" to "C:\app\aspnetapp\bin\roslyn\System.Security.Cryptography.Algorithms.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Security.Principal.Windows.dll" to "C:\app\aspnetapp\bin\roslyn\System.Security.Principal.Windows.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.ValueTuple.dll" to "C:\app\aspnetapp\bin\roslyn\System.ValueTuple.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Text.Encoding.CodePages.dll" to "C:\app\aspnetapp\bin\roslyn\System.Text.Encoding.CodePages.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Threading.Thread.dll" to "C:\app\aspnetapp\bin\roslyn\System.Threading.Thread.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Xml.ReaderWriter.dll" to "C:\app\aspnetapp\bin\roslyn\System.Xml.ReaderWriter.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Xml.XmlDocument.dll" to "C:\app\aspnetapp\bin\roslyn\System.Xml.XmlDocument.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Xml.XPath.dll" to "C:\app\aspnetapp\bin\roslyn\System.Xml.XPath.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\System.Xml.XPath.XDocument.dll" to "C:\app\aspnetapp\bin\roslyn\System.Xml.XPath.XDocument.dll".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\vbc.exe" to "C:\app\aspnetapp\bin\roslyn\vbc.exe".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\vbc.rsp" to "C:\app\aspnetapp\bin\roslyn\vbc.rsp".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\vbc.exe.config" to "C:\app\aspnetapp\bin\roslyn\vbc.exe.config".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\VBCSCompiler.exe" to "C:\app\aspnetapp\bin\roslyn\VBCSCompiler.exe".
  Copying file from "C:\app\packages\Microsoft.Net.Compilers.2.4.0\build\..\tools\VBCSCompiler.exe.config" to "C:\app\aspnetapp\bin\roslyn\VBCSCompiler.exe.config".
Done Building Project "C:\app\aspnetapp\aspnetapp.csproj" (default targets).

Build succeeded.
    0 Warning(s)
    0 Error(s)

Time Elapsed 00:00:07.74
Removing intermediate container 13fd80c94f6a
 ---> a550ac503e71
Step 10/12 : FROM microsoft/aspnet:4.7.2-windowsservercore-ltsc2016 AS runtime
 ---> 7b1f2f42da1d
Step 11/12 : WORKDIR /inetpub/wwwroot
 ---> Using cache
 ---> 5eee9ba0a18c
Step 12/12 : COPY --from=build /app/aspnetapp/. ./
 ---> 477657f8a6f7
Successfully built 477657f8a6f7
Successfully tagged aspnetapp:latest
```
Run it to see your change
```PowerShell
PS C:\Users\AdminTechDays\dockerfiles> docker run --hostname aspnetnew aspnetapp:latest
```
Open http://aspnetnew --> you should see your new headline  