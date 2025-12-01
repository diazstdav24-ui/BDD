--Todas las columnas 
select * 
from climatologia; 

--Para que solo lance una de las dos consultas se selecciona con el raton
--Solo las columnas seleccionada 
select fecha, estacion, provincia, temperatura_maxima
from Climatologia;

select estacion, provincia 
from climatologia

--Distinct: Solamente tendrá sentido cuando no usemos asterisco o un valor sea propenso a repetirse 
select distinct estacion 
from climatologia; 

--OrderBy
select distinct provincia, estacion 
from climatologia

--por ascendencia y descendencia 
order by provincia desc , estacion asc;

--Condicionales clausula Where 
select temperatura_maxima , provincia, estacion
from climatologia
where temperatura_maxima <= 10;



