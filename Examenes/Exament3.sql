select * 
from climatologia; 

--1. 
select  round (avg(precipitacion_total),2) as "Precipitacion total media"
from climatologia
where 
	estacion in ('Huesca','Zaragoza','Teruel')
	and fecha::text ilike '2019-06-%'
	and precipitacion_total <20;
--2. 
select *,
	precipitacion_0_a_6 +
	precipitacion_6_a_12 +
	precipitacion_12_a_18 +
	precipitacion_18_a_24 as "Suma todas las precipitaciones"
from climatologia
where 
	(estacion ilike '%f%'
		or estacion ilike '%t%'
		or estacion ilike '%x%')
	and fecha::text ilike '2019-02-%';

--3. 
select * 
from climatologia 
where 
	left(estacion,2)='Ba'
	and temperatura_maxima 
		between 25 and 30
	and climatologia.temperatura_minima <15
	and left (fecha::text,4) = '2019'
	and (SUBSTRING (fecha::text,6,2) = '09'
		or SUBSTRING (fecha::text,6,2) = '10')
order by fecha desc, estacion asc;

--4. 
select 
	estacion, 
	provincia,
	fecha,
	racha_viento,
	case 
		when racha_viento <=40 then 'Ventoso'
		when racha_viento <=60 then 'Muy Ventoso'
		else 'Huracanado'
	end as "Clasificacion viento"
from climatologia
where 
	racha_viento >25
	and hora_racha_viento ilike '15:00'
	and (fecha::text ilike '2019-03%'
		or fecha::text ilike '2019-04%')
	and temperatura_maxima >23 
order by racha_viento desc ;

--5. 
select 
	provincia,
	estacion,
	fecha,
	racha_viento,
	velocidad_maxima_viento,
	round(temperatura_media*temperatura_maxima/100)
from climatologia
where temperatura_minima != 0
	and temperatura_maxima !=0
	and temperatura_minima >10 
order by provincia desc , estacion desc, fecha asc;
	
	
	