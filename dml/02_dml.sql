-- =====================================================
-- 02_DML
-- =====================================================
-- INSERCIÓN DE DATOS

-- Limpieza rápida respetando estrictamente el orden de llaves foráneas
DELETE FROM telefono;
DELETE FROM hito;
DELETE FROM riesgo;
DELETE FROM documento;
DELETE FROM asignacion;
DELETE FROM recurso;
DELETE FROM tarea;
DELETE FROM empleado;
DELETE FROM proyecto;
DELETE FROM categoria;
COMMIT;

-- =====================================================
-- INSERTS: CATEGORIA
-- =====================================================

INSERT INTO categoria (id_categoria, nombre_categoria, descripcion_categoria)
VALUES (1, 'Construccion Residencial', 'Proyectos de viviendas y complejos habitacionales');

INSERT INTO categoria (id_categoria, nombre_categoria, descripcion_categoria)
VALUES (2, 'Construccion Comercial', 'Centros comerciales, oficinas y locales');

INSERT INTO categoria (id_categoria, nombre_categoria, descripcion_categoria)
VALUES (3, 'Infraestructura Vial', 'Carreteras, puentes y obras de transporte');

INSERT INTO categoria (id_categoria, nombre_categoria, descripcion_categoria)
VALUES (4, 'Obras Industriales', 'Plantas industriales y bodegas');

-- =====================================================
-- INSERTS: PROYECTO
-- =====================================================

INSERT INTO proyecto (
id_proyecto,
nombre_proyecto,
id_categoria,
fecha_inicio,
fecha_fin,
presupuesto,
estado_proyecto
)
VALUES (
1,
'Residencial Los Pinos',
1,
DATE '2026-01-15',
DATE '2026-12-20',
99999.99,
'EN_DESARROLLO'
);

INSERT INTO proyecto (
id_proyecto,
nombre_proyecto,
id_categoria,
fecha_inicio,
fecha_fin,
presupuesto,
estado_proyecto
)
VALUES (
2,
'Centro Comercial Plaza Norte',
2,
DATE '2026-02-01',
DATE '2026-11-30',
85000.00,
'POR_INICIAR'
);

INSERT INTO proyecto (
id_proyecto,
nombre_proyecto,
id_categoria,
fecha_inicio,
fecha_fin,
presupuesto,
estado_proyecto
)
VALUES (
3,
'Ampliacion Ruta Metropolitana',
3,
DATE '2026-03-10',
DATE '2026-10-15',
95000.50,
'EN_ESPERA'
);

INSERT INTO proyecto (
id_proyecto,
nombre_proyecto,
id_categoria,
fecha_inicio,
fecha_fin,
presupuesto,
estado_proyecto
)
VALUES (
4,
'Planta Industrial Delta',
4,
DATE '2026-04-01',
DATE '2026-12-01',
9800.75,
'EN_DESARROLLO'
);

-- =====================================================
-- INSERTS: EMPLEADO
-- =====================================================

INSERT INTO empleado (
id_empleado,
nombre,
apellido,
correo,
disponibilidad,
rol
)
VALUES (
1,
'Carlos',
'Martinez',
'carlos.martinez@empresa.com',
'DISPONIBLE',
'GERENTE'
);

INSERT INTO empleado (
id_empleado,
nombre,
apellido,
correo,
disponibilidad,
rol
)
VALUES (
2,
'Ana',
'Lopez',
'ana.lopez@empresa.com',
'OCUPADO',
'ANALISTA'
);

INSERT INTO empleado (
id_empleado,
nombre,
apellido,
correo,
disponibilidad,
rol
)
VALUES (
3,
'Luis',
'Hernandez',
'luis.hernandez@empresa.com',
'DISPONIBLE',
'DESARROLLADOR'
);

INSERT INTO empleado (
id_empleado,
nombre,
apellido,
correo,
disponibilidad,
rol
)
VALUES (
4,
'Maria',
'Gomez',
'maria.gomez@empresa.com',
'EN_VACACIONES',
'LIDER'
);
-- =====================================================
-- INSERTS: TELEFONO
-- Compatible con chk_telefono_formato
-- =====================================================

