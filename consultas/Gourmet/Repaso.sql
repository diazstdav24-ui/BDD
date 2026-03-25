/*Ejercicio 3: El gerente quiere identificar los productos "Premium" de la tienda. Usando la tabla producto, muestra el nombre 
y el pvp de aquellos productos cuyo precio sea estrictamente mayor que el precio medio de todos los productos del catálogo.*/

select nombre , pvp 
from producto 
where pvp >= all (
		select avg(pvp) --Esto devuelve un unico dato (subConsulta escalar). A partir de esto 
		from producto --Postgres compara todos los productos si es el precio es mayor o igual que lo que ha devuelto la consulta
);