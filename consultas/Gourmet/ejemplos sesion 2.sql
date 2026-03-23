select count(*) as "Total clientes" 
from cliente; 

select max(pvp)
from producto;

select round(avg(pvp),2)
from producto; 

select round(avg(pvp),2)
from producto
where pvp < 20;

select count(pvp)
from producto
where  pvp < 20; 

select * 
from lineaventa;

--Subtotal de cada venta 
select id_venta,sum(precio_unitario * cantidad 
		- round (coalesce((precio_unitario * cantidad * descuento),0),2)) as "subtotal"
from lineaventa 
group by (id_venta)
order by id_venta ; 

--Número de undades de articulos que se han vendido en cada venta 
select id_venta,sum(cantidad) as "Cantidad articulo"
from lineaventa
group by (id_venta)
order by id_venta; 

--La cantidad de ud de prod que ha comprado cada cliente 

select id_cliente, sum (cantidad)
from venta v join lineaventa lv on (lv.id_venta=v.id)
group by v.id_cliente; 

--La cantidad de ud de producto que ha comprado cada cliente pero con su nombre apellido 
select c.nombre, c.apellidos, v.id_cliente, sum(lv.cantidad)
from venta v join lineaventa lv on (lv.id_venta=v.id)
			join cliente c on (v.id_cliente = c.id )
group by c.nombre, c.apellidos, v.id_cliente; 

--Lo que está en el select o esta en el group by o es una de la 5. Todo lo que este en el group by no tiene porque estar en el select, pero lo que esta
--en el select tiene que estar en el group by


