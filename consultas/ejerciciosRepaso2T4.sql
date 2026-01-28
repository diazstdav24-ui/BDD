
/*Seleccionar el identificador del vuelo, el nombre del aeropuerto de origen y la duración del vuelo en horas (con dos decimales) para aquellos vuelos que:

Hayan salido un sábado o domingo.

La hora de salida sea después de las 20:00.

El destino no sea un aeropuerto de España.

Ordena el resultado por la duración del vuelo de mayor a menor.*/


select v.id_vuelo, ae_origen.nombre, v.llegada-v.salida as duracion
from vuelo v join aeropuerto ae_origen on (v.desde = ae_origen.id_aeropuerto)
			 join aeropuerto ae_destino on (v.hasta = ae_destino.id_aeropuerto)
where extract (isodow from v.salida) in (6,7)
and extract (hour from v.salida) >20
and ae_destino.ciudad not in ('Málaga','Sevilla','Barcelona','Madrid','Bilbao')
order by duracion desc;

/*Mostrar el nombre del vendedor, la provincia y el porcentaje de rebaja (diferencia entre precio inicial y precio final) de aquellos inmuebles que:

Sean de tipo 'Oficina' o 'Local'.

Se hayan vendido en las provincias de Sevilla o Málaga.

Hayan tardado en venderse entre 2 y 5 meses desde su fecha de alta.

Ordena la salida por el nombre del vendedor alfabéticamente.*/


select v.nombre, i.provincia, round((((i.precio - o.precio_final) / i.precio::numeric)*100),2) as "Porcentaje rebaja"
from vendedor v join operacion o using (id_vendedor)
				join inmueble i using (id_inmueble)
				join tipo t on (t.id_tipo = i.tipo_inmueble)
where t.nombre in ('Oficina','Local')
and i.provincia in ('Sevilla','Málaga')
and age(o.fecha_operacion,i.fecha_alta) between interval '2 months' and interval'5 months'
order by  v.nombre asc ;









/*Obtener un listado con el nombre de la empresa cliente (company_name), el nombre del empleado que atendió el pedido y
el retraso en días para aquellos pedidos donde:

El pedido se realizó en un lunes de cualquier año.

El retraso (diferencia entre shipped_date y required_date) sea de más de 3 días.

El empleado sea 'Janet Leverling'.

Ordena por el retraso de forma descendente.*/


select c.company_name ,e.first_name ||' '|| e.last_name as "Nombre Completo", o.required_date-o.shipped_date as "Retraso"
from customers c join orders o using (customer_id)
	  		     join employees e using (employee_id)
where extract (isodow from o.order_date) = 1
and age(o.required_date,o.shipped_date) > interval '3 days' 
and e.first_name ilike 'Janet' 
and e.last_name ilike 'Leverling'
order by "Retraso" desc;

/*Selecciona el nombre y el apellido de todos los empleados de la tabla employees. Para cada uno, 
intenta buscar su cambio de puesto más reciente en la tabla job_history. Si el empleado nunca ha cambiado de puesto,
sus datos deben aparecer igualmente con el nuevo campo vacío.*/

select e.first_name, e.last_name, j.job_title
from employees e left join jobs j using (job_id);

/*Muestra el ID y la dirección de todos los inmuebles que nunca han tenido ninguna operación (ni venta ni alquiler)*/

select i.id_inmueble, i.provincia
from inmueble i left join operacion o using (id_inmueble)
where o.id_inmueble is null;

/*Muestra la dirección de todos los inmuebles de la provincia de 'Sevilla'. Para cada inmueble,
busca el precio_final más alto que haya tenido en la tabla de operaciones. 
Si un inmueble no tiene ninguna operación registrada, debe aparecer igualmente con el precio vacío.*/

select i.id_inmueble,
from inmueble i left join operacion o using (id_inmueble)
where provincia ilike 'Sevilla'; 


/*Selecciona el nombre, 
el apellido y el nombre del departamento de aquellos empleados que trabajen en oficinas de 'América'  
y cuya fecha de contratación (HIRE_DATE) fuera en los meses de Mayo o Septiembre de cualquier año.
Ordena el resultado por el apellido de forma ascendente.*/


