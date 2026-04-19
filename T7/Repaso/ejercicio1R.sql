
create table usuario (

codUsuario 		serial,
email	   		varchar(150) not null, 
password 		varchar(10) not null,
fechaAlta 		date not null,
nombre			varchar(100) not null,

constraint pk_usuario primary key(codUsuario)
); 

create table revision (

codUsuario		serial,
id_revisable	serial,
fecha			timestamp not null,
comentario		varchar(300),

constraint pk_revision primary key (codUsuario, id_revisable)
);

create table revisable (

id_revisable	serial,

constraint pk_revisable primary key (id_revisable)

); 

create table serie (

codSerie		serial,
nombre			varchar(150) not null,
numTemporada	int not null,
id_revisable	serial,
idCompania		serial,



constraint pk_serie	primary key (codSerie)
); 


create table episodio (

numEpisodio		serial,
titulo			varchar(15) not null,
codSerie		serial,
id_revisanle	serial,

constraint pk_episodio primary key (numEpisodio)
); 

create table emision (

numEpisodio		serial,
fecha			date,

constraint pk_emision primary key (numEpisodio	)
); 

create table actua (

numSegSocial	serial,
codSerie		serial,

constraint pk_actua primary key (numSegSocial, codSerie)
); 

create table actor (

numSegSocial	serial,

constraint pk_actor primary key (numSegSocial)
); 

create table director (

numSegSocial	serial,

constraint pk_director primary key (numSegSocial)
); 

create table empleado (

numSegSocial	serial,
nombre			varchar(150) not null,
direccion		varchar(300) not null,
sueldo			numeric(9,2) not null,

constraint pk_empleado primary key (numSegSocial)
);

create table trabaja (

fechaInicio		date,
idCompania		serial,
numSegSocial	serial,
fechaFin		date,

constraint pk_trabaja primary key (fechaInicio,idCompania,numSegSocial)
);

create table compania(

idCompania 		serial,
nombre			varchar(150) not null,

constraint pk_compania primary key (idCompania)
);

alter table revision 
	add constraint fk_revision_usuario foreign key (codUsuario) references usuario(codUsuario),
	add constraint fk_revision_revisable foreign key (id_revisable) references revisable(id_revisable);

alter table serie
	add constraint fk_serie_revisable foreign key (id_revisable) references revisable(id_revisable),
	add constraint fk_serie_compania foreign key  (idCompania) references compania(idCompania);

alter table trabaja
	add constraint fk_trabaja_compania foreign key (idCompania) references compania(idCompania),
	add constraint fk_trabaja_empleado foreign key (numSegSocial) references empleado(numSegSocial);

alter table actua
	add constraint fk_actua_actor foreign key (numSegSocial) references actor(numSegSocial),
	add constraint fk_actua_serie foreign key (codSerie) references serie(codSerie);

alter table episodio
	add constraint fk_episodio_serie foreign key (codSerie) references serie(codSerie),
	add constraint fk_episodio_revisable foreign key (revisable) references revisable(id_revisable);

alter table emision 
	add constraint fk_emision_episodio foreign key (numEpisodio) references episodio;


