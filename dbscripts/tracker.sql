CREATE DATABASE  IF NOT EXISTS `tracker` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `tracker`;
-- MySQL dump 10.13  Distrib 5.7.9, for linux-glibc2.5 (x86_64)
--
-- Host: localhost    Database: tracker
-- ------------------------------------------------------
-- Server version	5.5.47-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Board`
--

DROP TABLE IF EXISTS `Board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Board` (
  `product_id` int(11) unsigned NOT NULL,
  `serial_num` varchar(9) NOT NULL,
  `fpga` varchar(8) NOT NULL,
  `bios` varchar(8) NOT NULL,
  `mac` varchar(17) NOT NULL,
  `fab` varchar(5) NOT NULL,
  `track_id` int(5) unsigned NOT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `product_id_UNIQUE` (`product_id`),
  UNIQUE KEY `track_id_UNIQUE` (`track_id`),
  UNIQUE KEY `serial_num_UNIQUE` (`serial_num`),
  KEY `product_id_INDEX` (`product_id`),
  CONSTRAINT `fk_Board_Items1` FOREIGN KEY (`product_id`) REFERENCES `Items` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Board`
--

LOCK TABLES `Board` WRITE;
/*!40000 ALTER TABLE `Board` DISABLE KEYS */;
/*!40000 ALTER TABLE `Board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Dropdown_Attributes`
--

DROP TABLE IF EXISTS `Dropdown_Attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Dropdown_Attributes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attr_type` varchar(20) NOT NULL,
  `attr_value` varchar(40) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Dropdown_Attributes`
--

LOCK TABLES `Dropdown_Attributes` WRITE;
/*!40000 ALTER TABLE `Dropdown_Attributes` DISABLE KEYS */;
INSERT INTO `Dropdown_Attributes` VALUES (1,'codename','Sandy Bridge'),(2,'codename','Jaketown'),(3,'codename','Haswell'),(4,'codename','Crystal Well'),(5,'codename','Bay Trail'),(6,'codename','Haswell Server'),(7,'codename','Broadwell'),(8,'codename','Skylake');
/*!40000 ALTER TABLE `Dropdown_Attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Events`
--

DROP TABLE IF EXISTS `Events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Events` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cpu_serial_num` varchar(14) NOT NULL,
  `memory_serial_num` varchar(20) NOT NULL,
  `ssd_serial_num` varchar(16) NOT NULL,
  `flash_drive_serial_num` varchar(20) NOT NULL,
  `modifier_wwid` varchar(8) NOT NULL,
  `modifier_idsid` varchar(12) NOT NULL,
  `modifier_ip` varchar(15) NOT NULL,
  `date` datetime NOT NULL,
  `action` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Events`
--

LOCK TABLES `Events` WRITE;
/*!40000 ALTER TABLE `Events` DISABLE KEYS */;
/*!40000 ALTER TABLE `Events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Flash_Drive`
--

DROP TABLE IF EXISTS `Flash_Drive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Flash_Drive` (
  `product_id` int(11) unsigned NOT NULL,
  `serial_num` varchar(20) NOT NULL,
  `manufacturer` varchar(15) NOT NULL,
  `capacity` int(5) NOT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `id_UNIQUE` (`product_id`),
  UNIQUE KEY `serial_num_UNIQUE` (`serial_num`),
  CONSTRAINT `fk_Flash_Drive_Items1` FOREIGN KEY (`product_id`) REFERENCES `Items` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Flash_Drive`
--

LOCK TABLES `Flash_Drive` WRITE;
/*!40000 ALTER TABLE `Flash_Drive` DISABLE KEYS */;
/*!40000 ALTER TABLE `Flash_Drive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Items`
--

DROP TABLE IF EXISTS `Items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Items` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `item_type` varchar(30) NOT NULL,
  `user` varchar(8) NOT NULL DEFAULT '',
  `notes` text NOT NULL,
  `checked_in` tinyint(1) NOT NULL DEFAULT '1',
  `scrapped` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `user_INDEX` (`user`),
  CONSTRAINT `fk_Items_Owners1` FOREIGN KEY (`user`) REFERENCES `Owners` (`wwid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Items`
--

LOCK TABLES `Items` WRITE;
/*!40000 ALTER TABLE `Items` DISABLE KEYS */;
INSERT INTO `Items` VALUES (17,'cpu','','',1,0),(18,'cpu','','',1,0),(19,'cpu','','',1,0),(20,'cpu','','',1,0),(21,'cpu','','',1,0),(22,'cpu','','',1,0),(23,'cpu','','',1,0),(24,'cpu','','',1,0),(25,'cpu','','',1,0),(26,'cpu','','',1,0),(27,'cpu','','',1,0),(28,'cpu','','',1,0),(29,'cpu','','',1,0),(30,'cpu','','',1,0),(31,'cpu','','',1,0),(32,'cpu','','undefined',1,0),(33,'cpu','','undefined',1,0);
/*!40000 ALTER TABLE `Items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Log`
--

DROP TABLE IF EXISTS `Log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(11) unsigned NOT NULL,
  `user` varchar(8) NOT NULL,
  `log_date` datetime NOT NULL,
  `checked_in` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `user_INDEX` (`user`),
  KEY `product_id_INDEX` (`product_id`),
  CONSTRAINT `fk_Log_Items1` FOREIGN KEY (`product_id`) REFERENCES `Items` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Log_Owners1` FOREIGN KEY (`user`) REFERENCES `Owners` (`wwid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Log`
--

LOCK TABLES `Log` WRITE;
/*!40000 ALTER TABLE `Log` DISABLE KEYS */;
/*!40000 ALTER TABLE `Log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Memory`
--

DROP TABLE IF EXISTS `Memory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Memory` (
  `product_id` int(11) unsigned NOT NULL,
  `Physical Size` varchar(15) NOT NULL,
  `Type` varchar(12) NOT NULL,
  `Capacity` int(5) NOT NULL,
  `Speed` int(5) NOT NULL,
  `ECC` varchar(12) NOT NULL,
  `Ranks` int(3) NOT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `product_id_UNIQUE` (`product_id`),
  KEY `product_id_INDEX` (`product_id`),
  CONSTRAINT `fk_Memory_Items1` FOREIGN KEY (`product_id`) REFERENCES `Items` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Memory`
--

LOCK TABLES `Memory` WRITE;
/*!40000 ALTER TABLE `Memory` DISABLE KEYS */;
/*!40000 ALTER TABLE `Memory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Owners`
--

DROP TABLE IF EXISTS `Owners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Owners` (
  `wwid` varchar(8) NOT NULL,
  `idsid` varchar(12) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  PRIMARY KEY (`wwid`),
  UNIQUE KEY `wwid_UNIQUE` (`wwid`),
  UNIQUE KEY `idsid_UNIQUE` (`idsid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Owners`
--

LOCK TABLES `Owners` WRITE;
/*!40000 ALTER TABLE `Owners` DISABLE KEYS */;
INSERT INTO `Owners` VALUES ('','','',''),('1','1','test_user','test_user');
/*!40000 ALTER TABLE `Owners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Processor`
--

DROP TABLE IF EXISTS `Processor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Processor` (
  `product_id` int(11) unsigned NOT NULL,
  `serial_num` varchar(14) NOT NULL,
  `spec` varchar(5) NOT NULL,
  `mm` varchar(7) NOT NULL,
  `frequency` varchar(5) NOT NULL,
  `stepping` varchar(6) NOT NULL,
  `llc` float NOT NULL,
  `cores` int(4) NOT NULL,
  `codename` varchar(25) NOT NULL,
  `cpu_class` varchar(10) NOT NULL,
  `external_name` varchar(25) DEFAULT NULL,
  `architecture` varchar(25) NOT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `product_id_UNIQUE` (`product_id`),
  UNIQUE KEY `serial_num_UNIQUE` (`serial_num`),
  KEY `product_id_INDEX` (`product_id`),
  CONSTRAINT `fk_Processor_Items1` FOREIGN KEY (`product_id`) REFERENCES `Items` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Processor`
--

LOCK TABLES `Processor` WRITE;
/*!40000 ALTER TABLE `Processor` DISABLE KEYS */;
INSERT INTO `Processor` VALUES (17,'2V127163B0897','SR02U','910244','2.5','D2',3,2,'Sandy Bridge','Mobile','Core i5-2510E','Sandy Bridge'),(18,'35127210J0054','SR02T','910243','2.1','D2',6,4,'Sandy Bridge','Mobile','Core i7-2710QE','Sandy Bridge'),(19,'35127210J0084','SR1XV','935852','2.2','M1',30,12,'Haswell Server','EP','Xeon E5-2658 v3','Haswell'),(20,'2V127163B0110','SR195','929620','1.8','C0',6,4,'Crystal Well','Mobile','Core i7-4860EQ','Haswell'),(21,'35127210J0092','SR0KQ','919841','2','C2',20,8,'Jaketown','EP','Xeon E5-2650','Sandy Bridge'),(22,'2V127163B0675','SR2F1','944341','2.6','D1',4,2,'Skylake','ULT','Core i7-6600U','Skylake'),(23,'35125272R0021','SR2E8','944076','2.7','G1',6,4,'Broadwell','Mobile','Core i7-5850EQ','Broadwell'),(24,'2V127163B0804','SR1W5','934898','1.58','C0',1,2,'Bay Trail','Atom','Celeron N2807','Silvermont'),(25,'35127210J0029','SR2E9','944077','1.8','G1',6,4,'Broadwell','Mobile','Xeon E3-1258L v4','Broadwell'),(26,'35127210J0062','SR268','939656','1.8','F0',3,2,'Broadwell','ULT','Core i5-5350U','Broadwell'),(27,'2V127163B0872','SR268','939656','1.8','F0',3,2,'Broadwell','ULT','Core i5-5350U','Broadwell'),(28,'2V127163B0686','SR2E7','944075','2','G1',6,4,'Broadwell','Mobile','Xeon E3-1278L v4','Broadwell'),(29,'35127210J0078','SR180','929227','2.4','C0',4,2,'Haswell','Desktop','Core i3-4330TE','Haswell'),(30,'35127210J0055','SR17N','929207','2.4','C0',3,2,'Haswell','Mobile','Core i3-4100E','Haswell'),(31,'35127210J0083','SR17N','929207','2.4','C0',3,2,'Haswell','Mobile','Core i3-4100E','Haswell');
/*!40000 ALTER TABLE `Processor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RAM`
--

DROP TABLE IF EXISTS `RAM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RAM` (
  `product_id` int(11) unsigned NOT NULL,
  `serial_num` varchar(20) NOT NULL,
  `manufacturer` varchar(15) NOT NULL,
  `physical_size` varchar(15) NOT NULL,
  `memory_type` varchar(12) NOT NULL,
  `capacity` int(5) NOT NULL,
  `speed` int(5) NOT NULL,
  `ecc` varchar(12) NOT NULL,
  `ranks` int(3) NOT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `product_id_UNIQUE` (`product_id`),
  UNIQUE KEY `serial_num_UNIQUE` (`serial_num`),
  KEY `product_id_INDEX` (`product_id`),
  CONSTRAINT `fk_RAM_Items1` FOREIGN KEY (`product_id`) REFERENCES `Items` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RAM`
--

LOCK TABLES `RAM` WRITE;
/*!40000 ALTER TABLE `RAM` DISABLE KEYS */;
/*!40000 ALTER TABLE `RAM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reservations`
--

DROP TABLE IF EXISTS `Reservations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Reservations` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(11) unsigned NOT NULL,
  `current_user` varchar(8) NOT NULL,
  `waiting_user` varchar(8) NOT NULL,
  `reservation_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `product_id_INDEX` (`product_id`),
  KEY `current_user_INDEX` (`current_user`),
  KEY `waiting_user_INDEX` (`waiting_user`),
  CONSTRAINT `fk_Reservations_Items1` FOREIGN KEY (`product_id`) REFERENCES `Items` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reservations_Owners1` FOREIGN KEY (`current_user`) REFERENCES `Owners` (`wwid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reservations_Owners2` FOREIGN KEY (`waiting_user`) REFERENCES `Owners` (`wwid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reservations`
--

LOCK TABLES `Reservations` WRITE;
/*!40000 ALTER TABLE `Reservations` DISABLE KEYS */;
/*!40000 ALTER TABLE `Reservations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SSD`
--

DROP TABLE IF EXISTS `SSD`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SSD` (
  `product_id` int(11) unsigned NOT NULL,
  `serial_num` varchar(16) NOT NULL,
  `manufacturer` varchar(45) NOT NULL,
  `model` varchar(15) NOT NULL,
  `capacity` int(5) NOT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `product_id_UNIQUE` (`product_id`),
  UNIQUE KEY `serial_num_UNIQUE` (`serial_num`),
  KEY `product_id_INDEX` (`product_id`),
  CONSTRAINT `fk_SSD_Items1` FOREIGN KEY (`product_id`) REFERENCES `Items` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SSD`
--

LOCK TABLES `SSD` WRITE;
/*!40000 ALTER TABLE `SSD` DISABLE KEYS */;
/*!40000 ALTER TABLE `SSD` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `System`
--

DROP TABLE IF EXISTS `System`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `System` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cpu_serial_num` varchar(14) NOT NULL,
  `board_serial_num` varchar(9) NOT NULL,
  `ssd_serial_num` varchar(16) NOT NULL,
  `memory_serial_num` varchar(20) NOT NULL,
  `in_use_by` varchar(30) NOT NULL,
  `ip` varchar(15) NOT NULL,
  `since` datetime NOT NULL,
  `location` varchar(25) NOT NULL,
  `num_dimms` int(5) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `memory_serial_num_UNIQUE` (`memory_serial_num`),
  UNIQUE KEY `ssd_serial_num_UNIQUE` (`ssd_serial_num`),
  UNIQUE KEY `board_serial_num_UNIQUE` (`board_serial_num`),
  UNIQUE KEY `cpu_serial_num_UNIQUE` (`cpu_serial_num`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `System`
--

LOCK TABLES `System` WRITE;
/*!40000 ALTER TABLE `System` DISABLE KEYS */;
/*!40000 ALTER TABLE `System` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'tracker'
--
/*!50003 DROP PROCEDURE IF EXISTS `check_serial_cpu` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE PROCEDURE `check_serial_cpu`(IN which_serial VARCHAR(14))
BEGIN
	SELECT Processor.serial_num
    FROM Processor
    WHERE Processor.serial_num = which_serial;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `check_serial_flash_drive` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE PROCEDURE `check_serial_flash_drive`(IN which_serial VARCHAR(20))
BEGIN
	SELECT Flash_Drive.serial_num
    FROM Flash_Drive
    WHERE Flash_Drive.serial_num = which_serial;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `check_serial_memory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE PROCEDURE `check_serial_memory`(IN which_serial VARCHAR(20))
BEGIN
	SELECT RAM.serial_num
    FROM RAM
    WHERE RAM.serial_num = which_serial;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `check_serial_ssd` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE PROCEDURE `check_serial_ssd`(IN which_serial VARCHAR(16))
BEGIN
	SELECT SSD.serial_num
    FROM SSD
    WHERE SSD.serial_num = which_serial;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_board` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE PROCEDURE `get_board`()
BEGIN
	SELECT
		Board.serial_num, fpga, bios, mac, fab,
		Board.track_id, Items.user, checked_in, notes
	FROM 
		Board INNER JOIN Items
        ON Board.product_id = Items.id
    WHERE
		scrapped = 0
        AND Items.item_type = 'board';

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_cpu` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE PROCEDURE `get_cpu`()
BEGIN
	SELECT
		Processor.serial_num, spec, mm, frequency, stepping, 
        llc, cores, codename, cpu_class, external_name,
		architecture, Items.user, checked_in, notes
	FROM 
		Processor INNER JOIN Items
        ON Processor.product_id = Items.id
    WHERE
		scrapped = 0
        AND Items.item_type = 'cpu';

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_dropdown` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE PROCEDURE `get_dropdown`(IN attr VARCHAR(20))
BEGIN
	SELECT 	attr_value
    FROM	Dropdown_Attributes
    WHERE	lcase(attr_type) = attr;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_flash_drive` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE PROCEDURE `get_flash_drive`()
BEGIN
	SELECT
		Flash_Drive.serial_num, manufacturer, capacity,
        Items.user, checked_in, notes
	FROM 
		Flash_Drive INNER JOIN Items
        ON Flash_Drive.product_id = Items.id
    WHERE
		scrapped = 0
        AND Items.item_type = 'flash_drive';

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_memory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE PROCEDURE `get_memory`()
BEGIN
	SELECT
		RAM.serial_num, manufacturer, physical_size,
        memory_type, capacity, speed, ecc, ranks,
        Items.user, checked_in, notes
	FROM 
		RAM INNER JOIN Items
        ON RAM.product_id = Items.id
    WHERE
		scrapped = 0
		AND Items.item_type = 'memory';

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_ssd` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE PROCEDURE `get_ssd`()
BEGIN
	SELECT
		SSD.serial_num, manufacturer, model,
        capacity, Items.user, checked_in, notes
	FROM 
		SSD INNER JOIN Items
        ON SSD.product_id = Items.id
    WHERE
		scrapped = 0
        AND Items.item_type = 'ssd';


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `put_board` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE PROCEDURE `put_board`(IN new_serial_num VARCHAR(9),
 IN new_fpga VARCHAR(8),
 IN new_bios VARCHAR(8),
 IN new_mac VARCHAR(17),
 IN new_fab VARCHAR(5),
 IN new_track_id INT(5),
 IN new_notes TEXT)
BEGIN
	INSERT INTO Items
		(item_type, notes)
	VALUES
		('board', new_notes);
	INSERT INTO Board
		(product_id, serial_num, fpga,
         bios, mac, fab, track_id)
	VALUES
		(LAST_INSERT_ID(), new_serial_num, new_fpga,
         new_bios, new_mac, new_fab, new_track_id);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `put_cpu` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE PROCEDURE `put_cpu`(IN `new_serial_num` VARCHAR(14), IN `new_spec` VARCHAR(5), IN `new_mm` VARCHAR(7), IN `new_frequency` VARCHAR(5), IN `new_stepping` VARCHAR(6), IN `new_llc` FLOAT, IN `new_cores` INT(4), IN `new_codename` VARCHAR(25), IN `new_cpu_class` VARCHAR(10), IN `new_external_name` VARCHAR(25), IN `new_architecture` VARCHAR(25), IN `new_notes` TEXT)
BEGIN
	INSERT INTO Items
		(item_type, notes)
	VALUES
		('cpu', new_notes);
	INSERT INTO Processor
		(product_id, serial_num, spec, mm, frequency,
         stepping, llc, cores, codename, cpu_class,
         external_name, architecture)
	VALUES
		(LAST_INSERT_ID(), new_serial_num, new_spec,
         new_mm, new_frequency, new_stepping, new_llc,
         new_cores, new_codename, new_cpu_class,
         new_external_name, new_architecture);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `put_flash_drive` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE PROCEDURE `put_flash_drive`(IN new_serial_num VARCHAR(20),
 IN new_manufacturer VARCHAR(15),
 IN new_capacity INT(5),
 IN new_notes TEXT)
BEGIN
	INSERT INTO Items
		(item_type, notes)
	VALUES
		('flash_drive', new_notes);
	INSERT INTO Flash_Drive
		(product_id, serial_num, manufacturer, capacity)
	VALUES
		(LAST_INSERT_ID(), new_serial_num,
         new_manufacturer, new_capacity);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `put_memory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE PROCEDURE `put_memory`(IN new_serial_num VARCHAR(20),
 IN new_manufacturer VARCHAR(15),
 IN new_physical_size VARCHAR(15),
 IN new_memory_type VARCHAR(12),
 IN new_capacity INT(5),
 IN new_speed INT(5),
 IN new_ecc VARCHAR(12),
 IN new_ranks INT(3),
 IN new_notes TEXT)
BEGIN
	INSERT INTO Items
		(item_type, notes)
	VALUES
		('memory', new_notes);
	INSERT INTO RAM
		(product_id, serial_num, manufacturer, physical_size,
         memory_type, capacity, speed, ecc, ranks)
	VALUES
		(LAST_INSERT_ID(), new_serial_num, new_manufacturer,
         new_physical_size, new_memory_type, new_capacity,
         new_speed, new_ecc, new_ranks);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `put_ssd` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE PROCEDURE `put_ssd`(IN new_serial_num VARCHAR(20),
 IN new_manufacturer VARCHAR(15),
 IN new_model VARCHAR(15),
 IN new_capacity INT(5),
 IN new_notes TEXT)
BEGIN
	INSERT INTO Items
		(item_type, notes)
	VALUES
		('ssd', new_notes);
	INSERT INTO SSD
		(product_id, serial_num, manufacturer, model, capacity)
	VALUES
		(LAST_INSERT_ID(), new_serial_num, new_manufacturer,
         new_model, new_capacity);
         
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `scan_cpu` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE PROCEDURE `scan_cpu`(IN new_user VARCHAR(8),
 IN item VARCHAR(14))
BEGIN
	UPDATE
		Items JOIN Processor
        ON Processor.product_id = Items.id
	SET 
		Items.user = IF(checked_in = 1, new_user, ''),
        Items.checked_in = ~Items.checked_in
    WHERE
		Processor.serial_num = item;
	INSERT INTO Log
		(product_id)
	SELECT
		Processor.product_id
	FROM
		Processor
	WHERE
		Processor.serial_num = item;
	INSERT INTO Log
		(user, log_date)
	VALUES
		(new_user, NOW());

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `scan_flash_drive` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE PROCEDURE `scan_flash_drive`(IN new_user VARCHAR(8),
 IN item VARCHAR(20))
BEGIN
	UPDATE
		Items JOIN Flash_Drive
        ON Flash_Drive.product_id = Items.id
	SET 
		Items.user = IF(checked_in = 1, new_user, ''),
        Items.checked_in = ~Items.checked_in
    WHERE
		Flash_Drive.serial_num = item;
	INSERT INTO Log
		(product_id)
	SELECT
		Flash_Drive.product_id
	FROM
		Flash_Drive
	WHERE
		Flash_Drive.serial_num = item;
	INSERT INTO Log
		(user, log_date)
	VALUES
		(new_user, NOW());
        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `scan_memory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE PROCEDURE `scan_memory`(IN new_user VARCHAR(8),
 IN item VARCHAR(20))
BEGIN
	UPDATE
		Items JOIN RAM
        ON RAM.product_id = Items.id
	SET 
		Items.user = IF(checked_in = 1, new_user, ''),
        Items.checked_in = ~Items.checked_in
    WHERE
		RAM.serial_num = item;
	INSERT INTO Log
		(product_id)
	SELECT
		RAM.product_id
	FROM
		RAM
	WHERE
		RAM.serial_num = item;
	INSERT INTO Log
		(user, log_date)
	VALUES
		(new_user, NOW());

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `scan_ssd` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE PROCEDURE `scan_ssd`(IN new_user VARCHAR(8),
 IN item VARCHAR(20))
BEGIN
	UPDATE
		Items JOIN SSD
        ON SSD.product_id = Items.id
	SET 
		Items.user = IF(checked_in = 1, new_user, ''),
        Items.checked_in = ~Items.checked_in
    WHERE
		SSD.serial_num = item;
	INSERT INTO Log
		(product_id)
	SELECT
		SSD.product_id
	FROM
		SSD
	WHERE
		SSD.serial_num = item;
	INSERT INTO Log
		(user, log_date)
	VALUES
		(new_user, NOW());

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-03-04 10:56:09