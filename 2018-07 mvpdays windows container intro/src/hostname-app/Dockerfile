FROM microsoft/aspnet:4.7.2-windowsservercore-ltsc2016
COPY default.aspx C:/inetpub/wwwroot

# workaround for bug
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
RUN Add-LocalGroupMember -Group 'Administrators' -Member 'IIS AppPool\DefaultAppPool';