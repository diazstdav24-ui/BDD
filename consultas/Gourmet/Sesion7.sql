--seleccionar el prodcuto mas caro de cada categoria 
--La subconsulta de dentro se va a aejecutar tanta como filas tengamos en la consulta de fuera
select category_name, product_name, unit_price
from products p  join categories c using (category_id)
where unit_price >= all (
	select unit_price
	from products p2 
	where p.category_id = p2.category_id
	/*Es lo mismo que 
where unit_price = (
	select max(unit_price)
	from products p2 
	where p.category_id = p2.category_id
)
	*/
) ;  

--Pensar siempre en un bucle for anidado dentro de otro bucle for que se recorren simultaneamente, es decir en la iteración de uno 
--Se hace con la iteración del otro

SELECT p1.product_name, p1.unit_price, p1.product_id
FROM products p1
WHERE p1.unit_price >
(
    SELECT AVG(p2.unit_price)
    FROM products p2
    WHERE p2.category_id = p1.category_id
);



--selecciona la venta mas cara de cada cliente (mostrando nombre,id_cliente,fecha,precio_total,numero_articulo)
--Cuando pedimos un dato individual, ya no podemos usar group by
--Si no me lo piden y pyuedo mostrar solo el grupo y la función de agregación pues uso group by 
select nombre, id_cliente, fecha, precio_total,numero_articulos
from venta v1 join cliente c on (v1.id_cliente = c.id )
where precio_total >= all (
		select v2.precio_total
		from venta v2 
		where v2.id_cliente = v1.id_cliente
); 
