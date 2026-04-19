
drop table if exists parqueNatural cascade;

create table parqueNatural (

codParque 		serial,
nombre			varchar(150) not null,
fechdecpln		date,

constraint pk_parqueNatural	primary key (codParque)
); 

drop table if exists area cascade;

create table area (

nombre_area				varchar(150),
codParque				int,
extension				bigint not null,

constraint pk_area primary key (nombre_area, codParque)
); 

drop table if exists vive cascade;

create table vive (

nombre_area					varchar,
codParque					int,
nombreCientifico		varchar(300),

constraint pk_vive primary key (nombre_area,nombreCientifico,codParque)
); 

drop table if exists especie cascade;

create table especie (

nombreCientifico		varchar(300) unique,
nombreVulgar			varchar(150) unique ,
numEjemplares			int not null,
tipo					varchar check (tipo in ( 'vegetal','animal')),

constraint pk_especie primary key (nombreCientifico) 
);

drop table if exists acceso cascade;


create table acceso (

id_acceso 				serial,
nombre_area				varchar(150),
codParque				int,
dni_gestor				varchar(9),

constraint pk_acceso primary key (id_acceso)
); 

drop table if exists gestor cascade;


create table gestor (

dni_gestor				varchar(9),

constraint pk_gestor primary key (dni_gestor)
);

drop table if exists trabajador cascade;

create table trabajador (

dni 					varchar(9),
nombre					varchar(150) not null,
telefono				varchar(9)	not null,
codParque				int,

constraint pk_trabajador primary key (dni)
);

drop table if exists vigilante cascade;

create table vigilante(

dni_vigilante			varchar(9),
nombre_area				varchar(150),
codParque				int,


constraint pk_vigilante	primary key (dni_vigilante)
);


alter table area	
	add constraint fk_parqueNatural_area foreign key (codParque) 
	references parqueNatural(codParque)
	on delete cascade; 

alter table vive 
	add constraint fk_area_vive	foreign key (nombre_area, codParque) 
	references area (nombre_area,codParque) 
	on delete cascade,
	add constraint fk_especie_vive foreign key (nombreCientifico)
	references especie(nombreCientifico)
	on delete cascade; 


alter table acceso 
	add constraint fk_area_acceso foreign key (nombre_area,codParque) 
	references area(nombre_area,codParque) 
	on delete set null,
	add constraint fk_gestor_acceso foreign key (dni_gestor)
	references gestor
	on delete set null;
alter table acceso 
	add constraint fk_area_acceso foreign key (nombre_area,codParque) 
	references area(nombre_area,codParque) 
	on delete set null,
	add constraint fk_gestor_acceso foreign key (dni_gestor)
	references gestor
	on delete set null;


	




