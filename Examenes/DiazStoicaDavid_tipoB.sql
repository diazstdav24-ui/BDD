--1.
select round(sum(o.precio_final),2)
from inmueble i join operacion o using (id_inmueble)
where i.provincia in ('Córdoba','Sevilla')
and age(o.fecha_operacion,i.fecha_alta) 
	between interval '3 months' and interval '4 months';

--2.
select round(avg(o.precio_final),2)
from operacion o join inmueble i using (id_inmueble)
where i.tipo_operacion ilike 'Venta'
and (extract (month from o.fecha_operacion) in (7,8)
	or (extract (month from o.fecha_operacion) = 6
		and extract (day from o.fecha_operacion) >21)
	or (extract (month from o.fecha_operacion) = 9
		and extract(day from o.fecha_operacion) < 20)
		);




--3.
select v.nombre
from vendedor v join operacion o using (id_vendedor)
				  join inmueble i using (id_inmueble)
				  join tipo t on (t.id_tipo = i.tipo_inmueble)
where t.nombre ilike 'Local'
and i.provincia in ('Sevilla','Cadíz','Huelva')
and i.superficie > 100
and ((extract(isodow from o.fecha_operacion) = 3
		and extract (month from o.fecha_operacion) = 6)
		or (extract(isodow from o.fecha_operacion) = 4
		and extract (month from o.fecha_operacion) = 5)
		);
		

--4.
select *
from comprador c join operacion o using (id_cliente)
				 join vendedor v using (id_vendedor)
				 join inmueble i using (id_inmueble)
				 join tipo t on (t.id_tipo = i.tipo_inmueble)
where t.nombre not in ('Local','Oficina')
and i.tipo_operacion in ('Alquiler''Venta')
and extract(epoch from age(o.fecha_operacion ,i.fecha_alta))/86400 <120;





--5
select *
from inmueble i left join operacion o using (id_inmueble)
where age(o.fecha_operacion,i.fecha_alta) >= interval '12 months'
and o.precio_final is null





