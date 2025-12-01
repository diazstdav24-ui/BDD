/*Seleccionar aquellos empleados cuyo número de departamento esté entre el 8 y el 12 (ambos excluidos).
*/

select first_name, department_id
from employees 
where department_id between 9 and 11; 

/*Seleccionar todos los países que contengan una letra a en la segunda posición.
*/

select country_name 
from countries 
where country_name like '_a%'

/*Seleccionar el nombre y apellidos de los empleados cuyo salario bruto anual sea mayor o igual que 100000$, y que no sean contables (job_id = 6).
*/
select first_name, last_name 
from employees 
where salary *14 >=100000; 

/*Seleccionar aquellos departamentos cuyo nombre contenga dos letras t.
*/
select department_name
from departments
where department_name ilike '%t%t%'

/*Seleccionar las localizaciones que estén en las ciudades de Toronto u Oxford, o bien en el estado de California.
*/

select * 
from locations 
where city  in 
		('Toronto','Oxford')
or state_province in 
		('California');
 


