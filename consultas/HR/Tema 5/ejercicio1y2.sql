-- 1. Seleccionar el salario máximo de cada departamento,
--mostrando el nombre del departamento y dicha cantidad.

select d.department_name, max(salary) as "Salario maximo"
from employees join departments d using (department_id)
group by d.department_name; 

--2.Seleccionar el salario mínimo de cada departamento, 
--para aquellos departamentos cuyo salario mínimo sea menor que 5000$.

select d.department_name, min(salary) as "Salario maximo"
from employees join departments d using (department_id)
group by d.department_name 
having min(salary) < 5000; 

--3.Seleccionar el número de empleados que trabajan en cada oficina
--, mostrando el STREET_ADDRESS 
--y dicho número; hay que ordenar la salida de mayor a menor 

select street_address, count(*)
from locations  