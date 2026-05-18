---
tipo: Manifiesto de Configuración y Meta-Plantilla de Resumen Ejecutivo
proyecto: Gestión de Proyectos (DBP135)
estado: En Desarrollo
progreso: 35%
última_actualización: 2026-05-17
tags: [ues, base-de-datos, oracle, sql, arquitectura-relacional]
---

# 🚀 Gestión de Proyectos (Oracle DB)

### 🛡️ Stack Tecnológico y Lenguajes
![Oracle](https://img.shields.io/badge/Oracle-%23F00000.svg?style=for-the-badge&logo=oracle&logoColor=white) ![SQL](https://img.shields.io/badge/SQL-%23003B57.svg?style=for-the-badge&logo=postgresql&logoColor=white) ![Git](https://img.shields.io/badge/git-%23F05033.svg?style=for-the-badge&logo=git&logoColor=white) ![Obsidian](https://img.shields.io/badge/Obsidian-%23483699.svg?style=for-the-badge&logo=obsidian&logoColor=white)

---

> [!IMPORTANT]
> **ESTADO DE INFRAESTRUCTURA Y DISEÑO:**
> Este documento representa la bitácora técnica oficial del diseño relacional para el sistema de "Gestión de Proyectos" de la cátedra DBP135 (UES). Gestionado como un Git-Submodule en el entorno `Digital_Brain` (`02_UES/Gestión_de_Proyectos`). El diseño se enfoca en la integridad referencial fuerte, control preventivo a nivel de base de datos y la 3ra Forma Normal (3NF).

## 🏛️ 1. Detalle del Stack y Lenguajes Utilizados
Análisis profundo del criterio de selección y rol de la tecnología en esta capa del sistema:

* **Oracle Database (Motor Relacional):** Seleccionado como el *Single Source of Truth* del sistema. Su rol es garantizar el cumplimiento ACID absoluto en las transacciones de asignación de horas y la estructura de hitos del proyecto.
* **SQL (DDL Estricto):** Lenguaje utilizado para definir la estructura, enfocándose en un uso agresivo de `CHECK constraints` y relaciones `ON DELETE CASCADE` para evitar que la lógica de validación dependa exclusivamente de un futuro backend.

## 🎯 2. Estado Actual del Sistema y Mapeo Modular
Desglose del progreso del desarrollo estructurado en los artefactos de la base de datos:

* **`01_ddl.sql` (Estructura Core):** [Estable] Mapeo completo de las 9 entidades principales (`categoria`, `proyecto`, `empleado`, `telefono`, `tarea`, `asignacion`, `documento`, `riesgo`, `hito`).
* **Reglas de Negocio (Constraints):** [Implementadas] Prevención de horas negativas en `asignacion`, estados predefinidos estrictos para `tarea` y control de emails únicos para `empleado`.
* **Datos de Prueba (DML) y Vistas:** [Pendiente] Falta estructurar los scripts de inicialización de datos sintéticos y las vistas analíticas para la reportería (ej. sumatoria de horas por proyecto).

> [!TIP]
> **Nota de Diseño:** Al delegar reglas críticas directamente al motor de la base de datos (vía constraints), el sistema se blinda contra inserciones defectuosas sin importar si el día de mañana se conecta a este esquema una API en Rust, Go, o simplemente se manipula desde la consola SQL.

## 📊 3. Interoperabilidad y Flujo de Procesamiento
Explicación detallada de cómo se comporta el dato en el diseño actual.

| Entidad / Módulo Interno | Rol Funcional | Restricción Crítica | Impacto de Integridad |
| :--- | :--- | :--- | :--- |
| `proyecto` & Anexos | Contenedor principal | `ON DELETE CASCADE` | Elimina hitos, tareas y riesgos si el proyecto se borra. Evita datos huérfanos. |
| `tarea` | Seguimiento de trabajo | `CHECK (estado_tarea IN (...))` | Bloquea estados irreales, forzando una máquina de estados finita. |
| `asignacion` | Control de esfuerzo (NxM) | `CHECK (horas >= 0)` | Impide lógicamente el registro de tiempos invertidos. |

## 🛡️ 4. Seguridad Perimetral e Infraestructura Lógica
Mecanismos activos implementados para garantizar la calidad y consistencia de la información a nivel de almacenamiento:
* **Integridad Referencial Fuerte:** Uso de restricciones bidireccionales en tablas pivote (`asignacion`) que destruyen el registro si la tarea o el empleado asociado dejan de existir.
* **Prevención de Duplicidad:** Claves primarias compuestas en entidades multivalor (ej. `telefono`) para asegurar que el mismo recurso no posea registros fantasma.
* **Aislamiento Semántico:** Modelado que separa explícitamente los *riesgos* y los *documentos* de la estructura del proyecto principal, permitiendo escalabilidad futura (como migrar documentos a un bucket S3 conservando solo la URL/referencia en la base de datos).