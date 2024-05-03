select*from tipousuario;
select*from formulario;
select*from bitacora;
select*from usuario;
select*from egresado;
select*from profesor;
select*from resultadopo;
select*from resultadobd;
select*from formulario;
select*from pro_asi;
select*from asignatura;
select*from egr_pro;
select*from elementoform;
-- Cosas random
select*from resultadobd inner join egresado on egresado.egr_id=resultadobd.egr_id;
select*from resultadopo inner join egresado on egresado.egr_id=resultadopo.egr_id;
delete from usuario where usu_id=8;

alter table pro_asi auto_increment=0;
select rpo_resp from resultadopo;
select rbd_resp from resultadobd;
-- fin
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

-- graficas por profesor
-- Nota: para que se adapte a la materia se cambia el campo, tabla, el valor de la materia (0,1)
select rpo_niv from resultadopo inner join egresado on egresado.egr_id=resultadopo.egr_id inner join egr_pro on egr_pro.egr_id=egresado.egr_id inner join profesor on profesor.pro_id=egr_pro.pro_id inner join pro_asi on pro_asi.pro_id=profesor.pro_id where pro_asi.asi_id=0 and egr_pro.pro_id=1 and egr_pro.egp_id%2!=0;
select rbd_niv from resultadobd inner join egresado on egresado.egr_id=resultadobd.egr_id inner join egr_pro on egr_pro.egr_id=egresado.egr_id inner join profesor on profesor.pro_id=egr_pro.pro_id inner join pro_asi on pro_asi.pro_id=profesor.pro_id where pro_asi.asi_id=1 and egr_pro.pro_id=3 and egr_pro.egp_id%2=0;

-- materias del profe
select profesor.pro_nombre, asignatura.asi_id from asignatura inner join pro_asi on pro_asi.asi_id=asignatura.asi_id inner join profesor on profesor.pro_id=pro_asi.pro_id where profesor.pro_id=2;
/*
-- graficas por profesor (por idusu)
select rpo_niv from resultadopo inner join egresado on egresado.egr_id=resultadopo.egr_id inner join egr_pro on egr_pro.egr_id=egresado.egr_id inner join profesor on profesor.pro_id=egr_pro.pro_id inner join pro_asi on pro_asi.pro_id=profesor.pro_id where pro_asi.asi_id=0 and profesor.usu_id=1 and egr_pro.egp_id%2!=0;
select rbd_niv from resultadobd inner join egresado on egresado.egr_id=resultadobd.egr_id inner join egr_pro on egr_pro.egr_id=egresado.egr_id inner join profesor on profesor.pro_id=egr_pro.pro_id inner join pro_asi on pro_asi.pro_id=profesor.pro_id where pro_asi.asi_id=1 and profesor.usu_id=3 and egr_pro.egp_id%2=0;
*/
-- total de egresados de un profe
select count(*) as 'egresados' from egresado inner join egr_pro on egr_pro.egr_id=egresado.egr_id inner join profesor on profesor.pro_id=egr_pro.pro_id where profesor.usu_id=1;

-- graficas por profesor y por generacion
select rpo_niv from resultadopo inner join egresado on egresado.egr_id=resultadopo.egr_id inner join egr_pro on egr_pro.egr_id=egresado.egr_id inner join profesor on profesor.pro_id=egr_pro.pro_id inner join pro_asi on pro_asi.pro_id=profesor.pro_id where pro_asi.asi_id=0 and egresado.egr_fch='2024' and egr_pro.pro_id=1 and egr_pro.egp_id%2!=0;
select rbd_niv from resultadobd inner join egresado on egresado.egr_id=resultadobd.egr_id inner join egr_pro on egr_pro.egr_id=egresado.egr_id inner join profesor on profesor.pro_id=egr_pro.pro_id inner join pro_asi on pro_asi.pro_id=profesor.pro_id where pro_asi.asi_id=1 and egresado.egr_fch='2024' and egr_pro.pro_id=2 and egr_pro.egp_id%2=0;

-- graficas ac/cn/err por profesor y por generacion
select rpo_resp from resultadopo inner join egresado on egresado.egr_id=resultadopo.egr_id inner join egr_pro on egr_pro.egr_id=egresado.egr_id inner join profesor on profesor.pro_id=egr_pro.pro_id inner join pro_asi on pro_asi.pro_id=profesor.pro_id where pro_asi.asi_id=0 and egresado.egr_fch='2024' and egr_pro.pro_id=3 and egr_pro.egp_id%2!=0;
select rbd_resp from resultadobd inner join egresado on egresado.egr_id=resultadobd.egr_id inner join egr_pro on egr_pro.egr_id=egresado.egr_id inner join profesor on profesor.pro_id=egr_pro.pro_id inner join pro_asi on pro_asi.pro_id=profesor.pro_id where pro_asi.asi_id=1 and egresado.egr_fch='2026' and egr_pro.pro_id=3 and egr_pro.egp_id%2=0;