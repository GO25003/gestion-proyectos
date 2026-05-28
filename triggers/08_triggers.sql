
-- =====================================================================
-- TRIGGER DE AUDITORÍA SOBRE LOG_ERRORES
-- Se dispara en INSERT sobre LOG_ERRORES.
-- Registra en AUDITORIA_PROYECTO reutilizando la misma tabla
-- de auditoría con acción 'LOG_INSERT' para trazabilidad completa.
-- NOTA: Para no crear una segunda tabla de auditoría redundante,
-- este trigger usa una tabla separada: AUDITORIA_LOG.
-- =====================================================================
 CREATE TABLE auditoria_proyecto (
    id_auditoria        NUMBER
        CONSTRAINT pk_auditoria PRIMARY KEY,
    accion              VARCHAR2(10)
        CONSTRAINT nn_aud_accion NOT NULL,
    usuario_oracle      VARCHAR2(100)
        CONSTRAINT nn_aud_usuario NOT NULL,
    fecha_hora          DATE DEFAULT SYSDATE
        CONSTRAINT nn_aud_fecha NOT NULL,
    -- Valores anteriores (solo aplica en UPDATE)
    old_nombre_proyecto VARCHAR2(150),
    old_id_categoria    NUMBER,
    old_fecha_inicio    DATE,
    old_fecha_fin       DATE,
    -- Valores nuevos
    new_nombre_proyecto VARCHAR2(150),
    new_id_categoria    NUMBER,
    new_fecha_inicio    DATE,
    new_fecha_fin       DATE
);
 
CREATE SEQUENCE seq_auditoria START WITH 1 INCREMENT BY 1 NOCACHE;

CREATE TABLE log_errores (
    id_log          NUMBER
        CONSTRAINT pk_log_errores PRIMARY KEY,
    procedimiento   VARCHAR2(100)
        CONSTRAINT nn_log_proc NOT NULL,
    mensaje_error   VARCHAR2(4000)
        CONSTRAINT nn_log_msg NOT NULL,
    usuario_oracle  VARCHAR2(100),
    fecha_error     DATE DEFAULT SYSDATE
        CONSTRAINT nn_log_fecha NOT NULL,
    parametros      VARCHAR2(500)
);

CREATE SEQUENCE seq_log_errores START WITH 1 INCREMENT BY 1 NOCACHE;


CREATE TABLE auditoria_log (
    id_aud_log      NUMBER
        CONSTRAINT pk_auditoria_log PRIMARY KEY,
    accion          VARCHAR2(20)    NOT NULL,
    usuario_oracle  VARCHAR2(100)   NOT NULL,
    fecha_hora      DATE DEFAULT SYSDATE NOT NULL,
    id_log_ref      NUMBER,
    procedimiento   VARCHAR2(100),
    mensaje_error   VARCHAR2(4000)
);
 
CREATE SEQUENCE seq_auditoria_log START WITH 1 INCREMENT BY 1 NOCACHE;
 


 
CREATE OR REPLACE TRIGGER trg_auditoria_log_errores
    AFTER INSERT ON log_errores
    FOR EACH ROW
BEGIN
    INSERT INTO auditoria_log (
        id_aud_log, accion, usuario_oracle, fecha_hora,
        id_log_ref, procedimiento, mensaje_error
    ) VALUES (
        seq_auditoria_log.NEXTVAL,
        'INSERT',
        USER,
        SYSDATE,
        :NEW.id_log,
        :NEW.procedimiento,
        :NEW.mensaje_error
    );
END trg_auditoria_log_errores;
/


-- =====================================================================
-- TRIGGER DE AUDITORÍA SOBRE PROYECTO
-- Se dispara en INSERT y UPDATE.
-- Registra usuario Oracle, fecha/hora, acción,
-- valores anteriores (OLD) y nuevos (NEW).
-- =====================================================================


 
CREATE OR REPLACE TRIGGER trg_auditoria_proyecto
    AFTER INSERT OR UPDATE ON proyecto
    FOR EACH ROW
DECLARE
    v_accion VARCHAR2(10);
