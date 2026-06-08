# Gestión de Proyectos - Oracle DB (leer antes de defensa, importante !)

Proyecto universitario de base de datos en Oracle para un sistema de gestión de proyectos. El repositorio modela categorías, proyectos, empleados, tareas, recursos, asignaciones, documentos, riesgos e hitos, incorporando reglas de integridad, procedimientos PL/SQL, triggers, auditoría, registro de errores, seguridad y una capa inicial de reportería.

---

## Estado del proyecto

**Avance general estimado: 82%**

El proyecto ya cuenta con una estructura relacional amplia, procedimientos almacenados, triggers de auditoría e integridad, configuración básica de seguridad y scripts de vistas/reportes. Aún quedan pendientes la carga de datos DML, la validación integral en Oracle y la alineación final de algunos nombres de columnas entre DDL, procedimientos y vistas.

| Módulo | Estado | Avance |
|---------|---------|---------:|
| Modelo relacional y DDL | Implementado con ajustes pendientes | 90% |
| Restricciones e integridad referencial | Implementado | 90% |
| Procedimientos almacenados | Implementado con validación pendiente | 85% |
| Triggers, auditoría y logs | Implementado con ajustes menores | 85% |
| Seguridad, usuarios y permisos | Implementado base | 75% |
| Vistas y reportería | En desarrollo | 60% |
| Datos de prueba DML | Pendiente | 0% |
| Portal/API de reportes | Estructura inicial | 35% |
| Pruebas integrales en Oracle | Pendiente parcial | 35% |

---

## Tecnologías en uso

