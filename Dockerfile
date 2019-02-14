FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# 2 phase build
FROM nginx

# Does nothing locally, but EBS expects this to specify the port.
EXPOSE 80

# Copy from the build
COPY --from=builder /app/build /usr/share/nginx/html
