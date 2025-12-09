select * 
from climatologia;

select estacion,    
	round(avg( precipitacion_total), 2 ) as "media_total"
from climatologia
where provincia ilike 'sevilla'
	and fecha between '2019-04-01' and '2019-04-30'
group by estacion 

select climatologia.temperatura_media,climatologia.temperatura_maxima,climatologia.temperatura_media,
		climatologia.velocidad_maxima_viento, climatologia.precipitacion_total,climatologia.estacion
from climatologia
where estacion ilike '%e%'
	and (fecha between'2019-02-20' and '2019-02-28' 
	or fecha between '2019-03-20' and '2019-03-31'
	or fecha between '2019-04-20' and '2019-04-30')
order by climatologia.estacion asc, climatologia.provincia asc, climatologia.fecha desc;

select sum (precipitacion_total) AS "precipitacion_total_galicia"
from climatologia 
where provincia IN ('A Coruña','Lugo','Pontevedra','Ourense')
 	AND fecha BETWEEN '2019-09-01' AND '2019-09-30';

select fecha, estacion, provincia, precipitacion_total

	round((precipitacion_0_a_6::numeric/precipitacion_total)*100,2) as "Porcentaje_0_6",
	round((precipitacion_6_a_12::numeric/precipitacion_total)*100,2)as "Porcentaje_6_12",
from climatologia;
where 
	