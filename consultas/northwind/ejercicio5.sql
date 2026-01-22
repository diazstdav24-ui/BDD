/*Seleccionar los nombres de los productos que hayan sido solicitados en pedidos que hayan sido enviados por la empresa United Package.
*/
select distinct product_name
from products join order_details using (product_id)
			  join orders using (order_id)
			  join shippers s on (orders.ship_via = s.shipper_id)
where s.company_name ilike 'United Package';


/*Seleccionar el nombre del producto y el de su categoría,
para aquellos productos que se hayan incluido en algún pedido, para todos aquellos pedidos solicitados en un día de Agosto*/

select distinct product_name, category_name
from products p join categories on (p.category_id = categories.category_id)
				join order_details od using (product_id)
				join orders o using (order_id)
where extract (month from order_date ) in ('08');

/*Seleccionar el nombre de todas las empresas que sean clientes, hayan realizado pedidos o no.*/

select distinct company_name
from customers left join orders using(customer_id);

/*Seleccionar el nombre de los empleados que han atendido pedidos realizados por clientes de Brasil (Brazil).*/
select distinct first_name 
from employees e join orders using (employee_id)
				 join customers using (customer_id)
where customers.country in ('Brasil','Brazil');

/*Seleccionar el nombre de la categoría y los productos que se han pedido en aquellos pedidos que han sido atendidos por Janet Leverling (EMPLOYEE).*/

select distinct product_name, category_name
from products join categories using (category_id)
			  join order_details using (product_id)
			  join orders using (order_id)
			  join employees using (employee_id)
where first_name ilike 'Janet' 
and last_name ilike 'Leverling';


/* Seleccionar el nombre de la empresa, su país, la fecha y el coste de envío (Freight) del pedido con mayor porte de cada cliente,
junto con el nombre completo del empleado que lo gestionó. 
Filtrar solo clientes de Alemania o Francia y pedidos ya enviados. 
Nota: Obtener el pedido máximo usando obligatoriamente LATERAL y unir la tabla de empleados usando JOIN ON. Ordenar por coste de envío descendente. */

select distinct company_name, customers.country, shipped_date,  o.freight, e.first_name
from customers left join orders o using (customer_id)
			   join employees e on (e.employee_id = o.employee_id)
where customers.country in ('Alemania','Francia');







