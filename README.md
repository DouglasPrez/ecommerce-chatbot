# Ecommerce chatbot

Ecommerce chatbot boilerplate - REST API backend con Express.js y PostgreSQL

![Wather application](ebot-sample.png)

## 🚀 Quick Start con Docker (Recomendado)

**Requisitos:** Docker y Docker Compose instalados

```bash
# 1. Clonar repositorio
git clone <url-del-repo>
cd ecommerce-chatbot

# 2. Crear archivo de configuración
cp .env.example .env

# 3. Levantar todo
docker compose up -d --build
```

**¡Listo!** Aplicación disponible en: `http://localhost:3000`

### Scripts Automatizados

**Linux/Mac/WSL:**
```bash
chmod +x quick-start.sh
./quick-start.sh
```

**Windows PowerShell:**
```powershell
.\quick-start.ps1
```

Ver documentación completa en [DOCKER_SETUP.md](DOCKER_SETUP.md)

---

## Prerequisites (Instalación Manual)
Make sure you have these requirements installed on your machine
* **Node.js 14+** (recomendado: usar [nvm](https://github.com/nvm-sh/nvm))
* npm 6+
* **PostgreSQL 12+** (o usar Docker - ver arriba)

## Installation

### Manual Setup
Run:
```bash
# Instalar PostgreSQL y crear base de datos
psql -U postgres
CREATE USER ebot_user WITH PASSWORD 'ebot_password';
CREATE DATABASE ebot OWNER ebot_user;
\q

# Ejecutar migraciones
psql -U ebot_user -d ebot -f db/init.sql

# Configurar variables de entorno
cp .env.example .env
# Editar .env y cambiar DB_HOST=localhost

# Instalar dependencias
npm install

# Iniciar aplicación
npm start
```

## Routes
* `/` - Render home template

### Database Queries
* `/users`  ____________________ (GET) Retrieves users by id ascending order
* `/users/:id` _________________ (GET) Retrieves users by id param
* `/users/username/:username` __ (GET) Retrieves users by username param
* `/products` __________________ (GET) Retrieves products by id ascending order
* `/users`  ____________________ (POST) Creates new user data on database 
* `/users/:id` _________________ (PUT) Updates user data on database


## Technologies used

* [Express](https://expressjs.com/) - Fast, unopinionated, minimalist web framework for Node.js
* [Mustache Express](https://www.npmjs.com/package/mustache-express) - Mustache template engine for Express
* [Sass](https://sass-lang.com/) - Professional grade CSS preprocessor
* [Node-postgres (pg)](https://www.npmjs.com/package/pg) - Non-blocking PostgreSQL client for Node.js
* [Docker](https://www.docker.com/) - Containerization platform (optional but recommended)
