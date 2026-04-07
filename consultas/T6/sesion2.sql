
drop table if exists usuario;

create table usuario (

	--Serial es un integer marca que va seguir un orden serial
	id 						serial primary key ,
	nombre 					varchar(256) not null, 
	email 					varchar(320) not null unique ,
	fecha_registro 			timestamp default current_timestamp ,
	edad 					int2 	, --Es igual que samll int
	precio_subscripcion 		numeric(4,2) constraint precio_positivo 	 --Le asigna un nombre a la condición boleana
							 check (precio_subscripcion >= 0.0) --Esto es para condicionar una columna, en este caso para que el precio no sea menor que 0.0
	--Lo ideal sería poner id serial constraint primary_key primary key
	,
	
	ultima_conexion timestamp default current_date
);

insert into usuario (nombre,email,edad,precio_subscripcion)
values ('Luismi','luismi.lopez@trirana.salesianos.edu',43,25.6)

select * 
from usuario;
