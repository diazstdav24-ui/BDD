select round(avg(precio_final),2)
from operacion join inmueble using (id_inmueble)
where provincia ilike 'Málaga' 
and tipo_operacion ilike 'Alquiler'
and extract(month from fecha_operacion) in (07,08);


select * 
from inmueble join operacion using (id_inmueble)
where Provincia in('Jaén','Córdoba')
and tipo_operacion ilike 'Venta'
and extract (month from fecha_operacion) in (10,11,12)
and extract (year from fecha_operacion) in (2022,2023);
--Otra forma de hacerlo es con and extract (quarter from fecha_operacion) = 4;  este extrae el cuarto trimestre

select round(avg(precio_final),2)
from inmueble i join tipo t on (i.tipo_inmueble = t.id_tipo)
				join operacion using (id_inmueble)
where provincia ilike 'Huelva'
and tipo_operacion ilike 'Venta'
and t.nombre ilike 'Parking'
and to_char(fecha_operacion,'ID') in ('1','2','3','4','5');


select * 
from inmueble join tipo t on (t.id_tipo = inmueble.tipo_inmueble)
			  join operacion using (id_inmueble)
where t.nombre ilike 'piso'
and tipo_operacion ilike 'Venta'
and  /*fecha_operacion between 
		fecha_alta + interval '3 months'and 
		fecha_alta + interval '6 months'*/
		age(fecha_operacion,fecha_alta)
		between interval '3 months' and interval '6 months'
and provincia ilike 'Granada';



