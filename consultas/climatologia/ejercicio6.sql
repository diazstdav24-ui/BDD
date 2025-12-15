select round (avg( temperatura_media ),2) 
--select avg (temperatura_maxima 
				--+minimia
from climatologia
where provincia in ('Sevilla','Jaén','Málaga','Huelva','Granada','Cadíz','Almería','Córdoba')
	and starts_with (estacion,'Al')
	--upper(left (estacion,2)) = 'al'
	and fecha between '2019-05-01' and '2019-05-31';
	--left (fecha::text,7) = '2019-05'
	--o tambien se puede con fecha::text ilike '2019-05-%%', pero como dice que no usemos el like no lo he usado


select fecha, estacion, temperatura_media, precipitacion_total
	CASE 
		WHEN precipitacion_total >= 50 then 'CHUZOS DE PUNTA'
		WHEN precipitacion_total between<= 40 and >50 then 'A CÁNTAROS'
		WHEN precipitacion_total between<= 25 and <40 then 'MUCHA LLUVIA'
		WHEN precipitacion_total between <= 10 and <25  then 'FALTA LE HACÍA AL CAMPO'
		WHEN precipitacion_total  < 10 then 'HA LLOVIDO POCO'
		else 'NO HA LLOVIDO'
		end
from climatologia
where provincia ilike 'jaen'
	and fecha::text ilike '2019-11-%'; --Esto no se puede porque between no puede usar los operadores
	
SELECT  fecha,estacion, temperatura_media, precipitacion_total,
    CASE 
        WHEN precipitacion_total >= 50 THEN 'CHUZOS DE PUNTA'
        WHEN precipitacion_total >= 40 AND precipitacion_total < 50 THEN 'A CÁNTAROS'
        WHEN precipitacion_total >= 25 AND precipitacion_total < 40 THEN 'MUCHA LLUVIA'
        WHEN precipitacion_total >= 10 AND precipitacion_total < 25 THEN 'FALTA LE HACÍA AL CAMPO'
        WHEN precipitacion_total > 0 AND precipitacion_total < 10 THEN 'HA LLOVIDO POCO'
		--WHEN precipitacion_total = 0 THEN 'NO HA LLOVIDO'
		ELSE 'NO HA LLOVIDO'
    END AS intensidad_lluvia
FROM
    climatologia
WHERE
    provincia ilike 'jaén'
    AND fecha::text ILIKE '2019-11-%'
order by fecha , estacion asc;
---------------------------------

select 
		upper(estacion) as "ESTACION",
		upper(provincia) as "PROVINCIA",
		temperatura_maxima
from climatologia 
where hora_temperatura_maxima = '14:00'
	and fecha::text ilike ('2019-03-%')
	and (provincia ilike 'asturias' 
		or provincia ilike 'cantabria') ;
----------------------------------

select 
	provincia,
	fecha,
	upper(estacion) as  estación,
	round(avg(temperatura_media)) as "Temperatura_Media"
from climatologia
where 
	(precipitacion_total >80 
	or provincia not in ('Sevilla','Málaga','Jaén','Córdoba','Almería','Huelva','Cadíz','Granada'))
	and estacion ilike 'g%'
group by 
		provincia,
		fecha,
		upper(estacion),
		temperatura_media
order by Temperatura_Media desc;

