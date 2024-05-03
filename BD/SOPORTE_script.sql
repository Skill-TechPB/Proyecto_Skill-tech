create database sp;
use sp;

select*from incidencia;
select*from programador;
select*from pro_inc;
alter table pro_inc auto_increment=0;
select inc_id, inc_email, inc_descripcion, inc_fch, estado.est_estado, tincidencia.tin_nombre, prioridad.pri_prioridad from incidencia inner join estado on estado.est_id=incidencia.est_id inner join tincidencia on tincidencia.tin_id=incidencia.tin_id inner join prioridad on prioridad.pri_id=tincidencia.pri_id where 0<incidencia.est_id<3;
UPDATE incidencia SET est_id = 2 WHERE inc_id = 1;
select inc_id, inc_email, inc_descripcion, inc_fch, estado.est_estado, incidencia.est_id, tincidencia.tin_nombre, prioridad.pri_prioridad from incidencia inner join estado on estado.est_id=incidencia.est_id inner join tincidencia on tincidencia.tin_id=incidencia.tin_id inner join prioridad on prioridad.pri_id=tincidencia.pri_id where 0<incidencia.est_id<3 order by inc_id asc;
select programador.pro_nombre from programador inner join pro_inc on programador.pro_id=pro_inc.pro_id where pro_inc.inc_id=1;
*/
create table prioridad(
pri_id integer not null auto_increment primary key,
pri_prioridad varchar(20) not null
);
insert into prioridad(pri_prioridad) values("URGENTE"),("No tan urgente");

create table tincidencia(
tin_id integer not null auto_increment primary key,
tin_nombre varchar(20) not null,
tin_descripcion varchar(50) not null,
pri_id integer not null,
foreign key(pri_id) references prioridad(pri_id) on delete cascade on update cascade
)engine=InnoDB default charset=LATIN1;
insert into tincidencia(tin_nombre, tin_descripcion, pri_id) values("Problema técnico","Fallas en el programa",1),("Sugerencia","Sugerencias propuestas por el usuario",2);

create table estado(
est_id integer not null auto_increment primary key,
est_estado varchar(20) not null
)engine=InnoDB default charset=LATIN1;
insert into estado(est_estado) values("No Resuelto"),("En proceso"),("Resuelto");

create table programador(
pro_id integer not null auto_increment primary key,
pro_nombre varchar(20) not null,
pro_apellido varchar(20) not null,
pro_email varchar(50) not null,
pro_llave varchar(20) not null,
pro_rol varchar(20)  not null
)engine=InnoDB default charset=LATIN1;
insert into programador(pro_nombre, pro_apellido, pro_email, pro_llave, pro_rol) values
("Josue","Diaz","diaz.amaro.josue@gmail.com","TILIN092", "BD"),
("Jan","Hurtado","jhurtador2100@alumno.ipn.mx","COCA13", "BACK"),
("Diego","Aguilar","aguilar.floress.diego@gmail.com","SESION69", "BACK"),
("Miguel","Isaac","garcia.garcia.miguel.isaac1@gmail.com","MIRIAM15", "FRONT"),
("Edgar","Rivera","ealvarezr2001@alumno.ipn.mx","MIRIAM15", "FRONT");

create table incidencia(
inc_id integer not null auto_increment primary key,
inc_email varchar(50) not null,
inc_descripcion varchar(70) not null,
inc_fch date not null,
est_id integer null,
tin_id integer null,
foreign key(tin_id) references tincidencia(tin_id) on update cascade on delete cascade,
foreign key(est_id) references estado(est_id) on update cascade on delete cascade
)engine=InnoDB default charset=LATIN1;

create table pro_inc(
pri_id integer not null auto_increment primary key,
pri_fche date not null,
pro_id integer not null,
inc_id integer not null,
foreign key(pro_id) references programador(pro_id) on delete cascade on update cascade,
foreign key(inc_id) references incidencia(inc_id) on delete cascade on update cascade
);

create table respuestaf(
rpf_id integer not null auto_increment primary key,
rpf_respuesta varchar(50)
)engine=InnoDB default charset=LATIN1;

create table preguntaf(
pgf_id integer not null auto_increment primary key,
pgf_pregunta varchar(50),
rpf_id integer not null,
foreign key(rpf_id) references respuestaf(rpf_id) on delete cascade on update cascade
)engine=InnoDB default charset=LATIN1;