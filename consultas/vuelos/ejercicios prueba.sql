select *, 
		COALESCE(
			(round(precio-((precio*descuento)/100),2)),0
			)as "Precio_neto"
from vuelos
where desde in ('Sevilla','Malaga')
	and (descuento > 15 or precio <100.0)
order by precio  desc;


select  
	desde || ' VIA ' || hasta as "ruta_detallada",
	COALESCE (
			(round(precio-((precio*descuento)/100),2)),precio
			) as "precio_final",
	Case 
		when precio <= 80000 then 'tarifa_mini'
		when precio >80000 and precio <= 300000 then 'tarifa_flexible'
		else 'tarifa_business'
		end as "Categoría_Vuelos"
from vuelos
order by precio asc;


select distinct hasta,
		desde, 
		salida,
		length(desde) as "longitud_origen"
from vuelos
where desde ilike 'B%'
	and (salida::text ilike '2021-04-%'
		or salida:: text ilike '2020-05-%')
order by longitud_origen desc;
		