

--2.
/*Seleccionar el nombre de aquellos departamentos en los que trabaja un empleado que fue contratado a lo largo del año 1993*/
select * 
from employees;

select d.department_name
from employees e join departments d
				using (department_id)
where e.hire_date::text like '1993-%';

--4 Seleccionar el nombre de aquellos empleados cuyo jefe directo tenga un apellido que empiece por D, H o S.


select emple.first_name, emple.last_name, manager.last_name
from employees emple join employees manager
					on	(emple.manager_id = manager.employee_id) --Es una relación reflexiva asi que se hace asi
where manager.last_name ilike 'H%'
	or manager.last_name ilike 'D%'
	or manager.last_name ilike 'S';
--5.Seleccionar el número de familiares (dependents) que son hijos de algún miembro de los departamentos de Marketing, Administration e IT.
select count (*) 
from dependents d join employees e 
				using (employee_id)
				join departments ds 
				using (department_id)
where ds.department_name in ('Marketing','Administration','IT')
					
