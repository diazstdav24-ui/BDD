/*1.Muestra el nombre del empleado,
la suma total de sus ventas (precio_total en la tabla venta), 
y el porcentaje que representa esa suma sobre el histórico de facturación absoluta de toda la tienda. 
(Redondea el porcentaje a 2 decimales).)*/

select 
	nombre, 
	sum(precio_total), sum(precio_total)
	( select 
		sum(precio_total)
		
	)
from empleado join venta using (id_empleado); 

/*Queremos analizar los tickets de compra. 
El gerente quiere saber, para cada venta, 
cuál es la cantidad media de artículos que se han comprado por línea.
Hay que mostrar el id de la venta, la fecha y esa "media de artículos por línea".*/

select v.id, v.fecha, media.media_articulos
from  venta v join (
						select id_venta, round (avg(cantidad),2) as media_articulos
						from lineaventa lv
						group by lv.id_venta
					 ) media on (v.id = media.id_venta) 

--Simulacro de examen 
/*Pregunta 1
Muestra el nombre de cada producto, el dinero total que ha generado a lo largo del tiempo (calculado con su cantidad y precio unitario) y qué porcentaje exacto representa ese dinero sobre el gran total de dinero generado por todos los productos en toda la historia de la tienda.

Pregunta 2
Muestra el nombre de cada empleado y la diferencia matemática entre el precio de la venta más cara y el precio de la venta más barata que ha gestionado cada uno de ellos a lo largo de su carrera en la tienda.

Pregunta 3
Obtén el nombre y apellidos de aquellos clientes cuyo gasto total acumulado en la tienda (la suma de todos sus tickets) sea estrictamente mayor que el gasto total medio por cliente de toda la empresa.

Pregunta 4
Muestra el nombre de todos los productos del catálogo que no han sido comprados nunca (es decir, que no aparecen en ninguna línea de venta). Aplica las restricciones de operadores indicadas para este examen.

Pregunta 5
Selecciona el identificador de la venta, la fecha y el nombre del producto, única y exclusivamente para aquella línea de venta en la que se haya registrado la mayor cantidad de unidades compradas de un mismo producto de toda la historia de la base de datos.*/

/*Pregunta 1

Muestra el nombre de cada producto, el dinero total que ha generado a lo largo del tiempo

(calculado con su cantidad y precio unitario) y qué porcentaje exacto representa ese dinero 

sobre el gran total de dinero generado por todos los productos en toda la historia de la tienda.

*/



select 

p.nombre, 

lv.precio_unitario * lv.cantidad as dinero_generado, 

round (lv.precio_unitario * lv.cantidad /

(

select sum(lv1.precio_unitario * lv1.cantidad)

from lineaventa lv1

) 

* 100.0,2) as porcentaje 

from lineaventa lv join producto p on (p.id = lv.id_producto)

   join venta v on (v.id = lv.id_venta); 





/*Pregunta 2

Muestra el nombre de cada empleado y la diferencia matemática entre el precio 

de la venta más cara y el precio de la venta 

más barata que ha gestionado cada uno de ellos a lo largo de su carrera en la tienda.*/





select 

e.nombre, 

max(precio_total) - min(precio_total) as diferencia

from empleado e join venta v using (id_empleado)

group by e.nombre, v.id_empleado;



/*Pregunta 3

Obtén el nombre y apellidos de aquellos clientes cuyo gasto total acumulado en la tienda 

(la suma de todos sus tickets) sea estrictamente mayor que el gasto total medio por cliente

de toda la empresa.

*/





select 

c.nombre,

c.apellidos

from cliente c join lineaventa lv on (lv.id_producto = c.id)

   join venta v on (lv.id_venta = v.id)

where precio_total > all 

(

select avg(precio_total)

from venta v1

)



/*

Pregunta 4

Muestra el nombre de todos los productos del catálogo que no han sido comprados nunca 

(es decir, que no aparecen en ninguna línea de venta). 

Aplica las restricciones de operadores indicadas para este examen.*/



select p.nombre 

from productos p join lineaventa lv on (lv.id_producto = p.id)

where 





/* Pregunta 5

Selecciona el identificador de la venta, la fecha y el nombre del producto, 

única y exclusivamente para aquella línea de venta en la que se haya registrado la mayor 

cantidad de unidades compradas de un mismo producto de toda la historia de la base de datos.*/



select v.id, v.fecha, p.nombre, count(cantidad) as total_cantidad

from venta v join lineaventa lv on (v.id = id_venta)

join producto p on (id_producto = p.id)

group by p.nombre, v.id, v.fecha

having count(cantidad) > all 

(

select count (cantidad)

from lineaventa lv1

group by lv1.id

)

;

/*
El gerente quiere analizar la constancia de sus empleados.
Muestra el id de la venta, la fecha y el precio_total de aquellos tickets de compra 
cuyo importe sea estrictamente mayor que la facturación media por ticket de ese mismo empleado.
*/

select v.id, fecha, precio_total 
from venta v 
where precio_total >
					(
						select round (avg(precio_total),2) 
						from venta v1
						where v.id_empleado = v1.id_empleado
					)
;

/*

Queremos saber cuál ha sido la venta más loca y variada de la tienda. 
Muestra el id de la venta y el número de líneas asociadas que tiene, pero 
SOLO para aquel ticket (o tickets) que tenga la mayor cantidad de líneas de venta de toda la historia.
*/

select v.id as venta_id, count (lv.id) as lineaventa_id
from venta v join lineaventa lv on (v.id = id_venta) 
group by v.id
having count (lv.id) >= all
		(
			select  count (lv1.id)
			from  venta v1 join lineaventa lv1 on (v1.id = id_venta) 
			group by v1.id
		)
;

/*
El gerente está revisando el catálogo y quiere hacer limpieza. 
Necesita que le muestres el nombre del producto y el dinero total que ha generado 
(calculando la suma de su cantidad por su precio unitario), pero SOLO para aquel 
producto (o productos) que haya generado los ingresos totales más bajos de toda la historia de la tienda.
*/




select p.nombre , sum(cantidad * precio_unitario) as precio_total
from lineaventa lv join producto p on (id_producto = p.id)
group by p.nombre, lv.id_producto 
having sum(cantidad * precio_unitario) <= all 
											(
												select sum(cantidad * precio_unitario)
												from lineaventa 
												group by id_producto
											)

