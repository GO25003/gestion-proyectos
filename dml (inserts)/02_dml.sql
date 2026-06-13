
-- INSERCIÓN DE DATOs


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


-- CATEGORIA

INSERT INTO categoria (id_categoria, nombre_categoria, descripcion_categoria)
VALUES (1, 'Tecnología', 'Proyectos relacionados con software, hardware e infraestructura TI');
INSERT INTO categoria (id_categoria, nombre_categoria, descripcion_categoria)
VALUES (2, 'Marketing', 'Campañas publicitarias, branding y estrategias digitales');
INSERT INTO categoria (id_categoria, nombre_categoria, descripcion_categoria)
VALUES (3, 'Construcción', 'Obras civiles, edificaciones y remodelaciones');


-- PROYECTO

INSERT INTO proyecto (id_proyecto, nombre_proyecto, id_categoria, fecha_inicio, fecha_fin, presupuesto, estado_proyecto)
VALUES (10, 'Desarrollo App Móvil', 1, DATE '2025-01-10', DATE '2025-06-30', 5000.00, 'EN_DESARROLLO');
INSERT INTO proyecto (id_proyecto, nombre_proyecto, id_categoria, fecha_inicio, fecha_fin, presupuesto, estado_proyecto)
VALUES (11, 'Campaña Redes Sociales Q1', 2, DATE '2025-02-01', DATE '2025-04-15', 1500.00, 'EN_DESARROLLO');
INSERT INTO proyecto (id_proyecto, nombre_proyecto, id_categoria, fecha_inicio, fecha_fin, presupuesto, estado_proyecto)
VALUES (12, 'Puente Vehicular Norte', 3, DATE '2024-11-01', DATE '2026-12-31', 9999.99, 'EN_DESARROLLO');
INSERT INTO proyecto (id_proyecto, nombre_proyecto, id_categoria, fecha_inicio, fecha_fin, presupuesto, estado_proyecto)
VALUES (13, 'Actualización Servidores', 1, DATE '2025-03-01', NULL, 3000.00, 'POR_INICIAR');


-- EMPLEADO

INSERT INTO empleado (id_empleado, nombre, apellido, correo, disponibilidad, rol)
VALUES (100, 'Ana', 'Rodríguez', 'ana.rodriguez@empresa.com', 'DISPONIBLE', 'LIDER');
INSERT INTO empleado (id_empleado, nombre, apellido, correo, disponibilidad, rol)
VALUES (101, 'Luis', 'Pérez', 'luis.perez@empresa.com', 'OCUPADO', 'DESARROLLADOR');
INSERT INTO empleado (id_empleado, nombre, apellido, correo, disponibilidad, rol)
VALUES (102, 'Carla', 'Gómez', 'carla.gomez@empresa.com', 'DISPONIBLE', 'ANALISTA');
INSERT INTO empleado (id_empleado, nombre, apellido, correo, disponibilidad, rol)
VALUES (103, 'Jorge', 'Martínez', 'jorge.martinez@empresa.com', 'OCUPADO', 'TESTER');
INSERT INTO empleado (id_empleado, nombre, apellido, correo, disponibilidad, rol)
VALUES (104, 'Elena', 'Fernández', 'elena.fernandez@empresa.com', 'EN_VACACIONES', 'GERENTE');


-- TAREA (Corregido con estados válidos del CHECK)

