FROM node:10.16.3-alpine as builder

RUN apk add --no-cache bash

RUN mkdir -p /app

WORKDIR /app

COPY package.json /app

RUN yarn install

COPY ./ ./

RUN npm run build

FROM nginx

COPY --from=builder /app/build /usr/share/nginx/html