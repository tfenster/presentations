# This dockerfile utilizes components licensed by their respective owners/authors.
# Prior to utilizing this file or resulting images please review the respective licenses at: http://www.apache.org/licenses/

FROM microsoft/windowsservercore:ltsc2016

LABEL Description="Apache" Vendor="Apache Software Foundation" Version="2.4.23"

COPY httpd-2.4.33-win64-VC15.zip /
COPY vc_redist.x64.exe /

RUN powershell -Command \
	$ErrorActionPreference = 'Stop'; \
	Expand-Archive -Path c:\httpd-2.4.33-win64-VC15.zip -DestinationPath c:\ ; \
	Remove-Item c:\httpd-2.4.33-win64-VC15.zip -Force

RUN powershell -Command \
	$ErrorActionPreference = 'Stop'; \
	start-Process c:\vc_redist.x64.exe -ArgumentList '/quiet' -Wait ; \
	Remove-Item c:\vc_redist.x64.exe -Force

CMD /Apache24/bin/httpd.exe -w