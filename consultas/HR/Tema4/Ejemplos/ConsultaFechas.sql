
--Puede interpretarlo

select '2005-12-01'::date;

--Pseudofunciones son funciones que no reciben argumentos 
select current_date;

select interval '1 year 3 month';
select current_date + interval '1 year 3 month';

--Suma Dias, tambien se puede restar
SELECT CURRENT_DATE +1;

select current_date - '2005-07-28';

--Lo unico que se puede multiplicar o dividir son los intervalos

--Esto es como una mascara. 
--Quiero que se muestre dd/mm/yyyy
select to_char(CURRENT_DATE, 'dd/mm/yyyy');

--Ver dia , tm cambia el idioma y fm quita los espacios. Cuando se usa TM ya realiza la funcion de fm
select to_char(CURRENT_DATE, 'DAY, dd/mm/yyyy');
--También acepta hora 
select to_char(CURRENT_TIME, 'DAY, dd/mm/yyyy');
