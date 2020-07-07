## Build the "deployable package"
FROM node:7.10 as frontend-build
WORKDIR /fullstack/frontend

# Download all package dependencies first.
# Download dependencies when packages changes
COPY package.json package-lock.json ./
RUN npm install

# Copy all and build
COPY . ./
RUN npm run build

# Get "deployable package"
FROM nginx:1.12-alpine
COPY --from=frontend-build /fullstack/frontend/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]