/*(INMO) Selecciona el nombre del comprador, 
el nombre del vendedor, la provincia y la fecha de operación de las viviendas 
(casa y piso) alquiladas en el tercer trimestre de año en las provincias de Huelva, 
Sevilla y Almería. Ordena la salida por fecha de operación descendentemente.*/

select c.nombre as comprador
				, provincia
				,fecha_operacion,
				v.nombre as vendedor
from comprador c join operacion o using (id_cliente)
				 join vendedor v using (id_vendedor)
			     join inmueble i using (id_inmueble)
				 join tipo t on (t.id_tipo = i.tipo_inmueble)
where t.nombre in ('Casa','Piso')
and tipo_operacion ilike 'Alquiler'
and extract (quarter from  fecha_operacion) = 3 
and Provincia in ('Huelva','Almería','Sevilla')
order by fecha_operacion desc; 

/*(INMO) Modifica la consulta anterior para que las viviendas que fueran vendidas en un plazo de entre 35 y 45 días desde que se dieron de alta en la inmobiliaria.*/

select c.nombre as comprador
				, provincia
				,fecha_operacion ,
				v.nombre as vendedor
from comprador c join operacion o using (id_cliente)
				 join vendedor v using (id_vendedor)
			     join inmueble i using (id_inmueble)
				 join tipo t on (t.id_tipo = i.tipo_inmueble)
where t.nombre in ('Casa','Piso')
and tipo_operacion ilike 'Venta'
and  o.fecha_operacion between 
	i.fecha_alta + interval '35 days'
	and i.fecha_alta + interval '45 days' 
and Provincia in ('Huelva','Almería','Sevilla')
order by fecha_operacion desc; 

/*(INMO) Calcula el precio máximo y precio mínimo por metro cuadrado de venta de inmuebles que no sean viviendas (no sean Piso o Casa) en provincias que contengan una n (mayúscula o minúscula), 
siempre que los inmuebles se hayan vendido en un mes que escrito de forma completa en inglés tenga entre 5 y 7 caracteres.*/

select  round(max(i.precio / i.superficie),2) as "Precio Max",
	   round (min(i.precio / i.superficie),2) as "Precio Min"
from inmueble i join tipo t on (t.id_tipo = i.tipo_inmueble)
				join operacion o using (id_inmueble)
where (lower (t.nombre) not ilike 'Piso'
			and lower (t.nombre)not ilike 'Casa')
and i.provincia ilike '%n%'
and i.tipo_operacion ilike 'Venta'
and length(to_char(o.fecha_operacion,'TMmonth' )) between 5 and 7;

