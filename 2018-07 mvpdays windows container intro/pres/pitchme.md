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

#### Practical samples<br />Docker containers<br />on Windows
##### Tobias Fenster<br />July 18, 2018

<!-- .slide: data-background="theme/bg.png" data-background-size="100%" data-background-repeat="no-repeat" data-background-position="initial" -->
---

## Introduction

*Tobias Fenster*<br />
CTO at Axians Infoma<br />
Microsoft MVP for Business Solutions (NAV / Business Central)<br />
<br />
@TobiasFenster / https://navblog.axians-infoma.com / https://github.com/tfenster<br />
&nbsp;<br />
Samples based on code by *@EltonStoneman* / https://github.com/sixeyed/docker-windows-workshop and *Microsoft* / https://github.com/Microsoft/dotnet-framework-docker/tree/master/sample, https://github.com/MicrosoftDocs/Virtualization-Documentation/tree/master/windows-container-samples

---

## Agenda

- Run your *first container*
- *Create an image* using an *installer*
- *Create an image* from the *sources*
- Create a *multi-stage image* with a build and a run part
- Run *multiple containers at once* using compose

---

## Run your first container

- Running implies downloading an image (if the image is not already locally available), creating a container from that image and starting it
- We'll use a nanonserver based sample image: 
```
microsoft/dotnet-samples:dotnetapp-nanoserver
```

---

## Create an image using an installer

- Scenario: You have an application with an installer and want to put it in a container
- Steps: 
  - Create a Dockerfile that installs (during build) and runs the application
  - Create an image from that Dockerfile
  - Run the image
  - Check if the container is running
  - Connect
<br />&nbsp;<br />
- We'll install Apache and start it

---

## Create an image from the sources

- Scenario: You have the sources for an application and want to put it in a container
- Steps:
  - Create a Dockerfile that (if neccessary) compiles and installs and then runs the application
  - Create an image from that Dockerfile
  - Run the image
<br />&nbsp;<br />
- We'll use one where we only copy a file but do something more complex in the next one

---

### Create a multi-stage image<br />with a build and a run part

- Scenario: You have the sources for an application and want to put it in a container, but the container used to run the application should be as small as possible
- Steps:
  - Create a Dockerfile with two parts: The first compiles and installs the application, the second only gets the results and runs them
  - Create an image from that Dockerfile
  - Run the image
<br />&nbsp;<br />
- We'll build and run an aspnet application

---

### Run multiple containers at once<br />using compose

- Scenario: Your application relies on multiple containers, e.g. a database, a middle tier and a web frontend. You want to describe and manage them together
- Steps:
  - Maybe create the neccessary images or reuse something that is already available
  - Define your application in a docker-compose file
  - Run docker-compose up
<br />&nbsp;<br />
- We'll build an aspnet application and use a standard SQL Server container for the backend
