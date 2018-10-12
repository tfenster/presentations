---
theme : "white"
customTheme: "theme/infoma"
transition: "none"
backgroundTransition: "none"
highlightTheme: "darkula"
height: "100%"
width: "100%"
showSlideNumber: "speaker"
center: "false"
---
<!-- .element: class="initialslide" -->

#### REAL LIFE SCENARIOS<br />AND BEST PRACTICES<br />FOR BC ON DOCKER
##### Tobias Fenster<br />Directions EMEA<br />The Hague, 31.10.2018

---

## Introduction and Agenda

*Tobias Fenster*<br />
CTO at Axians Infoma<br />
Microsoft MVP for Business Applications<br />
[@tobiasfenster](https://twitter.com/tobiasfenster) and https://navblog.axians-infoma.com<br />
&nbsp;<br />&nbsp;<br />
*Agenda*
- Self-service container environments
- Multi-container environments
- Automated extension 2.0 builds with multi-stage containers
- Using Azure Container Instances

---

## Self-service container environments

- Why? No Win 10 containers, not everyone has the technical knowledge, PMs / Devs don't need it &rarr; Provision containers on a server through a self-service interface
- Explain base structure with a graphical overview: BC frontend, dotnet Core API, Docker API; gMSAs
- Demo: create the container
- Explain details about all components

---

## Multi-container environments

- Why? Multiple very similar containers or more complex scenarios
- Explain release tests with 10 databases and all need a container
- Explain compose and show PS script to generate compose yaml
- Explain tools host with a couple of different containers
- Explain setup with an external database, two BC containers and a reverse proxy

---

## Automated extension 2.0 builds with multi-stage containers

- see https://www.axians-infoma.de/navblog/dynamics-365-bc-extension-build-in-tfs-vsts-using-containers/

---

## Using Azure Container Instances

- go through the GUI wizard
- show the az cli command that does the same
- show quickstart template
- show script to set up 100 BC containers for a workshop
- mention ALRunner

---

<!-- .element: class="finalslide" -->

#### Any questions I can try to answer?

##### [@tobiasfenster](https://twitter.com/tobiasfenster)<br />https://navblog.axians-infoma.de<br />[tobias.fenster@axians-infoma.de](mailto:tobias.fenster@axians-infoma.de)
