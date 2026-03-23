SELECT nombre, pvp
FROM producto
WHERE pvp IN (
    SELECT pvp
    FROM producto
    GROUP BY pvp
    HAVING COUNT(*) > 1
);

--Seleccionar el nombre, pvp de aquellos
--productos que son más caros que algún 
--producto cuyo nombre contiene cervezas: 

SELECT nombre, pvp
FROM producto
WHERE pvp > ANY (
	SELECT pvp 
	FROM producto
	WHERE nombre ILIKE '%cerveza%'
)
ORDER BY pvp; 
--La consulta de fuera lo que hace es listar cualquiera producto que el precio se mayor que cualquiera de la consulta 

--Any es mayor que alguno, con que sea mayor que alguno sirve 

--Operador all: 
-- Seleccionar Producto mas caro de todos los productos: 
SELECT nombre, pvp
FROM producto
where pvp >= all (
	select pvp 
	from producto
); 

select nombre, pvp
from producto 
where pvp 
order by pvp desc 
limit 1; 

---- Seleccionar Producto mas caro de todos los productos, por letra de inicio 

SELECT left (nombre,1),nombre, pvp
FROM producto p1
where pvp >= all (
	select pvp 
	from producto p2
	where left (p1.nombre,1) = left (p2.nombre,1)
	order by left (nombre,1)
) 
order by left (nombre,1);

--Tiene que ser mayor o igual que el maximo 



--Ejercicios: 
--2. 
select * 
from venta
where precio_total in (
	select precio_total
	from venta
	group by precio_total
	having count (*) >1
);

--ejercicio 7:

select nombre,pvp 
from producto 
where pvp <= all (
	select pvp 
	from producto 
	where pvp > 100
); 

--Boletín de ejercicios: 

--3.2 
select c.nombre, max(avg(o.precio_final))
from comprador c join operacion o using (id_cliente)
				join inmueble i using (id_inmueble) 
				join tipo on ( i.id_inmueble = tipo.id_tipo)
where tipo_operacion = 'Venta' 
	and i.provincia ilike 'Almería'
	and tipo_inmueble ilike 'Casa'
	and precio_final > (
		select avg 
		where tipo_operacion = 'Venta' 
	and i.provincia ilike 'Almería'
	and tipo_inmueble ilike 'Casa
	)
group by c.nombre; 


select * 
from inmueble;

