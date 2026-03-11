# The Pain Audit (Repositorio - Opción B)
#### Sergio Geovany García Smith.
#### Douglas Daniel Pérez Hernández.

# Friction Points Encountered

1. **[MISSING_DOC] PostgreSQL no mencionado en los requisitos previos**
   * **Problema:** El README solo lista `Node^8` y `npm`, pero la aplicación requiere PostgreSQL instalado y corriendo en el sistema. Un nuevo ingeniero no sabrá que necesita PostgreSQL hasta que la app crashee al intentar conectarse.
   * **Severidad:** BLOCKER — La app no puede iniciarse sin PostgreSQL.

2. **[IMPLICIT_DEP] Versión de PostgreSQL no especificada**
   * **Problema:** No se indica qué versión de PostgreSQL se necesita. El código usa características que podrían no estar disponibles en versiones muy antiguas de la base de datos.
   * **Severidad:** MEDIUM — Puede causar comportamiento inesperado o errores de sintaxis en queries.

3. **[ENV_GAP] Credenciales de base de datos hardcodeadas**
   * **Problema:** En `queries.js:3-8`, las credenciales están escritas directamente en el código:
     ```javascript
        const pool = new Pool({
            user: 'jhonatan',
            host: 'localhost',
            database: 'ebot',
            password: 'jhonatan',
            port: 5432
        });
     ```
     Un nuevo usuario no sabrá que debe cambiar estas credenciales o que debe crear un usuario en su máquina con ese nombre y contraseña específicos.
   * **Severidad:** BLOCKER — Si el usuario no tiene estas credenciales exactas, la app fallará al conectar a la base de datos.

4. **[MISSING_DOC] No hay instrucciones para inicializar la base de datos**
   * **Problema:** El archivo `init.sql` existe, pero el README no menciona que debe ejecutarse. Un nuevo ingeniero no sabrá que antes de correr la app debe:
     1. Crear el usuario de PostgreSQL.
     2. Crear la base de datos `ebot`.
     3. Ejecutar el script `init.sql`.
   * **Severidad:** BLOCKER — Sin las tablas creadas, todas las rutas de la API fallarán.

5. **[BROKEN_CMD] Error de sintaxis en el script SQL**
   * **Problema:** En `init.sql:27`, hay una coma extra que causa un error de sintaxis al intentar poblar la base de datos:
     ```sql
        CREATE TABLE categories(
            id SERIAL PRIMARY KEY,
            category_name VARCHAR(150) NOT NULL,
        );
     ```
   * **Severidad:** BLOCKER — El script SQL no se ejecutará correctamente, dejando la base de datos incompleta.

6. **[MISSING_DOC] Orden de ejecución de scripts SQL no documentado**
   * **Problema:** El `init.sql` contiene un `ALTER TABLE` al final que hace referencia a tablas que deben existir primero. No hay ninguna documentación o guía sobre el orden correcto de ejecución.
   * **Severidad:** MEDIUM — Puede causar errores si las tablas se crean en el orden equivocado.

7. **[ENV_GAP] No existe archivo `.env.example`**
   * **Problema:** Aunque existe un archivo `.env` (con solo `PORT=3000`), no hay un `.env.example` que documente qué variables de entorno son necesarias. Alguien que clone el repo no tendrá este archivo si está incluido en el `.gitignore`.
   * **Severidad:** MEDIUM — El `app.js` usará `process.env.PORT || 3000` por defecto, lo cual lo salva de romperse, pero la falta del archivo genera confusión.

8. **[MISSING_DOC] Falta de instrucciones de conexión a PostgreSQL**
   * **Problema:** No hay instrucciones sobre cómo crear el usuario de PostgreSQL, cómo configurar los permisos, ni cómo acceder a la terminal de `psql` para ejecutar los scripts necesarios.
   * **Severidad:** BLOCKER — Un nuevo ingeniero sin experiencia previa en la administración local de PostgreSQL estará completamente bloqueado.

