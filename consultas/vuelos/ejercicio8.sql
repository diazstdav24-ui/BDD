select 
	coalesce(
        ROUND(precio * ((100.0 - descuento) / 100.0), 2),
        precio) as "Precio final",
    coalesce(
        ROUND((precio * (descuento / 100.0), 2),
        0.0) ) as "descuento"
from vuelos
where desde in ('Sevilla','Málaga')
	and hasta in ('Madrid','Barcelona')
	and salida::text ilike '2019-12%'
	and precio >= 80;
 

SELECT id,
    desde,
    hasta,
    precio,
 UPPER(SUBSTRING(desde, 1, 3)) || '-' ||
UPPER(SUBSTRING(hasta, 1, 3)) || '-' ||
FROM
    vuelos
WHERE
	salida::text ilike '2020-%' 
    AND desde IN ('Madrid', 'Barcelona')  
    AND hasta IN ('París', 'Londres')    
    AND descuento IS NULL;



SELECT *,
    CASE
        WHEN descuento IS NULL THEN 'SIN_DESCUENTO'
        WHEN descuento >= 30 THEN 'DESCUENTO_ALTO'
        ELSE 'DESCUENTO_BAJO'
    END AS tipo_descuento,
   coalesce(
        ROUND(precio * ((100.0 - descuento) / 100.0), 2)
FROM
    vuelos
WHERE
    salida::text BETWEEN '2020-01-01' AND '2020-12-31'
    AND (desde IN ('Londres', 'París')
        OR hasta IN ('Sevilla', 'Málaga'))
    AND precio BETWEEN 60 AND 300
    AND (descuento IS NOT NULL
        OR precio > 200);


