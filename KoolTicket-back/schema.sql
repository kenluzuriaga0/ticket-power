CREATE TABLE IF NOT EXISTS public.boton (
	id serial4 NOT NULL,
	nombre varchar(255) NOT NULL,
	prefijo_ticket varchar(255) NOT NULL,
	color varchar(255) NULL,
	orden int4 null,
	estado bool NULL,
	CONSTRAINT boton_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.roles (
	id serial4 NOT NULL,
	nombre varchar(255) NOT NULL,
	estado bool NULL,
	CONSTRAINT roles_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.usuario (
	id serial4 NOT NULL,
	username varchar(255) NOT NULL,
	nombres varchar(255) NOT NULL,
	apellidos varchar(255) NOT NULL,
	caja_prioridad varchar(255) NULL,
	creado_en timestamp(6) NULL,
	"password" varchar(255) NOT NULL,
	id_rol int4 NULL,
	turno_actual_id int8 null,
	estado bool NULL,
	CONSTRAINT usuario_pkey PRIMARY KEY (id),
	CONSTRAINT id_rol_usuario_fk FOREIGN KEY (id_rol) REFERENCES public.roles(id),
	CONSTRAINT usuario_turnos_generados_fk FOREIGN KEY (turno_actual_id) REFERENCES public.turnos_generados(id);
);


CREATE TABLE IF NOT EXISTS public.sucursal (
	id serial4 NOT NULL,
	nombre text NOT NULL,
	direccion text NULL,
	orden int4 NULL,
	estado bool NULL,
	CONSTRAINT sucursal_pkey PRIMARY KEY (id)
);


CREATE TABLE IF NOT EXISTS public.turnos_generados (
	id bigserial NOT NULL,
	id_boton int4 NULL,
	numero int4 NULL,
	fecha_generado timestamp(6) NOT NULL,
	fecha_atendido timestamp(6) NULL,
	tiempo_atencion time(6) NULL,
	caja_num varchar(255) NULL,
	id_sucursal int4 NULL,
	estado varchar(255) NULL,
	sucursal_nombre varchar(255) NULL,
	id_usuario int4 NULL,
	usuario_crea varchar(255) NULL,
	CONSTRAINT turnos_generados_pkey PRIMARY KEY (id),
	CONSTRAINT id_usuario_turno_fk FOREIGN KEY (id_usuario) REFERENCES public.usuario(id),
	CONSTRAINT id_boton_turno_fk FOREIGN KEY (id_boton) REFERENCES public.boton(id),
	CONSTRAINT id_sucursal_turno_fk FOREIGN KEY (id_sucursal) REFERENCES public.sucursal(id)
);

CREATE TABLE IF NOT EXISTS public.turno_llamada (
	id bigserial NOT NULL,
	id_turno int8 NULL,
	fecha_llamada timestamp(6) NOT NULL,
	usuario_llamada varchar(255) NOT NULL,
	CONSTRAINT turno_llamada_pkey PRIMARY KEY (id),
	CONSTRAINT id_turno_llamada_fk FOREIGN KEY (id_turno) REFERENCES public.turnos_generados(id)
);
