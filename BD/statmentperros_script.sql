select*from bitacora;
select*from usuario;
select*from egresado;
select*from profesor;
select*from resultadopo;

-- Filtro del nombre del profesor (abc)
select bitacora.bit_fchmod, profesor.pro_nombre, formulario.for_nombre, bitacora.elf_id,bitacora.bit_indice, bitacora.bit_origen, bitacora.bit_cambio from bitacora inner join profesor on profesor.pro_id=bitacora.pro_id inner join formulario on formulario.for_id=bitacora.for_id order by profesor.pro_nombre asc;

-- Filtro por letras del nombre del profesor
select bitacora.bit_fchmod, profesor.pro_nombre, formulario.for_nombre, bitacora.elf_id,bitacora.bit_indice, bitacora.bit_origen, bitacora.bit_cambio from bitacora inner join profesor on profesor.pro_id=bitacora.pro_id inner join formulario on formulario.for_id=bitacora.for_id where profesor.pro_nombre like "li%";

-- Filtro por fecha
select bitacora.bit_fchmod, profesor.pro_nombre, formulario.for_nombre, bitacora.elf_id,bitacora.bit_indice, bitacora.bit_origen, bitacora.bit_cambio from bitacora inner join profesor on profesor.pro_id=bitacora.pro_id inner join formulario on formulario.for_id=bitacora.for_id order by bitacora.bit_fchmod desc;

-- Filtro por formulario
select bitacora.bit_fchmod, profesor.pro_nombre, formulario.for_nombre, bitacora.elf_id,bitacora.bit_indice, bitacora.bit_origen, bitacora.bit_cambio from bitacora inner join profesor on profesor.pro_id=bitacora.pro_id inner join formulario on formulario.for_id=bitacora.for_id where bitacora.for_id =1;

-- Posibles combinaciones
select bitacora.bit_fchmod, profesor.pro_nombre, formulario.for_nombre, bitacora.elf_id,bitacora.bit_indice, bitacora.bit_origen, bitacora.bit_cambio from bitacora inner join profesor on profesor.pro_id=bitacora.pro_id inner join formulario on formulario.for_id=bitacora.for_id  where profesor.pro_nombre like "j%" order by bitacora.bit_fchmod desc;

select bitacora.bit_fchmod, profesor.pro_nombre, formulario.for_nombre, bitacora.elf_id,bitacora.bit_indice, bitacora.bit_origen, bitacora.bit_cambio from bitacora inner join profesor on profesor.pro_id=bitacora.pro_id inner join formulario on formulario.for_id=bitacora.for_id  where profesor.pro_nombre like "l%" and bitacora.for_id=1 order by bitacora.bit_fchmod desc;
