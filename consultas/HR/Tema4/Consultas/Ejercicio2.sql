--Seleccionar el FIRST_NAME y LAST_NAME de los empleados del departamento de IT o Finance cuya fecha de alta (HIRE_DATE) fuera un día cualquiera de Abril o Junio.
select first_name, last_name
from employees e join departments d using (department_id)
where d.department_name in ('IT','Finance')
and extract ( month from e.hire_date ) in (04,06);

--Seleccionar el FIRST_NAME y LAST_NAME de los managers de los empleados del departamento de Administration.

select man.first_name, man.last_name 
from employees emple join departments d using (department_id)
				join employees man on (man.employee_id= emple.manager_id)
where d.department_name ilike 'Administration';

--Es mejor hacer esta forma porque de esta forma garanatizo que el filtrado entre tablas este bien
select man.first_name, man.last_name 
from employees emple join departments d on (emple.department_id = d.department_id)
				join employees man on (man.employee_id= emple.manager_id)
where d.department_name ilike 'Administration';

--Seleccionar el COUNTRY_NAME donde tiene localización el departamento de Public Relations

select country_name
from countries c join locations l 
					using (country_id)
				join departments d
					using (location_id)
where d.department_name ilike 'Public Relations';

--Seleccionar aquellos empleados que trabajen en oficinas de América.
select * 
from employees e join departments  using (department_id)
				join locations  using (location_id)
				join countries using (country_id)
				join regions r using (region_id)
where r.region_name ilike 'Americas';

--Seleccionar el nombre y apellidos de los hijos, así como el nombre y apellidos de sus padres, 
--para aquellos empleados que trabajen en oficinas de América. Ordena la salida por orden alfabético del país :)

select ds.first_name, ds.last_name, 
		e.first_name as "Nombre Padre"
		, e.last_name as "Apellido Padre"
from dependents ds join employees e using (employee_id)
					join departments  using (department_id)
					join locations using (location_id)
					join countries c using (country_id)
					join regions r using (region_id)
where r.region_name ilike 'Americas'
	and relationship = 'Child'
order by c.country_name asc;

--Seleccionar el nombre del empleado, el apellido del jefe y el titulo de trabajo, donde el salario del 
--empleado sea mayor de 5000Su titulo empiece por S. Ordenar de mayor a menor el salario del empleado

select emple.first_name as Nombre_Empleado,
	j.job_title as titulo, 
	man.last_name as Apellido_Jefe
from employees emple join jobs j using (job_id)
					join employees man on (man.employee_id= emple.manager_id)
where emple.salary >= 5000
and j.job_title ilike 'S%'
order by emple.salary  asc;

					


select * 
from employees;