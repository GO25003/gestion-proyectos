-- =====================================================================
---- ARCHIVO: 10_configurar_directorio_backup.sql
-- DESCRIPCION:
--   Prepara el objeto DIRECTORY que Oracle Data Pump usa para guardar
--   y leer los archivos .dmp y .log de backup.
--
-- EJECUTAR COMO:
--   SYSTEM o un usuario con privilegio CREATE ANY DIRECTORY.
--
-- IMPORTANTE:
--   La ruta debe existir en el servidor donde corre Oracle, no
--   necesariamente en la computadora cliente donde se ejecuta SQL Developer.
--   Si Oracle está en Docker, usar una ruta dentro del contenedor o un
--   volumen montado.
-- =====================================================================

-- 1. Crear la carpeta física antes de ejecutar este script.
--    En mi caso (Windows local), tú reemplazala por la tuya o la ruta que corresponda en tu entorno de Oracle:
--    C:\Users\Uber\gestion-proyectos\backup_y_restauracion

CREATE OR REPLACE DIRECTORY GP_BACKUP_DIR AS 'C:\Users\Uber\gestion-proyectos\backup_y_restauracion';

-- 2. Otorgar permisos al usuario que va a ejecutar los backups/restauraciones.
GRANT READ, WRITE ON DIRECTORY GP_BACKUP_DIR TO gestionproyectosdpb;

-- 3. Verificación recomendada:

SELECT directory_name, directory_path
FROM all_directories
WHERE directory_name = 'GP_BACKUP_DIR';

-- =====================================================================
-- FIN DEL SCRIPT