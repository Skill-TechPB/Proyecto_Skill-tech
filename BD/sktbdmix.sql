-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: sktbdmix
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `asignatura`
--

DROP TABLE IF EXISTS `asignatura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asignatura` (
  `asi_id` int NOT NULL,
  `asi_nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`asi_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asignatura`
--

LOCK TABLES `asignatura` WRITE;
/*!40000 ALTER TABLE `asignatura` DISABLE KEYS */;
INSERT INTO `asignatura` VALUES (0,'POO'),(1,'BD');
/*!40000 ALTER TABLE `asignatura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bitacora`
--

DROP TABLE IF EXISTS `bitacora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bitacora` (
  `bit_id` int NOT NULL AUTO_INCREMENT,
  `pro_id` int DEFAULT NULL,
  `bit_fchmod` datetime DEFAULT NULL,
  `for_id` int DEFAULT NULL,
  `elf_id` int DEFAULT NULL,
  `bit_indice` int DEFAULT NULL,
  `bit_origen` varchar(120) DEFAULT NULL,
  `bit_cambio` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`bit_id`),
  KEY `pro_id` (`pro_id`),
  KEY `elf_id` (`elf_id`),
  KEY `for_id` (`for_id`),
  CONSTRAINT `bitacora_ibfk_1` FOREIGN KEY (`pro_id`) REFERENCES `profesor` (`pro_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bitacora_ibfk_2` FOREIGN KEY (`elf_id`) REFERENCES `elementoform` (`elf_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bitacora_ibfk_3` FOREIGN KEY (`for_id`) REFERENCES `formulario` (`for_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bitacora`
--

LOCK TABLES `bitacora` WRITE;
/*!40000 ALTER TABLE `bitacora` DISABLE KEYS */;
/*!40000 ALTER TABLE `bitacora` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `egr_pro`
--

DROP TABLE IF EXISTS `egr_pro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `egr_pro` (
  `egp_id` int NOT NULL AUTO_INCREMENT,
  `egr_id` int DEFAULT NULL,
  `pro_id` int DEFAULT NULL,
  PRIMARY KEY (`egp_id`),
  KEY `egr_id` (`egr_id`),
  KEY `pro_id` (`pro_id`),
  CONSTRAINT `egr_pro_ibfk_1` FOREIGN KEY (`egr_id`) REFERENCES `egresado` (`egr_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `egr_pro_ibfk_2` FOREIGN KEY (`pro_id`) REFERENCES `profesor` (`pro_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `egr_pro`
--

LOCK TABLES `egr_pro` WRITE;
/*!40000 ALTER TABLE `egr_pro` DISABLE KEYS */;
INSERT INTO `egr_pro` VALUES (1,1,1),(2,1,2),(3,2,1),(4,2,2),(5,3,3),(6,3,3);
/*!40000 ALTER TABLE `egr_pro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `egresado`
--

DROP TABLE IF EXISTS `egresado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `egresado` (
  `egr_id` int NOT NULL AUTO_INCREMENT,
  `usu_id` int DEFAULT NULL,
  `egr_fch` varchar(4) DEFAULT NULL,
  `egr_bandPOO` int DEFAULT '0',
  `egr_banBD` int DEFAULT '0',
  PRIMARY KEY (`egr_id`),
  KEY `usu_id` (`usu_id`),
  CONSTRAINT `egresado_ibfk_1` FOREIGN KEY (`usu_id`) REFERENCES `usuario` (`usu_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `egresado`
--

LOCK TABLES `egresado` WRITE;
/*!40000 ALTER TABLE `egresado` DISABLE KEYS */;
INSERT INTO `egresado` VALUES (1,4,'2024',1,1),(2,5,'2025',1,1),(3,6,'2026',1,1);
/*!40000 ALTER TABLE `egresado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elementoform`
--

DROP TABLE IF EXISTS `elementoform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `elementoform` (
  `elf_id` int NOT NULL AUTO_INCREMENT,
  `elf_elemento` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`elf_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elementoform`
--

LOCK TABLES `elementoform` WRITE;
/*!40000 ALTER TABLE `elementoform` DISABLE KEYS */;
INSERT INTO `elementoform` VALUES (1,'Pregunta'),(2,'Respuesta'),(3,'Respuesta_valor');
/*!40000 ALTER TABLE `elementoform` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `formulario`
--

DROP TABLE IF EXISTS `formulario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `formulario` (
  `for_id` int NOT NULL AUTO_INCREMENT,
  `for_nombre` varchar(120) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `for_url` varchar(120) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`for_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `formulario`
--

LOCK TABLES `formulario` WRITE;
/*!40000 ALTER TABLE `formulario` DISABLE KEYS */;
INSERT INTO `formulario` VALUES (1,'FORMULARIO DE PROGRAMACIÓN INTERMEDIA','C:/Users/Josue/Desktop/Proyecto_skt/skt/web/formularios/fpoo.txt'),(2,'FORMULARIO DE BASES DE DATOS RELACIONALES','C:/Users/Josue/Desktop/Proyecto_skt/skt/web/formularios/fbd.txt');
/*!40000 ALTER TABLE `formulario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pro_asi`
--

DROP TABLE IF EXISTS `pro_asi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pro_asi` (
  `pra_id` int NOT NULL AUTO_INCREMENT,
  `pro_id` int NOT NULL,
  `asi_id` int NOT NULL,
  PRIMARY KEY (`pra_id`),
  KEY `pro_id` (`pro_id`),
  KEY `asi_id` (`asi_id`),
  CONSTRAINT `pro_asi_ibfk_1` FOREIGN KEY (`pro_id`) REFERENCES `profesor` (`pro_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pro_asi_ibfk_2` FOREIGN KEY (`asi_id`) REFERENCES `asignatura` (`asi_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pro_asi`
--

LOCK TABLES `pro_asi` WRITE;
/*!40000 ALTER TABLE `pro_asi` DISABLE KEYS */;
INSERT INTO `pro_asi` VALUES (1,1,0),(2,2,1),(3,3,0),(4,3,1),(5,4,0);
/*!40000 ALTER TABLE `pro_asi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profesor`
--

DROP TABLE IF EXISTS `profesor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profesor` (
  `pro_id` int NOT NULL AUTO_INCREMENT,
  `usu_id` int DEFAULT NULL,
  `pro_nombre` varchar(70) DEFAULT NULL,
  PRIMARY KEY (`pro_id`),
  KEY `usu_id` (`usu_id`),
  CONSTRAINT `profesor_ibfk_1` FOREIGN KEY (`usu_id`) REFERENCES `usuario` (`usu_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profesor`
--

LOCK TABLES `profesor` WRITE;
/*!40000 ALTER TABLE `profesor` DISABLE KEYS */;
INSERT INTO `profesor` VALUES (1,1,'Diego'),(2,2,'DiegoDos'),(3,3,'DiegoTres'),(4,7,'Garcia');
/*!40000 ALTER TABLE `profesor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resultadobd`
--

DROP TABLE IF EXISTS `resultadobd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resultadobd` (
  `rbd_id` int NOT NULL AUTO_INCREMENT,
  `egr_id` int DEFAULT NULL,
  `rbd_fchrec` datetime DEFAULT NULL,
  `rbd_resp` varchar(120) DEFAULT NULL,
  `rbd_calif` int DEFAULT NULL,
  `rbd_niv` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`rbd_id`),
  KEY `egr_id` (`egr_id`),
  CONSTRAINT `resultadobd_ibfk_1` FOREIGN KEY (`egr_id`) REFERENCES `egresado` (`egr_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resultadobd`
--

LOCK TABLES `resultadobd` WRITE;
/*!40000 ALTER TABLE `resultadobd` DISABLE KEYS */;
INSERT INTO `resultadobd` VALUES (1,1,'2024-04-11 00:20:11','1 0 1 0 0 0 0 0 1 0',3,'0'),(2,2,'2024-04-11 00:20:11','0 1 1 0 1 1 0 0 1 0',5,'1'),(3,3,'2024-04-11 00:20:11','0 0 0 0 0 1 0 0 0 0',1,'0');
/*!40000 ALTER TABLE `resultadobd` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resultadopo`
--

DROP TABLE IF EXISTS `resultadopo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resultadopo` (
  `rpo_id` int NOT NULL AUTO_INCREMENT,
  `egr_id` int DEFAULT NULL,
  `rpo_fchrec` datetime DEFAULT NULL,
  `rpo_resp` varchar(120) DEFAULT NULL,
  `rpo_calif` int DEFAULT NULL,
  `rpo_niv` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`rpo_id`),
  KEY `egr_id` (`egr_id`),
  CONSTRAINT `resultadopo_ibfk_1` FOREIGN KEY (`egr_id`) REFERENCES `egresado` (`egr_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resultadopo`
--

LOCK TABLES `resultadopo` WRITE;
/*!40000 ALTER TABLE `resultadopo` DISABLE KEYS */;
INSERT INTO `resultadopo` VALUES (1,1,'2024-04-11 00:19:08','0 1 0 0 0 1 1 0 0 0',3,'0'),(2,2,'2024-04-11 00:19:08','0 0 1 0 1 0 0 0 0 0',2,'0'),(3,3,'2024-04-11 00:19:08','0 1 0 0 0 1 0 0 0 1',3,'0');
/*!40000 ALTER TABLE `resultadopo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `soporte`
--

DROP TABLE IF EXISTS `soporte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `soporte` (
  `sop_id` int NOT NULL AUTO_INCREMENT,
  `usu_id` int DEFAULT NULL,
  `sop_nombre` varchar(40) DEFAULT NULL,
  `sop_email` varchar(40) DEFAULT NULL,
  `sop_desc` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`sop_id`),
  KEY `usu_id` (`usu_id`),
  CONSTRAINT `soporte_ibfk_1` FOREIGN KEY (`usu_id`) REFERENCES `usuario` (`usu_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `soporte`
--

LOCK TABLES `soporte` WRITE;
/*!40000 ALTER TABLE `soporte` DISABLE KEYS */;
/*!40000 ALTER TABLE `soporte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipousuario`
--

DROP TABLE IF EXISTS `tipousuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipousuario` (
  `tpu_id` int NOT NULL,
  `tpu_nombre` varchar(30) NOT NULL,
  PRIMARY KEY (`tpu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipousuario`
--

LOCK TABLES `tipousuario` WRITE;
/*!40000 ALTER TABLE `tipousuario` DISABLE KEYS */;
INSERT INTO `tipousuario` VALUES (0,'Egresado'),(1,'Profesor'),(2,'Jefe de Area'),(3,'Administrador');
/*!40000 ALTER TABLE `tipousuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `usu_id` int NOT NULL AUTO_INCREMENT,
  `tpu_id` int DEFAULT NULL,
  `usu_password` varchar(120) DEFAULT NULL,
  `usu_tk` varchar(120) DEFAULT NULL,
  `usu_email` varchar(120) DEFAULT NULL,
  `usu_hab` int DEFAULT '1',
  PRIMARY KEY (`usu_id`),
  KEY `tpu_id` (`tpu_id`),
  CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`tpu_id`) REFERENCES `tipousuario` (`tpu_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,1,'HNjobZOOdfnwyHjd7w1g9g==','FWFTM','dieaguilar.2577@gmail.com',1),(2,1,'HNjobZOOdfnwyHjd7w1g9g==','JLHBE','aguilar.floress.diego@gmail.com',1),(3,1,'HNjobZOOdfnwyHjd7w1g9g==','VPAYN','daguilarf2100@alumno.ipn.mx',1),(4,0,'HNjobZOOdfnwyHjd7w1g9g==','EUSFG','diazamarojosueramses@gmail.com',1),(5,0,'HNjobZOOdfnwyHjd7w1g9g==','UUFDX','diaz.amaro.josue@gmail.com',1),(6,0,'HNjobZOOdfnwyHjd7w1g9g==','FCUQC','lizeth26guadalupe@gmail.com',1),(7,2,'HNjobZOOdfnwyHjd7w1g9g==','RNDXH','pedidoslol06@gmail.com',1);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-18 14:39:44
