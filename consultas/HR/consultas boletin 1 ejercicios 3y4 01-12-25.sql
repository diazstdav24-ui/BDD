

/*Seleccionar aquellos empleados cuyo número de departamento esté entre el 8 y el 12 (ambos excluidos).
*/

select first_name, department_id
from employees 
where department_id between 8 and 12; 

/*Seleccionar todos los países que contengan una letra a en la segunda posición.
*/

select country_name 
from countries 
where countries_name like '_'

select first_name,last_name 
from employees 
where salary *14>=100000
	and job_id !=6;
