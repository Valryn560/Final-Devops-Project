FROM node:latest as build-step
WORKDIR /app
COPY . /app
RUN npm install -g @angular/cli@latest
EXPOSE 4200
ENTRYPOINT ["ng","serve","--host", "0.0.0.0", "--port", "4200"]
