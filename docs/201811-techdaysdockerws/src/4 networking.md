## 4 Networking with Docker containers
### Scenario 1: No additional setup --> host-only networking
Run an IIS container without additional config
```PowerShell
PS C:\Users\AdminTechDays> docker run --rm --name iis microsoft/iis:nanoserver-sac2016
Unable to find image 'microsoft/iis:nanoserver-sac2016' locally
nanoserver-sac2016: Pulling from microsoft/iis
bce2fbc256ea: Already exists
6f2071dcd729: Already exists
21e67e484b23: Pull complete
6f53d1ee4ceb: Pull complete
3ffc7c4aceea: Pull complete
Digest: sha256:6b4a528cb12730647f5b6904bf48b04b462d9c32719a3585a508a9432dbee3d1
Status: Downloaded newer image for microsoft/iis:nanoserver-sac2016
```
Use the second powershell to get the IP address
```PowerShell
PS C:\Users\AdminTechDays> docker exec iis ipconfig

Windows IP Configuration

Ethernet adapter vEthernet (Container NIC 0df28342):

   Connection-specific DNS Suffix  . : dmfn1rjxqpnubaf5pkj5g4xped.ax.internal.cloudapp.net
   Link-local IPv6 Address . . . . . : fe80::b582:9a2b:7a96:b0cc%24
   IPv4 Address. . . . . . . . . . . : 172.29.91.46
   Subnet Mask . . . . . . . . . . . : 255.255.240.0
   Default Gateway . . . . . . . . . : 172.29.80.1
```
Disable IE enhanced security through the Server admin console  
Open http://&lt;ip&gt; in IE, in my case http://172.29.91.46 --> you should see the standard IE page  
Add a firewall a rule to allow external traffic to reach port 80  
```PowerShell
netsh advfirewall firewall add rule name="Open Port 80" dir=in action=allow protocol=TCP localport=80
```
Get the IP address of the host
```PowerShell
PS C:\Users\AdminTechDays> ipconfig

Windows IP Configuration

Ethernet adapter Ethernet 2:

   Connection-specific DNS Suffix  . : dmfn1rjxqpnubaf5pkj5g4xped.ax.internal.cloudapp.net
   Link-local IPv6 Address . . . . . : fe80::b97a:c726:ae7e:4c4e%4
   IPv4 Address. . . . . . . . . . . : 10.1.1.5
   Subnet Mask . . . . . . . . . . . : 255.255.255.0
   Default Gateway . . . . . . . . . : 10.1.1.1
```
Open RDP to the second, smaller machine (I'll call it "client" as differentiation from the other machine called "host")  
Disable IE enhanced security through the Server admin console or by running `Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value 00000000`   
Open http://&lt;host-ip&gt; in IE, in my case http://10.1.1.5 --> you should see a connection error 
### Scenario 2: Port mapping
Switch back to the host, stop the IIS container and start it again with port 80 mapped to the host
```PowerShell
PS C:\Users\AdminTechDays> docker stop iis
iis
PS C:\Users\AdminTechDays> docker run --rm --name iis -p 80:80 microsoft/iis:nanoserver-sac2016
```
Switch back to the client and reload the IE page to http://&lt;host-ip&gt; --> you should now see the standard IE page
### Scenario 3: Transparent network
Switch back to the host, stop the iis container, create a transparent network (this will probably cause a quick network disconnect) and start the IIS container again using that network 
```PowerShell
PS C:\Users\AdminTechDays> docker stop iis
iis
PS C:\Users\AdminTechDays> docker network create -d transparent --subnet=10.1.1.0/24 --gateway=10.1.1.1 transp
93a0da02aa4673e9b513a814a036819369a0e059902d61a5a55db8a6479b2ede
PS C:\Users\AdminTechDays> docker run --rm --name iis --network transp microsoft/iis:nanoserver-sac2016
```
Please note that the transparent network setup very likely will be different outside of Azure and depends on you networking architecture. There is a good chance that `docker network create -d transparent transp` will just work  
Use the second PowerShell to check the IP address the container now uses
```PowerShell
PS C:\Users\AdminTechDays> docker exec iis ipconfig

Windows IP Configuration

Ethernet adapter vEthernet (Container NIC 80a552c2):

   Connection-specific DNS Suffix  . :
   Link-local IPv6 Address . . . . . : fe80::2d30:1f72:ceaa:d9ed%24
   IPv4 Address. . . . . . . . . . . : 10.1.1.31
   Subnet Mask . . . . . . . . . . . : 255.255.255.0
   Default Gateway . . . . . . . . . : 10.1.1.1
```
Use IE on the host to connect to http://&lt;client-ip&gt;, in my case http://10.1.1.31. Unfortunately connecting from the client doesn't work in Azure because MAC address spoofing is disabled ([see here](https://docs.microsoft.com/en-us/virtualization/windowscontainers/container-networking/network-drivers-topologies)) but this can probably be configured on your local datacenter