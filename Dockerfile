FROM node:8.6-alpine

RUN mkdir -p /usr/src/app

ADD . /usr/src/app

WORKDIR /usr/src/app

RUN npm install --only=production

RUN ls -la

EXPOSE 8080

CMD [ "npm", "run", "server" ]
