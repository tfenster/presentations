---
theme : "white"
customTheme: "theme/infoma"
transition: "none"
backgroundTransition: "none"
highlightTheme: "darkula"
height: "100%"
width: "100%"
slideNumber: "false"
center: "false"
---
<!-- .element: class="initialslide" -->

#### D365 Business Central<br />Container und APIs<br />AI meets BizApps
##### Tobias Fenster<br />München, 13.10.2018

---

## Vorstellung und Agenda

*Tobias Fenster*<br />
Technischer Leiter bei Axians Infoma<br />
Microsoft MVP für Business Applications<br />
[@tobiasfenster](https://twitter.com/tobiasfenster) und https://navblog.axians-infoma.de<br />
&nbsp;<br />&nbsp;<br />
*Agenda*
- Überblick: D365 Business Central *custom App Typen und Betrieb im Container*
- Hands on 1: *Azure Container Instance* mit D365 BC
- Hands on 2: *API Client* gegen BC verbinden (Connect App)
- Hands on 3: Container *konfigurieren und Verhalten anpassen*
- Hands on 4: Business Central *Challenges*

---

### Überblick: D365 Business Central<br />Custom App Typen

- Microsoft unterscheidet drei Arten von Apps:
- *Connect App*: Verbunden über *Schnittstelle / API*, App selbst aber außerhalb BC
  - Anbindung über *OData / REST oder SOAP* mit Azure AD (produktiv) oder Basic Auth / WebService Key (Entwicklung)
  - Entwicklung in *beliebiger Programmiersprache*
- *Add-on App*: Erweitert BC um *eigene Datenstrukturen und Logik*, interagiert mit der bereits vorhandenen Business Logik über Events
  - Umsetzung über sog. *Extensions*
  - Entwicklung in *AL mit Visual Studio Code*
- *Embed App*: *Tief integrierte Änderungen und Anpassungen* an Strukturen und Logik
  - Umsetzung ebenfalls über *Extensions*, teilweise aktuell noch *direkte Codeänderungen* notwendig
  - Entwicklung bis 2020 noch teilweise in *C/AL mit C/SIDE*, ansonsten auch *AL mit VS Code*

---

### Einschub<br />Was sind Docker Container und was bringen sie?

- **Docker**: Führende *cross-platform* Umgebung für *Software Container* (einzige Option unter Windows)
- Was sind Docker *Container, Image und Host*?
  - Ein *Image* ist ein *Template* mit minal notwendigem Betriebssystem, Bibliotheken und Anwendungslibraries und wird über ein Dockerfile definiert
  - Ein *Container* ist die *Instanz eines Image* mit einer nicht veränderbaren Basis aus dem Image und darauf allen Änderungen
  - Ein Container ist *keine VM*, insbesondere hat er *keine GUI* und kann *nicht per RDP* verbunden werden
  - Ein Docker *Host* ist die physische oder virtuelle Maschine, auf der *Container laufen*
- Wesentliche Vorteile:
  - *Einfacher* Weg, um Deployments / Konfigurationen *sehr stabil und sicher reproduzierbar* darzustellen (kein "works here", vermeidet Gap Dev vs. Ops)
  - *Bessere Ressourcennutzung* als mit klassischen VMs, insbes. da es kein Guest OS gibt, sondern der Kernel des Host *direkt verwendet* wird
  - Großes Ökosystem vorhandener Images

---

### Überblick: D365 Business Central<br />Betrieb im Container

- Microsoft bietet Container Images für *NAV ab 2015* und für *Business Central als Sandbox für die Cloud-Variante sowie direkt für On-Prem*
- Aktuell nur für *Entwicklung und Test*, nicht für Produktion freigegeben
- Betrieb auf *eigenem Docker Host*:
  - Unter *Windows 10* funktioniert *Docker Community Edition*: Neuer, aber instabiler
  - Unter *Windows Server 2016/19* funktioniert *Docker Enterprise Edition* (kostenlos in Windows Server enthalten): Etwas älter, aber deutlich stabiler
  - Wenn der eigene Laptop der Docker Host ist: Evtl. Betrieb einer Windows-Server-VM mit Docker
- Betrieb auf *Azure*:
  - Diverse Variante, u.a. *Azure Container Instances* als sehr schneller, einfacher Weg

---

## Agenda

- Überblick: D365 Business Central *custom App Typen und Betrieb im Container*
- **Hands on 1: Azure Container Instance mit D365 BC**
- Hands on 2: *API Client* gegen BC verbinden (Connect App)
- Hands on 3: Container *konfigurieren und Verhalten anpassen*
- Hands on 4: Business Central *Challenges*

---

### Hands on 1<br />Azure Container Instance mit D365 BC

<div class="container">
  <div class="col">
    <img src="img/container-morph2.gif" class="maxheight">
  </div>
</div>

---

### Hands on 1<br />Azure Container Instance mit D365 BC

- Im *Azure Portal*: Neue *Container Instance*
- Schritt 1 *Basics* ausfüllen und als *Image microsoft/bcsandbox:de* verwenden
- Schritt 2 *Configuration*:
  - OS Type: Windows / Number of cores: 2 / Memory (GB): 7
  - DNS name: eindeutiger Wert / Port: 443 / Open additional ports: Yes / Port: 7049 / Port: 8080
  - Environment variable: "accept_eula":"Y"
  - Rest Default
- Schritt 3 *bestätigen* und warten...
- Im Azure Portal über *Container Instance &rarr; Containers &rarr; Events* warten bis "Pulling" beendet ist (5-10 Minute) und Container Status "Running" bekommt. Zwischenzeitliche Failures beim Pulling sind unbedenklich, wird automatisch erneut versucht
- Unter *Overview* den *FQDN* suchen und mit `http://<fqdn>:8080` auf Dateien bzw. `https://<fqdn>/nav` auf BC zugreifen

---

### Hands on 1<br />Azure Container Instance mit D365 BC

- Schnellere (und flexiblere) Alternative: *Azure Quickstart Template* für NAV / BC unter https://ve.link/bc_aci &rarr; In Azure bereitstellen
- Resource group auswählen
- Dns Prefix (muss *eindeutig* sein) und Lets Encrypt Mail angeben (keine Registrierung notwendig) &rarr; *Valides SSL-Zertifikat*
- Nav Release auf microsoft/bcsandbox:de ändern
- Username und Password vergeben, Cpu Cores auf 4, Memory in Gb auf 8, Accept Eula auf Y
- Ebenfalls bestätigen und per Azure Portal Fortschritt verfolgen
- Hat neben Port 443, 8080 und 7049 auch *7048* (OData Service) offen

---

### Hands on 1<br />Azure Container Instance mit D365 BC

- Per *Azure CLI* z.B. in der [Cloud Shell](https://shell.azure.com) automatisierbar

```Shell
az group deployment create --name mydeployment --resource-group test \
  --template-uri https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-aci-dynamicsnav/azuredeploy.json \
  --parameters dnsPrefix=tst123tfe letsEncryptMail=tobias.fenster@axians-infoma.de \
    navRelease=microsoft/bcsandbox:de username=admin password=Passw0rd* \
    cpuCores=4 memoryInGb=8 acceptEula=Y
```
<br />
- Unbedingt **dnsPrefix und eMail-Adresse anpassen...**
<br />
- Code und Präsentation unter https://ve.link/AIMeetsBizAppsHandson

---

## Agenda

- Überblick: D365 Business Central *custom App Typen und Betrieb im Container*
- Hands on 1: *Azure Container Instance* mit D365 BC
- **Hands on 2: API Client gegen BC verbinden (Connect App)**
- Hands on 3: Container *konfigurieren und Verhalten anpassen*
- Hands on 4: Business Central *Challenges*

---

### Hands on 2<br />API Client gegen BC verbinden (Connect App)

- *Dokumentation zur API* unter https://docs.microsoft.com/en-us/dynamics-nav/fin-graph/
- Über einfache REST Requests *Daten erzeugen, lesen, ändern und löschen*
- Komplexe Aktivitäten über *Bound Actions* aufrufen (z.B. ein Buch.-Blatt buchen)
<br />&nbsp;<br />
- Einfacher Weg zur *Generierung* von Beispiel-REST-Aufrufen:
  - *Visual Studio Code* öffnen (ggf. vorher von https://code.visualstudio.com/download herunterladen)
  - Extension *ALRunner* suchen und installieren
  - Ctrl+Shift+P &rarr; ALRunner: *Generate an API Client for Business Central*, dann URL `https://<fqdn>/nav`, Benutzername und Passwort eingeben
- Wer *nicht* den Weg über das *Template* zum Erstellen des Containers gegangen ist oder es nicht geklappt hat: Ctrl+Shift+P &rarr; *ALRunner: Go API on Azure!*
  - Erstellt eine Azure Container Instance anhand des *Template* und *generiert die Beispiel-REST-Aufrufe*

---

## Agenda

- Überblick: D365 Business Central *custom App Typen und Betrieb im Container*
- Hands on 1: *Azure Container Instance* mit D365 BC
- Hands on 2: *API Client* gegen BC verbinden (Connect App)
- **Hands on 3: Container konfigurieren und Verhalten anpassen**
- Hands on 4: Business Central *Challenges*

---

### Hands on 3<br />Container konfigurieren und Verhalten anpassen

- Im Azure Portal über *Container Instance &rarr; Containers &rarr; Connect* eine Verbindung starten
- Als *Start Up Command* das Eingabefeld auswählen und `powershell` eingeben
- `c:\run\prompt.ps1` ausführen (importiert die BC Cmdlets)

```Shell
Windows PowerShell
Copyright (C) 2016 Microsoft Corporation. All rights reserved.

PS C:\> C:\Run\Prompt.ps1
Welcome to the NAV Container PowerShell prompt
```

- z.B. Get-NAVServerConfiguration NAV ausführen, um *aktuelle Konfig* anzuzeigen

---

### Hands on 3<br />Container konfigurieren und Verhalten anpassen

- NAV Server Instanz im Container *konfigurieren*: OData Services *deaktivieren*

```Shell
PS C:\Run> Set-NAVServerConfiguration -KeyName ODataServicesEnabled -KeyValue false NAV
WARNING: The new settings value will not take effect util you stop and restart the service.
PS C:\Run> Restart-NAVServerInstance NAV

ServerInstance : MicrosoftDynamicsNavServer$NAV
DisplayName    : Microsoft Dynamics NAV Server [NAV]
State          : Running
ServiceAccount : NT AUTHORITY\SYSTEM
Version        : 13.0.24623.24800
Default        : True
```

- OData Services *aktivieren* funktioniert identisch, nur `-KeyValue true` und anschließend ebenfalls *Restart*

---

### Hands on 3<br />Container konfigurieren und Verhalten anpassen

- Konfigurationseinstellungen beim *Start mitgeben* über sog. Docker environment variables wie z.B. `customNavSettings=ODataServicesEnabled=false`
- Alle Basis-Scripts im Container (https://github.com/microsoft/nav-docker) über *gleichnamige Dateien* in c:\run\my überschreibbar
  - Beim Start können .zip Dateien *heruntergeladen und in den Ordner kopiert* werden, z.B. `folders=c:\run\my=https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-aci-dynamicsnav/scripts/SetupCertificate.zip`
- Genauso z.B. eigene DLL Libraries oder andere notwendige Dateien beim Start in Container bringen: `folders:c:\temp=https://www.axians-infoma.de/logo.gif`
- Wird im Quickstart Templat verwendet, um obenstehendes Script für LetsEncrypt-Zertifikate einzubinden und API Services zu aktivieren

---

## Agenda

- Überblick: D365 Business Central *custom App Typen und Betrieb im Container*
- Hands on 1: *Azure Container Instance* mit D365 BC
- Hands on 2: *API Client* gegen BC verbinden (Connect App)
- Hands on 3: Container *konfigurieren und Verhalten anpassen*
- **Hands on 4: Business Central Challenges**

---

### Hands on 4<br />Business Central Challenges

- https://blogs.msdn.microsoft.com/hackathonchallenges/
- Nicht von mir, erstellt von Freddy Kristiansen
- Voraussetzung: *AL extension* aus dem Container herunterladen (`http://<fqdn>:8080`) und in Visual Studio Code installieren
- Selbst versuchen, aber wer nicht weiter kommt: Ganz unten *Cheat Sheets* und unter dem Namen sind die Passwörter in "weißer Schrift auf weißem Grund"

---

<!-- .element: class="finalslide" -->

#### Welche Fragen darf ich beantworten?

##### Kontaktdaten:<br />tobias.fenster@axians-infoma.de<br />+49 731 1551-964
