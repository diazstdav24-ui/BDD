--Ejercicio 1
select d.department_name
from employees e join departments d
				using (department_id)
where --extract (year from hire_dare)=1993
		to_char (hire_date,'yyyy')=1993;
--Diferentes formas 

--Ejercicio 2 

select first_name, last_name
from employees join departments using (department_id)
where department_name in ('IT','Finance')
and to_char(hire_date,'MM') in ('04''06');