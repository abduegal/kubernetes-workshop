FROM node:0.12

ADD . /usr/src/webapp
RUN chmod -R 755 /usr/src/webapp

EXPOSE 3000

ENV VERSION=0

WORKDIR /usr/src/webapp
CMD node index.js
