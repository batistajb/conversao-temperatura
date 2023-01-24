FROM node:18-slim as buildStage

LABEL stage="builder"

RUN apt update

#USER node

WORKDIR /app

COPY ./src/package.json .

RUN npm install

COPY ./src .

RUN npm run build:prod

FROM node:18-slim

LABEL author="João B S Alves<batistadasilvaalvesjoao@gmail.com>"

WORKDIR /app

COPY --from=buildStage /app/ /app/
COPY --from=buildStage /app/dist/server.js /app/server.js

EXPOSE 8080

CMD [ "node", "server.js" ]