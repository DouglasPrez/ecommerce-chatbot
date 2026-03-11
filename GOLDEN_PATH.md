# GOLDEN_PATH - Ecommerce Chatbot
**Autores:** Sergio Geovany García Smith & Douglas Daniel Pérez Hernández

---

## 🎯 Objetivo

Este documento describe los artefactos creados para eliminar todos los puntos de fricción identificados en el `PAIN_LOG.md`, transformando un proceso de onboarding caótico en una experiencia fluida y automatizada.

---

## 🛠️ Artefactos Creados

Se crearon los siguientes artefactos para resolver los 18 puntos de fricción identificados:

### 1. `docker-compose.yml`
Elimina la necesidad de instalar y configurar PostgreSQL manualmente. Incluye:
- Servicio de PostgreSQL 14 con healthchecks.
- Servicio de la aplicación Node.js.
- Volúmenes persistentes para datos.
- Ejecución automática de `init.sql` al crear el contenedor.
- Red interna para comunicación entre servicios.

### 2. `Dockerfile`
Define el entorno de ejecución:
- Imagen base Node 14 Alpine (ligera).
- Instalación automática de dependencias.
- Compilación de Sass.
- Configuración de directorio de trabajo en el contenedor.

### 3. `.env.example`
Documenta todas las variables de entorno necesarias:
- `PORT` (puerto de la aplicación).
- `DB_USER`, `DB_PASSWORD`, `DB_HOST`, `DB_NAME`, `DB_PORT` (configuración de PostgreSQL).
- `NODE_ENV` (entorno de ejecución).
- Comentarios *inline* explicando cada variable y sus valores válidos.

### 4. `.nvmrc`
Especifica la versión exacta de Node.js requerida (14.21.3).

### 5. `setup.sh`
Script bash automatizado que:
- Verifica la versión de Node.js (con mensajes claros si falla).
- Verifica `npm`.
- Crea `.env` desde `.env.example`.
- Detecta si PostgreSQL está instalado localmente.
- Instala dependencias npm y compila Sass.
- Verifica la estructura de carpetas.
- Proporciona instrucciones claras de próximos pasos con códigos de color para éxito/error/advertencia.

### 6. `Makefile`
Comandos simplificados para operaciones comunes:
- `make help` - Lista todos los comandos disponibles.
- `make setup` - Ejecuta el script de configuración completo.
- `make docker-up` - Inicia el stack completo con Docker.
- `make docker-down` - Detiene los servicios Docker.
- `make docker-logs` - Muestra logs en tiempo real.
- `make docker-reset` - Reset completo (borra volúmenes).
- `make install` - Instala dependencias.
- `make db-init` - Inicializa la base de datos (local).
- `make db-reset` - Resetea la base de datos (⚠️ destructivo).
- `make start` - Inicia la aplicación.
- `make clean` - Limpia `node_modules` y compilados.

### 7. `db/init-fixed.sql`
Versión corregida del script SQL original:
- ✅ Eliminada coma extra en tabla `categories`.
- Agregado `CREATE TABLE IF NOT EXISTS` para idempotencia.
- Agregado `ALTER TABLE ... IF NOT EXISTS` para evitar errores en re-ejecuciones.
- Comentada la línea `CREATE DATABASE` (debe ejecutarse fuera del script).
- Mejorado el tipo de dato de `card_number` (`BIGINT` en lugar de `INT`).

### 8. `db/queries.js` (Actualizado)
- Usa variables de entorno en lugar de credenciales *hardcodeadas*.
- Manejo de errores de conexión mejorado con mensajes claros y accionables.
- Verificación de conexión al iniciar.
- Respuestas HTTP apropiadas (500 en errores de query).

### 9. `README_IMPROVED.md`
README completamente reescrito con:
- Descripción clara de qué es el proyecto (API backend, no frontend).
- Requisitos previos detallados (con versiones específicas).
- Instrucciones de instalación para Docker y manual.
- Lista completa de rutas API con tabla y ejemplos de uso con `curl`.
- Sección de *troubleshooting*.
- Estructura de base de datos y variables de entorno documentadas.

---

## 📊 Tabla de Mapeo: Pain Point → Solución

| # | Pain Point | Artefacto(s) que lo Solucionan | Estado |
|---|-----------|-------------------------------|---------|
| 1 | `[MISSING_DOC]` PostgreSQL no mencionado | `docker-compose.yml`, `README_IMPROVED.md` | ✅ Fixed |
| 2 | `[IMPLICIT_DEP]` Versión PostgreSQL no especificada | `docker-compose.yml` (postgres:14-alpine), `README_IMPROVED.md` | ✅ Fixed |
| 3 | `[ENV_GAP]` Credenciales hardcodeadas | `db/queries.js` (actualizado), `.env.example` | ✅ Fixed |
| 4 | `[MISSING_DOC]` No hay instrucciones para init DB | `setup.sh`, `Makefile` (db-init), `docker-compose.yml` (auto-init), `README_IMPROVED.md` | ✅ Fixed |
| 5 | `[BROKEN_CMD]` Error sintaxis SQL | `db/init-fixed.sql` | ✅ Fixed |
| 6 | `[MISSING_DOC]` Orden de scripts SQL | `db/init-fixed.sql` (orden corregido), `README_IMPROVED.md` | ✅ Fixed |
| 7 | `[ENV_GAP]` No existe .env.example | `.env.example` creado con doc. completa | ✅ Fixed |
| 8 | `[MISSING_DOC]` Cómo conectarse a PostgreSQL | `setup.sh` (detecta e instruye), `README_IMPROVED.md` | ✅ Fixed |
| 9 | `[SILENT_FAIL]` npm start falla silenciosamente | `db/queries.js` (errores claros), `setup.sh` (verifica todo) | ✅ Fixed |
| 10 | `[MISSING_DOC]` Puerto no especificado | `.env.example`, `README_IMPROVED.md` | ✅ Fixed |
| 11 | `[VERSION_HELL]` Node^8 obsoleto | `.nvmrc`, `Dockerfile`, `README_IMPROVED.md` | ✅ Fixed |
| 12 | `[IMPLICIT_DEP]` body-parser redundante | `README_IMPROVED.md` (como mejora pendiente) | ⚠️ Partial |
| 13 | `[MISSING_DOC]` Favicon comentado sin contexto | N/A (código legacy existente) | 🔵 Out Scope |
| 14 | `[MISSING_DOC]` Arquitectura no explicada | `README_IMPROVED.md` (sección "¿Qué es?") | ✅ Fixed |
| 15 | `[MISSING_DOC]` Variables entorno inflexibles | `db/queries.js` (actualizado), `.env.example` | ✅ Fixed |
| 16 | `[MISSING_DOC]` Carpeta db-lectures sin explicar | `README_IMPROVED.md` (nota aclaratoria) | ⚠️ Partial |
| 17 | `[BROKEN_CMD]` Comandos redundantes README | `README_IMPROVED.md` (flujo claro), `Makefile` | ✅ Fixed |
| 18 | `[MISSING_DOC]` Barrera de idioma | `README_IMPROVED.md` (español), comentarios mejorados | ⚠️ Partial |

### Leyenda
- ✅ **Fixed:** Completamente resuelto por artefactos.
- ⚠️ **Partial:** Parcialmente resuelto, requiere acciones adicionales del desarrollador.
- 🔵 **Out of Scope:** No requiere solución técnica o es código legacy aceptable.
