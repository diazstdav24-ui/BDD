
create table Autor(

DNI 			varchar(9),
Nombre			varchar(100) not null, 
Nacionalidad 	varchar(3)/*Las abreviaciones del pais*/,
constraint pk_autor primary key (DNI)

);

create table Editorial (

Cod_editorial 	serial,
Nombre			varchar(100) not null,
Direccion 		varchar(40),
Poblacion 		varchar(40), 
constraint pk_Editorial primary key (Cod_editorial)

);

create table Genero (

Id_genero 		serial,
Nombre 			varchar not null, 
Descripcion 	varchar(900),
constraint pk_Genero primary key (Id_genero)
);


create table Libro (

ISBN 			varchar(13),
Titulo 			varchar(100) not null,
Dni_autor		varchar(9) not null, 
Cod_genero 		integer not null, 
Cod_editorial 	integer not null, 

constraint pk_libro primary key (isbn),
constraint fk_autor foreign key (Dni_autor) references autor ,
constraint fk_genero foreign key (Cod_genero) references genero,
constraint fk_editorial foreign key (Cod_editorial) references editorial

);


create table Edicion (

ISBN 				varchar(13),
Fecha_publicacion	date, 
cantidad 			integer,
constraint pk_Edicion primary key (ISBN, Fecha_publicacion), /*Esto es una clave primaria compuesta porque no es capaz de refernciarse pro si sola */
constraint fk_edicion foreign key (ISBN) references Libro,
constraint ck_cantidad  check  (cantidad > 0 )

);

