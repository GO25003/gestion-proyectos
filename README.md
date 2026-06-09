# Gestion de Proyectos - Oracle DB

Proyecto universitario de base de datos en Oracle para un sistema de gestion de proyectos. El repositorio modela categorias, proyectos, empleados, telefonos, tareas, recursos, asignaciones, documentos, riesgos e hitos. Tambien incorpora restricciones de integridad, procedimientos PL/SQL, triggers, auditoria, log de errores, seguridad por usuarios y una capa inicial de vistas/reportes.

## Estado Del Proyecto

**Estado academico: terminado para fines del proyecto de DPB135.**

El proyecto ya cuenta con modelo relacional, restricciones, procedimientos almacenados, triggers de auditoria e integridad, seguridad por roles y vistas de reporteria. Para efectos de la entrega academica de DPB135, los componentes principales estan completos y alineados entre si. Las tareas restantes se consideran mejoras o validaciones posteriores, no bloqueantes para la defensa del proyecto.

| Modulo | Estado | Avance |
| --- | --- | ---: |
| Modelo relacional y DDL | Implementado | 100% |
| Restricciones adicionales | Implementado | 95% |
| Procedimientos almacenados | Implementado | 95% |
| Triggers, auditoria y logs | Implementado | 95% |
| Seguridad, usuarios y permisos | Implementado | 95% |
| Vistas y reporteria | Implementado | 90% |
| Datos de prueba DML | Pendiente de carga formal | 0% |
| Portal/API de reportes | Estructura inicial | 35% |
| Pruebas integrales en Oracle | Pendiente de evidencia final | 60% |

## Tecnologias