INSERT INTO telefono (id_empleado, telefono)
VALUES (1, '+503 7000-1001');

INSERT INTO telefono (id_empleado, telefono)
VALUES (2, '+503 7000-1002');

INSERT INTO telefono (id_empleado, telefono)
VALUES (3, '+503 7000-1003');

INSERT INTO telefono (id_empleado, telefono)
VALUES (4, '+503 7000-1004');

-- =====================================================
-- INSERTS:TAREA
-- Necesarios para las FK de ASIGNACION
-- =====================================================
INSERT INTO tarea (
    id_tarea,
    id_proyecto,
    titulo_tarea,
    estado_tarea,
    fecha_creacion,
    fecha_entrega,
    descripcion_tarea
)
VALUES (
    1,
    1,
    'Diseño Arquitectonico',
    'FINALIZADO',
    DATE '2026-01-20',
    DATE '2026-02-15',
    'Diseño inicial del complejo residencial'
);

INSERT INTO tarea (
    id_tarea,
    id_proyecto,
    titulo_tarea,
    estado_tarea,
    fecha_creacion,
    fecha_entrega,
    descripcion_tarea
)
VALUES (
    2,
    2,
    'Levantamiento Topografico',
    'EN DESARROLLO',
    DATE '2026-02-10',
    DATE '2026-04-01',
    'Estudio topográfico del terreno'
);

INSERT INTO tarea (
    id_tarea,
    id_proyecto,
    titulo_tarea,
    estado_tarea,
    fecha_creacion,
    fecha_entrega,
    descripcion_tarea
)
VALUES (
    3,
    3,
    'Construccion de Base',
    'POR INICIAR',
    DATE '2026-03-15',
    DATE '2026-05-30',
    'Preparación y construcción de base vial'
);

INSERT INTO tarea (
    id_tarea,
    id_proyecto,
    titulo_tarea,
    estado_tarea,
    fecha_creacion,
    fecha_entrega,
    descripcion_tarea
)
VALUES (
    4,
    4,
    'Instalacion Electrica',
    'EN PAUSA',
    DATE '2026-04-10',
    DATE '2026-07-15',
    'Instalación eléctrica industrial'
);
-- =====================================================
-- INSERTS: RECURSO
-- Necesarios para las FK de ASIGNACION
-- =====================================================

INSERT INTO recurso (
id_recurso,
nombre_recurso,
tipo_recurso,
descripcion_recurso,
disponibilidad_recurso
)
VALUES (
1,
'Retroexcavadora CAT',
'MAQUINARIA',
'Equipo pesado para excavaciones',
'DISPONIBLE'
);

INSERT INTO recurso (
id_recurso,
nombre_recurso,
tipo_recurso,
descripcion_recurso,
disponibilidad_recurso
)
VALUES (
2,
'Estacion Topografica',
'EQUIPO',
'Equipo de medicion topografica',
'OCUPADO'
);

INSERT INTO recurso (
id_recurso,
nombre_recurso,
tipo_recurso,
descripcion_recurso,
disponibilidad_recurso
)
VALUES (
3,
'Camion Volteo',
'VEHICULO',
'Transporte de materiales',
'DISPONIBLE'
);

INSERT INTO recurso (
id_recurso,
nombre_recurso,
tipo_recurso,
descripcion_recurso,
disponibilidad_recurso
)
VALUES (
4,
'Generador Industrial',
'EQUIPO',
'Suministro electrico temporal',
'EN_MANTENIMIENTO'
);

-- =====================================================
-- INSERTS: ASIGNACION
-- Corregido:
-- antes usaba columna HORAS (inexistente)
-- =====================================================

INSERT INTO asignacion (
id_tarea,
id_empleado,
id_recurso,
horas_reales,
horas_estimadas
)
VALUES (
1,
1,
1,
40,
45
);

INSERT INTO asignacion (
id_tarea,
id_empleado,
id_recurso,
horas_reales,
horas_estimadas
)
VALUES (
2,
2,
2,
55,
60
);

