.PHONY: help setup docker-up docker-down docker-logs install db-init db-reset start clean test

# Variables
DB_USER ?= ebot_user
DB_NAME ?= ebot
DB_HOST ?= localhost
DB_PORT ?= 5432

help: ## Muestra esta ayuda
    @echo "Comandos disponibles:"
    @grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

setup: ## Ejecuta el script de configuración completo
    @chmod +x setup.sh
    @./setup.sh

docker-up: ## Inicia todos los servicios con Docker Compose
    @echo "🐳 Iniciando servicios con Docker..."
    docker-compose up -d
    @echo "✅ Servicios iniciados. App disponible en http://localhost:3000"

docker-down: ## Detiene todos los servicios Docker
    @echo "🛑 Deteniendo servicios..."
    docker-compose down

docker-logs: ## Muestra los logs de los servicios
    docker-compose logs -f

docker-reset: docker-down ## Resetea completamente Docker (borra volumes)
    @echo "⚠️  Eliminando volúmenes de datos..."
    docker-compose down -v
    @echo "✅ Reset completo"

install: ## Instala dependencias de Node.js
    @echo "📦 Instalando dependencias..."
    npm install
    @echo "✅ Dependencias instaladas"

db-init: ## Ejecuta el script de inicialización de la base de datos (requiere PostgreSQL local)
    @echo "🗄️  Inicializando base de datos..."
    @if [ -z "$$DB_PASSWORD" ]; then \
        echo "❌ ERROR: Define DB_PASSWORD. Ejemplo: DB_PASSWORD=tu_password make db-init"; \
        exit 1; \
    fi
    PGPASSWORD=$$DB_PASSWORD psql -h $(DB_HOST) -p $(DB_PORT) -U $(DB_USER) -d $(DB_NAME) -f db/init.sql
    @echo "✅ Base de datos inicializada"

db-reset: ## Elimina y recrea la base de datos (⚠️ CUIDADO: borra todos los datos)
    @echo "⚠️  ADVERTENCIA: Esto eliminará todos los datos"
    @read -p "¿Estás seguro? [y/N] " confirm && [ "$$confirm" = "y" ] || exit 1
    @echo "🗄️  Reseteando base de datos..."
    dropdb -h $(DB_HOST) -p $(DB_PORT) -U $(DB_USER) $(DB_NAME) --if-exists
    createdb -h $(DB_HOST) -p $(DB_PORT) -U $(DB_USER) $(DB_NAME)
    $(MAKE) db-init
    @echo "✅ Base de datos reseteada"

start: ## Inicia la aplicación en modo desarrollo
    @echo "🚀 Iniciando aplicación..."
    npm start

compile-sass: ## Compila archivos Sass
    @echo "🎨 Compilando Sass..."
    npm run compile:sass

clean: ## Limpia node_modules y archivos compilados
    @echo "🧹 Limpiando..."
    rm -rf node_modules
    rm -f public/css/main.css
    @echo "✅ Limpieza completa"

.env: .env.example ## Crea .env desde .env.example
    @if [ ! -f .env ]; then \
        cp .env.example .env; \
        echo "✅ Archivo .env creado. Por favor configura las credenciales."; \
    else \
        echo "ℹ️  .env ya existe"; \
    fi