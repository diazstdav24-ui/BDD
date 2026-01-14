
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