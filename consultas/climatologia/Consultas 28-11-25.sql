
select * 
from climatologia; 


--And y or significa que voy a usar parentesis
select * 
from climatologia 
where (temperatura_maxima between 10 and 20
	or temperatura_minima between 5 and 10 )
	and provincia = 'Jaén';



select * 
from climatologia 
where provincia in 
		('Jaén','Cordoba','Sevilla')
	--= 'Caceres' 
	--or provincia= 'Badajoz'; 

select * 
from climatologia 
where provincia ilike 'jaén';


select * 
from climatologia 
where provincia like 'A%' 
	or provincia like 'Á%';


select * 
from climatologia
where estacion like 'A____';

select * 
from climatologia
where temperatura_maxima >30 
and like '%a';