![Oracle](https://img.shields.io/badge/Oracle-Database-F80000?style=for-the-badge&logo=oracle&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-DDL%20%7C%20DML-336791?style=for-the-badge)
![PLSQL](https://img.shields.io/badge/PL%2FSQL-Procedures%20%26%20Triggers-2F4F4F?style=for-the-badge)
![Docker](https://img.shields.io/badge/Docker-Containerization-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Git](https://img.shields.io/badge/Git-Version%20Control-F05032?style=for-the-badge&logo=git&logoColor=white)

- **Oracle Database:** motor relacional principal.
- **SQL DDL:** definicion de tablas, llaves primarias, llaves foraneas y restricciones.
- **PL/SQL:** procedimientos almacenados, excepciones, triggers, auditoria y logs.
- **Oracle Security:** usuarios, cuotas y privilegios.
- **Docker:** estructura inicial para portal/API de reportes.
- **Git:** control de versiones del proyecto.

## Estructura Del Repositorio

```text
gestion-proyectos/
|-- ddl (Estructura de base de datos)/
|   |-- 01_ddl.sql
|   `-- 01_1alter_table.sql
|-- dml (inserts)/
|-- procedimientos/
|   `-- 07_procedimientos.sql
|-- triggers/
|   `-- 08_triggers.sql
|-- seguridad (roles y permisos)/
|   `-- 09_seguridad.sql
|-- vistas_y_reportes/
|   |-- README.md
|   |-- 04_agregados.sql
|   |-- 05_subconsultas.sql
|   `-- 06_vistas.sql
|-- vistas_y_reportes_portal_web/
|   |-- Dockerfile
|   `-- docker-compose.yml
|-- index.html
`-- README.md
```

## Modelo Relacional

El archivo `ddl (Estructura de base de datos)/01_ddl.sql` define las tablas principales:

- `categoria`
- `proyecto`
- `empleado`
- `telefono`
- `tarea`
- `recurso`
- `asignacion`
- `documento`
- `riesgo`
- `hito`

El modelo incluye restricciones `PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, `NOT NULL`, `CHECK` y reglas `ON DELETE CASCADE` para proteger la integridad referencial.

## Restricciones Adicionales

El archivo `ddl (Estructura de base de datos)/01_1alter_table.sql` agrega validaciones complementarias:

- nombres sin espacios vacios,
- formato de correo,
- formato de telefono,
- consistencia de fechas,
- validaciones adicionales por entidad.

Este script debe ejecutarse despues de crear las tablas base.

## Procedimientos Almacenados

El archivo `procedimientos/07_procedimientos.sql` contiene procedimientos PL/SQL para analisis y control operativo:

- `sp_resumen_periodo`: genera un resumen gerencial por rango de fechas.
- `sp_top_elementos`: muestra rankings de empleados, proyectos y categorias.
- `sp_indicadores_categoria`: calcula indicadores por categoria comparando periodos.
- `sp_alertas_negocio`: genera alertas sobre proyectos, tareas, empleados e hitos.

Los procedimientos usan `log_errores` y `seq_log_errores` para registrar excepciones controladas.

## Triggers Y Auditoria

El archivo `triggers/08_triggers.sql` implementa:

- `auditoria_proyecto`
- `log_errores`
- `auditoria_log`
- `seq_auditoria`
- `seq_log_errores`
- `seq_auditoria_log`
- `trg_auditoria_log_errores`
- `trg_auditoria_proyecto`
- `trg_integridad_horas_empleado`

El trigger `trg_integridad_horas_empleado` controla que un empleado no supere 40 horas activas asignadas. Para esta regla de capacidad debe usarse `horas_estimadas`, porque representa planificacion/asignacion antes de registrar el trabajo real.

## Vistas Y Reporteria

La carpeta `vistas_y_reportes/` contiene consultas avanzadas y vistas:

- `04_agregados.sql`: consultas agregadas e indicadores. Conserva deudas tecnicas conocidas y no se considera parte del flujo estable.
- `05_subconsultas.sql`: subconsultas y filtros avanzados.
- `06_vistas.sql`: vistas de abstraccion y vista materializada.

Vistas principales:

- `v_reporte_tareas`: control operativo de tareas segun fecha de entrega.
- `v_dashboard_empleados`: carga laboral del personal.
- `mv_resumen_gerencial_proyectos`: resumen gerencial materializado.

## Seguridad

El archivo `seguridad (roles y permisos)/09_seguridad.sql` implementa una politica de usuarios alineada con la consigna academica.

### Usuarios

| Usuario | Rol | Puede acceder a | No debe acceder a |
| --- | --- | --- | --- |
| `usr_lectura` | Solo lectura / consultas | `SELECT` sobre tablas del negocio y vistas | Tablas de auditoria, procedimientos almacenados, funciones, triggers; no puede hacer `INSERT`, `UPDATE` ni `DELETE` |
| `usr_admin` | Administracion / PL/SQL | `EXECUTE` sobre procedimientos; `SELECT` y DML sobre logs/auditoria | No debe modificar estructura de tablas ni recibir permisos DDL |

### Requisitos Cubiertos

- Creacion de usuarios con `CREATE USER`.
- Asignacion de cuota con `ALTER USER ... QUOTA UNLIMITED ON USERS`.
- Privilegio de conexion con `GRANT CREATE SESSION`.
- `GRANT SELECT` sobre tablas del negocio para `usr_lectura`.
- `GRANT EXECUTE` sobre procedimientos para `usr_admin`.
- Permisos DML controlados sobre `log_errores` para `usr_admin`.

### Pruebas Recomendadas

Conectado como `usr_lectura`, debe funcionar:

```sql
SELECT * FROM esquema.proyecto;
SELECT * FROM esquema.tarea;
SELECT * FROM nombre_esquema.recurso;
SELECT * FROM nombre_esquema.v_dashboard_empleados;
SELECT * FROM nombre_esquema.v_reporte_tareas;
```

Conectado como `usr_lectura`, debe fallar:

```sql
INSERT INTO nombre_esquema.proyecto (...) VALUES (...);
UPDATE nombre_esquema.proyecto SET nombre_proyecto = 'TEST';
DELETE FROM nombre_esquema.proyecto WHERE id_proyecto = 1;
EXEC nombre_esquema.sp_alertas_negocio(7);
```

Conectado como `usr_admin`, debe funcionar:

```sql
SELECT * FROM nombre_esquema.log_errores;
EXEC nombre_esquema.sp_alertas_negocio(7);
EXEC nombre_esquema.sp_resumen_periodo(DATE '2026-01-01', DATE '2026-12-31');
```

Conectado como `usr_admin`, debe fallar:

```sql
CREATE TABLE prueba (id NUMBER);
ALTER TABLE nombre_esquema.proyecto ADD columna_prueba NUMBER;
DROP TABLE nombre_esquema.proyecto;
```

> `nombre_esquema` debe reemplazarse por el usuario propietario real de las tablas, procedimientos y vistas cuando el equipo defina el nombre definitivo.

## Portal/API De Reportes

La carpeta `vistas_y_reportes_portal_web/` contiene una estructura inicial para exponer informacion de reporteria mediante servicios web:

- `Dockerfile`
- `docker-compose.yml`

Esta capa esta planteada como base para una futura API conectada a Oracle Database.

## Orden Sugerido De Ejecucion

1. Ejecutar `ddl (Estructura de base de datos)/01_ddl.sql`.
2. Ejecutar `ddl (Estructura de base de datos)/01_1alter_table.sql`.
3. Ejecutar `triggers/08_triggers.sql`.
4. Ejecutar `procedimientos/07_procedimientos.sql`.
5. Ejecutar `vistas_y_reportes/05_subconsultas.sql` cuando existan datos de prueba.
6. Ejecutar `vistas_y_reportes/06_vistas.sql`.
7. Ejecutar `seguridad (roles y permisos)/09_seguridad.sql` desde el usuario correspondiente.
8. Agregar y ejecutar scripts DML cuando esten disponibles.

## Criterio De Estados De Tarea

`estado_tarea` debe representar el flujo operativo de la tarea:

- `POR INICIAR`
- `EN DESARROLLO`
- `EN PAUSA`
- `FINALIZADO`

Los estados calculados por fecha, como `SIN FECHA`, `RETRASADO`, `PROXIMO` y `EN TIEMPO`, deben vivir en vistas como `v_reporte_tareas`, no en la tabla base.

## Criterio De Uso De Horas

El modelo distingue dos columnas:

- `horas_estimadas`: horas planificadas o asignadas.
- `horas_reales`: horas efectivamente trabajadas.

| Caso | Columna recomendada |
| --- | --- |
| Capacidad del empleado | `horas_estimadas` |
| Alertas de sobreasignacion | `horas_estimadas` |
| Planificacion de carga laboral | `horas_estimadas` |
| Pagos | `horas_reales` |
| Horas extras | `horas_reales` |
| Bonificaciones | `horas_reales` |
| Costo real del proyecto | `horas_reales` |
| Comparativo planificado vs ejecutado | `horas_estimadas` y `horas_reales` |

## Pendientes Posteriores A La Entrega

- Crear scripts formales de insercion en `dml (inserts)/`.
- Generar evidencias de ejecucion en Oracle SQL Developer o SQL*Plus.
- Robustecer la reejecucion de scripts con bloques que ignoren objetos inexistentes o ya creados.
- Crear procedimientos separados para pagos, horas extras y bonificaciones usando `horas_reales`.
- Documentar evidencias de ejecucion, capturas o resultados de pruebas.
- Revisar credenciales hardcodeadas antes de usar el proyecto fuera de un entorno academico/local.

## Ultima Actualizacion

2026-06-08
