# Script de inicio rápido para Windows PowerShell

Write-Host "🚀 Iniciando Ecommerce Chatbot con Docker..." -ForegroundColor Green
Write-Host ""

# Verificar que Docker está corriendo
try {
    docker info | Out-Null
} catch {
    Write-Host "❌ Docker no está corriendo. Por favor inicia Docker Desktop primero." -ForegroundColor Red
    exit 1
}

# Crear .env si no existe
if (!(Test-Path .env)) {
    Write-Host "📝 Creando archivo .env..." -ForegroundColor Yellow
    Copy-Item .env.example .env
    Write-Host "✅ Archivo .env creado" -ForegroundColor Green
} else {
    Write-Host "✅ Archivo .env existe" -ForegroundColor Green
}

# Levantar servicios
Write-Host ""
Write-Host "🐳 Levantando PostgreSQL y Aplicación..." -ForegroundColor Cyan
docker compose up -d --build

# Esperar a que los servicios estén listos
Write-Host ""
Write-Host "⏳ Esperando a que los servicios inicien..." -ForegroundColor Yellow
Start-Sleep -Seconds 5

# Verificar estado
Write-Host ""
Write-Host "📊 Estado de los servicios:" -ForegroundColor Cyan
docker compose ps

Write-Host ""
Write-Host "✅ ¡Listo! Aplicación corriendo en:" -ForegroundColor Green
Write-Host "   🌐 http://localhost:3000" -ForegroundColor White
Write-Host ""
Write-Host "📝 Comandos útiles:" -ForegroundColor Cyan
Write-Host "   Ver logs:      docker compose logs -f"
Write-Host "   Detener:       docker compose down"
Write-Host "   Reiniciar:     docker compose restart"
Write-Host ""
Write-Host "🧪 Probar API:" -ForegroundColor Cyan
Write-Host "   Invoke-WebRequest http://localhost:3000/users"
Write-Host "   Invoke-WebRequest http://localhost:3000/products"
