/*(VUELOS) ¿Cuál es el descuento medio obtenido en vuelos donde el origen sea España y el destino fuera de España, 
siempre que estos vuelos no se hayan realizado en fin de semana (contaremos como fin de semana los Viernes a partir de las 15:00)?*/

select  round (avg( v.precio * (v.descuento/100.0)),2) as "Descuento medio"
from vuelo v  join aeropuerto a_desde on (a_desde.id_aeropuerto = v.desde)
			  join aeropuerto a_hasta on ( a_hasta.id_aeropuerto = v.hasta)
where a_desde.ciudad in ('Sevilla','Madrid','Bilbao','Málaga','Barcelona')
and  a_hasta.ciudad in ('París','Ámsterdam','Londres','Berlín','Nueva York','Ankara')
and (extract (isodow from v.salida) between 1 and 4 
		or (extract (isodow from v.salida) = 5
		and extract(hour from v.salida) < 15
		and extract (isodow from v.salida) in (6,7)));
		

select * 
from vuelo;



