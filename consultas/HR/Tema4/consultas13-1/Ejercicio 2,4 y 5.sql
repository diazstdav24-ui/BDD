--Ejercicio5 
select estacion, fecha, precipitacion_total
from climatologia
where fecha /*between make_date (2019,4,1)
			and make_date(2019,4,30)*/
			--Otra forma 
			--to_char (fecha,'YYY/MM') = '04/2019'
		and provincia = 'Sevilla'
		
order by estacion asc;

select * 
from climatologia 
where 
	provincia in ('Cuenca', 'Guadalajara')
	and fecha between make_date(2019,3,21)
					and make_date(2019,6,20)
order by fecha;

--Para repasar se pueden coger todos los ejercicios del boletín anterior (rehacer los ejercicios)
--¿Como podríamos transformar esta consulta para que fuera obtener los datos de cualquier año?