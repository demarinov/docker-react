# Getting Started with Docker
<p align="center">
  <img width="70%" height="70%" src="https://www.hashroot.com/assets/img/services/devops/docker.png" />
</p>

## :rocket: Introduction
In this mini project we demonstrate how to use Docker to build and run a simple react application.

## ❔ The what & the why
Docker is an open platform for developing, shipping, and running applications. Docker enables us to separate our applications from our infrastructure so we can deliver software quickly. Basically, it is a tool that allows us to install applications faster and easier.

## 🚢 Docker Concepts
- Container
  - A container is a sandboxed process running on a host machine that is isolated from all other processes running on that host machine.
  - Is a runnable instance of an image. We can create, start, stop, move, or delete a container using the Docker API or CLI.
 
- Image
  - A running container uses an isolated filesystem. This isolated filesystem is provided by an image, and the image must contain everything needed to run an application - all dependencies, configurations, scripts, binaries, etc.
 
## 👷 Building and running
To build our image we need 2 things - docker installed and a Dockerfile with our image configuration.
- Install docker from https://docs.docker.com/get-docker/
- Create a Dockerfile:
```
FROM node:16-alpine

USER node

RUN mkdir -p /home/node/app
WORKDIR '/home/node/app'

COPY --chown=node:node ./package.json ./
RUN npm install
COPY --chown=node:node ./ ./


CMD ["npm","start"]
```
- In order to build our docker image, from docker file directory we run: `docker build -t react-app .`
  - The -t flag tags our image
- In order to run our application inside a docker container we run: `docker run -dp 127.0.0.1:3000:3000 react-app`
  - The -d flag (short for --detach) runs the container in the background. The -p flag (short for --publish) creates a port mapping between the host and the container.
  - After few seconds we can open the browser on http://localhost:3000
- We can list our running containers with: `docker ps`

## ✖️ Multiple containers
To run multiple containers simultenously, we can use `docker-compose`
- Create `docker-compose.yml` file with following structure:
```
version: '3'
services:
  web:
    build:
      context: .
      dockerfile: Dockerfile.dev  
    ports:
      - "3000:3000"
    volumes:
      - /home/node/app/node_modules
      - .:/home/node/app   

  tests:
    build:
      context: .
      dockerfile: Dockerfile.dev 
    volumes:
      - /home/node/app/node_modules
      - .:/home/node/app
    command: ["npm","run", "test"]      
   ```
- To run the containers with docker-compose we use: `docker compose up -d`

## 🔚 Conclusion
Docker is a powerful tool for building, running and deploying applications faster and easier.

## 🔗 References
- [Overview](https://docs.docker.com/get-started/)
- [Containers](https://docs.docker.com/get-started/02_our_app/)
- [Docker Compose](https://docs.docker.com/get-started/08_using_compose/)
  
<p>
  :fire: <a href="https://github.com/demarinov/">DM</a>
</p>
