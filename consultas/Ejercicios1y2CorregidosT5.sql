-- 1. Seleccionar el salario máximo de cada departamento,
--mostrando el nombre del departamento y dicha cantidad.

select d.department_name, max(salary) as "Salario maximo"
from employees join departments d using (department_id)
group by d.department_name; 

--2.Seleccionar el salario mínimo de cada departamento, 
--para aquellos departamentos cuyo salario mínimo sea menor que 5000$.

select d.department_name, min(salary) as "Salario maximo"
from employees join departments d using (department_id)
group by d.department_name 
having min(salary) < 5000; 

--3.Seleccionar el número de empleados que trabajan en cada oficina
--, mostrando el STREET_ADDRESS 
--y dicho número; hay que ordenar la salida de mayor a menor 

select street_address, count(*) as num_empleados
from locations l join departments using (location_id)
			   join employees e using (department_id)
group by l.street_address
order by num_empleados desc; 



--4.Modificar la consulta anterior para que muestre las localizaciones que no tienen ningún empleado.

--Aqui debo de usar el having y el left join, ya que con el inner join si una oficina no tiene empleado simplemente desaparece
select l.street_address, count (e.employee_id) as num_empleados
from locations l left join departments using (location_id)
			   left join employees e using (department_id)
group by l.street_address
having count(e.employee_id) = 0
order by num_empleados desc; 

--Cuando le pones count(*) cuenta las filas, en cambio con e.employee_id cuenta los id por lo tanto los nulos los toma como 0 

--5.Seleccionar el salario que es cobrado a la vez por más personas. Mostrar dicho salario y el número de personas.

select salary, count(*) as num_personas
from employees 
group by salary 
order by num_personas desc
limit 1;

--Con lo que sabemos no podemos dar otra solución, habria que hacer subconsultas

--6.Seleccionar el número de empleados que empezaron a trabajar cada año, ordenando la salida por el año.

select extract (year from hire_date) as anio, count(employee_id) 
from employees 
group by extract (year from hire_date)
order by anio; 

--Extract se puede usar en el select, group by o where

--1.Seleccionar el número de pedidos atendidos por cada empleado, sí y sólo si dicho número está entre 100 y 150.

select employee_id, count(*)
from orders
group by (employee_id)
having count(*) between 100 and 150; --Having se usa para filtrar filas cuando ya las tengo agrupadas, where hace lo contrario 


--2. Seleccionar el nombre de las empresas que no han realizado ningún pedido.

select company_name, count(order_id) as pedidos
from orders right join customers using(customer_id)
group by company_name
having count(order_id) = 0; 

--Explicacion de porque usar id cuando contamos y usamos un join lateral: 
/*1. El comportamiento de COUNT(*)
La función COUNT(*) cuenta filas completas, independientemente de si su contenido es nulo o no
.
En tu consulta, al usar un RIGHT JOIN, el sistema se asegura de que todos los clientes aparezcan en el resultado
.
Si un cliente no tiene pedidos, el JOIN genera una fila "artificial" que contiene los datos del cliente y rellena con NULL los huecos donde deberían ir los datos del pedido
.
Como esa fila existe físicamente en la tabla temporal que crea SQL, COUNT(*) la cuenta como 1
. Por eso, nunca encontrarías clientes con "0" pedidos usando el asterisco.
2. El comportamiento de COUNT(columna)
A diferencia del anterior, COUNT(expresión) solo cuenta las filas donde el valor de esa columna no es nulo (NOT NULL)
.
Al decirle que cuente orders.order_id, el motor mira específicamente esa columna en cada fila del grupo
.
En los clientes que no tienen pedidos, el campo order_id es NULL
.
Como COUNT(columna) ignora los nulos, el resultado para esos clientes será 0*/


--3.Seleccionar la categoría que tiene más productos diferentes solicitados en pedidos. 
--Mostrar el nombre de la categoría y dicho número

select category_name, count( distinct units_on_order)
from categories join products using (category_id)
				join order_details using (product_id)
group by category_name
order by category_name desc 
limit 1; 

--4.Si suponemos que nuestro margen de beneficio con los productos es de un 25% 
--(es decir, el 25% de su precio, son beneficios, y el 75% son costes), calcular la cantidad de beneficio que hemos obtenido, 
--agrupado por categoría y producto. Las cantidades deben redondearse a dos decimales.

select  category_name, product_name, round(sum(quantity * o.unit_price * 0.25)::numeric,2) as margen_benefeicio
from categories join products using (category_id)
				join order_details o using (product_id)
group by category_name, product_name;

--5.Selecciona aquellos clientes (CUSTOMERS) para los que todos los envíos que ha recibido 
--(sí, todos) los haya transportado (SHIPPERS) la empresa United Package

select distinct c.company_name, s.company_name
from customers c left join orders o  using (customer_id) 
				join  shippers s on (o.ship_via= s.shipper_id)
where s.company_name ilike 'United Package'

