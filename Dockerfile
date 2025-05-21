FROM node:lts-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM node:lts-alpine
RUN npm install -g http-server
WORKDIR /app
COPY --from=build /app/dist ./dist
EXPOSE 8080
CMD [ "http-server", "dist", "-p", "8080" ]