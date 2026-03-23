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

select street_address, count(*) as num_empleados
from locations l join departments using (location_id)
			   join employees e using (department_id)
group by l.street_address
order by num_empleados desc; 


select * 
from locations; 
--4.Modificar la consulta anterior para que muestre las localizaciones que no tienen ningún empleado.

--Aqui debo de usar el having y el left join, ya que con el inner join si una oficina no tiene empleado simplemente desaparece
select l.street_address, count (e.employee_id) as num_empleados
from locations l left join departments using (location_id)
			   left join employees e using (department_id)
group by l.street_address
having count(e.employee_id) = 0
order by num_empleados desc; 




--5.Seleccionar el salario que es cobrado a la vez por más personas. Mostrar dicho salario y el número de personas.

select salary, count(*) as num_personas
from employees 
group by salary 
order by num_personas
limit 1;


--6.Seleccionar el número de empleados que empezaron a trabajar cada año, ordenando la salida por el año.

select extract (year from hire_date) as anio, count(employee_id)
from employees 
group by extract (year from hire_date)
order by anio; 

