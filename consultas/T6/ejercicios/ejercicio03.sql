
create table invitado (

nroInvitado		serial ,
nombre 			varchar(100) not null, 
categoria 		varchar(100), 
origen			varchar(3) not null, /*Abreviación de su pais */
constraint pk_invitado primary key(nroInvitado)
);

create table Teatro (

codTeat 		serial ,
nombre			varchar(100) not null,
direccion		varchar(40) not null,
cantAsiento 	smallint not null,
constraint pk_Teatro primary key(codTeat)

); 

create table Obra (
codObra 		serial ,
nombreObra		varchar(250) not null,
Autor 			varchar(200) ,
constraint pk_Obra primary key(codObra)
); 

create table Exhibe (

codTeat 		int, 
fecha 			timestamp not null,
codObra 		int,
constraint pk_Exhibe primary key(codTeat, fecha)

); 


create table tipo_asiento (

tipo 			varchar(10),
nombre			varchar(10) not null, 
descripcion		varchar(300),
constraint pk_tipo_asiento primary key (tipo)

);

create table asiento_tipo (

nroAsiento		serial,
tipo			varchar(10),
constraint pk_asiento_tipo primary key (nroAsiento)

); 

create table precio (

codTeat 		int,
fecha			timestamp,
tipo			varchar(10),
precio			numeric(5,2) not null,
constraint pk_precio primary key (codTeat,fecha,tipo)

);

create table entrada (

codTeat			int,
fecha 			timestamp,
nroAsiento		int,
nroInvitado		int,
constraint pk_entrada primary key (codTeat,fecha,nroAsiento)

); 


alter table exhibe 
	add constraint fk_teatro foreign key (codTeat) references Teatro (codTeat),
	add constraint fk_obra  foreign key (codObra) references obra (codObra);


alter table asiento_tipo
	add constraint fk_tipo_asiento foreign key (tipo) references tipo_asiento (tipo);

alter table precio 
	add constraint fk_precio_exhibe foreign key (codTeat,fecha) references exhibe (codTeat,fecha),
	add constraint fk_tipo foreign key (tipo) references tipo_asiento (tipo); 

alter table entrada 
	add constraint fk_entrada_exhibe foreign key (codTeat,fecha) references exhibe (codTeat,fecha),
	add constraint fk_asiento_tipo foreign key (nroAsiento) references asiento_tipo (nroAsiento),
	add constraint fk_invitado foreign key (nroInvitado) references invitado (nroInvitado);




