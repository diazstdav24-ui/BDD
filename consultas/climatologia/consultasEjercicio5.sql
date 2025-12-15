
select * 
from climatologia;

select estacion,    
	round(avg( precipitacion_total), 2 ) as "media_total"
from climatologia
where provincia ilike 'sevilla'
	and fecha between '2019-04-01' and '2019-04-30'
	--and fecha::text like '2019-04%'. Vamos a pasar las fechas a cadena de caracteres, por ahora
group by estacion;

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

select fecha, estacion, provincia, precipitacion_total,
	Round( case 
			when precipitacion_total = 0 then 0.00
			else (precipitacion_0_a_6::numeric/precipitacion_total)*100 end,2) as "Porcentaje_0_6"
	Round( case 
			when precipitacion_total = 0 then 0.00
			else(precipitacion_6_a_12::numeric/precipitacion_total)*100 end,2)as "Porcentaje_6_12"
	Round( case 
			when precipitacion_total = 0 then 0.00
	 		else (precipitacion_12_a_18::numeric/precipitacion_total)*100 end,2)as "Porcentaje_12_16" 
	Round( case 
			when precipitacion_total = 0 then 0.00
			else(precipitacion_18_a_24::numeric/precipitacion_total)*100 end,2)as "Porcentaje_18_24"
from climatologia
where provincia in ('Guadalajara','Cuenca','Toledo','Ciudad Real','Albacete')
 	and fecha between '2019-3-21'and '2019-6-20'; 

SELECT
    fecha,
    estacion,
    provincia,
    precipitacion_total,
    ROUND(CASE 
            WHEN precipitacion_total = 0 THEN 0.00
            ELSE (precipitacion_0_a_6::numeric / precipitacion_total) * 100 END,2 ) AS "Porcentaje_0_6", 
    ROUND(CASE 
            WHEN precipitacion_total = 0 THEN 0.00 
            ELSE (precipitacion_6_a_12::numeric / precipitacion_total) * 100 END,2 ) AS "Porcentaje_6_12",
    ROUND(CASE 
            WHEN precipitacion_total = 0 THEN 0.00 
            ELSE (precipitacion_12_a_18::numeric / precipitacion_total) * 100 END,2 ) AS "Porcentaje_12_18", 
    ROUND(CASE 
            WHEN precipitacion_total = 0 THEN 0.00 
            ELSE (precipitacion_18_a_24::numeric / precipitacion_total) * 100 END, 2 ) AS "Porcentaje_18_24"
FROM
    climatologia
WHERE
    provincia IN ('Guadalajara','Cuenca','Toledo','Ciudad Real','Albacete')
    AND fecha BETWEEN '2019-3-21' AND '2019-6-20'; 

	--Aqui me vas a tener que perdonar pero aunque lo tenia igual puesto en mi consulta, me estaba dando error
	--Así que use el notebook para poder arreglarlo 


/*Selecciona todos los datos de aquellas estaciones que han tenido algún día  
con una precipitación total de más de 50 litros por metro cuadrado, 
y donde el % de la precipitación caída de 6 a 12 horas sea entre el 60 y el 80%. 
Ordena la salida por precipitación total descendente, y fecha ascendente*/

---Estp es pregunta de examen
select estacion, provincia,precipitacion_total,precipitacion_6_a_12
from climatologia
where precipitacion_total >50 
 	and  precipitacion_total = 0 then  0.0
	 round((precipitacion_6_a_12::numeric / precipitacion_total)*100,2)
	between 0.60 and 0.80)
order by precipitacion_total desc, fecha asc;

select climatologia.temperatura_media,climatologia.temperatura_maxima,climatologia.temperatura_media,
		climatologia.velocidad_maxima_viento, climatologia.precipitacion_total,climatologia.estacion
from climatologia
where estacion ilike '%e%'
	--and (fecha between'2019-02-20' and '2019-02-28' 
	--or fecha between '2019-03-20' and '2019-03-31'
	--or fecha between '2019-04-20' and '2019-04-30')
left(fecha,5) like '2019-%'
order by climatologia.estacion asc, climatologia.provincia asc, climatologia.fecha desc;
	