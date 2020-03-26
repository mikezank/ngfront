FROM node as builder

WORKDIR /app

COPY package.json .
RUN npm install
RUN npm install -g @angular/cli@latest

COPY . /app

RUN ng build --prod

# PROD environment
FROM nginx:alpine
EXPOSE 80
COPY --from=builder /app/dist/ngfront /usr/share/nginx/html