INSERT INTO tarea (id_tarea, id_proyecto, titulo_tarea, estado_tarea, fecha_creacion, fecha_entrega, descripcion_tarea)
VALUES (200, 10, 'Definir requerimientos', 'EN TIEMPO', DATE '2025-01-10', DATE '2025-01-20', 'Fase inicial de toma de requerimientos');
INSERT INTO tarea (id_tarea, id_proyecto, titulo_tarea, estado_tarea, fecha_creacion, fecha_entrega, descripcion_tarea)
VALUES (201, 10, 'Diseño UI/UX', 'EN TIEMPO', DATE '2025-01-21', DATE '2025-02-15', 'Creación de prototipos de alta fidelidad');
INSERT INTO tarea (id_tarea, id_proyecto, titulo_tarea, estado_tarea, fecha_creacion, fecha_entrega, descripcion_tarea)
VALUES (202, 10, 'Implementación backend', 'PROXIMO', DATE '2025-02-16', DATE '2025-04-10', 'Desarrollo de API en Node.js');
INSERT INTO tarea (id_tarea, id_proyecto, titulo_tarea, estado_tarea, fecha_creacion, fecha_entrega, descripcion_tarea)
VALUES (203, 11, 'Crear contenido gráfico', 'RETRASADO', DATE '2025-02-01', DATE '2025-03-01', 'Banners y videos promocionales');
INSERT INTO tarea (id_tarea, id_proyecto, titulo_tarea, estado_tarea, fecha_creacion, fecha_entrega, descripcion_tarea)
VALUES (204, 11, 'Programar publicaciones', 'SIN FECHA', DATE '2025-03-02', NULL, 'Planificación en plataformas de gestión');
INSERT INTO tarea (id_tarea, id_proyecto, titulo_tarea, estado_tarea, fecha_creacion, fecha_entrega, descripcion_tarea)
VALUES (205, 12, 'Excavación y cimientos', 'EN TIEMPO', DATE '2024-11-01', DATE '2025-02-28', 'Fase pesada de ingeniería civil');
INSERT INTO tarea (id_tarea, id_proyecto, titulo_tarea, estado_tarea, fecha_creacion, fecha_entrega, descripcion_tarea)
VALUES (206, 12, 'Levantamiento de columnas', 'PROXIMO', DATE '2025-03-01', DATE '2025-08-20', 'Armado de estructuras principales');
INSERT INTO tarea (id_tarea, id_proyecto, titulo_tarea, estado_tarea, fecha_creacion, fecha_entrega, descripcion_tarea)
VALUES (207, 13, 'Migración de datos', 'EN TIEMPO', DATE '2025-03-05', DATE '2025-05-01', 'Traspaso de BD Cloud antigua a nueva');


-- RECURSO

INSERT INTO recurso (id_recurso, nombre_recurso, tipo_recurso, descripcion_recurso, disponibilidad_recurso)
VALUES (1, 'Servidor AWS EC2', 'Infraestructura Cloud', 'Instancia para entorno de pruebas', 'DISPONIBLE');
INSERT INTO recurso (id_recurso, nombre_recurso, tipo_recurso, descripcion_recurso, disponibilidad_recurso)
VALUES (2, 'Licencia Adobe CC', 'Software', 'Suite de diseño gráfico', 'OCUPADO');
INSERT INTO recurso (id_recurso, nombre_recurso, tipo_recurso, descripcion_recurso, disponibilidad_recurso)
VALUES (3, 'Excavadora Caterpillar', 'Maquinaria Pesada', 'Uso exclusivo en obra vial', 'DISPONIBLE');
INSERT INTO recurso (id_recurso, nombre_recurso, tipo_recurso, descripcion_recurso, disponibilidad_recurso)
VALUES (4, 'PC de Desarrollo Dell', 'Hardware', 'Estación de trabajo potente', 'OCUPADO');


-- ASIGNACION (Corregido a horas_reales, horas_estimadas e id_recurso)

INSERT INTO asignacion (id_tarea, id_empleado, id_recurso, horas_reales, horas_estimadas) VALUES (200, 100, 4, 40.00, 45.00);
INSERT INTO asignacion (id_tarea, id_empleado, id_recurso, horas_reales, horas_estimadas) VALUES (200, 101, 4, 20.50, 20.00);
INSERT INTO asignacion (id_tarea, id_empleado, id_recurso, horas_reales, horas_estimadas) VALUES (201, 102, 2, 35.00, 40.00);
INSERT INTO asignacion (id_tarea, id_empleado, id_recurso, horas_reales, horas_estimadas) VALUES (202, 100, 1, 15.00, 30.00);
INSERT INTO asignacion (id_tarea, id_empleado, id_recurso, horas_reales, horas_estimadas) VALUES (202, 103, 1, 25.00, 25.00);
INSERT INTO asignacion (id_tarea, id_empleado, id_recurso, horas_reales, horas_estimadas) VALUES (203, 104, 2, 30.00, 35.00);
INSERT INTO asignacion (id_tarea, id_empleado, id_recurso, horas_reales, horas_estimadas) VALUES (204, 104, 2, 18.00, 20.00);
INSERT INTO asignacion (id_tarea, id_empleado, id_recurso, horas_reales, horas_estimadas) VALUES (205, 101, 3, 50.00, 50.00);
INSERT INTO asignacion (id_tarea, id_empleado, id_recurso, horas_reales, horas_estimadas) VALUES (207, 103, 1, 28.00, 30.00);