select e.first_name, e.last_name, d.department_name
from employees e join departments d using (department_id)
				 join locations l using (location_id)
				 join countries c using (country_id)
				 join regions r using (region_id)
where r.region_name ilike 'America%'
and extract(month from e.hire_date) in ('5','9')
order by e.last_name asc;



/*Muestra el identificador y la dirección de los inmuebles de las provincias de 'Sevilla' o 'Huelva' 
que se dieron de alta en un viernes  
y que nunca han tenido ninguna operación registrada (están sin vender ni alquilar*/

select i.id_inmueble,i.provincia
from inmueble i left join operacion o using (id_inmueble)
where i.provincia in ('Sevilla','Huelva')
and extract (isodow from i.fecha_alta) = 5
and o.id_inmueble is null; 

/*Selecciona el nombre del vendedor, 
la provincia del inmueble y el precio final de todas las operaciones de venta de tipo 'Local' u 'Oficina' 
realizadas en las provincias de 'Sevilla' o 'Málaga'.

El requisito principal es que el inmueble haya tardado en venderse entre 2 y 5 meses 
(contados desde su fecha de alta hasta la fecha de la operación).*/



select v.nombre, i.provincia, o.precio_final
from vendedor v join operacion o using (id_vendedor)
				join inmueble i using (id_inmueble)
				join tipo t on (t.id_tipo = i.tipo_inmueble)
where t.nombre in ('Local','Oficina')
and i.provincia in ('Sevilla','Málaga')
and age(o.fecha_operacion,i.fecha_alta) between interval '2 months' and interval '5 months';

/*Obtén un listado que muestre el nombre de la empresa cliente (company_name), 
el nombre completo del empleado que atendió el pedido (nombre y apellido concatenados) y 
una columna llamada 'Dias_Espera' que calcule cuánto tiempo pasó desde que se pidió el producto hasta que se envió.

Solo deben aparecer los registros que cumplan lo siguiente: 
1. El pedido se realizó un lunes. 
2.El envío (shipped_date) se retrasó más de 10 días respecto a la fecha en que se requería (required_date).*/



select c.company_name, e.first_name ||' '|| e.last_name, 
		o.required_date-o.shipped_date as "Dias Espera"
from customers c join orders o using (customer_id)
				 join employees e using (employee_id)
where extract(isodow from o.order_date) = 1
and age(o.required_date,o.shipped_date) > interval '10 days';


/*La inmobiliaria quiere un informe de eficiencia de ventas. 
Selecciona la dirección del inmueble, la provincia y el número de días (en formato numérico) que el inmueble estuvo en el mercado.

Solo deben aparecer aquellos inmuebles que:

Sean de la provincia de 'Sevilla' o 'Cádiz'.

Hayan tardado en venderse más de 2 meses desde su fecha de alta.*/


select i.provincia, 
		ROUND(EXTRACT(EPOCH FROM age(o.fecha_operacion,i.fecha_alta)) / 86400.0, 2) AS "Dias en el mercado"
from inmueble i join operacion o using (id_inmueble)
where i.provincia in ('Sevilla','Cádiz')
and age(o.fecha_operacion,i.fecha_alta) > interval '2 months';


/*Calcular la antelación media en horas con la que se realizan las reservas de vuelos cuyo origen esté en España 
(Sevilla, Madrid, Bilbao, Málaga y Barcelona) y cuyo destino esté fuera de España,
excluyendo aquellos vuelos que se hayan realizado en fin de semana ampliado 
(viernes a partir de las 15:00, sábados y domingos completos). 
El resultado debe mostrar un único valor numérico.*/

select round (extract(epoch from avg (age(v.llegada,v.salida)))/3600,2)
from vuelo v join aeropuerto ae_origen on (ae_origen.id_aeropuerto = v.desde)
			 join aeropuerto ae_destino on (ae_destino.id_aeropuerto = v.hasta)
where ae_origen.nombre in ('Madrid','Sevilla','Málaga','Barcelona','Bilbao')
and (
		extract (isodow from v.salida) in (1,2,3,4)
		or ( extract ( isodow from v.salida) = 5 
				and extract (hour from v.salida) <15)
	);
			 


