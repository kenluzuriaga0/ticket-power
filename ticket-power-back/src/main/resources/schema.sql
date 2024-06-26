CREATE TABLE public.botones (id serial PRIMARY KEY,nombre VARCHAR(4),descripcion text, estado boolean);

CREATE TABLE public.roles (
    id serial PRIMARY KEY,
    nombre character varying NOT NULL
);

CREATE TABLE public.sucursales (
    id serial PRIMARY KEY,
    nombre text NOT NULL,
    direccion text,
    orden integer NOT NULL,
    estado boolean DEFAULT false NOT NULL
);

CREATE TABLE public.turno_llamada (
    id bigserial PRIMARY KEY,
    id_turno bigint,
    llamada_fecha timestamp without time zone,
    llamada_usuario character varying(40)
);

CREATE TABLE public.turnos_generados (
    id bigserial PRIMARY KEY,
    tno_fecha_completa timestamp without time zone,
    tno_fecha date,
    tno_numero integer,
    tno_caja integer,
    tno_fecha_atendido timestamp without time zone,
    tno_tiempo_atencion time without time zone,
    tno_centro character varying(40),
    tno_usuario_crea character varying(40),
    id_usuario integer,
    tno_estado character varying(40),
    id_boton integer NOT NULL,
    id_sucursal integer NOT NULL
);

CREATE TABLE public.usuarios (
    id serial PRIMARY KEY,
    username character varying(30) NOT NULL,
    clave text NOT NULL,
    nombres character varying(30),
    apellidos character varying(30),
    id_rol integer,
    caja_prioridad character varying(20) DEFAULT 'FIFO'::character varying,
    estado boolean DEFAULT false
);

ALTER TABLE ONLY public.turnos_generados
    ADD CONSTRAINT botones_turnos_generados FOREIGN KEY (id_boton) REFERENCES public.botones(id);

ALTER TABLE ONLY public.turno_llamada
    ADD CONSTRAINT turno_llamada_fk FOREIGN KEY (id_turno) REFERENCES public.turnos_generados(id);

ALTER TABLE ONLY public.turnos_generados
    ADD CONSTRAINT turnos_generados_sucfk FOREIGN KEY (id_sucursal) REFERENCES public.sucursales(id);

ALTER TABLE ONLY public.turnos_generados
    ADD CONSTRAINT turnos_generados_user_fk FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id);

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_fk FOREIGN KEY (id_rol) REFERENCES public.roles(id);

