#!/bin/bash

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "======================================"
echo "🚀 Ecommerce Chatbot - Setup Script"
echo "======================================"
echo ""

# Función para imprimir errores
error() {
    echo -e "${RED}❌ ERROR: $1${NC}"
    exit 1
}

# Función para imprimir warnings
warning() {
    echo -e "${YELLOW}⚠️  WARNING: $1${NC}"
}

# Función para imprimir éxitos
success() {
    echo -e "${GREEN}✅ $1${NC}"
}

# Verificar versión de Node.js
echo "📋 Verificando versión de Node.js..."
if ! command -v node &> /dev/null; then
    error "Node.js no está instalado. Por favor instala Node.js 14.x o superior."
fi

NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 14 ]; then
    error "Node.js versión $NODE_VERSION detectada. Se requiere Node.js 14 o superior. Usa nvm: 'nvm install 14'"
fi
success "Node.js versión $(node -v) detectada"

# Verificar npm
echo ""
echo "📋 Verificando npm..."
if ! command -v npm &> /dev/null; then
    error "npm no está instalado."
fi
success "npm versión $(npm -v) detectada"

# Crear archivo .env si no existe
echo ""
echo "📋 Configurando variables de entorno..."
if [ ! -f .env ]; then
    if [ -f .env.example ]; then
        cp .env.example .env
        success "Archivo .env creado desde .env.example"
        warning "Por favor revisa y ajusta las credenciales en .env según tu configuración"
    else
        error ".env.example no encontrado. No se puede crear .env"
    fi
else
    success "Archivo .env ya existe"
fi

# Verificar PostgreSQL
echo ""
echo "📋 Verificando PostgreSQL..."
if command -v psql &> /dev/null; then
    success "PostgreSQL está instalado"
    
    # Intentar conectar
    source .env 2>/dev/null || true
    DB_USER=${DB_USER:-ebot_user}
    DB_NAME=${DB_NAME:-ebot}
    
    echo ""
    echo "⚠️  IMPORTANTE: Debes ejecutar manualmente:"
    echo "   1. Crear usuario PostgreSQL: CREATE USER $DB_USER WITH PASSWORD 'tu_password';"
    echo "   2. Crear base de datos: CREATE DATABASE $DB_NAME OWNER $DB_USER;"
    echo "   3. Ejecutar script: psql -U $DB_USER -d $DB_NAME -f db/init.sql"
else
    warning "PostgreSQL no detectado en el sistema"
    echo ""
    echo "Tienes dos opciones:"
    echo "   A. Instalar PostgreSQL localmente"
    echo "   B. Usar Docker: 'docker-compose up -d postgres'"
fi

# Instalar dependencias
echo ""
echo "📦 Instalando dependencias de Node.js..."
if npm install; then
    success "Dependencias instaladas correctamente"
else
    error "Falló la instalación de dependencias. Revisa los errores arriba."
fi

# Compilar Sass
echo ""
echo "🎨 Compilando archivos Sass..."
if npm run compile:sass -- --no-watch; then
    success "Sass compilado correctamente"
else
    warning "Falló la compilación de Sass, pero el app puede funcionar"
fi

# Verificar estructura de carpetas
echo ""
echo "📁 Verificando estructura de carpetas..."
REQUIRED_DIRS=("db" "routes" "views" "public" "sass")
for dir in "${REQUIRED_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        success "Carpeta $dir existe"
    else
        error "Carpeta requerida '$dir' no encontrada"
    fi
done

echo ""
echo "======================================"
echo "✅ Setup completado!"
echo "======================================"
echo ""
echo "📝 Próximos pasos:"
echo "   1. Configura PostgreSQL (si no usas Docker)"
echo "   2. Revisa y ajusta el archivo .env"
echo "   3. Ejecuta el script SQL: db/init.sql"
echo "   4. Inicia la aplicación: npm start"
echo "   5. Accede a: http://localhost:3000"
echo ""
echo "🐳 Para usar Docker (recomendado):"
echo "   docker-compose up -d"
echo ""