![Oracle](https://img.shields.io/badge/Oracle-Database-F80000?style=for-the-badge&logo=oracle&logoColor=white)

![SQL](https://img.shields.io/badge/SQL-DDL%20%7C%20DML-336791?style=for-the-badge)

![PLSQL](https://img.shields.io/badge/PL%2FSQL-Procedures%20%26%20Triggers-2F4F4F?style=for-the-badge)

![Docker](https://img.shields.io/badge/Docker-Containerization-2496ED?style=for-the-badge&logo=docker&logoColor=white)

![Git](https://img.shields.io/badge/Git-Version%20Control-F05032?style=for-the-badge&logo=git&logoColor=white)

### Herramientas principales

- **Oracle Database:** motor relacional principal.
- **SQL DDL:** definición de tablas, llaves primarias, llaves foráneas y restricciones.
- **PL/SQL:** procedimientos almacenados, excepciones, triggers, auditoría y logs.
- **Oracle Security:** usuarios, cuotas y privilegios.
- **Docker:** estructura inicial para portal/API de reportes.
- **Git:** control de versiones del proyecto.

---

## Estructura del repositorio

```text
gestion-proyectos/
│
├── ddl (Estructura de base de datos)/
│   ├── 01_ddl.sql
│   └── 01_1alter_table.sql
│
├── dml (inserts)/
│   └── .gitkeep
│
├── procedimientos/
│   └── 07_procedimientos.sql
│
├── triggers/
│   └── 08_triggers.sql
│
├── seguridad (roles y permisos)/
│   └── 09_seguridad.sql
│
├── vistas_y_reportes/
│   ├── README.md
│   ├── 04_agregados.sql
│   ├── 05_subconsultas.sql
│   └── 06_vistas.sql
│
├── vistas_y_reportes_portal_web/
│   ├── Dockerfile
│   └── docker-compose.yml
│
├── index.html
└── README.md
```

---

# Componentes implementados

## Modelo relacional

El archivo:

```text
ddl (Estructura de base de datos)/01_ddl.sql
```

define las entidades principales del sistema:

- categoria
- proyecto
- empleado
- telefono
- tarea
- recurso
- asignacion
- documento
- riesgo
- hito

Incluye restricciones:

- PRIMARY KEY
- FOREIGN KEY
- UNIQUE
- NOT NULL
- CHECK
- ON DELETE CASCADE

para mantener integridad referencial y evitar registros huérfanos.

---

## Restricciones adicionales

El archivo:

```text
ddl (Estructura de base de datos)/01_1alter_table.sql
```

agrega validaciones adicionales sobre:

- nombres
- fechas
- correo electrónico
- campos obligatorios

Estas restricciones complementan el DDL principal y deben ejecutarse después de crear las tablas base.

---

## Procedimientos almacenados

El archivo:

```text
procedimientos/07_procedimientos.sql
```

contiene procedimientos PL/SQL orientados a análisis gerencial y control operativo.

### Procedimientos implementados

#### sp_resumen_periodo

Genera un resumen gerencial por rango de fechas.

#### sp_top_elementos

Muestra rankings de:

- empleados
- proyectos
- categorías

#### sp_indicadores_categoria

Calcula indicadores por categoría con comparativo entre períodos.

#### sp_alertas_negocio

Genera alertas operativas sobre:

- proyectos
- tareas
- empleados
- hitos

Los procedimientos utilizan:

```text
log_errores
seq_log_errores
```

para registrar excepciones controladas.

---

## Triggers y auditoría

El archivo:

```text
triggers/08_triggers.sql
```

implementa:

### Tablas

- auditoria_proyecto
- log_errores
- auditoria_log

### Secuencias

- seq_auditoria
- seq_log_errores
- seq_auditoria_log

### Triggers

#### trg_auditoria_log_errores

Audita inserciones en el log de errores.

#### trg_auditoria_proyecto

Registra cambios relevantes en proyectos.

#### trg_integridad_horas_empleado

Controla que un empleado no acumule más de 40 horas activas asignadas.

Para esta regla de capacidad se recomienda utilizar:

```text
horas_estimadas
```

ya que representa planificación/asignación previa a la ejecución real.

---

## Vistas y reportería

La carpeta:

```text
vistas_y_reportes/
```

contiene consultas avanzadas y vistas para análisis.

### Archivos

#### 04_agregados.sql

Consultas agregadas e indicadores.

#### 05_subconsultas.sql

Subconsultas y filtros avanzados.

#### 06_vistas.sql

Vistas de abstracción y vista materializada para reporting.

### Vistas principales

#### v_reporte_tareas

Vista de control operativo de tareas y retrasos.

#### v_dashboard_empleados

Vista de carga laboral del personal.

#### mv_resumen_gerencial_proyectos

Vista materializada para reportería ejecutiva.

---

## Seguridad

El archivo:

```text
seguridad (roles y permisos)/09_seguridad.sql
```

define una configuración base de seguridad.

### Usuarios

#### c##usr_lectura

Usuario de solo lectura.

#### c##usr_admin

Usuario administrador de procedimientos y logs.

### Privilegios

- CREATE SESSION
- SELECT
- EXECUTE
- permisos DML controlados sobre logs

> **Nota:** Las credenciales incluidas son académicas/de prueba. No deben utilizarse sin modificaciones en entornos reales.

---

## Portal/API de reportes

La carpeta:

```text
vistas_y_reportes_portal_web/
```

contiene una estructura inicial para exponer información mediante servicios web.

### Componentes

- Dockerfile
- docker-compose.yml

Esta capa está pensada como base para una futura API conectada a Oracle Database.

---

# Orden sugerido de ejecución

1. Ejecutar:

```text
ddl (Estructura de base de datos)/01_ddl.sql
```

2. Ejecutar:

```text
ddl (Estructura de base de datos)/01_1alter_table.sql
```

3. Ejecutar:

```text
triggers/08_triggers.sql
```

4. Ejecutar:

```text
procedimientos/07_procedimientos.sql
```

5. Ejecutar:

```text
vistas_y_reportes/05_subconsultas.sql
```

cuando existan datos de prueba.

6. Ejecutar:

```text
vistas_y_reportes/06_vistas.sql
```

7. Ejecutar:

```text
seguridad (roles y permisos)/09_seguridad.sql
```

desde un usuario con privilegios suficientes.

8. Agregar y ejecutar scripts DML cuando estén disponibles.

> **Nota:** `04_agregados.sql` conserva deudas técnicas conocidas y debe revisarse antes de considerarlo parte del flujo estable.

---

# Pendientes técnicos conocidos

- Crear scripts de inserción en `dml (inserts)/`.
- Validar integralmente todos los scripts en Oracle SQL Developer o SQL*Plus.
- Alinear el nombre definitivo de la fecha de hito entre DDL, procedimientos y vistas.
- Revisar referencias restantes a columnas antiguas en vistas y reportes.
- Ajustar la vista materializada para utilizar:

```sql
estado_tarea = 'FINALIZADO'
```

en lugar de valores antiguos como:

```sql
COMPLETADO
```

- Verificar que el trigger de horas utilice consistentemente `horas_estimadas`.
- Crear procedimientos separados para:
  - pagos
  - horas extras
  - bonificaciones

utilizando `horas_reales`.

- Documentar evidencias de ejecución, capturas o resultados de pruebas.
- Revisar credenciales hardcodeadas antes de utilizar el proyecto fuera de entornos académicos.

---

# Criterio de uso de horas

El modelo distingue entre:

### horas_estimadas

Horas planificadas o asignadas.

### horas_reales

Horas efectivamente trabajadas.

### Uso recomendado

| Caso | Columna recomendada |
|--------|--------|
| Capacidad del empleado | horas_estimadas |
| Alertas de sobreasignación | horas_estimadas |
| Planificación de carga laboral | horas_estimadas |
| Pagos | horas_reales |
| Horas extras | horas_reales |
| Bonificaciones | horas_reales |
| Costo real del proyecto | horas_reales |
| Comparativo planificado vs ejecutado | horas_estimadas y horas_reales |

---

## Última actualización

**2026-06-08**
