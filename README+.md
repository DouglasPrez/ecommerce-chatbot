# Ecommerce Chatbot

API REST backend para un sistema de ecommerce con chatbot.

![Ecommerce Chatbot](ebot-sample.png)

## 🎯 ¿Qué es este proyecto?

Este es un **backend API REST** construido con Express.js y PostgreSQL. Proporciona endpoints para gestionar usuarios y productos de un sistema de ecommerce.

**⚠️ Nota:** Este proyecto NO incluye interfaz frontend. Las rutas retornan JSON.

---

## 📋 Requisitos Previos

### ⚠️ IMPORTANTE: Debes usar WSL/Ubuntu en Windows

Este proyecto requiere Docker y funciona mejor en un entorno Linux. Si estás en Windows:

#### 1. Instalar WSL (Windows Subsystem for Linux)

```powershell
# Abre PowerShell como Administrador y ejecuta:
wsl --install

# O si ya tienes WSL instalado, instala Ubuntu:
wsl --install -d Ubuntu

# Reinicia tu computadora cuando se solicite
```

#### 2. Abrir Ubuntu

- Busca "Ubuntu" en el menú inicio de Windows
- Abre la aplicación Ubuntu
- La primera vez te pedirá crear un usuario y contraseña (anótalos)

#### 3. Instalar Docker en Ubuntu/WSL

```bash
# Actualizar repositorios
sudo apt update

# Instalar dependencias
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Agregar clave GPG de Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Agregar repositorio de Docker
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Instalar Docker
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Iniciar servicio Docker
sudo service docker start

# Verificar instalación
docker --version
docker compose version
```

---

## 🚀 Levantar el Proyecto (3 Pasos)

### Desde tu terminal Ubuntu/WSL:

```bash
# 1. Navegar al proyecto (ajusta la ruta según donde clonaste)
cd /mnt/c/Users/TU_USUARIO/Desktop/ecommerce-chatbot

# 2. Crear archivo de configuración
cp .env.example .env

# 3. Levantar todo con Docker
sudo docker compose up -d --build
```

**¡Eso es todo!** ⚡

---

## 🌐 Ver el Proyecto en el Navegador

Una vez que los contenedores estén corriendo:

### Abrir en tu navegador de Windows:

- **Página principal:** http://localhost:3000
- **Lista de usuarios (JSON):** http://localhost:3000/users  
- **Lista de productos (JSON):** http://localhost:3000/products

### Probar desde la terminal:

```bash
# Probar la API
curl http://localhost:3000/users
curl http://localhost:3000/products
```

---

## 📊 Ver Logs y Estado

```bash
# Ver logs en tiempo real
sudo docker compose logs -f

# Ver solo logs de la aplicación
sudo docker compose logs -f app

# Ver solo logs de PostgreSQL
sudo docker compose logs -f postgres

# Ver contenedores corriendo
sudo docker ps

# Presiona Ctrl+C para salir de los logs
```

---

## 🛠️ Comandos Útiles

```bash
# Detener todo
sudo docker compose down

# Reiniciar servicios
sudo docker compose restart

# Reiniciar solo la app
sudo docker compose restart app

# Resetear completamente (borra datos)
sudo docker compose down -v
sudo docker compose up -d --build

# Iniciar Docker (si no está corriendo)
sudo service docker start
```

---

## 📡 Rutas API Disponibles

| Método | Ruta | Descripción |
|--------|------|-------------|
| GET | `/` | Página de inicio (HTML) |
| GET | `/users` | Obtiene todos los usuarios (JSON) |
| GET | `/users/:id` | Obtiene usuario por ID (JSON) |
| GET | `/users/username/:username` | Obtiene usuario por username (JSON) |
| POST | `/users` | Crea nuevo usuario |
| PUT | `/users/:id` | Actualiza usuario existente |
| GET | `/products` | Obtiene todos los productos (JSON) |

### Ejemplo de uso:

```bash
# Obtener todos los usuarios
curl http://localhost:3000/users

# Crear un usuario
curl -X POST http://localhost:3000/users \
  -H "Content-Type: application/json" \
  -d '{
    "firstname": "John",
    "lastname": "Doe",
    "email": "john@example.com",
    "password_": "securepassword",
    "username": "johndoe"
  }'

# Obtener usuario por ID
curl http://localhost:3000/users/1
```

---

## 🐛 Troubleshooting

### Error: "Cannot connect to Docker daemon"
```bash
# Iniciar Docker
sudo service docker start
```

### Error: "port is already allocated"
```bash
# Cambiar puerto en .env
echo "PORT=3001" >> .env
sudo docker compose down
sudo docker compose up -d
```

### Error: "Container name already in use"
```bash
# Limpiar contenedores anteriores
sudo docker compose down
sudo docker stop ebot-db 2>/dev/null || true
sudo docker rm ebot-db 2>/dev/null || true
sudo docker compose up -d --build
```

### La aplicación no responde
```bash
# Ver logs para diagnosticar
sudo docker compose logs app

# Verificar que los contenedores están corriendo
sudo docker ps
```

### "Sass compilation" demora mucho
Es normal, la primera vez puede tardar ~2-3 minutos compilando Sass. Las siguientes veces será más rápido.

---

## 🗄️ Base de Datos

El proyecto usa **PostgreSQL** que se levanta automáticamente con Docker.

### Credenciales por defecto:
- **Usuario:** ebot_user
- **Contraseña:** ebot_password
- **Base de datos:** ebot
- **Puerto:** 5432
- **Host:** localhost (desde Windows) o postgres (desde el contenedor)

### Conectarse a PostgreSQL:
```bash
# Desde terminal Ubuntu
sudo docker exec -it ebot-db psql -U ebot_user -d ebot

# Comandos útiles en psql:
# \dt              - Ver tablas
# \d users         - Ver estructura de tabla users
# SELECT * FROM users; - Ver datos
# \q               - Salir
```

---

## 📚 Tecnologías Utilizadas

- **[Express.js](https://expressjs.com/)** - Framework web para Node.js
- **[PostgreSQL](https://www.postgresql.org/)** - Base de datos relacional
- **[Mustache Express](https://www.npmjs.com/package/mustache-express)** - Motor de templates
- **[Sass](https://sass-lang.com/)** - Preprocesador CSS
- **[Docker](https://www.docker.com/)** - Containerización
- **[Node-postgres (pg)](https://www.npmjs.com/package/pg)** - Cliente PostgreSQL para Node.js

---

## 👥 Autores

- Jhonatan Tomimatsu (autor original)
- Sergio Geovany García Smith
- Douglas Daniel Pérez Hernández

---

## 📝 Documentación Adicional

- [DOCKER_SETUP.md](DOCKER_SETUP.md) - Guía completa de Docker
- [PAIN_LOG.md](PAIN_LOG.md) - Análisis de puntos de fricción
- [GOLDEN_PATH.md](GOLDEN_PATH.md) - Artefactos de automatización
- [POSTMORTEM.md](POSTMORTEM.md) - Análisis post-implementación

---

## ⚡ Resumen de Comandos (Copy-Paste)

```bash
# Todo en uno - Levantar proyecto
cd /mnt/c/Users/TU_USUARIO/Desktop/ecommerce-chatbot
sudo service docker start
cp .env.example .env
sudo docker compose up -d --build

# Luego abre en navegador: http://localhost:3000
```

**Tiempo total: ~2-3 minutos** (primera vez con compilación de Sass)
**Siguientes veces: ~30 segundos**