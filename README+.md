# Ecommerce Chatbot

API REST backend para un sistema de ecommerce con chatbot.

![Ecommerce Chatbot](ebot-sample.png)

## 🎯 ¿Qué es este proyecto?

Este es un **backend API REST** construido con Express.js y PostgreSQL. Proporciona endpoints para gestionar usuarios y productos de un sistema de ecommerce.

**⚠️ Nota:** Este proyecto NO incluye interfaz frontend. Las rutas retornan JSON.

## 📋 Requisitos Previos

### Opción A: Docker (Recomendado)
- Docker Engine 20.10+
- Docker Compose 2.0+

### Opción B: Instalación Manual
- **Node.js**: v14.21.3 o superior (usa `nvm` para gestionar versiones)
- **npm**: 6.x o superior
- **PostgreSQL**: 12.x o superior

## 🚀 Instalación Rápida

### Con Docker (Recomendado)

```bash
# 1. Clonar el repositorio
git clone <repo-url>
cd ecommerce-chatbot

# 2. Configurar variables de entorno
cp .env.example .env
# Edita .env si necesitas cambiar configuraciones

# 3. Iniciar todo con Docker
docker-compose up -d

# 4. Verificar que funciona
curl http://localhost:3000/users

# Con Makefile
# Ver todos los comandos disponibles
make help

# Setup completo
make setup

# Iniciar con Docker
make docker-up

# Iniciar sin Docker
make start

# Instalación manual 
# 1. Clonar repo
git clone <repo-url>
cd ecommerce-chatbot

# 2. Usar la versión correcta de Node
nvm install 14
nvm use 14

# 3. Ejecutar script de setup
chmod +x setup.sh
./setup.sh

# 4. Configurar PostgreSQL
# Crear usuario y database
psql -U postgres
CREATE USER ebot_user WITH PASSWORD 'tu_password';
CREATE DATABASE ebot OWNER ebot_user;
\q

# 5. Ejecutar migraciones
psql -U ebot_user -d ebot -f db/init.sql

# 6. Configurar .env
cp .env.example .env
# Editar .env con tus credenciales

# 7. Iniciar aplicación
npm start

# Comandos disponibles
# Desarrollo
npm start                    # Inicia app con nodemon
npm run compile:sass         # Compila Sass en modo watch

# Con Make
make docker-up               # Inicia con Docker
make docker-down             # Detiene Docker
make docker-logs             # Ver logs
make start                   # Inicia app localmente
make db-init                 # Inicializa DB
make help                    # Ver todos los comandos