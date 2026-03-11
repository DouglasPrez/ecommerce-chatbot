FROM node:14-alpine

# Instalar dependencias del sistema para node-sass
RUN apk add --no-cache python3 make g++

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

# Compilar Sass sin bloquear si falla
RUN npm run compile:sass --no-watch || echo "Sass compilation skipped"

EXPOSE 3000
CMD ["npm", "start"]
