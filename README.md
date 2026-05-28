# gestion-proyectos
Proyecto universitario de base de datos en oracle
# Gestion de Proyectos - Oracle DB

Repositorio de base de datos para un sistema de gestion de proyectos. El proyecto
modela categorias, proyectos, empleados, tareas, asignaciones, documentos, riesgos
e hitos, incorporando reglas de integridad, procedimientos PL/SQL, auditoria,
registro de errores y configuracion basica de seguridad para DB.

## Estado del proyecto

**Avance general estimado: 78%**

El porcentaje se calcula a partir de los artefactos disponibles en el repositorio:
estructura relacional, reglas de negocio, procedimientos, triggers y seguridad.
Quedan pendientes los scripts de datos de prueba, vistas analiticas y validacion
integral en una instancia Oracle.

| Modulo | Estado | Avance |
| --- | --- | ---: |
| Modelo relacional y DDL | Implementado | 95% |
| Restricciones e integridad referencial | Implementado | 90% |
| Procedimientos almacenados | Implementado | 85% |
| Triggers, auditoria y logs | Implementado | 80% |
| Seguridad, usuarios y permisos | Implementado base | 75% |
| Datos de prueba DML | Pendiente | 0% |
| Vistas/reporteria | Pendiente | 0% |
| Pruebas de ejecucion integrales | Pendiente parcial | 35% |

## Tecnologias en uso

![Oracle](https://img.shields.io/badge/Oracle-Database-F80000?style=for-the-badge&logo=oracle&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-DDL%20%7C%20DML-336791?style=for-the-badge)
![PLSQL](https://img.shields.io/badge/PL%2FSQL-Procedures%20%26%20Triggers-2F4F4F?style=for-the-badge)
![Git](https://img.shields.io/badge/Git-Version%20Control-F05032?style=for-the-badge&logo=git&logoColor=white)

- **Oracle Database:** motor relacional principal del proyecto.
- **SQL DDL:** definicion de tablas, llaves primarias, llaves foraneas y restricciones.
- **PL/SQL:** procedimientos almacenados, manejo de excepciones, triggers y auditoria.
- **Oracle Security:** usuarios, cuotas y privilegios por perfil.
- **Git:** control de versiones del repositorio.

## Estructura del repositorio

```text
gestion-proyectos/
|-- ddl (Estructura de base de datos)/
|   |-- 01_ddl.sql
|   `-- 01_1alter_table.sql
|-- procedimientos/
|   `-- 07_procedimientos.sql
|-- triggers/
|   `-- 08_triggers.sql
|-- seguridad (roles y permisos)/
|   `-- 09_seguridad.sql
|-- dml (inserts)/
|-- vistas/
`-- README.md
```

## Componentes implementados

### Modelo relacional

El archivo `ddl (Estructura de base de datos)/01_ddl.sql` define las entidades
principales del sistema:

- `categoria`
- `proyecto`
- `empleado`
- `telefono`
- `tarea`
- `asignacion`
- `documento`
- `riesgo`
- `hito`

Incluye restricciones `PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, `NOT NULL`,
`CHECK` y reglas `ON DELETE CASCADE` para evitar registros huerfanos.

### Procedimientos almacenados

El archivo `procedimientos/07_procedimientos.sql` contiene procedimientos PL/SQL
orientados a analisis y control operativo:

- `sp_resumen_periodo`: genera un resumen gerencial por rango de fechas.
- `sp_top_elementos`: muestra rankings de empleados, proyectos y categorias.
- `sp_indicadores_categoria`: calcula indicadores por categoria con comparativo.
- `sp_alertas_negocio`: genera alertas operativas de tareas, proyectos e hitos.

### Triggers y auditoria

El archivo `triggers/08_triggers.sql` implementa:

- Tabla y secuencia para auditoria de proyectos.
- Tabla y secuencia para registro de errores.
- Tabla y secuencia para auditoria del log de errores.
- Trigger de auditoria sobre `log_errores`.
- Trigger de auditoria sobre `proyecto`.
- Trigger de integridad para limitar horas activas por empleado.

### Seguridad

El archivo `seguridad (roles y permisos)/09_seguridad.sql` define una base de
seguridad para Oracle:

- Usuario de solo lectura: `c##usr_lectura`.
- Usuario administrador de procedimientos y logs: `c##usr_admin`.
- Privilegios `CREATE SESSION`, `SELECT`, `EXECUTE` y permisos DML controlados
  sobre logs.

## Orden sugerido de ejecucion

1. Ejecutar `ddl (Estructura de base de datos)/01_ddl.sql`.
2. Ejecutar `triggers/08_triggers.sql`.
3. Ejecutar `procedimientos/07_procedimientos.sql`.
4. Ejecutar `seguridad (roles y permisos)/09_seguridad.sql` desde un usuario con
   privilegios suficientes.
5. Agregar y ejecutar scripts DML cuando esten disponibles.
6. Agregar y ejecutar vistas/reportes cuando esten disponibles.

## Pendientes

- Crear scripts de insercion en `dml (inserts)/`.
- Crear vistas analiticas en `vistas/`.
- Validar el orden de ejecucion completo en Oracle SQL Developer o SQL*Plus.
- Agregar consultas de prueba para procedimientos y triggers.
- Documentar capturas o evidencias de ejecucion.
- Revisar credenciales hardcodeadas antes de usar el proyecto fuera de un entorno
  academico o local.

## Ultima actualizacion

2026-05-28
