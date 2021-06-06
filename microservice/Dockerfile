# docker build -t streaming-video --file Dockerfile .
# docker run -d -p 3000:3000 streaming-video

FROM node:12.8.1-alpine

WORKDIR /usr/app

COPY package*.json ./

RUN npm install --only=production

COPY ./streaming-video/* ./

CMD npm start
