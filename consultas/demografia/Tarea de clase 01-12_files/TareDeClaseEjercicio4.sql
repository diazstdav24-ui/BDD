select * 
from demografia_basica; 

select hombres
from demografia_basica
where anio between  2000 and 2003;

select *
from demografia_basica
where (hombres >= 600000 
	or mujeres >= 600000 )
and anio between 2014 and 2019 
order by (hombres,mujeres) desc;

select provincia,rango_edad 
from demografia_avanzada
where edad_menor >=20 
and edad_mayor <=29 
and sexo='M'
and anio=2018
and (provincia in ('Sevilla','Córdoba','Málaga','Granada','Jaén','Alemría','Huelva'))