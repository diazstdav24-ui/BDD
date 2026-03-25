/*La dirección quiere evaluar el peso de cada transportista (shippers).
Muestra el nombre de la empresa de transporte,
cuántos pedidos ha transportado en su historia, 
y qué porcentaje representa ese número sobre el total absoluto de pedidos de toda la base de datos.
(Pista: Para hacer la división matemática, necesitas el total de pedidos global. 
Esa es la subconsulta que va directa en el SELECT).*/

select
	company_name, 
	(count(ship_via) * 100)/(select count(order_id) from orders ) as porcentaje 
	--Otra forma sería (count(ship_via) ::numeric)/(select count(order_id) from orders ) * 100
	 --as porcentaje
from shippers s join orders o on (s.shipper_id = o.ship_via)
group by company_name;
