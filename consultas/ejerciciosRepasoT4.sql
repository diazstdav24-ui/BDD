/*1. El "Flash Sale": Selecciona la dirección, la provincia y el precio final de aquellos inmuebles de tipo 'Local' o 'Oficina'
que se hayan vendido en menos de 15 días desde su fecha de alta. Ordena por rapidez de venta.*/

select i.provincia, o.precio_final
from inmueble i join tipo t on (t.id_tipo = i.tipo_inmueble)
				join operacion o using (id_inmueble)
where t.nombre in ('Local','Oficina')
and i.tipo_operacion ilike 'Venta'
and  age(i.fecha_alta,o.fecha_operacion) < interval  '15 days';


/*2. Margen de Beneficio: Calcula el precio medio por metro cuadrado de las ventas realizadas en la provincia de 
'Sevilla' durante el primer semestre de 2023. El resultado debe estar redondeado a dos decimales. (Dato: precio_final / superficie).*/

select round (avg(o.precio_final::numeric/i.superficie),2)
from inmueble i join operacion o using (id_inmueble)
where i.provincia ilike  'Sevilla'
and extract (month from o.fecha_operacion) between 1 and 6;



select 
from operacion;

/*3. Análisis de Primavera: Muestra el nombre del vendedor,
la ciudad del inmueble y la fecha de operación de todas las ventas de 'Casas' realizadas en 'Huelva' o 'Almería' durante los meses de abril,
mayo y junio de cualquier año. Usa EXTRACT para los meses.*/

select v.nombre, i.provincia, o.fecha_operacion 
from vendedor v join operacion o using (id_vendedor)
			   join inmueble i using (id_inmueble)
			   join tipo t on (t.id_tipo = i.id_inmueble)
where t.nombre ilike 'Casa'
and i.tipo_operacion ilike 'Venta'
and i.provincia in ('Huelva','Almería')
and extract (month from o.fecha_operacion) between 4 and 6;


/* El Salto Transatlántico: Selecciona el id_vuelo, la ciudad de origen y la ciudad de destino de los vuelos cuya duración sea superior a 8 horas.
Muestra la duración formateada como "Horas Totales" (en número) usando EPOCH.*/

select v.id_vuelo, ae_desde.ciudad, ae_hasta.ciudad, 
		round (extract (epoch from  (v.llegada-v.salida) )/3600,2) as "Horas totales"
from vuelo v join aeropuerto ae_desde on (ae_desde.id_aeropuerto = v.desde)
			 join aeropuerto ae_hasta on (ae_hasta.id_aeropuerto = v.hasta)
where extract (epoch from ( v.llegada-v.salida) )/3600 > 8;
--Otra forma v.llegada - v.salida > interval '8 hour';
			 

/*6. Doble Identidad (Joins): Muestra el nombre completo de los clientes (Formato: Nombre Apellidos) y 
el nombre del aeropuerto de destino para aquellos que vuelen desde España hacia cualquier aeropuerto que no esté en 'España', 'Portugal' o 'Francia'.*/

															
select c.nombre ||' '|| c.apellido1 ||' '|| c.apellido2 as "Nombre completo"
		, ae_destino.ciudad
from cliente c join reserva r using (id_cliente)
			   join vuelo v using (id_vuelo)
			   join aeropuerto ae_destino on (ae_destino.id_aeropuerto = v.hasta)
			   join aeropuerto ae_origen on (ae_origen.id_aeropuerto = v.desde)
where ae_origen.ciudad in ('Sevilla','Madrid','Bilbao','Málaga','Barcelona')
and ae_destino.ciudad not in ('París','Ankara','Sevilla','Madrid','Bilbao','Málaga','Barcelona');


select *
from aeropuerto;

/*7. El Reto del Viernes: Calcula la antelación media (en días enteros) con la que reservan sus vuelos los clientes que viajan en "Viernes de escapada" 
(Viernes a partir de las 14:00). Solo para vuelos con un precio base superior a 150€.*/


select trunc (extract( epoch from avg ((v.salida-r.fecha_reserva))/86400)) as media 
from vuelo v  join reserva r using (id_vuelo )
where extract (isodow from v.salida) = 5
and extract ( hour from v.salida) >= 14
and v.precio >150;

/*8. Regalo de Cumpleaños: Selecciona los clientes que viajan en el mes de su cumpleaños. Muestra su nombre, 
su edad actual y el precio final que pagaron por el vuelo tras aplicar el descuento (si el descuento es NULL, el precio es el original).*/

select c.nombre, (current_date-c.fecha_nacimiento) as "Edad Actual", round (coalesce (v.precio - v.precio*(v.descuento/100),v.precio),2)
from cliente c join reserva r using (id_cliente)
				join vuelo v using (id_vuelo)
