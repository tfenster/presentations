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

<!-- .element: class="initialslide_directions" -->

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
- Quick intro to Docker and the overall scenario
- Self-service container environments
- Multi-container environments
- Automated extension 2.0 builds with multi-stage containers
- Using Azure Container Instances

---

### Introduction to Docker<br />If you are not sure yet what this is

- What is **Docker**? Leading cross platform *software container* environment
- What is a *Docker container* and a *Docker image*?
  - An image is a template with the *minimum amount of os, libraries and application binaries* needed
  - A container is an *instance of an image* with an immutable base and it’s changes on top
  - A container is *NOT a VM*, you especially don’t have a GUI and nothing you can connect to with RDP!
- What is a *Docker host*? The (physical or virtual) machine where the *containers are running*
- What is a *Docker registry*? A place where you and others can *upload (push) and download (pull) images*
- *Why* Docker?
  - *Easy way* to ceate deployments / configuration in a *very stable and reliable* way (no "works here", helps a lot to avoid gaps between dev and ops)
  - *Better resource usage* than in vms, especially because there is no guest os as the host kernel is *directly users*
  - Big ecosystem of readily available images, primarily on Docker Hub

---

## Introduction to the overall scenario

- Axians Infoma is an ISV for > 1.200 customers with *> 100 employees directly working on the product* (program managers, developers, back office etc.)
- Technical infrastructure as *quick and easy as possible*: standardize, minimize friction, don't expect infrastructure knowledge (and don't create a need for it)
  - A lot of employees with a lot of infrastructure knowledge, but main strength and therefore *focus is working on the product itself*
- *Central team* provides all infrastructure:
  - *Standard images* for laptops, *central vms* for development
  - *Central SQL Servers / NST / IIS* for dev and test. Local NST installs for some cases but more because of how NAV currently works than because we like it (debugging, need to restart, cmdlets that work only locally, development of server-side dlls)
- **Central Docker containers** because of all of the above and we can stay away from Docker on Win 10 / Docker Community Edition
  - Main reason why we are not using navcontainerhelper a lot, as it mostly assumes local Docker installs (and our ops professionals already have advanced Docker knowledge)

---

### Self-service container environments<br />Overview

- Why? Easy access to releases
  - 1-3 major releases, 4-6 bugfix releases for each country solution per year &rarr; up to *20 Infoma newsytem releases per year*
  - Business central / NAV *cumulative updates, releases and previews*
  - All of those should be readily available for *quick tests*
- How?

![img maxwidth centered](img/selfservice1.png)

---

<!-- .element: class="transitionslide" -->

#### Demo: Create a container

---

### Self-service container environments<br />Details

- Client: Extension v2 in a Business Central Container
  - Available images maintained in a table, pulled nightly
  - Containers valid for max. 3 days, deleted nightly
  - Calls proxy API through a REST interface to create or delete containers, get status and logs
- Proxy API: Custom .Net Core application
  - Creates gMSA, if newsystem container then downloads DLLs from TFS and gets backup
  - Constructs and executes `docker run` command
  - Gets running containers and logs from the Docker API
- Container: Standard image from Microsoft
  - TODO
- Example `docker run` command: 

---

<!-- .element: class="transitionslide" -->

#### Demo 1: See the running container

---

### Multi-container environments<br />Overview

- Why? Multiple very similar containers or more complex scenarios
  - Release tests with 10 databases and all need a container with NST / IIS
  - Tools host with different images
  - Externally available environment with multiple WebClients and WebService endpoints but only a reverse proxy is exposed
  - ToDo diagram
- How? Docker compose
  - Describes in YAML the containers, their configuration and the networking setup
  - For the scenario with 10 almost identical containers: PowerShell script to generate the compose file from templates

---

<!-- .element: class="transitionslide" -->

#### Demo 2.1: Create compose files 

---

<!-- .element: class="transitionslide" -->

#### Demo 2.2: Tools host 

---

<!-- .element: class="transitionslide" -->

#### Demo 2.3: Externally exposed proxy

---

### Multi-container environments<br />Details

- YAML definitions can be changed and Docker will only update the changed parts
- Allows easily updating or even changing the host
- Dynamically scalable if needed: number of replicas
  - Windows auth works fine but needs correctly named containers (with Server 2016, no longer with Server 2019)
- Even more flexible alternative: Docker Swarm
  - Spans multiple hosts (nodes) and places containers on the nodes on demand
  - Very flexible networking from Server 2019 onwards
  - Dynamic reverse proxy setup with Traefik
  - Can run mixed OS: some nodes Windows, some nodes Linux
- Widely used alternative to Docker Swarm in the Linux world: Kubernetes
  - Windows GA expected in the next months

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
