FROM node:22.3.0

ENV YARN_VERSION 4.3.0

RUN corepack enable && corepack prepare yarn

WORKDIR /frontend

ENV NODE_ENV=development
