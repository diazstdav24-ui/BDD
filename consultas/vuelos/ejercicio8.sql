
select * 
from vuelos;
--Ejercicio1
select *,
	COALESCE (
		round(precio - ((precio * descuento ) /100 ),2),
		precio) as "Precio Final", 
	COALESCE (
		round (((precio*descuento)/100),2), 0
	) as "Descuento"
from vuelos
where desde in('Sevilla','Málaga')
	and salida::text ilike '2019-%'
	and hasta in ('Barcelona','Madrid')
	and precio >= 80;

--Ejercicio2
select 
		upper(substring(desde,1,3)) || '-' ||
		upper(substring(hasta,1,3)) || '-' ||
		lpad ((id::text),4,'0') as codigo_ruta
from vuelos;
--Ejercicio3
select *,
	COALESCE (
		round(precio - ((precio * descuento ) /100 ),2),
		precio) as "Precio Final", 
	case 
		when descuento is null then 'sin_descuento'
		when descuento  >= 30 then 'descuento_alto'
		else 'descuento_bajo'
	end as tipo_descuento
from vuelos
where 
	salida::text ilike '2020-03-%'
	and 
		(desde in ('Londres','París')
		or hasta in ('Sevilla,Málaga'))
	and precio between 60 and 300
	and (descuento is not null 
		or precio > 200);  

--Ejercicio4

select 
	count (*) as "Total_vuelos",
	max(precio) as precio_maximo,
	min(precio) as precio_minimo,
	round (avg(precio),2) as precio_medio,
	round (avg(COALESCE(descuento,0)),2) as descuento_medio
from vuelos
where 
	salida::text ilike '2020-%'
	and desde in ('Madrid','Barcelona','Sevilla','Málaga')
	and precio between 60 and 500 
	and desde <> hasta;

	
--ejercicio5
select 
	id,
	upper (desde) as "desde", 
	upper (hasta) as "hasta",
	round (precio,2)
	ABS(precio - ROUND(precio, -1)) AS "Diferencia Absoluta"
from vuelos
where 
	salida::text ilike '2019-%'
	and (hasta ilike 'B%'
		or hasta ilike 'a%')
	and COALESCE (
				(descuento >= 10),
				'0'
					)
	and precio<200; 




