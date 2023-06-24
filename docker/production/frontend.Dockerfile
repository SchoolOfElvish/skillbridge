FROM node:20-alpine as BUILD_IMAGE
WORKDIR /frontend
COPY frontend/package.json frontend/pnpm-lock.yaml ./

RUN npm install -g pnpm@8.6.3
RUN pnpm install --frozen-lockfile

COPY frontend .

# build
RUN pnpm build

# remove dev dependencies
RUN pnpm prune --production

FROM node:20-alpine
WORKDIR /frontend

COPY --from=BUILD_IMAGE /frontend/package.json .
COPY --from=BUILD_IMAGE /frontend/build .

RUN npm install -g pnpm@8.6.3
RUN pnpm install --production
RUN pnpm add dotenv

CMD node -r dotenv/config index.js
