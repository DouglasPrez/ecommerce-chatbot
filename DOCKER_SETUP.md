# 🚀 Levantar Proyecto con Docker

## Pasos Rápidos (3 Comandos)

```bash
# 1. Clonar el repositorio (si aún no lo tienes)
git clone <url-del-repo>
cd ecommerce-chatbot

# 2. Crear archivo .env
cp .env.example .env

# 3. Levantar todo con Docker
docker compose up -d --build
```

**¡Listo!** La aplicación estará disponible en: `http://localhost:3000`

---

## ✅ Verificar que Funciona

```bash
# Ver logs
docker compose logs -f

# Probar API
curl http://localhost:3000/users
curl http://localhost:3000/products

# O abrir en navegador:
# http://localhost:3000
```

---

## 🛠️ Comandos Útiles

```bash
# Detener todo
docker compose down

# Reiniciar
docker compose restart

# Ver contenedores corriendo
docker ps

# Ver solo logs de la app
docker compose logs -f app

# Ver solo logs de la base de datos
docker compose logs -f postgres

# Resetear completamente (borra datos)
docker compose down -v
docker compose up -d --build
```

---

## 📋 Requisitos

- **Docker** instalado
- **Docker Compose** (incluido en Docker Desktop)
- Puertos **3000** y **5432** disponibles

---

## 🐛 Troubleshooting

### Error: "port is already allocated"
```bash
# Cambiar puerto en .env
echo "PORT=3001" >> .env
docker compose down
docker compose up -d
```

### Error: "Cannot connect to Docker daemon"
```bash
# Iniciar Docker
sudo service docker start  # Linux/WSL
# O iniciar Docker Desktop en Windows/Mac
```

### La base de datos no se inicializa
```bash
# Resetear volúmenes
docker compose down -v
docker compose up -d
```

---

## 📦 ¿Qué hace cada comando?

1. **`cp .env.example .env`** - Crea variables de entorno con valores por defecto
2. **`docker compose up -d --build`** - Levanta PostgreSQL + App en contenedores
   - `-d` = modo detached (en segundo plano)
   - `--build` = reconstruye imágenes si hay cambios

---

## 🎯 Sin Docker (Alternativa)

Si no puedes usar Docker:

```bash
# 1. Instalar PostgreSQL localmente
# 2. Crear usuario y base de datos:
psql -U postgres
CREATE USER ebot_user WITH PASSWORD 'ebot_password';
CREATE DATABASE ebot OWNER ebot_user;
\q

# 3. Ejecutar migraciones
psql -U ebot_user -d ebot -f db/init.sql

# 4. Configurar .env
cp .env.example .env
# Editar .env: DB_HOST=localhost

# 5. Instalar y ejecutar
npm install
npm start
```

---

**Tiempo total con Docker: ~2 minutos** ⚡
