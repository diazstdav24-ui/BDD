
--Esta es la forma de hacerla inicialmente en SQL (SQL'92)
--Comnsulta de varías tablas
select employees.first_name, employees.last_name, departments.department_name
from employees, departments
where 
	employees.department_id = departments.department_id 
order by employees.department_id;


select first_name, last_name, department_name,job_title --aqui no tengo porque usar el alias porque no hay ambiguedad
from employees e, departments d, jobs j  --Alias de columna 
where 
	e.department_id = d.department_id
	and j.job_id = e.job_id
	and (d.department_name = 'Administration'
	or d.department_name = 'IT');
order by e.department_id;
--Esto se llama Join, es la union de dos tablas a partír de una clave externa

--Conuslta SQL'99
select * 
from employees 
cross join departments; --Hace el mismo producto cartesiano

--El natural join es une directamente los campos que tengan el mismo nombre en ambos tablas. 
--Es comodo pero, a la vez peligroso
select *  
from employees 
NATURAL join departments; 

--Join Using, cuando clave externa y clave primaria se llamen igual 
select first_name, last_name, department_name,job_title 
from employees e JOIN departments d 
				using (department_id)
				join jobs j
				using (job_id)
where e.department_id = d.department_id
	and j.job_id = e.job_id
	and (d.department_name ilike'Administration'
	or d.department_name ilike 'IT');

select first_name, last_name 
from employees join departments using (department_id);
				
--Join on cuando no se llamen igual, esta base datos no tiene claves priamria y claves externas diferentes pero vamos a simularlo 

select first_name, last_name, department_name,job_title 
from employees e JOIN departments d 
				on (e.employee_id= d.department_id)
				join jobs j
				on (e.employee_id = j.job_id)
where 
	and (d.department_name ilike'Administration'
	or d.department_name ilike 'IT');

--Se puede mezclar Join using con Join on

/* 
	Estrategia 1 : Usar siempre Join on 
	Estrategia 2:
				-Siempre que pueda, Join USING (fk igual a pk)
				-Cuando no se pueda, Join on (fk no igual a pk) */



/* 
Seleccionar el nombre y apellidos, incluyendo el nombre 
de la región, para aquellos empleados cuya región sea Europe o America */

select * 
from regions;

select *
from countries 
where countries.country_name ilike 'United Kingdom'


select first_name, last_name, region_name
	from employees e join departments  using (department_id) 
					join locations  using (location_id)
					join countries using (country_id)
					join regions  using (region_id)
where  
	region_name in ('Americas','Europe');


--Ejercicio 2
select first_name, last_name, email
	from employees 
				join departments d using (department_id)
				join locations l using (location_id)
				join countries  c using (country_id)
where  c.country_name ilike 'United Kingdom';

--Ejercicio3

select distinct r.region_name --El distinct se usa para ver el nombre de las regiones sin que este 20 veces repetido 
from employees 
				join departments d using (department_id)
				join locations l using (location_id)
				join countries  c using (country_id)
				join regions r USING (region_id)
where employees.salary < 10000;

-------------------------------------------------------------
--Esto de aqui es para actualizar la tabla para que uno de los empleados sea nulo (mas especificamente el empleado 100)
Select count (*)
from employees; 

select * 
from employees join departments d using (department_id);

update employees
set department_id = null 
where employee_id = 100;

insert into departments
values (12,'IA');

--Join Lateral (Externo) *Los otros eran internos(Inner)*
--Como poco en un Join externo salen las mismas filas, solo que puede añadir algunas filas adicionales no relacionadas

select * 
from employees left join departments using (department_id); --Esto hace que los valores nulos de la tabla a la izquierda de la palabra salgan, hace que aparezcan los empleados que no tengan depto

select * 
from employees right join departments using (department_id); --Hace que aparezcan los depto que no tienen empleados

select * 
from employees full join departments using (department_id); --Hace que aparezcan los dos

--Ejercicio1, Mostrar el nombre de los depto que no tengan empleados: 
select d.department_name
from employees e right join departments d using (department_id)
where e.employee_id is null;
--Aqui es depende de donde tienes puesto el lado, aqui por ejemplo he decidido ponerlo en right pero podría tambien ser left si hago la consulta al reves