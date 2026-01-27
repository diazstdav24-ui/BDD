
/*Seleccionar el id_vuelo, la ciudad de origen, la ciudad de destino, la fecha y hora de salida, la fecha y hora de llegada y 
la duración del vuelo en minutos para aquellos vuelos que hayan salido en el tercer trimestre de 2023, 
cuya duración sea superior a 120 minutos y en los que el avión tenga una capacidad igual o superior a 300 pasajeros.
Ordena el resultado por duración del vuelo de mayor a menor.
*/

select v.id_vuelo, a_desde.ciudad, a_hasta.ciudad, 
		v.llegada, v.salida, v.salida - v.llegada as "duración"
from vuelo v join aeropuerto a_desde on ( a_destino.id_aeropuerto = v.desde)
			 join aeropuerto a_hasta on (a_hasta.id_aeropuerto = v.hasta)
			 