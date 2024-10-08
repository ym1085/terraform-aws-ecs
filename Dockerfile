# alpine은 경량화된 리눅스 배포판
FROM node:10.13-alpine

WORKDIR /home
COPY . .
ENV TZ Asia/Seoul

RUN npm install
CMD npm run start