# Stage 0, based on Node.js, to build and compile Angular
FROM node:8.6 as builder
WORKDIR /app
COPY package.json /app/
RUN npm install --silent
COPY ./ /app/
RUN $(npm bin)/ng build --prod --build-optimizer

 

# Stage 1, based on Nginx, to have only the compiled app, ready for deployment with Nginx
FROM nginx:1.13
COPY --from=builder /app/dist /usr/share/nginx/html
COPY ./nginx-custom.conf /etc/nginx/conf.d/default.conf
