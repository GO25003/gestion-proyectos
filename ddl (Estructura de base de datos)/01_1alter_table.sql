ALTER TABLE proyecto
ADD (
    fecha_inicio DATE,
    fecha_fin DATE
);

ALTER TABLE tarea
ADD (
    fecha_creacion DATE,
    fecha_entrega DATE
);

ALTER TABLE hito
ADD (
    fecha_hito DATE
);