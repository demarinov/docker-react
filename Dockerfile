FROM node:16-alpine as builder

USER node

RUN mkdir -p /home/node/app
WORKDIR "/home/node/app"

COPY --chown=node:node ./package.json ./
RUN npm config set fetch-retry-mintimeout 20000;npm config set fetch-retry-maxtimeout 180000;npm install
COPY --chown=node:node ./ ./

RUN npm run build

FROM nginx

EXPOSE 80

COPY --from=builder /home/node/app/build /usr/share/nginx/html
