# base image
FROM node:lts-alpine3.13 as angular-built

# install @angular/cli on the image
#RUN npm install -g @angular/cli@10.1.4
RUN npm install -g @angular/cli@12.1.0
