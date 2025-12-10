select sum (hombres)
from demografia_basica
where anio between 2002 and 2003
	and provincia in ('Cáceres','Badajoz');

select provincia, anio
from demografia_basica
where (hombres >=600000 
	or mujeres >=600000)
order by provincia desc, anio asc;


select provincia, anio
from demografia_basica
where (hombres >=600000 
	or mujeres >=600000) 
	and anio between 2014 and 2019 
order by provincia desc, anio asc;

select provincia, anio
from demografia_basica
where (hombres >=600000 
	or mujeres >=600000) 
	and (anio-5) 
order by provincia desc, anio asc;

select *
from demografia_avanzada
where sexo = 'M' 
	and anio = 2018
	and edad_mayor<=29
	and edad_menor>=20
	and provincia in ('Sevilla','Córdoba','Málaga','Granada','Jaén','Alemería','Huelva','Cadíz')
order by numero_habitantes asc; 

select anio, numero_habitantes, rango_edad 
from demografia_avanzada
where provincia = 'Madrid'
	and (
		edad_mayor>65
		or edad_menor<20
		)
	and sexo = 'H'
	and anio between 2010 and 2015
order by anio asc, numero_habitantes desc, rango_edad asc; 
