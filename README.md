"# angular-cli" 

App Dockerization Steps
-----------------------


1.) create a Dockerfile:
------------------------
# base image
FROM node:lts-alpine3.12 as angular-built

RUN npm install -g @angular/cli@latest



2.) push to https://hub.docker.com/
-----------------------------------

a.) build image: docker build -t angular-cli-v11 .
b.)   tag image: docker tag 1a6b3b65cb25 omostan/angular-cli:v11.0.0
c.)  push image: docker push omostan/angular-cli:v11.0.0

optional:
---------
d.) save a local copy of the image: docker save omostan/angular-cli > c:\CSharp\GitHub\VS2017\docker_hub\angular-cli.v11.0.0.tar
e.) load the local copy when needed: docker load --input c:\CSharp\GitHub\VS2017\docker_hub\angular-cli.v11.0.0.tar


*** view the image at https://hub.docker.com/repository/docker/omostan/angular-cli/ ***


3.) dockerize your angular app:
-------------------------------
# base image
FROM omostan/angular-cli:v11.0.0 as angular-built

# set working directory
WORKDIR /usr/src/app

# install and cache app dependencies
COPY package.json package.json
RUN npm install --silent
#RUN npm install -g @angular/cli@latest

# add all files and folders
COPY . .

# build the app
RUN ng build --prod

FROM nginx:alpine
LABEL author="Stanley Omoregie"
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=angular-built /usr/src/app/dist /usr/share/nginx/html
EXPOSE 80 443
CMD [ "nginx", "-g", "daemon off;" ]

