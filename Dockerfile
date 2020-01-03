FROM node:lts as build-stage

WORKDIR /usr/src/app
RUN git clone https://github.com/janrembold/react-test.git

WORKDIR /usr/src/app/react-test
RUN yarn install
RUN yarn build

FROM nginx:alpine
COPY --from=build-stage /usr/src/app/react-test/build/ /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]