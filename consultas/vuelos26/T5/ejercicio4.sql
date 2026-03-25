

/*1.Seleccionar el vuelo más largo (con mayor duración) de cada día de la semana. Debe aparecer 
el nombre del aeropuerto de salida, el de llegada, la fecha y hora de salida y llegada y la duración. */

select  ae_desde.nombre as desde , ae_hasta.nombre as hasta, 
		extract(hour from v1.salida) as "hora salida", extract (hour from v1.llegada) as "hora llegada",
		v1.salida, v1.llegada, age(v1.llegada,v1.salida) as duracion ,extract(isodow from v1.salida) as dia_semana
from vuelo v1 join aeropuerto ae_desde on (v1.desde = ae_desde.id_aeropuerto)
			  join aeropuerto ae_hasta on (v1.hasta = ae_hasta.id_aeropuerto)
where age(v1.llegada,v1.salida) >= all (
				select age(v2.llegada,v2.salida) 
				from vuelo v2 
				where extract(isodow from v1.salida) = 
				extract (isodow from v2.salida) --Aqui le digo que mire las fechas 
				
) 
order by dia_semana;


/*2.Seleccionar el cliente que más ha gastado en vuelos que 
salen del mismo aeropuerto. Debe aparecer el nombre del cliente,
el nombre y la ciudad del aeropuerto y la cuantía de dinero que ha gastado.
 */


select c.nombre, ae.nombre, ae.ciudad, coalesce (sum(precio-(precio*(descuento/100))),0) as precio_total
from cliente c join reserva using (id_cliente)
			   join vuelo v using (id_vuelo)
			   join aeropuerto ae on (ae.id_aeropuerto = v.desde)
group by c.nombre, ae.nombre, ae.ciudad
order by precio_total desc
limit 1; 

/*3.Seleccionar el piso que se ha vendido más caro de cada provincia.
Debe aparecer la provincia, el nombre del comprador, la fecha de la operación y la cuantía.
*/

select i.provincia, c.nombre, o.fecha_operacion, o.precio_final
from inmueble i join tipo t on (t.id_tipo = i.tipo_inmueble)
				join operacion o using (id_inmueble)
				join comprador c using (id_cliente)
where o.precio_final >= all (
			select o1.precio_final
			from operacion o1  join inmueble i1 using (id_inmueble)
				join tipo t1 on (t1.id_tipo = i1.tipo_inmueble)
			where i1.provincia = i.provincia	
			and t1.nombre ilike 'piso'
)
and t.nombre ilike 'piso';

/*4Seleccionar los alquileres más baratos de cada provincia y mes 
(da igual el día y el año). Debe aparecer el nombre de la provincia, el nombre del mes, 
el resto de atributos de la tabla inmueble y el precio final del alquiler.
*/


select i.provincia, to_char(o.fecha_operacion, 'month') as mes, i.tipo_operacion, 
		 i.superficie, i.precio, o.precio_final, i.id_inmueble,i.fecha_alta,i.tipo_inmueble
from inmueble i join  operacion o using (id_inmueble) 
where i.tipo_operacion ilike 'Alquiler'
and o.precio_final <= all (
			select o1.precio_final
			from inmueble i1 join operacion o1 using (id_inmueble)
			where i1.tipo_operacion ilike 'Alquiler'
			and i1.provincia = i.provincia 
			and extract (month from o1.fecha_operacion) = 
			extract (month from o.fecha_operacion)
); 


