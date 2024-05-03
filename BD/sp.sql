-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: sp
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
-- Table structure for table `estado`
--

DROP TABLE IF EXISTS `estado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estado` (
  `est_id` int NOT NULL AUTO_INCREMENT,
  `est_estado` varchar(20) NOT NULL,
  PRIMARY KEY (`est_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado`
--

LOCK TABLES `estado` WRITE;
/*!40000 ALTER TABLE `estado` DISABLE KEYS */;
INSERT INTO `estado` VALUES (1,'No Resuelto'),(2,'En proceso'),(3,'Resuelto');
/*!40000 ALTER TABLE `estado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incidencia`
--

DROP TABLE IF EXISTS `incidencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incidencia` (
  `inc_id` int NOT NULL AUTO_INCREMENT,
  `inc_email` varchar(50) NOT NULL,
  `inc_descripcion` varchar(70) NOT NULL,
  `inc_fch` date NOT NULL,
  `est_id` int DEFAULT NULL,
  `tin_id` int DEFAULT NULL,
  PRIMARY KEY (`inc_id`),
  KEY `tin_id` (`tin_id`),
  KEY `est_id` (`est_id`),
  CONSTRAINT `incidencia_ibfk_1` FOREIGN KEY (`tin_id`) REFERENCES `tincidencia` (`tin_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `incidencia_ibfk_2` FOREIGN KEY (`est_id`) REFERENCES `estado` (`est_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incidencia`
--

LOCK TABLES `incidencia` WRITE;
/*!40000 ALTER TABLE `incidencia` DISABLE KEYS */;
INSERT INTO `incidencia` VALUES (1,'armando235@gmail.com','4h4whwhw42','2024-05-02',1,1),(2,'nedyamaro77@gmail.com','5g2g5h2','2024-05-02',1,1);
/*!40000 ALTER TABLE `incidencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `preguntaf`
--

DROP TABLE IF EXISTS `preguntaf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `preguntaf` (
  `pgf_id` int NOT NULL AUTO_INCREMENT,
  `pgf_pregunta` varchar(50) DEFAULT NULL,
  `rpf_id` int NOT NULL,
  PRIMARY KEY (`pgf_id`),
  KEY `rpf_id` (`rpf_id`),
  CONSTRAINT `preguntaf_ibfk_1` FOREIGN KEY (`rpf_id`) REFERENCES `respuestaf` (`rpf_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preguntaf`
--

LOCK TABLES `preguntaf` WRITE;
/*!40000 ALTER TABLE `preguntaf` DISABLE KEYS */;
/*!40000 ALTER TABLE `preguntaf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prioridad`
--

DROP TABLE IF EXISTS `prioridad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prioridad` (
  `pri_id` int NOT NULL AUTO_INCREMENT,
  `pri_prioridad` varchar(20) NOT NULL,
  PRIMARY KEY (`pri_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prioridad`
--

LOCK TABLES `prioridad` WRITE;
/*!40000 ALTER TABLE `prioridad` DISABLE KEYS */;
INSERT INTO `prioridad` VALUES (1,'URGENTE'),(2,'No tan urgente');
/*!40000 ALTER TABLE `prioridad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pro_inc`
--

DROP TABLE IF EXISTS `pro_inc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pro_inc` (
  `pri_id` int NOT NULL AUTO_INCREMENT,
  `pri_fche` date NOT NULL,
  `pro_id` int NOT NULL,
  `inc_id` int NOT NULL,
  PRIMARY KEY (`pri_id`),
  KEY `pro_id` (`pro_id`),
  KEY `inc_id` (`inc_id`),
  CONSTRAINT `pro_inc_ibfk_1` FOREIGN KEY (`pro_id`) REFERENCES `programador` (`pro_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pro_inc_ibfk_2` FOREIGN KEY (`inc_id`) REFERENCES `incidencia` (`inc_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pro_inc`
--

LOCK TABLES `pro_inc` WRITE;
/*!40000 ALTER TABLE `pro_inc` DISABLE KEYS */;
/*!40000 ALTER TABLE `pro_inc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `programador`
--

DROP TABLE IF EXISTS `programador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `programador` (
  `pro_id` int NOT NULL AUTO_INCREMENT,
  `pro_nombre` varchar(20) NOT NULL,
  `pro_apellido` varchar(20) NOT NULL,
  `pro_email` varchar(50) NOT NULL,
  `pro_llave` varchar(20) NOT NULL,
  `pro_rol` varchar(20) NOT NULL,
  PRIMARY KEY (`pro_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programador`
--

LOCK TABLES `programador` WRITE;
/*!40000 ALTER TABLE `programador` DISABLE KEYS */;
INSERT INTO `programador` VALUES (1,'Josue','Diaz','diaz.amaro.josue@gmail.com','TILIN092','BD'),(2,'Jan','Hurtado','jhurtador2100@alumno.ipn.mx','COCA13','BACK'),(3,'Diego','Aguilar','aguilar.floress.diego@gmail.com','SESION69','BACK'),(4,'Miguel','Isaac','garcia.garcia.miguel.isaac1@gmail.com','MIRIAM15','FRONT'),(5,'Edgar','Rivera','ealvarezr2001@alumno.ipn.mx','MIRIAM15','FRONT');
/*!40000 ALTER TABLE `programador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `respuestaf`
--

DROP TABLE IF EXISTS `respuestaf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `respuestaf` (
  `rpf_id` int NOT NULL AUTO_INCREMENT,
  `rpf_respuesta` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`rpf_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `respuestaf`
--

LOCK TABLES `respuestaf` WRITE;
/*!40000 ALTER TABLE `respuestaf` DISABLE KEYS */;
/*!40000 ALTER TABLE `respuestaf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tincidencia`
--

DROP TABLE IF EXISTS `tincidencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tincidencia` (
  `tin_id` int NOT NULL AUTO_INCREMENT,
  `tin_nombre` varchar(20) NOT NULL,
  `tin_descripcion` varchar(50) NOT NULL,
  `pri_id` int NOT NULL,
  PRIMARY KEY (`tin_id`),
  KEY `pri_id` (`pri_id`),
  CONSTRAINT `tincidencia_ibfk_1` FOREIGN KEY (`pri_id`) REFERENCES `prioridad` (`pri_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tincidencia`
--

LOCK TABLES `tincidencia` WRITE;
/*!40000 ALTER TABLE `tincidencia` DISABLE KEYS */;
INSERT INTO `tincidencia` VALUES (1,'Problema técnico','Fallas en el programa',1),(2,'Sugerencia','Sugerencias propuestas por el usuario',2);
/*!40000 ALTER TABLE `tincidencia` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-02 18:35:16
