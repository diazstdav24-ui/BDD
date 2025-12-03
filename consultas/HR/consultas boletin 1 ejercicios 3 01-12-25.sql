
/*Seleccionar aquellos empleados cuyo número de departamento esté entre el 8 y el 12 (ambos excluidos).
*/

select first_name, department_id
from employees 
where department_id between 9 and 11; --En este momento es correcto, pero no se recomienda hacer

--Sería mejor esto 
select *
from employees 
where department_id >8 and department_id <12;
								

/*Seleccionar todos los países que contengan una letra a en la segunda posición.
*/

select country_name 
from countries 
where country_name like '_a%';

/*Seleccionar todos los empleados que el salario anual sea superior a 100000*/
select first_name, last_name 
from employees 
where salary *12 >=100000;

--otra forma
select first_name, last_name, salary*14 as "salario anual"
from employees
where salary *14 >=100000
	and job_id !=6
order by "salario anual"; --ordenar con alias

/*Seleccionar aquellos departamentos 
cuyo nombre contenga dos letras t*/
select department_name
from departments
where department_name ilike '%t%t%';

/*Seleccionar las localizaciones que estén 
en las ciudades de Toronto u Oxford, o bien en el estado de California*/

--Si interviene una columna mas de una vez no puede ser and 


select * 
    from locations 
where city  in 
		('Toronto','Oxford')
or state_province in 
		('California');

/*Calcular gasto de total  Salarios con funciones*/
--Esto suma todas las filas de la columna salarío 
--Conjunto de instrucciones de operaciones que produce como resultado un valor de salida
--Hay diferentes tipos de funciones
--Tendremos funciones que trabajan fila a fila y otras que recogen varías filas
--greatest compara columnaas

select sum(salary)
from employees; 

select max(salary), min (salary)
from employees; 