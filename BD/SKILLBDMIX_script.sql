create database sktbdmix;
use sktbdmix;

#Catalogo
create table tipousuario(
tpu_id integer not null primary key,
tpu_nombre varchar(30) not null
)engine=InnoDB default charset=LATIN1;
insert into tipousuario(tpu_id,tpu_nombre) values(0,"Egresado"),(1,"Profesor"),(2,"Jefe de Area"),(3,"Administrador");

create table usuario(
usu_id integer not null auto_increment primary key, 
tpu_id integer, 
usu_password varchar(120),
usu_tk varchar(120),
usu_email varchar(120),
usu_hab integer default 1,
foreign key(tpu_id) references tipousuario(tpu_id) on update cascade on delete cascade
)engine=InnoDB default charset=LATIN1;

create table profesor(
pro_id integer not null auto_increment primary key,
usu_id integer,
pro_nombre varchar(70),
foreign key(usu_id) references usuario(usu_id) on update cascade on delete cascade
)engine=InnoDB default charset=LATIN1;

create table asignatura(
asi_id integer not null primary key,
asi_nombre varchar(100) not null
)engine=InnoDB default charset=LATIN1;
insert into asignatura values(0, 'POO'), (1, 'BD');

create table pro_asi(
pra_id integer  not null auto_increment primary key,
pro_id integer not null,
asi_id integer not null,
foreign key(pro_id) references profesor(pro_id) on update cascade on delete cascade,
foreign key(asi_id) references asignatura(asi_id) on update cascade on delete cascade
)engine=InnoDB default charset=LATIN1;

#Formularios
create table formulario(
for_id integer not null auto_increment primary key,
for_nombre varchar(120) CHARACTER SET utf8 COLLATE utf8_spanish_ci not null,
for_url varchar(120)
)engine=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
insert into formulario(for_nombre, for_url) values("FORMULARIO DE PROGRAMACIÓN INTERMEDIA","C:/Users/Josue/Desktop/Proyecto_skt/skt/web/formularios/fpoo.txt"),("FORMULARIO DE BASES DE DATOS RELACIONALES","C:/Users/Josue/Desktop/Proyecto_skt/skt/web/formularios/fbd.txt");
#

create table elementoform(
elf_id integer not null auto_increment primary key,
elf_elemento varchar(20)
)engine=InnoDB default charset=LATIN1;
insert into elementoform(elf_elemento) values('Pregunta'),('Respuesta'),('Respuesta_valor'),('Tematica');

create table bitacora(
bit_id integer not null auto_increment primary key,
pro_id integer,
bit_fchmod datetime,
for_id integer,
elf_id integer,
bit_indice integer(2),
bit_origen varchar(120),
bit_cambio varchar(120),
foreign key(pro_id) references profesor(pro_id) on update cascade on delete cascade,
foreign key(elf_id) references elementoform(elf_id) on update cascade on delete cascade,
foreign key(for_id) references formulario(for_id) on update cascade on delete cascade
)engine=InnoDB default charset=LATIN1;

create table egresado(
egr_id integer not null auto_increment primary key,
usu_id integer,
egr_fch varchar(4),
egr_bandPOO integer(1) default 0,
egr_banBD integer(1) default 0,
foreign key(usu_id) references usuario(usu_id) on update cascade on delete cascade
)engine=InnoDB default charset=LATIN1;
#esto para relacional los egresados con sus profesores

create table egr_pro(
egp_id integer not null auto_increment primary key,
egr_id integer(1),
pro_id integer(1),
foreign key(egr_id) references egresado(egr_id) on update cascade on delete cascade,
foreign key(pro_id) references profesor(pro_id) on update cascade on delete cascade
);

create table resultadopo(
rpo_id integer not null auto_increment primary key,
egr_id integer,
rpo_fchrec datetime,
rpo_resp varchar(120),
rpo_calif integer(10),
rpo_niv varchar(10),
foreign key(egr_id) references egresado(egr_id) on update cascade on delete cascade
)engine=InnoDB default charset=LATIN1;

create table resultadobd(
rbd_id integer not null auto_increment primary key,
egr_id integer,
rbd_fchrec datetime,
rbd_resp varchar(120),
rbd_calif integer(10),
#puede que cambie
rbd_niv varchar(10),
foreign key(egr_id) references egresado(egr_id) on update cascade on delete cascade
)engine=InnoDB default charset=LATIN1;