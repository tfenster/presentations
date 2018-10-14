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

#### Docker on Windows<br />and Business Central<br />on Docker intro
##### Tobias Fenster<br />Directions EMEA<br />The Hague, 29.10.2018

---

## Introduction and Agenda

*Tobias Fenster*<br />
CTO at Axians Infoma<br />
Microsoft MVP for Business Applications<br />
[@tobiasfenster](https://twitter.com/tobiasfenster) and https://navblog.axians-infoma.com<br />
&nbsp;<br />&nbsp;<br />
*Agenda*
- Intro to the workshop structure and quick walk-through
- You work :)

---

### Intro to the workshop structure<br />Multiple "tracks" according to your preference

- *Track 1:* **Docker on Windows**
- *Track 2:* **Business Central on Docker**
- *Track 3:* **navcontainerhelper**
- *Track 4:* **Business Central with Azure Container Instances (ACI) and Azure Container Registry (ACR)**
- *Track 5:* **Container high availability: Business Central using Compose and on Docker Swarm**

---

### Introduction to Docker<br />if you are not sure yet what this is

- What is Docker? Leading cross platform software container environment
- What is a Docker container and a Docker image?
  - An image is a template with the minimum amount of os, libraries and application binaries needed
  - A container is an instance of an image with an immutable base and it’s changes on top
  - A container is NOT a VM, you especially don’t have a GUI and nothing you can connect to with RDP!
- What is a Docker host? The (physical or virtual) machine where the containers are running
- What is a Docker registry? A place where you and others can upload (push) and download (pull) images
- Why Docker?
  - *Easy way* to ceate deployments / configuration in a *very stable and reliable* way (no "works here", helps a lot to avoid gaps between dev and ops)
  - *Better resource usage* than in vms, especially because there is no guest os as the host kernel is *directly users*
  - Big ecosystem of readily available images, primarily on Docker Hub

---

### Track 1<br />Docker on Windows

- If you want: Uninstall Docker as it already is installed and install it again
- Try small *hello world* examples and create *simple Dockerfiles* building your own images
- Extend existing Dockerfiles as *multi-stage images*
- Run *multi-container environments* using Docker Compose
<br />&nbsp;<br />
- Interesting if you want to install Docker yourself and want to learn the Docker basics without anything BC specific

---

### Track 2<br />Business Central on Docker

- Run your first *Business Central* in a container, change *config settings* and add your *own files*
- Persist your changes in your *own image*
- Run a more complex scenario connecting Business Central to an *external SQL Server*
- Connect your *development tools* to the container
<br />&nbsp;<br />
- Interesting if you want to get started with Business Central on Docker and look into some moderately complex examples

---

### Track 3<br />navcontainerhelper

- Install the module and run your *first Business Central in a container*
- *"Old school"* setup: Win Auth, C/SIDE, Win Client
- Develop with *VS Code* and publish *apps*
<br />&nbsp;<br />
- Interesting if you want to follow the easiest possible route when using Docker in connection with BC

---

### Track 4<br />Business Central with ACIs and ACR

- Get started: Use the *GUI* to create your *first ACI*
- Use the *Azure CLI to automate* creating the ACI
- Use *templates* to deploy ACIs
- Create you *own image*, push it to *ACR* and run it as ACI
<br />&nbsp;<br />
- Interesting if you want to run Docker images and create your own images without installing and maintaining the base infrastructure

---

### Track 5<br />Container HA: Business Central using Compose and on Docker Swarm

- Use Compose to create a *multi-container Business Central environment*
- Create a *Docker Swarm*
- Publish Business Central
- Add *more containers*, make them available with a *reverse proxy* and visualize them with *Portainer*
<br />&nbsp;<br />
- Interesting if you want to implement a highly available Business Central infrastructure using containers

---

<!-- .element: class="finalslide" -->

#### Any questions I can try to answer?

##### [@tobiasfenster](https://twitter.com/tobiasfenster)<br />https://navblog.axians-infoma.de<br />[tobias.fenster@axians-infoma.de](mailto:tobias.fenster@axians-infoma.de)
