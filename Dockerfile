# base image
FROM node:lts-alpine3.12 as angular-built

# install @angular/cli on the image
RUN npm install -g @angular/cli@10.1.4
