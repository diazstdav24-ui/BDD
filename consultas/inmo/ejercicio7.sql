/*(INMO) Selecciona el nombre del comprador, 
el nombre del vendedor, la provincia y la fecha de operación de las viviendas 
(casa y piso) alquiladas en el tercer trimestre de año en las provincias de Huelva, 
Sevilla y Almería. Ordena la salida por fecha de operación descendentemente.*/

select c.nombre, provincia,fecha_operacion
from comprador c join operacion o using (id_cliente)
			     join inmueble i using (id_inmueble)
				 join tipo t on (t.id_tipo = i.tipo_inmueble)
where t.nombre ilike 