BEGIN
    v_accion := CASE WHEN INSERTING THEN 'INSERT' ELSE 'UPDATE' END;
 
    INSERT INTO auditoria_proyecto (
        id_auditoria,
        accion,
        usuario_oracle,
        fecha_hora,
        -- Valores anteriores (NULL en INSERT)
        old_nombre_proyecto,
        old_id_categoria,
        old_fecha_inicio,
        old_fecha_fin,
        -- Valores nuevos
        new_nombre_proyecto,
        new_id_categoria,
        new_fecha_inicio,
        new_fecha_fin
    ) VALUES (
        seq_auditoria.NEXTVAL,
        v_accion,
        USER,
        SYSDATE,
        :OLD.nombre_proyecto,
        :OLD.id_categoria,
        :OLD.fecha_inicio,
        :OLD.fecha_fin,
        :NEW.nombre_proyecto,
        :NEW.id_categoria,
        :NEW.fecha_inicio,
        :NEW.fecha_fin
    );
END trg_auditoria_proyecto;
/


-- =====================================================================
-- TRIGGER DE INTEGRIDAD DE NEGOCIO
-- Tabla: ASIGNACION — BEFORE INSERT OR UPDATE
--
-- Regla: Un empleado no puede acumular más de 40 horas semanales
-- asignadas entre todas sus tareas activas (estado <> 'FINALIZADO').
-- Esta regla NO puede expresarse con un CHECK simple porque requiere
-- consultar el acumulado del empleado en otras filas de la tabla.
--
-- Si se supera el límite, bloquea la operación con
-- RAISE_APPLICATION_ERROR y registra el intento en LOG_ERRORES.
-- =====================================================================
 
CREATE OR REPLACE TRIGGER trg_integridad_horas_empleado
    BEFORE INSERT OR UPDATE OF horas ON asignacion
    FOR EACH ROW
DECLARE
    v_horas_actuales  NUMBER;
    v_horas_nuevas    NUMBER;
    v_horas_total     NUMBER;
    v_nombre_empleado VARCHAR2(150);
    v_limite          CONSTANT NUMBER := 40;
BEGIN
    -- Horas ya asignadas al empleado en tareas activas (excluye la fila actual en UPDATE)
    SELECT NVL(SUM(a.horas), 0)
      INTO v_horas_actuales
      FROM asignacion a
      JOIN tarea      t ON t.id_tarea = a.id_tarea
     WHERE a.id_empleado  = :NEW.id_empleado
       AND t.estado_tarea <> 'FINALIZADO'
       AND a.id_tarea     <> :NEW.id_tarea;  -- excluir la fila que se está modificando
 
    v_horas_nuevas := NVL(:NEW.horas, 0);
    v_horas_total  := v_horas_actuales + v_horas_nuevas;
 
    IF v_horas_total > v_limite THEN
        -- Obtener nombre para el mensaje
        SELECT nombre_empleado INTO v_nombre_empleado
          FROM empleado WHERE id_empleado = :NEW.id_empleado;
 
        -- Registrar el intento en log_errores
        INSERT INTO log_errores (id_log, procedimiento, mensaje_error, usuario_oracle, parametros)
        VALUES (
            seq_log_errores.NEXTVAL,
            'TRG_INTEGRIDAD_HORAS_EMPLEADO',
            'Asignación rechazada: el empleado ' || v_nombre_empleado
                || ' superaría el límite de ' || v_limite || ' horas activas. '
                || 'Horas actuales: ' || v_horas_actuales
                || ', horas nuevas: ' || v_horas_nuevas
                || ', total: ' || v_horas_total || '.',
            USER,
            'id_empleado=' || :NEW.id_empleado || ' id_tarea=' || :NEW.id_tarea
        );
 
        RAISE_APPLICATION_ERROR(-20010,
            'INTEGRIDAD: El empleado "' || v_nombre_empleado
            || '" superaría el límite de ' || v_limite || ' horas activas ('
            || v_horas_total || '/' || v_limite || '). Asignación rechazada.');
    END IF;
 
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- El empleado no existe; la FK lo rechazará, solo logueamos
        INSERT INTO log_errores (id_log, procedimiento, mensaje_error, usuario_oracle, parametros)
        VALUES (seq_log_errores.NEXTVAL, 'TRG_INTEGRIDAD_HORAS_EMPLEADO',
                'NO_DATA_FOUND: empleado id=' || :NEW.id_empleado || ' no encontrado.', USER,
                'id_empleado=' || :NEW.id_empleado);
        RAISE_APPLICATION_ERROR(-20011,
            'INTEGRIDAD: El empleado con id=' || :NEW.id_empleado || ' no existe.');
END trg_integridad_horas_empleado;
/