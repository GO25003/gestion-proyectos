-- =====================================================================
-- ARCHIVO: 08_seguridad.sql
-- DESCRIPCIÓN: Configuración de usuarios, cuotas y privilegios.
-- REFERENCIA: image_e733ac.png
-- =====================================================================

-- NOTA: Si estás utilizando Oracle 12c, 18c, 19c o 21c/23c con arquitectura 
-- Multitenant (CDB/PDB) y estás en la raíz, recuerda anteponer "C##" a los usuarios 
-- o ejecutar: ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

-- =====================================================================
-- 1. CREACIÓN DE USUARIOS Y ASIGNACIÓN DE CUOTAS
-- =====================================================================

-- Creación del usuario de solo lectura
CREATE USER c##usr_lectura IDENTIFIED BY "Lectura2026#";

-- Creación del usuario administrador de PL/SQL
CREATE USER c##usr_admin IDENTIFIED BY "Admin2026#";

-- Asignación de cuota ilimitada en el tablespace USERS
ALTER USER c##usr_lectura QUOTA UNLIMITED ON USERS;
ALTER USER c##usr_admin QUOTA UNLIMITED ON USERS;


-- =====================================================================
-- 2. OTORGAMIENTO DE PRIVILEGIOS DE CONEXIÓN
-- =====================================================================

GRANT CREATE SESSION TO c##usr_lectura;
GRANT CREATE SESSION TO c##usr_admin;


-- =====================================================================
-- 3. PRIVILEGIOS PARA: usr_lectura
-- (SELECT sobre tablas de negocio y ejecución de VIEWS)
-- =====================================================================

-- Tablas del negocio principales
GRANT SELECT ON proyecto TO c##usr_lectura;
GRANT SELECT ON tarea TO c##usr_lectura;
GRANT SELECT ON asignacion TO c##usr_lectura;
GRANT SELECT ON empleado TO c##usr_lectura;
GRANT SELECT ON categoria TO c##usr_lectura;
GRANT SELECT ON documento TO c##usr_lectura;
GRANT SELECT ON riesgo TO c##usr_lectura;
GRANT SELECT ON hito TO c##usr_lectura;

-- Ejecución de Vistas (VIEWS) si posees vistas en tu esquema
-- Reemplazar 'nombre_de_tu_vista' por las que tengas creadas, por ejemplo:
-- GRANT SELECT ON vista_resumen_proyectos TO usr_lectura;

-- NOTA DE CONTROL: Al no otorgarle GRANT EXECUTE sobre los procedimientos,
-- ni privilegios DML (INSERT/UPDATE/DELETE), se cumple la restricción de la imagen.


-- =====================================================================
-- 4. PRIVILEGIOS PARA: usr_admin
-- (EXECUTE sobre SPs/Funciones, SELECT y DML sobre auditoría y logs)
-- =====================================================================

-- CAMBIAR c##PROYECTOS POR EL USUARIO CON EL QUE SE HAYA CREADO LA TABLA LOG ERRORES
-- ES RECOMENDABLE HACERLO LOGEADO DESDE SYSTEM, PARA AVERIGUAR QUE USUARIO CREO LA TABLA LOG_ERRORES, PODEMOS EJECUTAR LA SIGUIENTE CONSULTA
-- SELECT owner, table_name 
-- FROM all_tables 
-- WHERE table_name LIKE '%LOG_ERRORES%';


GRANT SELECT, INSERT, UPDATE, DELETE ON c##PROYECTOS.log_errores TO c##usr_admin;
-- GRANT SELECT, INSERT, UPDATE, DELETE ON tabla_auditoria TO usr_admin; -- (Agregar si existe otra)

-- Privilegios EXECUTE sobre cada procedimiento almacenado
GRANT EXECUTE ON sp_resumen_periodo TO c##usr_admin;
GRANT EXECUTE ON sp_top_elementos TO c##usr_admin;
GRANT EXECUTE ON sp_indicadores_categoria TO c##usr_admin;
GRANT EXECUTE ON sp_alertas_negocio TO c##usr_admin;

-- NOTA DE CONTROL: No se le otorga ningún privilegio DDL (CREATE, ALTER, DROP), 
-- cumpliendo la restricción de que "No puede modificar la estructura de tablas".


-- =====================================================================
-- 5. DEMOSTRACIÓN DE ACCESO / PRUEBAS DE PRIVILEGIOS
-- =====================================================================

/*
  INSTRUCCIONES DE PRUEBA EN SQL DEVELOPER:
  
  Paso 1: Crea una nueva conexión en SQL Developer apuntando a tu base de datos
          usando las credenciales del usuario creado: usr_lectura / Lectura2026#
          
  Paso 2: Desde la hoja de trabajo de 'usr_lectura', ejecuta las siguientes consultas
          para verificar el error de privilegio insuficiente.
*/

-- A. Esta consulta DEBE funcionar correctamente (Lectura autorizada):
-- SELECT * FROM nombre_del_esquema_propietario.proyecto;

-- B. Intentar ejecutar un procedimiento almacenado (DEBE DAR ERROR ORA-00904 o ORA-01031):
-- EXEC nombre_del_esquema_propietario.sp_alertas_negocio(7);

-- C. Intentar insertar datos en una tabla de negocio (DEBE DAR ERROR ORA-01031: privilegios insuficientes):
-- INSERT INTO nombre_del_esquema_propietario.proyecto (id_proyecto, nombre_proyecto) VALUES (999, 'Proyecto Intruso');

*/