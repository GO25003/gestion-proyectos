-- 1. Vista de Control de Hitos y Retrasos Operativos
CREATE OR REPLACE VIEW v_reporte_hitos AS
SELECT 
    h.id_hito,
    p.nombre_proyecto,
    h.nombre_hito,
    h.fecha_estimada,
    h.estado,
    CASE 
        WHEN h.estado = 'PENDIENTE' AND h.fecha_estimada < SYSDATE THEN 'ALERTA: RETRASADO'
        ELSE 'EN TIEMPO'
    END AS semaforo_control
FROM hito h
JOIN proyecto p ON h.id_proyecto = p.id_proyecto;

-- 2. Vista de Carga de Trabajo del Personal (Seguridad de Abstracción)
CREATE OR REPLACE VIEW v_dashboard_empleados AS
SELECT 
    e.id_empleado,
    e.nombre || ' ' || e.apellido AS nombre_completo,
    e.cargo,
    COUNT(a.id_asignacion) AS total_proyectos_asignados
FROM empleado e
LEFT JOIN asignacion a ON e.id_empleado = a.id_empleado
GROUP BY e.id_empleado, e.nombre, e.apellido, e.cargo;

-- 3. OPTIMIZACIÓN: Vista Materializada para Reporting Gerencial Alto Rendimiento
-- Nota: Esta vista almacena físicamente el resumen financiero y de avance en disco
-- para que tu API en Go/Astro lea al instante sin penalizar la BD con JOINS repetidos.

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
