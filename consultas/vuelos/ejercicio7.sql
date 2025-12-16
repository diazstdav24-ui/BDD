
select * 
from vuelos; 


--Yo
select *
from vuelos
where desde = 'Berlín'
and hasta ='Londres'
and llegada::text between '2020-09%' and '2020-12%';

select *, 	
	round(precio - ((precio * descuento ) /100 ),2) as "Precio con descuento"
from vuelos
where desde in ('Sevilla','Málaga')
	and hasta in ('Madrid','Barcelona')
	and salida::text ilike '2020-12%';

--Compañero



--Grupo
select count(*)
from vuelos
where desde ilike 'Berlín'
and hasta  ilike 'Londres'
and llegada::text between '2020-09%' and '2020-12%';

select *, 	
	COALESCE (
		round(precio - ((precio * descuento ) /100 ),2),
		precio) as "Precio Descuento"
from vuelos
where desde in ('Sevila','Málaga')
	and hasta in ('Madrid','Barcelona')
	and salida::text ilike '2020-12%';

------------------------------
--Resultado corregido
select *, 	
	COALESCE (
		round(precio - ((precio * descuento ) /100 ),2),
		precio) as "Precio Descuento"
from vuelos
where desde in ('Sevilla','Málaga')
	and hasta in ('Madrid','Barcelona')
	and salida::text ilike '2020-12%';

select count(*)
--select *
from vuelos
where desde ilike 'Berlín'
	and hasta  ilike 'Londres'
	and (llegada::text ilike '2020-10-%'
		or llegada::text ilike '2020-11-%'
		or llegada::text ilike '2020-12-%');



