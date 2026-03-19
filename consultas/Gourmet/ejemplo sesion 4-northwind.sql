--La suma de los importes de la venta agrupados por clientes
--para las ventas del mes de marzo 

select id_cliente sum(precio_total)
from venta   
where extract(month from fecha) = 3 --El where siempre va antes del group by 
group by id_cliente;

--Aqui necesitabamos filtrar antes de agrupar 
--where sirve para quedarnos con una tabla o varías que cumplen esa condición 


--Qué clientes han realizado más de 10 pedidos.


select id_cliente, count(*)
from venta     
group by id_cliente
having count(*) > 10; --Aqui si se puede tener funciones de grupo, porque ya tenemos los datos agrupados 

--aqui necesitamos filtrar despues de agrupar. Por eso usamos having, ya que se usa despues 
--Aquellos clientes con mas de 15 pedidos en el primer semestre del año 

select id_cliente, count(*)
from venta  
where extract(month from fecha ) <=6  
group by id_cliente
having count(*) > 15; 


--Ejercicios con northwind 
--Ejercicio 1: Mostrar el número de pedidos por cliente.

select customer_id, count(*) as pedidos
from orders 
group by customer_id; 

--Ejercicio 2 : Mostrar los clientes con más de 10 pedidos.
select customer_id, count(*) as pedidos
from orders 
group by customer_id 
having count(*) > 10; 
--Ejercicio 3 : Mostrar el número de pedidos gestionados por cada empleado.
select employee_id, count(*) as "pedidos gestionados"
from orders 
group by employee_id;
--Ejercicio 4: Mostrar los empleados que han gestionado más de 50 pedidos.
select employee_id, count(*) as "pedidos gestionados"
from orders 
group by employee_id
having count(*) > 50; 
--Ejercicio 5: Mostrar productos cuyo precio medio de venta sea superior a 30.

select round(avg(unit_price)),2
from order_details
group by (product_id)
having avg(unit_price) >30; 


--Ejercicio 6: ¿Qué clientes han realizado más de 15 pedidos?

select customer_id, count(*)
from orders 
group by customer_id
having count (*) > 15; 

--Ejercicio 7 : ¿Qué empleados han gestionado más de 100 pedidos?

select employee_id, count(*) as "pedidos gestionados"
from orders 
group by employee_id
having count(*) > 100; 

-- Ejercicio 8: ¿Qué productos se han vendido más de 500 unidades?
select product_id, sum(quantity)
from order_details
group by (product_id)
having sum(quantity) > 500;

--mañana ejercicio 1 y 2 