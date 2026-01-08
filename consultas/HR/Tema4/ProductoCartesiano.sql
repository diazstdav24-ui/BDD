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
select first_name, last_name, department_name,job_titl 
from employees e JOIN departments d 
				using (department_id)
				join jobs j
				using (job_id)
where e.department_id = d.department_id
	and j.job_id = e.job_id
	and (d.department_name = 'Administration'
	or d.department_name = 'IT');

select first_name, last_name 
from employees join departments using (department_id);
				
--Join on cuando no se llamen igual 



