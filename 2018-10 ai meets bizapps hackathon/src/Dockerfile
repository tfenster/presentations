FROM microsoft/bcsandbox:de
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
RUN mkdir c:/run/my
COPY AdditionalSetup.ps1 c:/run/my