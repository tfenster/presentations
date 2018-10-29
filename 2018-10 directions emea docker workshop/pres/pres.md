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
<br />&nbsp;<br />
- Find material at [https://ve.link/dir18-docker-ws](https://ve.link/dir18-docker-ws)

---

### Intro to the workshop structure<br />Multiple "tracks" according to your preference

- *Track 1:* **Docker on Windows**
- *Track 2:* **Business Central on Docker**
- *Track 3:* **navcontainerhelper**
- *Track 4:* **Business Central with Azure Container Instances** 

---

### Introduction to Docker<br />if you are not sure yet what this is

- What is **Docker**? Leading cross platform *software container* environment
- What is a *Docker container* and a *Docker image*?
  - An image is a template with the *minimum amount of os, libraries and application binaries* needed
  - A container is an *instance of an image* with an immutable base and it’s changes on top
  - A container is *NOT a VM*, you especially don’t have a GUI and nothing you can connect to with RDP!
- What is a *Docker host*? The (physical or virtual) machine where the *containers are running*
- What is a *Docker registry*? A place where you and others can *upload (push) and download (pull) images*
- *Why* Docker?
  - *Easy way* to create deployments / configuration in a *very stable and reliable* way (no "works here", helps a lot to avoid gaps between dev and ops)
  - *Better resource usage* than in vms, especially because there is no guest os as the host kernel is *directly used*
  - Big ecosystem of readily available images, primarily on Docker Hub

---

### Track 1<br />Docker on Windows

- If you want: Uninstall Docker ([video 1.1](https://tfenster.github.io/presentations/201810-emeadockerworkshop/video/1.1%20-%20uninstall.mp4)) as it already is installed and install it again ([video 1.2](https://tfenster.github.io/presentations/201810-emeadockerworkshop/video/1.2%20-%20install.mp4))
  - If you are not using the workshop vm, then follow the install instructions as well
- Try a small *hello world* example ([video 1.3](https://tfenster.github.io/presentations/201810-emeadockerworkshop/video/1.3%20-%20hello%20world.mp4)) and create *simple Dockerfiles* building your own image ([video 1.4](https://tfenster.github.io/presentations/201810-emeadockerworkshop/video/1.4%20-%20customer%20container%20image.mp4), [download sources](https://ve.link/dir18-14))
- Extend existing Dockerfiles as *multi-stage images* ([video 1.5](https://tfenster.github.io/presentations/201810-emeadockerworkshop/video/1.5%20-%20multistage.mp4), [download sources](https://ve.link/dir18-15))
<br />&nbsp;<br />
- Interesting if you want to *install Docker yourself* and want to learn the *Docker basics without anything BC specific*

---

### Track 2<br />Business Central on Docker

- Run your first *Business Central* in a container ([video 2.1](https://tfenster.github.io/presentations/201810-emeadockerworkshop/video/2.1%20-%20simple%20startup.mp4))
- Change *config settings* ([video 2.2](https://tfenster.github.io/presentations/201810-emeadockerworkshop/video/2.2%20-%20config.mp4)) 
- Add your *own custom script* ([video 2.3](https://tfenster.github.io/presentations/201810-emeadockerworkshop/video/2.3%20-%20custom%20script%20file.mp4)) &rarr; same mechanism works for .dlls or other files
- Persist the script in your *own image* ([video 2.4](https://tfenster.github.io/presentations/201810-emeadockerworkshop/video/2.4%20-%20custom%20image.mp4), based on 2.3)
- Connect your *development tools* to the container ([video 2.5](https://tfenster.github.io/presentations/201810-emeadockerworkshop/video/2.5%20-%20connect%20dev%20tools.mp4))
<br />&nbsp;<br />
- Interesting if you want to *get started with Business Central on Docker* and look into some moderately complex examples

---

### Track 3<br />navcontainerhelper

- Install the module and run your *first Business Central in a container* ([video 3.1](https://tfenster.github.io/presentations/201810-emeadockerworkshop/video/3.1%20-%20install%20and%20run%20first.mp4))
  - On the workshop host, it is already installed
  - If you run in your own VM, you need to install it for the following to work
- *"Old school"* setup: Win Auth, C/SIDE, Win Client ([video 3.2](https://tfenster.github.io/presentations/201810-emeadockerworkshop/video/3.2%20-%20old%20school.mp4))
- Connect with *VS Code* and publish your *app* ([video 3.3](https://tfenster.github.io/presentations/201810-emeadockerworkshop/video/3.3%20-%20vs%20code.mp4), based on 3.2)
<br />&nbsp;<br />
- Interesting if you want to follow the *easiest possible route* when using Docker in connection with BC

---

### Track 4<br />Business Central with Azure Container Instances

- **Please note**: 
  - This requires an *Azure subscription* and will *cause some small cost*
  - It only needs a browser, so no need to connect to the workshop VM for this
- Get started: Use the *GUI* to create your *first ACI* ([video 4.1](https://tfenster.github.io/presentations/201810-emeadockerworkshop/video/4.1%20-%20aci%20gui.mp4))
- Use the *Azure CLI to automate* creating the ACI ([video 4.2](https://tfenster.github.io/presentations/201810-emeadockerworkshop/video/4.2%20-%20aci%20shell.mp4))
- Use my *quickstart template* to deploy ACIs ([video 4.3](https://tfenster.github.io/presentations/201810-emeadockerworkshop/video/4.3%20-%20aci%20quickstart.mp4))
  - Includes Let's Encrypt certificates for secure communication without warnings
<br />&nbsp;<br />
- Interesting if you want to run Docker containers *without installing and maintaining* the base infrastructure

---

## Additional notes before you start

- If you want to use the workshop VM, send and email to freddy.kristiansen@microsoft.com with the IP address on the landing page and he will enable access
- Make sure to **stop all running containers before starting a new track** ([video 0](https://tfenster.github.io/presentations/201810-emeadockerworkshop/video/0%20-%20cleanup.mp4))
  - Only exception are parts where "depends on previous part" is explicitly noted
- If actions run for a *longer time*, I have *skipped* the waiting time in the recordings
- *Green* target circle means *left click*, *yellow* target circle means *right click*

---


<!-- .element: class="finalslide" -->

#### Any questions I can try to answer?

##### [@tobiasfenster](https://twitter.com/tobiasfenster)<br />https://navblog.axians-infoma.de<br />[tobias.fenster@axians-infoma.de](mailto:tobias.fenster@axians-infoma.de)
