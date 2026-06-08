-- 1. Vista de Control de Tareas y Retrasos Operativos
CREATE OR REPLACE VIEW v_reporte_tareas AS
SELECT
    t.id_tarea,
    t.titulo_tarea,
    t.fecha_entrega AS fecha_tarea,
    p.id_proyecto,
    p.nombre_proyecto,
    CASE
        WHEN t.fecha_entrega IS NULL THEN 'SIN FECHA'
        WHEN t.fecha_entrega < TRUNC(SYSDATE) THEN 'RETRASADO'
        WHEN t.fecha_entrega BETWEEN TRUNC(SYSDATE) AND TRUNC(SYSDATE) + 7 THEN 'PROXIMO'
        ELSE 'EN TIEMPO'
    END AS estado_control,
    CASE
        WHEN t.fecha_entrega IS NULL THEN NULL
        ELSE TRUNC(t.fecha_entrega) - TRUNC(SYSDATE)
    END AS dias_restantes
FROM tarea t
JOIN proyecto p
    ON p.id_proyecto = t.id_proyecto;

-- 2. Vista de Carga de Trabajo del Personal (Seguridad de Abstracción)
CREATE OR REPLACE VIEW v_dashboard_empleados AS
SELECT 
    e.id_empleado,
    e.nombre || ' ' || e.apellido AS nombre_completo,
    e.rol,
    COUNT(a.id_tarea) AS total_tareas_asignadas
FROM empleado e
LEFT JOIN asignacion a 
    ON e.id_empleado = a.id_empleado
GROUP BY 
    e.id_empleado,
    e.nombre,
    e.apellido,
    e.rol;

-- 3. OPTIMIZACIÓN: Vista Materializada para Reporting Gerencial Alto Rendimiento
-- Nota: Esta vista almacena físicamente el resumen financiero y de avance en disco
-- para que una API en Go/Astro por ejemplo, pueda leer al instante sin penalizar la BD con JOINS repetidos.

CREATE MATERIALIZED VIEW mv_resumen_gerencial_proyectos
BUILD IMMEDIATE
REFRESH COMPLETE ON DEMAND
AS
SELECT 
    p.id_proyecto,
    p.nombre_proyecto,
    SUM(p.presupuesto) AS presupuesto_asignado,
    COUNT(t.id_tarea) AS volumen_tareas,
    SUM(CASE WHEN t.estado = 'COMPLETADO' THEN 1 ELSE 0 END) AS tareas_exitosas
FROM proyecto p
LEFT JOIN tarea t ON p.id_proyecto = t.id_proyecto
GROUP BY p.id_proyecto, p.nombre_proyecto;
