/*(HR) Selecciona el número de empleados que fueron contratados en el año 1997 en la que trabajen en una oficina situada en Bélgica.
*/

select count(*)
from employees e join departments using (department_id)
				join  locations using (location_id)
				join countries  using (country_id)
where  extract(year from e.hire_date ) = 1997
and  country_name ilike 'Belgium';

/*(HR) Selecciona la media de salario máximo de los trabajadores de Administration en Asia*/
select coalesce(round(avg(max_salary),2),0)
from employees e join departments using (department_id)
				join jobs using (job_id)
				join  locations using (location_id)
				join countries  using (country_id)
				join regions r using (region_id)
where r.region_name ilike 'Asia'
and departments.department_name ilike 'Administration';





				
