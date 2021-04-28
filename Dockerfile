FROM node:alpine
WORKDIR '/app'
COPY --chown=node:node package*.json ./
RUN npm install
RUN chown node:node /app/node_modules
COPY --chown=node:node ./ ./
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=0 /app/build /usr/share/nginx/html