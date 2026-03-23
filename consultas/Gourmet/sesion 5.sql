select nombre, pvp,
	(select round(avg(pvp),2) from producto) as media, 
	pvp-(select round(avg(pvp),2) from producto) as diferencia
from producto
where pvp > (
	select avg(pvp)
	from producto
); --Como en cualquier problema matematico la consultase hace desde dentro hacia afuera, primero se hace la subconsulta la cual devuelve la media 
--y luego poder utilizarlo en una consulta mas grande 
--Una subconsulta escalar se puede usar en el where, having (ya que son casi que lo mismo simplemente que se aplican en momentos diferentes) 
--y en el select 

select v.id, count(*)
from venta v join lineaventa lv on (v.id = lv.id_venta)
group by v.id
having count(*) > (
        select avg(num_prd)
        from (
            select v.id, count(*) as "num_prd"
            from venta v join lineaventa lv on (v.id = lv.id_venta)
            group by v.id
        ) d
);