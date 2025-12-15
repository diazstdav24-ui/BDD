
select 
	round((mujeres::numeric/(hombres+mujeres))*100,2) as "% mujeres",

	provincia,
	anio,
	mujeres
from demografia_basica
where provincia in ('Huesca','Zaragoza','Teruel')
order by anio desc, provincia asc; 

select 
	round(max(mujeres::numeric/(hombres+mujeres))*100,2) as "% mujeres",
	provincia,
	anio,
	mujeres
from demografia_basica
where provincia in ('Huesca','Zaragoza','Teruel')
order by anio desc, provincia asc; 

select 
	round((mujeres::numeric/(hombres+mujeres))*100,2) as "% mujeres",
	provincia, mujeres, (hombres+mujeres) as “población_total”
from demografia_basica
where provincia in ('Huesca','Zaragoza','Teruel')
	and anio between 2010 and 2020
order by anio desc, provincia asc; 

select  --Si usamos max avg min o sum no podemos poner nada mas en el select
	max (round(((mujeres::numeric/(hombres+mujeres)))*100,2)) as "% mujeres"
from demografia_basica
where provincia in ('Huesca','Zaragoza','Teruel')
	and anio between 2010 and 2020;

