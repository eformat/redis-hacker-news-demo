FROM nginx:1.19-alpine as build

USER root

# Install nvm with node and npm
RUN apk add --no-cache --repository http://nl.alpinelinux.org/alpine/edge/main libuv \
    && apk add --no-cache --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/main nodejs=16.13.1-r1 nodejs-npm=12.22.6-r0 \
    && echo "NodeJS Version:" "$(node -v)" \
    && echo "NPM Version:" "$(npm -v)"

ARG NPM_MIRROR_REGISTRY
RUN npm config set registry ${NPM_MIRROR_REGISTRY}

RUN mkdir /build
COPY . /build
WORKDIR /build

RUN npm install
#RUN npm run build

#FROM nginxinc/nginx-unprivileged

#COPY  --from=build /build/.next/ /usr/share/nginx/html
#COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 5000
#CMD ["npm", "run", "start"]
CMD ["npm", "run", "dev"]
