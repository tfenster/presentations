FROM microsoft/aspnet
COPY default.aspx C:/inetpub/wwwroot

# workaround for bug
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
RUN Add-LocalGroupMember -Group 'Administrators' -Member 'IIS AppPool\DefaultAppPool';