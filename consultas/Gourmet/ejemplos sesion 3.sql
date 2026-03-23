-- Aparezca el cliente el importe y lo que ha gastado 

select c.nombre, c.apellidos, email, sum(v.precio_total)
from cliente c join venta v on (c.id = v.id)
group by c.id;

select * 
from venta; 

--Seleccionar el número de productos
--

select e.id_empleado, nombre, 
		apellido1, apellido2 , count(distinct id_producto),array_agg(fecha) --Si no usamos funciones como esta la fecha no se pueda sacar
from venta v join empleado e on (v.id_empleado = e.id_empleado)
			join lineaventa lv on (lv.id_venta = v.id)
group by e.id_empleado;

--Si agrupo lo normal es que use una funcion de agregación, si no ¿Para que agrupo?

--Ejercicio 1 ¿Cuántas ventas ha realizado cada cliente?

select c.id, c.nombre, c.apellidos, count(fecha)
from cliente c join venta v on (v.id_cliente = c.id)
group by c.nombre;

--ejercicio 2 ¿Cuánto dinero ha gastado cada cliente?

select   c.nombre, c.apellidos, sum(precio_total)
from cliente c join venta on (id_cliente = c.id)
group by c.id;

--ejercicio 3 ¿Cuántos artículos se han vendido de cada producto?
select id_producto, sum( cantidad)
from lineaventa 
group by id_producto; 


--ejercicio 4: ¿Cuántas ventas ha realizado cada empleado?

select e.id_empleado cont



select * 
from lineaventa;

