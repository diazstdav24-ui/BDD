
/*Seleccionar el id_vuelo, la ciudad de origen, la ciudad de destino, la fecha y hora de salida, la fecha y hora de llegada y 
la duración del vuelo en minutos para aquellos vuelos que hayan salido en el tercer trimestre de 2023, 
cuya duración sea superior a 120 minutos y en los que el avión tenga una capacidad igual o superior a 300 pasajeros.
Ordena el resultado por duración del vuelo de mayor a menor.
*/

select v.id_vuelo, a_desde.ciudad, a_hasta.ciudad, 
		v.llegada, v.salida, v.llegada - v.salida  as "duración"
from vuelo v join aeropuerto a_desde on (a_desde.id_aeropuerto = v.desde)
			 join aeropuerto a_hasta on (a_hasta.id_aeropuerto = v.hasta)
			 join avion a using (id_avion)
where extract (quarter from v.salida) = 3 
and extract (year from v.salida) = 2025
and (v.llegada - v.salida) > interval '120 minutes'
/*extract (epoch from v.llegada-v.salida) /60 >120 */ --Aqui uso epoch debido a que cuando me devuelve intervalo epoch lo pone todo en segundos, luwgo lo paso a minutos y le digo que sea mayor que 120
and a.max_pasajeros >= 300
order by age(v.llegada,v.salida) desc 



/*Mostrar el id de la reserva, el nombre completo del cliente con el formato APELLIDO1 APELLIDO2, 
Nombre, el id del vuelo, la fecha y hora de salida, la fecha de la reserva y el número de días de antelación con el que se realizó la reserva, 
para aquellas reservas en las que la antelación sea de al menos 10 días y cuyo primer apellido del cliente empiece por la letra “M”, 
sin distinguir entre mayúsculas y minúsculas.
Ordena el resultado por mayor antelación.
*/

select r.id_reserva, upper (c.apellido1)  || ' ' || upper (c.apellido2) || ', '||  
	   c.nombre as nombre_completo , v.id_vuelo,
	   v.salida, v.llegada, r.fecha_reserva, 
	    v.salida - r.fecha_reserva as "dif reserva"
from reserva r join cliente c using (id_cliente)
			 join vuelo v using (id_vuelo)
where (v.salida-r.fecha_reserva) >= interval '10 days' --Aqui no se puede usar extract porque extrae el los dias pero no los dias totales ej 1 mon y 14 days, solo extrae 14 days 
and c.apellido1 ilike 'M%'
order by v.salida-r.fecha_reserva desc

/*Obtener un listado con el id de la reserva, el id del vuelo, el precio original, 
el descuento aplicado (considerando 0 si no existe), el precio final tras aplicar el descuento, redondeado a dos decimales, 
y la hora de salida del vuelo, para aquellas reservas correspondientes a vuelos que salgan de lunes a jueves, cuya hora de salida esté entre las 06:00 y las 14:00 
y cuyo precio final sea superior a 200 euros.
Ordena el resultado por fecha y hora de salida.
*/

select r.id_reserva, v.id_vuelo, v.precio,
	   coalesce(v.descuento,0) as descuento, coalesce (round (precio - (precio * (descuento/100)),2),precio) as precio_final,
	   v.salida as "Fecha salida"
from reserva r join vuelo v using (id_vuelo)
where extract(isodow from v.salida) in (1,2,3,4)
and extract (hour from v.salida ) between 6 and 14
and round (precio - (precio * (descuento/100)),2) > 200.0
order by v.salida;  

/*Seleccionar los clientes que hayan realizado un vuelo el mismo día y mes de su cumpleaños, mostrando el id del cliente, 
su nombre completo, la fecha de nacimiento, la fecha y hora de salida del vuelo, la edad del cliente en el momento del vuelo,
así como la ciudad de origen y la ciudad de destino del vuelo.
Ordena el resultado por fecha de salida del vuelo de forma ascendente.
*/

select  c.apellido1 ||' '||c.apellido2 ||', '||c.nombre as "Nombre completo", 
	   c.id_cliente, c.fecha_nacimiento, v.salida,
	   age(v.salida, c.fecha_nacimiento) as "Edad Cliente",
	   ae_desde.ciudad , ae_hasta.ciudad   
from cliente c join reserva r using (id_cliente)
			   join vuelo v using (id_vuelo)
			   join aeropuerto ae_desde on (ae_desde.id_aeropuerto = v.desde)
			   join aeropuerto ae_hasta on (ae_hasta.id_aeropuerto = v.hasta)
where extract (day from c.fecha_nacimiento) = extract (day from v.salida)
and extract (month from c.fecha_nacimiento) = extract (month from v.salida)
order by v.salida asc;

/*Calcular la antelación media en horas con la que se realizan las reservas de vuelos cuyo origen esté en España 
(considerando como ciudades españolas Sevilla, Madrid, Bilbao, Málaga y Barcelona) y cuyo destino esté fuera de España,
excluyendo aquellos vuelos que se hayan realizado en fin de semana ampliado, considerando como tal los viernes a partir de las 15:00 horas,
así como los sábados y domingos completos.
El resultado debe mostrar un único valor numérico correspondiente a dicha antelación media.
*/


select round (extract(epoch from (avg( v.salida-r.fecha_reserva))/3600),2) as " media de antelación en horas" 
from reserva r  join vuelo v using (id_vuelo)
			   join aeropuerto ae_desde on (ae_desde.id_aeropuerto = v.desde)
			   join aeropuerto ae_hasta on (ae_hasta.id_aeropuerto = v.hasta)
where ae_desde.ciudad in ('Sevilla','Madrid','Barcelona','Bilbao','Málaga')
and ae_hasta.ciudad not in ('Sevilla','Madrid','Barcelona','Bilbao','Málaga')
and (extract(isodow from v.salida) between 1 and 4
		or (extract (isodow from v.salida) = 5
	 and extract (hour from v.salida) < 15));
