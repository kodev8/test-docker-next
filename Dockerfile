FROM node:latest AS build

WORKDIR /app

COPY package.json package-lock.json /app/
RUN npm install

COPY . /app
RUN npm run build

FROM node:latest

WORKDIR /app
COPY --from=build /app/package.json /app/package-lock.json /app/
COPY --from=build /app/.next /app/.next
COPY --from=build /app/public /app/public
COPY --from=build /app/node_modules /app/node_modules

# Expose the port
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