INSERT INTO asignacion (
id_tarea,
id_empleado,
id_recurso,
horas_reales,
horas_estimadas
)
VALUES (
3,
3,
3,
30,
35
);

INSERT INTO asignacion (
id_tarea,
id_empleado,
id_recurso,
horas_reales,
horas_estimadas
)
VALUES (
4,
4,
4,
25,
30
);

-- =====================================================
-- INSERTS: DOCUMENTO
-- Corregido:
-- fecha_creacion y contenido son NOT NULL
-- =====================================================

INSERT INTO documento (
id_documento,
id_proyecto,
nombre_documento,
fecha_creacion,
contenido
)
VALUES (
1,
1,
'Plano General Residencial.pdf',
DATE '2026-01-25',
'Plano general del proyecto residencial'
);

INSERT INTO documento (
id_documento,
id_proyecto,
nombre_documento,
fecha_creacion,
contenido
)
VALUES (
2,
2,
'Estudio Comercial.pdf',
DATE '2026-02-15',
'Documento de estudio comercial'
);

INSERT INTO documento (
id_documento,
id_proyecto,
nombre_documento,
fecha_creacion,
contenido
)
VALUES (
3,
3,
'Informe Tecnico Vial.pdf',
DATE '2026-03-20',
'Informe tecnico de infraestructura vial'
);

INSERT INTO documento (
id_documento,
id_proyecto,
nombre_documento,
fecha_creacion,
contenido
)
VALUES (
4,
4,
'Memoria de Calculo Industrial.pdf',
DATE '2026-04-25',
'Memoria de calculo del proyecto industrial'
);

-- =====================================================
-- INSERTS: RIESGO
-- Corregido:
-- probabilidad y plan_mitigacion son NOT NULL
-- =====================================================

INSERT INTO riesgo (
id_riesgo,
id_proyecto,
descripcion_riesgo,
impacto,
probabilidad,
plan_mitigacion
)
VALUES (
1,
1,
'Retraso en entrega de materiales',
'ALTO',
'MEDIA',
'Mantener proveedores alternativos'
);

INSERT INTO riesgo (
id_riesgo,
id_proyecto,
descripcion_riesgo,
impacto,
probabilidad,
plan_mitigacion
)
VALUES (
2,
2,
'Incremento de costos de construccion',
'MEDIO',
'ALTA',
'Negociar contratos anticipadamente'
);

INSERT INTO riesgo (
id_riesgo,
id_proyecto,
descripcion_riesgo,
impacto,
probabilidad,
plan_mitigacion
)
VALUES (
3,
3,
'Condiciones climaticas adversas',
'ALTO',
'MEDIA',
'Reprogramar actividades criticas'
);

INSERT INTO riesgo (
id_riesgo,
id_proyecto,
descripcion_riesgo,
impacto,
probabilidad,
plan_mitigacion
)
VALUES (
4,
4,
'Falla de equipos especializados',
'MEDIO',
'BAJA',
'Mantenimiento preventivo'
);

-- =====================================================
-- INSERTS: HITO
-- Corregido:
-- fecha_estimada -> fecha_hito
-- =====================================================

INSERT INTO hito (
id_hito,
id_proyecto,
nombre_hito,
fecha_hito
)
VALUES (
1,
1,
'Aprobacion de Diseños',
DATE '2026-02-01'
);

INSERT INTO hito (
id_hito,
id_proyecto,
nombre_hito,
fecha_hito
)
VALUES (
2,
2,
'Finalizacion de Cimentacion',
DATE '2026-05-15'
);

INSERT INTO hito (
id_hito,
id_proyecto,
nombre_hito,
fecha_hito
)
VALUES (
3,
3,
'Entrega de Tramo Principal',
DATE '2026-08-20'
);

INSERT INTO hito (
id_hito,
id_proyecto,
nombre_hito,
fecha_hito
)
VALUES (
4,
4,
'Inicio de Operaciones',
DATE '2026-11-15'
);

COMMIT;
