FROM node:14-alpine

# Instalar dependencias del sistema
RUN apk add --no-cache python3 make g++

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

# Compilar Sass una vez (sin watch)
RUN npx sass sass/main.scss:public/css/main.css --no-source-map || echo "CSS skipped"

EXPOSE 3000
CMD ["npm", "start"]
