select *, to_char(fecha_operacion, 'ID-MM') 
from inmueble join operacion using (id_inmueble)
				join vendedor using (id_vendedor)
where to_date  (fecha_operacion,'ID-MM') in ('1-02','5-03')
	and superfice >200 
	and nombre ilike '%A%';