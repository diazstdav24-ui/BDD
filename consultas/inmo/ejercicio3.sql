
select * 
from tipo;

--1Selecciona los datos del inmueble sobre el que se ha realizado una 
--operación un lunes de febrero o un viernes de marzo, que tenga más de 200 
--metros cuadrados y donde el nombre del vendedor contenga una A mayúscula o minúscula.

select *, to_char(fecha_operacion, 'ID-MM') 
from inmueble i join operacion using (id_inmueble)
				join vendedor using (id_vendedor)
where to_char  (fecha_operacion,'ID-MM') in ('1-02','5-03')
	and i.superficie >200 
	and nombre ilike '%A%';

--2.Selecciona el precio medio por metro cuadrado de los alquileres de viviendas 
--en los meses de marzo y abril de cualquier año para las provincias costeras de Andalucía.

select * 
from inmueble;


select round(avg(precio/superficie),2) as "Precio Medio"
from inmueble 
where provincia in ('Almería','Cádiz','Huelva','Granada','Málaga')
and tipo_operacion ilike 'Alquiler'
and extract (month from fecha_alta) in (03,04);

--3.¿Cuál es la media del porcentaje de diferencia entre el 
--precio inicial (en la tabla inmueble) y el precio final (en la tabla operación) para aquellas operaciones de alquiler realizadas en enero de cualquier año,
--donde el tipo del inmueble es Oficina,Local o Suelo?



select round (avg( ((i.precio - o.precio_final)/i.precio)*100),2) 
from inmueble i join operacion o using (id_inmueble)
				join tipo t on (id_tipo = i.tipo_inmueble)
where extract (month from fecha_operacion) in (01)
and t.nombre in ('Oficina','Local','Suelo');

--4.Seleccionar el nombre de aquellos compradores de Casa o Piso en las provincias de Jaén o Córdoba, 
--donde el precio final de inmueble esté entre 150.000 y 200.000€, para aquellos inmuebles que han tardado entre 3 y 4 meses en venderse.

select c.nombre
from comprador c join operacion o using (id_cliente)
			   join inmueble i using ( id_inmueble)
			   join tipo t on (i.tipo_inmueble = t.id_tipo)
where i.provincia in ('Jaén','Córdoba')
	  and o.precio_final between 150000 and 200000
	  and extract ( month from age(o.fecha_operacion,i.fecha_alta)) between 3 and 4
	  and  t.nombre in ('Casa','Piso');


--5.Selecciona la media del precio inicial (en la tabla inmueble), del precio final (en la tabla operación) y de la diferencia en porcentaje 
--entre ellas de aquellas viviendas (Casa o Piso) en alquiler que tengan menos de 100 metros cuadrados y que hayan tardado un año o más en alquilarse.
select avg(precio) as "Porcentaje precio inicial",
	   avg (precio_final) as "Porcentaje precio final",
	   round (avg( ((precio - precio_final)/precio)*100),2)  as "Diferencia porcentaje"
from inmueble join operacion using (id_inmueble)
			  join tipo t on (inmueble.tipo_inmueble = id_tipo)
where nombre in ('Casa','Piso')
	and tipo_operacion ilike 'Alquiler'
	and superficie <100 
	and extract ( year from age(fecha_operacion,fecha_alta)) >= 1;

--6.Selecciona el alquiler de vivienda (Casa o Piso) más caro realizado en 
--Julio o Agosto de cualquier año en la provincia de Huelva.
select t.nombre, precio_final, fecha_operacion
from tipo t join inmueble on (t.id_tipo = tipo_inmueble)
			join operacion using ( id_inmueble)
where t.nombre in ('Casa','Piso')
	  and extract(month from fecha_operacion) in ('07','08')
	  and provincia ilike 'Huelva'
order by precio_final desc 
limit 1;

/*Columnas a mostrar: El nombre del tipo de inmueble, la provincia, el precio final y una columna calculada llamada "Meses_en_Venta".

Fechas: Filtra solo las operaciones que se firmaron en el primer trimestre (Enero, Febrero, Marzo) de cualquier año.

Tablas: Necesitarás inmueble, operacion y tipo.

Join Obligatorio: Recuerda que la tabla tipo no se une igual que las demás.

Orden: Ordena los resultados para ver primero los que se vendieron más rápido (menor tiempo de venta).*/

select t.nombre, provincia,precio_final, 
	   age(fecha_operacion,fecha_alta) as "Meses_en_Venta"
from tipo t join inmueble on (id_tipo = tipo_inmueble)
		  join operacion using (id_inmueble)
where extract( month from fecha_operacion) in ('01','02','03')
order by "Meses_en_Venta" asc;