-- DOCUMENTO (Corregido con fecha_creacion y contenido)

INSERT INTO documento (id_documento, id_proyecto, nombre_documento, fecha_creacion, contenido) 
VALUES (300, 10, 'Requerimientos_v1.pdf', DATE '2025-01-11', 'Contenido resumido del documento de requerimientos funcionales del sistema.');
INSERT INTO documento (id_documento, id_proyecto, nombre_documento, fecha_creacion, contenido) 
VALUES (301, 10, 'Diagrama_BD.png', DATE '2025-01-15', 'Estructura relacional binaria mapeada del modelo de base de datos.');
INSERT INTO documento (id_documento, id_proyecto, nombre_documento, fecha_creacion, contenido) 
VALUES (302, 11, 'Plan_medios.xlsx', DATE '2025-02-02', 'Cronograma detallado de pautas comerciales en redes sociales de la empresa.');
INSERT INTO documento (id_documento, id_proyecto, nombre_documento, fecha_creacion, contenido) 
VALUES (303, 12, 'Estudio_suelo.pdf', DATE '2024-11-05', 'Resultados de resistencia de terreno y capacidad de carga estructural del suelo.');
INSERT INTO documento (id_documento, id_proyecto, nombre_documento, fecha_creacion, contenido) 
VALUES (304, 13, 'Inventario_servidores.csv', DATE '2025-03-06', 'Mapeo completo de IPs y componentes de hardware activos a migrar.');


-- RIESGO (Corregido con probabilidad y plan_mitigacion)

INSERT INTO riesgo (id_riesgo, id_proyecto, descripcion_riesgo, impacto, probabilidad, plan_mitigacion) 
VALUES (400, 10, 'Retraso en aprobación de API externa', 'ALTO', 'MEDIA', 'Desarrollar un Mock temporal para pruebas locales.');
INSERT INTO riesgo (id_riesgo, id_proyecto, descripcion_riesgo, impacto, probabilidad, plan_mitigacion) 
VALUES (401, 11, 'Cambio en algoritmo de redes sociales', 'MEDIO', 'ALTA', 'Diversificar canales utilizando email marketing integrado.');
INSERT INTO riesgo (id_riesgo, id_proyecto, descripcion_riesgo, impacto, probabilidad, plan_mitigacion) 
VALUES (402, 12, 'Sobreprecio de materiales de acero', 'ALTO', 'BAJA', 'Firmar contratos de compra anticipada con precios congelados.');
INSERT INTO riesgo (id_riesgo, id_proyecto, descripcion_riesgo, impacto, probabilidad, plan_mitigacion) 
VALUES (403, 13, 'Incompatibilidad de versiones de SO', 'BAJO', 'ALTA', 'Realizar pruebas en contenedores Docker antes del despliegue real.');


-- HITO (Corregido a fecha_hito)

INSERT INTO hito (id_hito, id_proyecto, nombre_hito, fecha_hito) VALUES (500, 10, 'MVP listo', DATE '2025-05-01');
INSERT INTO hito (id_hito, id_proyecto, nombre_hito, fecha_hito) VALUES (501, 11, 'Lanzamiento campaña', DATE '2025-03-20');
INSERT INTO hito (id_hito, id_proyecto, nombre_hito, fecha_hito) VALUES (502, 12, 'Finalización de cimientos', DATE '2025-04-15');
INSERT INTO hito (id_hito, id_proyecto, nombre_hito, fecha_hito) VALUES (503, 12, 'Estructura principal culminada', DATE '2026-03-30');
INSERT INTO hito (id_hito, id_proyecto, nombre_hito, fecha_hito) VALUES (504, 13, 'Backup completo', DATE '2025-04-10');
INSERT INTO hito (id_hito, id_proyecto, nombre_hito, fecha_hito) VALUES (505, 10, 'Entrega final', DATE '2025-06-30');


-- TELEFONO

INSERT INTO telefono (id_empleado, telefono) VALUES (100, '25251001');
INSERT INTO telefono (id_empleado, telefono) VALUES (100, '25251002');
INSERT INTO telefono (id_empleado, telefono) VALUES (101, '25251010');
INSERT INTO telefono (id_empleado, telefono) VALUES (102, '25251025');
INSERT INTO telefono (id_empleado, telefono) VALUES (104, '25251044');

COMMIT;