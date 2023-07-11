FROM node:20-alpine as BUILD_IMAGE

WORKDIR /frontend

COPY frontend .

ARG PUBLIC_CLIENT_HOST_URL
ARG PUBLIC_SERVER_HOST_URL
ARG JWT_SECRET

ENV PUBLIC_CLIENT_HOST_URL=$PUBLIC_CLIENT_HOST_URL
ENV PUBLIC_SERVER_HOST_URL=$PUBLIC_SERVER_HOST_URL
ENV JWT_SECRET=$JWT_SECRET

# build
RUN yarn install
RUN yarn build

# remove dev dependencies
RUN yarn install --production --frozen-lockfile

FROM node:20-alpine
WORKDIR /frontend

COPY --from=BUILD_IMAGE /frontend/package.json .
COPY --from=BUILD_IMAGE /frontend/build .

RUN yarn --prod
RUN yarn add dotenv

CMD node -r dotenv/config index.js
