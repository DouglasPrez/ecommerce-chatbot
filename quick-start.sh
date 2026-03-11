#!/bin/bash

echo "🚀 Iniciando Ecommerce Chatbot con Docker..."
echo ""

# Verificar que Docker está corriendo
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker no está corriendo. Por favor inicia Docker primero."
    echo "   Linux/WSL: sudo service docker start"
    echo "   Windows/Mac: Inicia Docker Desktop"
    exit 1
fi

# Crear .env si no existe
if [ ! -f .env ]; then
    echo "📝 Creando archivo .env..."
    cp .env.example .env
    echo "✅ Archivo .env creado"
else
    echo "✅ Archivo .env existe"
fi

# Levantar servicios
echo ""
echo "🐳 Levantando PostgreSQL y Aplicación..."
docker compose up -d --build

# Esperar a que los servicios estén listos
echo ""
echo "⏳ Esperando a que los servicios inicien..."
sleep 5

# Verificar estado
echo ""
echo "📊 Estado de los servicios:"
docker compose ps

echo ""
echo "✅ ¡Listo! Aplicación corriendo en:"
echo "   🌐 http://localhost:3000"
echo ""
echo "📝 Comandos útiles:"
echo "   Ver logs:      docker compose logs -f"
echo "   Detener:       docker compose down"
echo "   Reiniciar:     docker compose restart"
echo ""
echo "🧪 Probar API:"
echo "   curl http://localhost:3000/users"
echo "   curl http://localhost:3000/products"
