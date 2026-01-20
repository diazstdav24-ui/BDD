/*Seleccionar el COMPANY_NAME y CONTACT_NAME de aquellos CUSTOMERS que hayan hecho pedidos (ORDERS).
*/
/*Seleccionar el COMPANY_NAME y CONTACT_NAME de aquellos CUSTOMERS que hayan hecho pedidos (ORDERS).
*/

select distinct company_name, contact_name
from customers join orders using(customer_id);

select distinct company_name, contact_name
from customers left join orders using(customer_id);

/*para saber cuando utilizo uno u otro */

/*Seleccionar el número de pedidos que hemos enviado en la década de 
los 90 con las empresas Federal Shipping o United Package.*/

select count(*)
from shippers s join orders o on (s.shipper_id = o.ship_via)
where s.company_name in ('Federal Shipping','United Package')
and to_char (o.shipped_date,'yy') like '9%';
/*Mejor el año con 4 cifras:'yyyy'*/
/*Con overlaps: and (shipped_date,shipped_date)
					overlaps 
					(make_date(1990,1,1), make_date (199,12,31));*/

/*Seleccionar el nombre de aquellos productos que han sido solicitados en algún pedido.*/
select distinct product_name
from products join order_details using (product_id);

/*Seleccionar la suma de los importes "cobrados" en todos los pedidos realizados en el año 96.*/
select round(sum( od.unit_price * od.quantity)::numeric,2) as total_Venta96
from order_details od join products p using (product_id) 
					  join orders using (order_id)
where to_char (orders.order_date,'yy') = '96'; 


/*Seleccionar el nombre de contacto del cliente y el del empleado para aquellos 
clientes y empleados que han participado en pedidos donde la 
diferencia entre la fecha de envío y la fecha de requisito sea menos de 20 días*/

select c.contact_name, e.first_name
from customers c join orders ord using (customer_id)
	 			 join employees e using (employee_id)
where (ord.required_date - ord.order_date) <=20;

/*"Seleccionar el nombre completo del empleado, el nombre del producto, la categoría y 
el importe total para aquellos empleados y productos que han participado en pedidos donde el año de envío sea 1997, 
la cantidad supere las 20 unidades, el producto no esté descatalogado y la categoría sea 
'Beverages' o 'Confections', ordenando el resultado por el importe de mayor a menor.".*/

select e.first_name, e.last_name, p.product_name,cat.category_name,
round(( od.unit_price * od.quantity)::numeric,2) as "total"
from employees e join orders ord using (employee_id)
				 join order_details od using(order_id)
				 join products p using (product_id)
				 join categories cat using (category_id)
where od.quantity >20 
and extract (year from ord.shipped_date) = 1997
and discontinued =0
and cat.category_name in ('Beverages','Confections')
order by desc;


				 



select distinct company_name, contact_name
from customers join orders using(customer_id);

/*Seleccionar el número de pedidos que hemos enviado en la década de 
los 90 con las empresas Federal Shipping o United Package.*/

select count(*)
from shippers s join orders o on (s.shipper_id = o.ship_via)
where s.company_name in ('Federal Shipping','United Package')
and to_char (o.shipped_date,'yy') like '9%';

/*Seleccionar el nombre de aquellos productos que han sido solicitados en algún pedido.*/
select distinct product_name
from products join order_details using (product_id);

/*Seleccionar la suma de los importes "cobrados" en todos los pedidos realizados en el año 96.*/
select round(sum( od.unit_price * od.quantity)::numeric,2) as total_Venta96
from order_details od join products p using (product_id) 
					  join orders using (order_id)
where to_char (orders.order_date,'yy') = '96'; 


/*Seleccionar el nombre de contacto del cliente y el del empleado para aquellos 
clientes y empleados que han participado en pedidos donde la 
diferencia entre la fecha de envío y la fecha de requisito sea menos de 20 días*/

select c.contact_name, e.first_name
from customers c join orders ord using (customer_id)
	 			 join employees e using (employee_id)
where (ord.required_date - ord.order_date) <=20;

/*"Seleccionar el nombre completo del empleado, el nombre del producto, la categoría y 
el importe total para aquellos empleados y productos que han participado en pedidos donde el año de envío sea 1997, 
la cantidad supere las 20 unidades, el producto no esté descatalogado y la categoría sea 
'Beverages' o 'Confections', ordenando el resultado por el importe de mayor a menor.".*/

select e.first_name, e.last_name, p.product_name,cat.category_name,
round(( od.unit_price * od.quantity)::numeric,2) as "total"
from employees e join orders ord using (employee_id)
				 join order_details od using(order_id)
				 join products p using (product_id)
				 join categories cat using (category_id)
where od.quantity >20 
and extract (year from ord.shipped_date) = 1997
and discontinued =0
and cat.category_name in ('Beverages','Confections')
order by desc;


				 