9. **[SILENT_FAIL] Falso positivo de éxito al correr npm start**
   * **Problema:** El comando `npm start` ejecuta `node-sass main.scss main.css && nodemon app.js`. El compilador de Sass termina exitosamente dando la ilusión de que todo funciona, pero luego `nodemon` falla silenciosamente en el fondo si no hay conexión a la base de datos.
   * **Severidad:** MEDIUM — Los mensajes de error son confusos y el usuario puede perder tiempo creyendo que el problema es Sass.

10. **[MISSING_DOC] Puerto de la aplicación no especificado en el README**
    * **Problema:** Aunque el README lista las rutas disponibles (`/users`, `/products`, etc.), nunca menciona que se debe acceder a través de `http://localhost:3000` o que el puerto depende del archivo `.env`.
    * **Severidad:** LOW — Es inferible revisando el código, pero no es obvio para un principiante.

11. **[VERSION_HELL] Dependencia de una versión obsoleta de Node**
    * **Problema:** Se exige `Node^8`, el cual llegó a su fin de vida (EOL) en diciembre de 2019. Los usuarios con versiones modernas de Node.js (v16+) encontrarán conflictos graves de compatibilidad al instalar las dependencias.
    * **Severidad:** MEDIUM — Genera fricción inmediata al hacer `npm install`.

12. **[IMPLICIT_DEP] Uso de dependencias obsoletas (body-parser)**
    * **Problema:** Express 4.16+ ya incluye `body-parser` de forma nativa. El código lo importa explícitamente como una dependencia separada, lo que es código legacy y puede confundir al intentar actualizar el proyecto.
    * **Severidad:** LOW — Funciona, pero es código redundante y anticuado.

13. **[MISSING_DOC] Código comentado sin contexto (Favicon)**
    * **Problema:** En `app.js:19`, hay una línea comentada relacionada con un *favicon*, pero no hay comentarios que expliquen por qué se deshabilitó o si el archivo físico siquiera existe en el proyecto.
    * **Severidad:** LOW — Causa confusión menor al leer el código.

14. **[MISSING_DOC] Arquitectura del proyecto no explicada**
    * **Problema:** El README no aclara que esto es puramente una API REST backend sin interfaz frontend. Las rutas listadas no especifican que el retorno esperado es un JSON y no una vista HTML.
    * **Severidad:** LOW — Genera expectativas incorrectas sobre qué debería verse en el navegador al ejecutar la app.

15. **[MISSING_DOC] Variables de entorno inflexibles**
    * **Problema:** Las credenciales de la base de datos en `queries.js` deberían consumirse mediante variables de entorno (ej. `process.env.DB_USER`), pero están hardcodeadas. No hay guía sobre cómo cambiarlas sin alterar el código fuente.
    * **Severidad:** MEDIUM — Es una mala práctica de seguridad y hace que el entorno de desarrollo sea sumamente rígido.

16. **[MISSING_DOC] Propósito de la carpeta `db-lectures` desconocido**
    * **Problema:** Existe un directorio llamado `db-lectures` con varios archivos SQL en su interior, pero el README lo ignora por completo. El ingeniero no sabrá si son scripts vitales para la ejecución, datos de prueba o simplemente archivos de estudio.
    * **Severidad:** LOW — Causa duda y pérdida de tiempo al analizarlos.

17. **[BROKEN_CMD] Comandos redundantes en el README**
    * **Problema:** El README instruye ejecutar `npm run compile:sass`, pero `npm start` ya incluye la compilación de Sass. Seguir el README al pie de la letra hace que el usuario repita pasos innecesariamente.
    * **Severidad:** LOW — No rompe el sistema, pero confunde sobre el flujo de trabajo real.

18. **[MISSING_DOC] Barrera de idioma no documentada**
    * **Problema:** El código, variables o comentarios están en otro idioma, lo cual no está documentado en los requisitos del proyecto. Esto dificulta severamente el *onboarding* de un ingeniero que intente analizar la lógica de negocio sin hablar el idioma local del código.
    * **Severidad:** MEDIUM — Agrega carga cognitiva y retrasa la comprensión del sistema.

---

## Severity Summary

* **Total de puntos de fricción encontrados:** 18
