/*Ejercicio 4: Queremos encontrar las 
"Ventas Destacadas" de la plantilla. 
Muestra el id de la venta, el id_empleado que la hizo y
el precio_total de esa venta, SOLO si el precio de esa venta
es superior a la media de ventas de ese empleado en concreto.*/

select v.id, v.id_empleado, v.precio_total
from venta v 
where precio_total > ( 
					select avg(v2.precio_total)
					from venta v2 
					where v2.id_empleado = v.id_empleado
);

/*El dueño de la tienda Gourmet quiere premiar a los "Empleados Estrella". 
Un empleado estrella es aquel cuya facturación total 
a lo largo del tiempo es superior a la facturación media del resto de la plantilla.*/

with facturacion_plantilla as (
select id_empleado, sum(precio_total) as suma_total
from venta v 
group by id_empleado
) --Esto crea una tabla virtual, no es una columna 
select e.nombre, fp.suma_total
from facturacion_plantilla fp join empleado e using(id_empleado)
where fp.suma_total > (
	select avg(suma_total)
	from facturacion_plantilla fp

)


