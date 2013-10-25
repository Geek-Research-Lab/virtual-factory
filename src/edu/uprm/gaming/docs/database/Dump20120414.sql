-- MySQL dump 10.13  Distrib 5.5.9, for Win32 (x86)
--
-- Host: localhost    Database: gaming
-- ------------------------------------------------------
-- Server version	5.5.15

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
-- Current Database: `gaming`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `gaming` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `gaming`;

--
-- Table structure for table `t_activity`
--

DROP TABLE IF EXISTS `t_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_activity` (
  `id_activity` int(11) NOT NULL,
  `id_game` int(11) NOT NULL,
  `id_part` int(11) DEFAULT NULL,
  `activity_description` varchar(50) DEFAULT NULL,
  `type_activity` varchar(10) DEFAULT NULL,
  `id_next_activity` int(11) DEFAULT NULL,
  `processing_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_activity`,`id_game`),
  KEY `fk_id_game_0011` (`id_game`),
  KEY `fk_activity_part` (`id_part`),
  CONSTRAINT `fk_activity_part` FOREIGN KEY (`id_part`) REFERENCES `t_part` (`id_part`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_id_game_0011` FOREIGN KEY (`id_game`) REFERENCES `t_game` (`id_game`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_activity`
--

LOCK TABLES `t_activity` WRITE;
/*!40000 ALTER TABLE `t_activity` DISABLE KEYS */;
INSERT INTO `t_activity` VALUES (1,0,1,'Purchase Part1','Purchase',4,8),(2,0,2,'Purchase Part2','Purchase',5,8),(3,0,3,'Assemble Part3','Operation',6,3),(4,0,1,'Transport Part1 from Receiving Dock to Station1','Transport',3,4),(5,0,2,'Transport Part2 from Receiving Dock to Station1','Transport',3,4),(6,0,3,'Move Part3 in Station1 to Storage','Store',7,5),(7,0,3,'Transport Part3 from Station1 to Ship Station','Transport',8,6),(8,0,3,'Ship Part3','Ship',0,10);
/*!40000 ALTER TABLE `t_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_assembly_details`
--

DROP TABLE IF EXISTS `t_assembly_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_assembly_details` (
  `id_output_part` int(11) NOT NULL,
  `id_input_part` int(11) NOT NULL,
  `id_game` int(11) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `assembly_description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_output_part`,`id_input_part`,`id_game`),
  KEY `assembly_output` (`id_output_part`),
  KEY `assembly_input` (`id_input_part`),
  KEY `assembly_game` (`id_game`),
  CONSTRAINT `assembly_game` FOREIGN KEY (`id_game`) REFERENCES `t_game` (`id_game`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `assembly_input` FOREIGN KEY (`id_input_part`) REFERENCES `t_part` (`id_part`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `assembly_output` FOREIGN KEY (`id_output_part`) REFERENCES `t_part` (`id_part`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_assembly_details`
--

LOCK TABLES `t_assembly_details` WRITE;
/*!40000 ALTER TABLE `t_assembly_details` DISABLE KEYS */;
INSERT INTO `t_assembly_details` VALUES (3,1,0,2,'Part3 requires 2 units of Part1'),(3,2,0,1,'Part3 requires 1 unit of Part2');
/*!40000 ALTER TABLE `t_assembly_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_bucket`
--

DROP TABLE IF EXISTS `t_bucket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_bucket` (
  `id_bucket` int(11) NOT NULL,
  `id_station` int(11) NOT NULL,
  `id_game` int(11) NOT NULL,
  `capacity` int(11) DEFAULT NULL,
  `unit` varchar(10) DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `id_part` int(11) NOT NULL,
  `direction` varchar(10) DEFAULT NULL,
  `units_to_arrive` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_bucket`,`id_station`,`id_game`),
  KEY `fk_id_station_0001` (`id_station`),
  KEY `fk_id_part_0001x` (`id_part`),
  KEY `bucket_game` (`id_game`),
  CONSTRAINT `bucket_game` FOREIGN KEY (`id_game`) REFERENCES `t_game` (`id_game`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_id_part_0001x` FOREIGN KEY (`id_part`) REFERENCES `t_part` (`id_part`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_id_station_0001` FOREIGN KEY (`id_station`) REFERENCES `t_station` (`id_station`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_bucket`
--

LOCK TABLES `t_bucket` WRITE;
/*!40000 ALTER TABLE `t_bucket` DISABLE KEYS */;
INSERT INTO `t_bucket` VALUES (1,1,0,50,'EACH',0,1,'Input',0),(1,2,0,200,'EACH',0,1,'Output',0),(1,3,0,500,'EACH',0,1,'Both',0),(1,4,0,100,'EACH',0,1,'Input',0),(2,1,0,25,'EACH',0,2,'Input',0),(2,2,0,100,'EACH',0,2,'Output',0),(2,3,0,250,'EACH',0,2,'Both',0),(2,4,0,100,'EACH',0,2,'Input',0),(3,1,0,25,'EACH',0,3,'Output',0),(3,3,0,125,'EACH',0,3,'Both',0),(3,4,0,100,'EACH',0,3,'Input',0);
/*!40000 ALTER TABLE `t_bucket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_catalog`
--

DROP TABLE IF EXISTS `t_catalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_catalog` (
  `id_supplier` int(11) NOT NULL,
  `id_part` int(11) NOT NULL,
  `id_game` int(11) NOT NULL,
  `quality` decimal(5,2) DEFAULT NULL,
  `production_distn` varchar(10) DEFAULT NULL,
  `production_parameter1` decimal(5,2) DEFAULT NULL,
  `production_parameter2` decimal(5,2) DEFAULT NULL,
  `price_function1_limit` int(11) DEFAULT NULL,
  `price_function1_charge` decimal(5,2) DEFAULT NULL,
  `price_function2_limit` int(11) DEFAULT NULL,
  `price_function2_charge` decimal(5,2) DEFAULT NULL,
  `price_function3_limit` int(11) DEFAULT NULL,
  `price_function3_charge` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`id_supplier`,`id_part`,`id_game`),
  KEY `fk_{F87663D2-AB54-4FFA-AB68-B965923832D7}` (`id_part`),
  KEY `fk_{C894B249-C7A7-4CC7-9E3E-ADA16FFF782E}` (`id_supplier`),
  KEY `catalog_game` (`id_game`),
  CONSTRAINT `catalog_game` FOREIGN KEY (`id_game`) REFERENCES `t_game` (`id_game`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_{C894B249-C7A7-4CC7-9E3E-ADA16FFF782E}` FOREIGN KEY (`id_supplier`) REFERENCES `t_supplier` (`id_supplier`),
  CONSTRAINT `fk_{F87663D2-AB54-4FFA-AB68-B965923832D7}` FOREIGN KEY (`id_part`) REFERENCES `t_part` (`id_part`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_catalog`
--

LOCK TABLES `t_catalog` WRITE;
/*!40000 ALTER TABLE `t_catalog` DISABLE KEYS */;
INSERT INTO `t_catalog` VALUES (1,1,0,0.00,'0',0.00,0.00,10,0.15,50,0.12,100,0.10),(1,2,0,0.00,'0',0.00,0.00,10,0.30,25,0.25,50,0.20);
/*!40000 ALTER TABLE `t_catalog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_event_list`
--

DROP TABLE IF EXISTS `t_event_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_event_list` (
  `id_event_list` int(11) NOT NULL,
  `id_game` int(11) NOT NULL,
  `id_event_code` int(11) DEFAULT NULL,
  `time_to_finish` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_event_list`,`id_game`),
  KEY `fkn_game_id_123` (`id_game`),
  CONSTRAINT `fkn_game_id_123` FOREIGN KEY (`id_game`) REFERENCES `t_game` (`id_game`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='######################\n#  This table needs to be updated  #\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_event_list`
--

LOCK TABLES `t_event_list` WRITE;
/*!40000 ALTER TABLE `t_event_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_event_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_game`
--

DROP TABLE IF EXISTS `t_game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_game` (
  `id_game` int(11) NOT NULL,
  `date_time` datetime DEFAULT NULL,
  `id_player` int(11) NOT NULL,
  `current_money` decimal(5,2) DEFAULT NULL,
  `current_minute` int(11) DEFAULT '0',
  `current_hour` int(11) DEFAULT NULL,
  `current_day` int(11) DEFAULT NULL,
  `current_month` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_game`),
  KEY `fkn_id_player_0001` (`id_player`),
  CONSTRAINT `fkn_id_player_0001` FOREIGN KEY (`id_player`) REFERENCES `t_player` (`id_player`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_game`
--

LOCK TABLES `t_game` WRITE;
/*!40000 ALTER TABLE `t_game` DISABLE KEYS */;
INSERT INTO `t_game` VALUES (0,'2012-01-09 18:51:28',0,500.00,0,0,1,0);
/*!40000 ALTER TABLE `t_game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_log`
--

DROP TABLE IF EXISTS `t_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_log` (
  `id_Log` int(11) NOT NULL AUTO_INCREMENT,
  `date_time` datetime DEFAULT NULL,
  `message` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_Log`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_log`
--

LOCK TABLES `t_log` WRITE;
/*!40000 ALTER TABLE `t_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_machine`
--

DROP TABLE IF EXISTS `t_machine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_machine` (
  `id_machine` int(11) NOT NULL,
  `id_game` int(11) NOT NULL,
  `machine_description` varchar(50) DEFAULT NULL,
  `speed` decimal(5,2) DEFAULT NULL,
  `weight_capacity` decimal(5,2) DEFAULT NULL,
  `volume_capacity` decimal(5,2) DEFAULT NULL,
  `pick_up_time_distn` varchar(10) DEFAULT NULL,
  `pick_up_time_parameter1` decimal(5,2) DEFAULT NULL,
  `pick_up_time_parameter2` decimal(5,2) DEFAULT NULL,
  `machine_time_distn` varchar(10) DEFAULT NULL,
  `machine_time_parameter1` decimal(5,2) DEFAULT NULL,
  `machine_time_parameter2` decimal(5,2) DEFAULT NULL,
  `placement_time_distn` varchar(10) DEFAULT NULL,
  `placement_time_parameter1` decimal(5,2) DEFAULT NULL,
  `placement_time_parameter2` decimal(5,2) DEFAULT NULL,
  `time_between_failures_distn` varchar(10) DEFAULT NULL,
  `time_between_failures_parameter1` decimal(5,2) DEFAULT NULL,
  `time_between_failures_parameter2` decimal(5,2) DEFAULT NULL,
  `repair_time_distn` varchar(10) DEFAULT NULL,
  `repair_time_parameter1` decimal(5,2) DEFAULT NULL,
  `repair_time_parameter2` decimal(5,2) DEFAULT NULL,
  `price_for_purchase` decimal(5,2) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `owner` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id_machine`,`id_game`),
  KEY `fk_id_game_0007` (`id_game`),
  CONSTRAINT `fk_id_game_0007` FOREIGN KEY (`id_game`) REFERENCES `t_game` (`id_game`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_machine`
--

LOCK TABLES `t_machine` WRITE;
/*!40000 ALTER TABLE `t_machine` DISABLE KEYS */;
INSERT INTO `t_machine` VALUES (1,0,'Machine assembles part 3',100.00,150.00,50.00,'',0.00,0.00,'',0.00,0.00,'',0.00,0.00,'',0.00,0.00,'',0.00,0.00,300.00,'Idle','User'),(2,0,'Machine to transport',100.00,110.00,50.00,'',0.00,0.00,'',0.00,0.00,'',0.00,0.00,'',0.00,0.00,'',0.00,0.00,200.00,'Idle','User'),(3,0,'Machine to transport',100.00,150.00,50.00,'',0.00,0.00,'',0.00,0.00,'',0.00,0.00,'',0.00,0.00,'',0.00,0.00,250.00,'Idle','User'),(4,0,'Some other machine',100.00,300.00,75.00,'',0.00,0.00,'',0.00,0.00,'',0.00,0.00,'',0.00,0.00,'',0.00,0.00,500.00,'Idle','Game'),(5,0,'Machine to transport',100.00,200.00,200.00,'',0.00,0.00,'',0.00,0.00,'',0.00,0.00,'',0.00,0.00,'',0.00,0.00,500.00,'Idle','User');
/*!40000 ALTER TABLE `t_machine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_operation`
--

DROP TABLE IF EXISTS `t_operation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_operation` (
  `id_operation` int(11) NOT NULL,
  `operation_description` varchar(50) DEFAULT NULL,
  `processing_distn` varchar(10) DEFAULT NULL,
  `processing_parameter1` decimal(5,2) DEFAULT NULL,
  `processing_parameter2` decimal(5,2) DEFAULT NULL,
  `production_policy` int(11) DEFAULT NULL,
  `id_type_operation` int(11) DEFAULT NULL,
  `id_machine` int(11) DEFAULT NULL,
  `id_station` int(11) DEFAULT NULL,
  `quantity_output` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_operation`),
  KEY `fk_{B252EC53-ADDE-423F-B434-60F13E0A8D64}` (`id_type_operation`),
  KEY `operation_machine` (`id_machine`),
  KEY `operation_station` (`id_station`),
  KEY `operation_activity` (`id_operation`),
  CONSTRAINT `fk_{B252EC53-ADDE-423F-B434-60F13E0A8D64}` FOREIGN KEY (`id_type_operation`) REFERENCES `t_type_operation` (`id_type_operation`),
  CONSTRAINT `operation_activity` FOREIGN KEY (`id_operation`) REFERENCES `t_activity` (`id_activity`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `operation_machine` FOREIGN KEY (`id_machine`) REFERENCES `t_machine` (`id_machine`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `operation_station` FOREIGN KEY (`id_station`) REFERENCES `t_station` (`id_station`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_operation`
--

LOCK TABLES `t_operation` WRITE;
/*!40000 ALTER TABLE `t_operation` DISABLE KEYS */;
INSERT INTO `t_operation` VALUES (3,'Assemble Part3','',0.00,0.00,0,2,1,1,2);
/*!40000 ALTER TABLE `t_operation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_operator`
--

DROP TABLE IF EXISTS `t_operator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_operator` (
  `id_operator` int(11) NOT NULL,
  `id_game` int(11) NOT NULL,
  `name_operator` varchar(50) DEFAULT NULL,
  `salary` decimal(5,2) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `owner` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id_operator`,`id_game`),
  KEY `fk_id_game_0017` (`id_game`),
  CONSTRAINT `fk_id_game_0017` FOREIGN KEY (`id_game`) REFERENCES `t_game` (`id_game`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_operator`
--

LOCK TABLES `t_operator` WRITE;
/*!40000 ALTER TABLE `t_operator` DISABLE KEYS */;
INSERT INTO `t_operator` VALUES (1,0,'Pepe',300.00,'Idle','User'),(2,0,'Bob',300.00,'Idle','User'),(3,0,'Juan',300.00,'Idle','User'),(4,0,'Maria',300.00,'Idle','User');
/*!40000 ALTER TABLE `t_operator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_part`
--

DROP TABLE IF EXISTS `t_part`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_part` (
  `id_part` int(11) NOT NULL,
  `id_game` int(11) NOT NULL,
  `part_description` varchar(50) DEFAULT NULL,
  `unit` varchar(10) DEFAULT NULL,
  `volume` decimal(5,2) DEFAULT NULL,
  `weight` decimal(5,2) DEFAULT NULL,
  `quantity_palette` int(11) DEFAULT NULL,
  `current_stock` int(11) DEFAULT NULL,
  `price_for_sale` decimal(5,2) DEFAULT NULL,
  `owner` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id_part`,`id_game`),
  KEY `fk_id_game_0001` (`id_game`),
  CONSTRAINT `fk_id_game_0001` FOREIGN KEY (`id_game`) REFERENCES `t_game` (`id_game`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_part`
--

LOCK TABLES `t_part` WRITE;
/*!40000 ALTER TABLE `t_part` DISABLE KEYS */;
INSERT INTO `t_part` VALUES (1,0,'Part One','EACH',100.00,100.00,100,0,0.25,'User'),(2,0,'Part Two','EACH',100.00,100.00,50,0,0.40,'User'),(3,0,'Part Three','EACH',300.00,300.00,25,0,2.00,'User');
/*!40000 ALTER TABLE `t_part` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_player`
--

DROP TABLE IF EXISTS `t_player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_player` (
  `id_player` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `nick_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(20) NOT NULL,
  PRIMARY KEY (`id_player`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_player`
--

LOCK TABLES `t_player` WRITE;
/*!40000 ALTER TABLE `t_player` DISABLE KEYS */;
INSERT INTO `t_player` VALUES (0,'DefaultPlayer','def','default@gaming.com','123456');
/*!40000 ALTER TABLE `t_player` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_purchase`
--

DROP TABLE IF EXISTS `t_purchase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_purchase` (
  `id_purchase` int(11) NOT NULL,
  `id_station` int(11) DEFAULT NULL,
  `id_supplier` int(11) DEFAULT NULL,
  `order_point` int(11) DEFAULT NULL,
  `order_quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_purchase`),
  KEY `fk_{F4EED5BB-4D6A-4C46-9A2A-A5E8404615A6}` (`id_station`),
  KEY `purchase_activity` (`id_purchase`),
  CONSTRAINT `fk_{F4EED5BB-4D6A-4C46-9A2A-A5E8404615A6}` FOREIGN KEY (`id_station`) REFERENCES `t_station` (`id_station`),
  CONSTRAINT `purchase_activity` FOREIGN KEY (`id_purchase`) REFERENCES `t_activity` (`id_activity`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_purchase`
--

LOCK TABLES `t_purchase` WRITE;
/*!40000 ALTER TABLE `t_purchase` DISABLE KEYS */;
INSERT INTO `t_purchase` VALUES (1,2,1,10,100),(2,2,1,10,50);
/*!40000 ALTER TABLE `t_purchase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_ship`
--

DROP TABLE IF EXISTS `t_ship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_ship` (
  `id_ship` int(11) NOT NULL,
  `id_station` int(11) DEFAULT NULL,
  `load_quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_ship`),
  KEY `ship_activity` (`id_ship`),
  CONSTRAINT `ship_activity` FOREIGN KEY (`id_ship`) REFERENCES `t_activity` (`id_activity`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_ship`
--

LOCK TABLES `t_ship` WRITE;
/*!40000 ALTER TABLE `t_ship` DISABLE KEYS */;
INSERT INTO `t_ship` VALUES (8,4,50);
/*!40000 ALTER TABLE `t_ship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_skill`
--

DROP TABLE IF EXISTS `t_skill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_skill` (
  `id_skill` int(11) NOT NULL,
  `id_game` int(11) NOT NULL,
  `skill_description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_skill`,`id_game`),
  KEY `fk_id_game_0019` (`id_game`),
  CONSTRAINT `fk_id_game_0019` FOREIGN KEY (`id_game`) REFERENCES `t_game` (`id_game`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_skill`
--

LOCK TABLES `t_skill` WRITE;
/*!40000 ALTER TABLE `t_skill` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_skill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_skill_operator`
--

DROP TABLE IF EXISTS `t_skill_operator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_skill_operator` (
  `id_skill` int(11) NOT NULL,
  `id_operator` int(11) NOT NULL,
  `id_game` int(11) NOT NULL,
  `efficiency` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`id_skill`,`id_operator`,`id_game`),
  KEY `fk_{3A660564-37B5-4207-80E0-9D06B7947121}` (`id_skill`),
  KEY `fk_{5FA8F82D-AC20-4DB6-B8E1-03BC47CB489F}` (`id_operator`),
  KEY `skillOperatorGame` (`id_game`),
  CONSTRAINT `fk_{3A660564-37B5-4207-80E0-9D06B7947121}` FOREIGN KEY (`id_skill`) REFERENCES `t_skill` (`id_skill`),
  CONSTRAINT `fk_{5FA8F82D-AC20-4DB6-B8E1-03BC47CB489F}` FOREIGN KEY (`id_operator`) REFERENCES `t_operator` (`id_operator`),
  CONSTRAINT `skillOperatorGame` FOREIGN KEY (`id_game`) REFERENCES `t_game` (`id_game`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_skill_operator`
--

LOCK TABLES `t_skill_operator` WRITE;
/*!40000 ALTER TABLE `t_skill_operator` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_skill_operator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_skill_type_operation`
--

DROP TABLE IF EXISTS `t_skill_type_operation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_skill_type_operation` (
  `id_type_operation` int(11) NOT NULL,
  `id_skill` int(11) NOT NULL,
  `id_game` int(11) NOT NULL,
  PRIMARY KEY (`id_type_operation`,`id_skill`,`id_game`),
  KEY `fk_{789D9D63-EDC3-497F-88A5-FF07D6B6B7B5}` (`id_type_operation`),
  KEY `fk_{7ACF4826-DDB6-4AE8-AE1D-C719634AE1A1}` (`id_skill`),
  KEY `skillTypeOperationGame` (`id_game`),
  CONSTRAINT `fk_{789D9D63-EDC3-497F-88A5-FF07D6B6B7B5}` FOREIGN KEY (`id_type_operation`) REFERENCES `t_type_operation` (`id_type_operation`),
  CONSTRAINT `fk_{7ACF4826-DDB6-4AE8-AE1D-C719634AE1A1}` FOREIGN KEY (`id_skill`) REFERENCES `t_skill` (`id_skill`),
  CONSTRAINT `skillTypeOperationGame` FOREIGN KEY (`id_game`) REFERENCES `t_game` (`id_game`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_skill_type_operation`
--

LOCK TABLES `t_skill_type_operation` WRITE;
/*!40000 ALTER TABLE `t_skill_type_operation` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_skill_type_operation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_station`
--

DROP TABLE IF EXISTS `t_station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_station` (
  `id_station` int(11) NOT NULL,
  `id_game` int(11) NOT NULL,
  `station_description` varchar(50) DEFAULT NULL,
  `station_location_x` int(11) DEFAULT NULL,
  `station_location_y` int(11) DEFAULT NULL,
  `size_w` decimal(5,2) DEFAULT NULL,
  `size_l` decimal(5,2) DEFAULT NULL,
  `price_for_purchase` decimal(5,2) DEFAULT NULL,
  `input_palette_capacity` int(11) DEFAULT NULL,
  `output_palette_capacity` int(11) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `owner` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id_station`,`id_game`),
  KEY `fk_id_game_0014` (`id_game`),
  CONSTRAINT `fk_id_game_0014` FOREIGN KEY (`id_game`) REFERENCES `t_game` (`id_game`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_station`
--

LOCK TABLES `t_station` WRITE;
/*!40000 ALTER TABLE `t_station` DISABLE KEYS */;
INSERT INTO `t_station` VALUES (1,0,'Station to create part 3',120,120,100.00,100.00,1.00,25,25,'Idle','User'),(2,0,'Receiving Dock',10,10,100.00,100.00,1.00,0,50,'Idle','User'),(3,0,'Storage',300,300,250.00,250.00,1.00,200,200,'Idle','User'),(4,0,'Ship Station',200,200,300.00,300.00,1.00,200,200,'Idle','User');
/*!40000 ALTER TABLE `t_station` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_supplier`
--

DROP TABLE IF EXISTS `t_supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_supplier` (
  `id_supplier` int(11) NOT NULL,
  `id_game` int(11) NOT NULL,
  `supplier_description` varchar(50) DEFAULT NULL,
  `supplier_location_x` int(11) DEFAULT NULL,
  `supplier_location_y` int(11) DEFAULT NULL,
  `service_level` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`id_supplier`,`id_game`),
  KEY `fk_id_game_0008` (`id_game`),
  CONSTRAINT `fk_id_game_0008` FOREIGN KEY (`id_game`) REFERENCES `t_game` (`id_game`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_supplier`
--

LOCK TABLES `t_supplier` WRITE;
/*!40000 ALTER TABLE `t_supplier` DISABLE KEYS */;
INSERT INTO `t_supplier` VALUES (1,0,'Supplier Pepito',0,0,0.00);
/*!40000 ALTER TABLE `t_supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_transport_store`
--

DROP TABLE IF EXISTS `t_transport_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_transport_store` (
  `id_transport` int(11) NOT NULL,
  `unit_load` int(11) DEFAULT NULL,
  `id_machine` int(11) DEFAULT NULL,
  `id_station_ini` int(11) DEFAULT NULL,
  `id_station_end` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_transport`),
  KEY `fk_{D9F77682-D5E2-4EB2-929E-A804836FC839}` (`id_machine`),
  KEY `transport_station_ini` (`id_station_ini`),
  KEY `transport_station_end` (`id_station_end`),
  KEY `transport_activity` (`id_transport`),
  CONSTRAINT `fk_{D9F77682-D5E2-4EB2-929E-A804836FC839}` FOREIGN KEY (`id_machine`) REFERENCES `t_machine` (`id_machine`),
  CONSTRAINT `transport_activity` FOREIGN KEY (`id_transport`) REFERENCES `t_activity` (`id_activity`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `transport_station_end` FOREIGN KEY (`id_station_end`) REFERENCES `t_station` (`id_station`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `transport_station_ini` FOREIGN KEY (`id_station_ini`) REFERENCES `t_station` (`id_station`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_transport_store`
--

LOCK TABLES `t_transport_store` WRITE;
/*!40000 ALTER TABLE `t_transport_store` DISABLE KEYS */;
INSERT INTO `t_transport_store` VALUES (4,10,2,2,1),(5,10,3,2,1),(6,20,5,1,3),(7,30,5,3,4);
/*!40000 ALTER TABLE `t_transport_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_type_operation`
--

DROP TABLE IF EXISTS `t_type_operation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_type_operation` (
  `id_type_operation` int(11) NOT NULL,
  `id_game` int(11) NOT NULL,
  `operation_description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_type_operation`,`id_game`),
  KEY `fk_id_game_0016` (`id_game`),
  CONSTRAINT `fk_id_game_0016` FOREIGN KEY (`id_game`) REFERENCES `t_game` (`id_game`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_type_operation`
--

LOCK TABLES `t_type_operation` WRITE;
/*!40000 ALTER TABLE `t_type_operation` DISABLE KEYS */;
INSERT INTO `t_type_operation` VALUES (1,0,'Paint'),(2,0,'Assemble'),(3,0,'Cut');
/*!40000 ALTER TABLE `t_type_operation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'gaming'
--
/*!50003 DROP PROCEDURE IF EXISTS `Activity_Insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `Activity_Insert`(
    intIdGame           int,
    intIdPart           int,
    vcActivityDesc      varchar(50),
    vcTypeActivity      varchar(10),
    intIdNextActivity   int,
    intProcessingTime   int
)
BEGIN
    insert into t_activity
        (id_game, id_part, activity_description, type_activity, 
        id_next_activity, processing_time)
    values
        (intIdGame, intIdPart, vcActivityDesc, vcTypeActivity, 
        intIdNextActivity, intProcessingTime);
    
    select max(id_activity)
    from t_activity;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Activity_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `Activity_Select`(
    intIdGame           int
)
BEGIN
    select
        id_activity, id_part, activity_description, type_activity,
        id_next_activity, processing_time
    from
        t_activity
    where
        id_game = intIdGame;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AssemblyDetails_Insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `AssemblyDetails_Insert`(
    intIdGame       int,
    intIdOutputPart int,
    intIdInputPart  int,
    intQuantity     int,
    vcAssemblyDesc  varchar(50)
)
BEGIN

    insert into t_assembly_details(id_game, id_output_part,
    id_input_part, quantity, assembly_description)
    values(intIdGame, intIdOutputPart, intIdInputPart,
    intQuantity, vcAssemblyDesc);    

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AssemblyDetails_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `AssemblyDetails_Select`(
    intIdGame       int,
    intIdOutputPart int
)
BEGIN

    select
        id_output_part, id_input_part, 
        quantity, assembly_description
    from
        t_assembly_details
    where
        id_game = intIdGame and
        id_output_part = intIdOutputPart;       

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Bucket_Insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `Bucket_Insert`(
    intIdBucket     int,
    intIdStation    int,
    intIdGame       int,
    intCapacity     int,
    vcUnit          varchar(10),
    intSize         int,
    intIdPart       int,
    vcDirection     varchar(10),
    intUnitsToArrive    int
)
BEGIN

    insert into t_bucket(
    id_bucket, id_station, id_game, capacity,
    unit, size, id_part, direction, units_to_arrive)
    values(
    intIdBucket, intIdStation, intIdGame, intCapacity, 
    vcUnit, intSize, intIdPart, vcDirection, intUnitsToArrive);

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Bucket_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `Bucket_Select`(
    intIdGame       int,
    intIdStation    int
)
BEGIN

    select
        id_bucket, capacity, unit, size, id_part, 
        direction, units_to_arrive
    from
        t_bucket
    where
        id_game = intIdGame and
        id_station = intIdStation;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Catalog_Insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `Catalog_Insert`(
    intIdGame               int,
    intIdSupplier           int,
    intIdPart               int,
    decQuality              decimal(5,2),
    vcProdDistn             varchar(10),
    decProdParam1           decimal(5,2),
    decProdParam2           decimal(5,2),
    intPriceFunc1_Limit     int,
    decPriceFunc1_Charge    decimal(5,2),
    intPriceFunc2_Limit     int,
    decPriceFunc2_Charge    decimal(5,2),
    intPriceFunc3_Limit     int,
    decPriceFunc3_Charge    decimal(5,2)
)
BEGIN
    insert into t_catalog
        (id_game, id_supplier, id_part, quality, production_distn,
        production_parameter1, production_parameter2, price_function1_limit,
        price_function1_charge, price_function2_limit, price_function2_charge,
        price_function3_limit, price_function3_charge)
    values
        (intIdGame, intIdSupplier, intIdPart, decQuality, vcProdDistn,
        decProdParam1, decProdParam2, intPriceFunc1_Limit, decPriceFunc1_Charge,
        intPriceFunc2_Limit, decPriceFunc2_Charge, intPriceFunc3_Limit, 
        decPriceFunc3_Charge);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Catalog_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `Catalog_Select`(
    intIdGame       int,
    intIdSupplier   int
)
BEGIN
    select
        id_supplier, id_part, quality, production_distn,
        production_parameter1, production_parameter2, price_function1_limit,
        price_function1_charge, price_function2_limit, price_function2_charge,
        price_function3_limit, price_function3_charge
    from
        t_catalog
    where
        id_game = intIdGame and
        id_supplier = intIdSupplier;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EventList_Insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `EventList_Insert`(
    intIdGame       int,
    intIdEventCode  int,
    intTimeToFinish int
)
BEGIN
    insert into t_event_list
        (id_game, id_event_code, time_to_finish)
    values
        (intIdGame, intIdEventCode, intTimeToFinish);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EventList_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `EventList_Select`(
    intIdGame       int,
    intIdEventList  int
)
BEGIN
    select
        id_game, id_event_list, id_event_code, time_to_finish
    from
        t_event_list
    where
        id_game = intIdGame and 
        id_event_list = ifnull(intIdEventList,id_event_list);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Game_Insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `Game_Insert`(
    intIdPlayer     int,
    decCurrentMoney  decimal(5,2),
    intCurrentMinute    int,
    intCurrentHour      int,
    intCurrentDay       int,
    intCurrentMonth     int
)
BEGIN

declare newIdGame int;
select ifnull(max(id_game)+1,1) into newIdGame from t_game;

INSERT INTO t_game(id_game, date_time, id_player, current_money,
    current_minute, current_hour, current_day, current_month) 
VALUES (newIdGame, now(), intIdPlayer, decCurrentMoney,
    intCurrentMinute, intCurrentHour, intCurrentDay, intCurrentMonth);

select max(id_game) from t_game;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Game_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `Game_Select`(
    intIdPlayer     int
)
BEGIN

    select
        id_game, date_format(date_time,'%m/%d/%Y %r') as date_time, 
        id_player, current_money, current_minute,
        current_hour, current_day, current_month
    from 
        t_game
    where
        id_player = intIdPlayer
    order by
        date_time desc;
        
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Log_Insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `Log_Insert`(
    vcMessage varchar(200)
)
BEGIN
    insert into t_log(date_time, message)
    values (now(), vcMessage);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Machine_Insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `Machine_Insert`(
    intIdMachine            int,
    intIdGame               int,
    vcMachineDesc           varchar(50),
    decSpeed                decimal(5,2),
    decWeightCapacity       decimal(5,2),
    decVolumeCapacity       decimal(5,2),
    vcPickUpTimeDistn       varchar(10),
    decPickUpTimeParam1     decimal(5,2),
    decPickUpTimeParam2     decimal(5,2),
    vcMachineTimeDistn      varchar(10),
    decMachineTimeParam1    decimal(5,2),
    decMachineTimeParam2    decimal(5,2),
    vcPlacementTimeDistn    varchar(10),
    decPlacementTimeParam1  decimal(5,2),
    decPlacementTimeParam2  decimal(5,2),
    vcTimeBetFailsDistn     varchar(10),
    decTimeBetFailsParam1   decimal(5,2),
    decTimeBetFailsParam2   decimal(5,2),
    vcRepairTimeDistn       varchar(10),
    decRepairTimeParam1     decimal(5,2),
    decRepairTimeParam2     decimal(5,2),
    decPriceForPurchase     decimal(5,2),
    vcStatus                varchar(10),
    vcOwner                 varchar(10)
)
BEGIN
    insert into t_machine
        (id_machine, id_game, machine_description, speed, weight_capacity, volume_capacity,
        pick_up_time_distn, pick_up_time_parameter1, pick_up_time_parameter2,
        machine_time_distn, machine_time_parameter1, machine_time_parameter2,
        placement_time_distn, placement_time_parameter1, placement_time_parameter2,
        time_between_failures_distn, time_between_failures_parameter1,
        time_between_failures_parameter2, repair_time_distn,
        repair_time_parameter1, repair_time_parameter2, price_for_purchase, status, owner)
    values
        (intIdMachine, intIdGame, vcMachineDesc, decSpeed, decWeightCapacity, decVolumeCapacity,
        vcPickUpTimeDistn, decPickUpTimeParam1, decPickUpTimeParam2, vcMachineTimeDistn,
        decMachineTimeParam1, decMachineTimeParam2, vcPlacementTimeDistn,
        decPlacementTimeParam1, decPlacementTimeParam2, vcTimeBetFailsDistn,
        decTimeBetFailsParam1, decTimeBetFailsParam2, vcRepairTimeDistn,
        decRepairTimeParam1, decRepairTimeParam2, decPriceForPurchase, vcStatus, vcOwner);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Machine_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `Machine_Select`(
    intIdGame               int
)
BEGIN
    select
        id_machine, machine_description, speed, weight_capacity,
        volume_capacity, pick_up_time_distn, pick_up_time_parameter1,
        pick_up_time_parameter2, machine_time_distn, machine_time_parameter1,
        machine_time_parameter2, placement_time_distn, placement_time_parameter1,
        placement_time_parameter2, time_between_failures_distn, 
        time_between_failures_parameter1, time_between_failures_parameter2, 
        repair_time_distn, repair_time_parameter1, repair_time_parameter2,
        price_for_purchase, status, owner
    from
        t_machine
    where
        id_game = intIdGame;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Operation_Insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `Operation_Insert`(
    intIdOperation      int,
    vcOperationDesc     varchar(50),
    vcProcessingDistn   varchar(10),
    decProcessingParam1 decimal(5,2),
    decProcessingParam2 decimal(5,2),
    intProductionPolicy int,
    intIdTypeOperation  int,
    intIdMachine        int,
    intIdStation        int,
    intQuantityOutput   int
)
BEGIN
    insert into t_operation
        (id_operation, operation_description, processing_distn, 
        processing_parameter1, processing_parameter2, production_policy,
        id_type_operation, id_machine, id_station, quantity_output)
    values
        (intIdOperation, vcOperationDesc, vcProcessingDistn, 
        decProcessingParam1, decProcessingParam2, intProductionPolicy,
        intIdTypeOperation, intIdMachine, intIdStation, intQuantityOutput);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Operation_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `Operation_Select`(
    intIdGame       int
)
BEGIN
    select
        o.id_operation, o.operation_description, o.processing_distn,
        o.processing_parameter1, o.processing_parameter2, 
        o.production_policy, o.id_type_operation, o.id_machine,
        o.id_station, o.quantity_output, a.id_part, a.activity_description,
        a.type_activity, a.id_next_activity, a.processing_time
    from
        t_operation o, t_activity a
    where
        o.id_operation = a.id_activity and
        a.id_game = intIdGame;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Operator_Insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `Operator_Insert`(
    intIdOperator   int,
    intIdGame       int,
    vcNameOperator  varchar(50),
    decSalary       decimal(5,2),
    vcStatus        varchar(10),
    vcOwner         varchar(10)
)
BEGIN
    insert into t_operator
        (id_operator, id_game, name_operator, salary, status, owner)
    values
        (intIdOperator, intIdGame, vcNameOperator,
        decSalary, vcStatus, vcOwner);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Operator_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `Operator_Select`(
    intIdGame       int
)
BEGIN
    select
        id_operator, name_operator, salary, status, owner
    from
        t_operator
    where
        id_game = intIdGame;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Part_Insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `Part_Insert`(
    intIdPart           int,
    intIdGame           int,
    vcPartDescription   varchar(50),
    vcUnit              varchar(10),
    decVolume           decimal(5,2),
    decWeight           decimal(5,2),
    intQuantityPalette  int,
    intCurrentStock     int,
    intPriceForSale     int,
    vcOwner             varchar(10)
)
BEGIN
    INSERT INTO t_part(id_part, id_game, part_description, unit, volume,
    weight, quantity_palette, current_stock, price_for_sale,
    owner) 
    VALUES (intIdPart, intIdGame, vcPartDescription, vcUnit, decVolume,
    decWeight, intQuantityPalette, intCurrentStock, intPriceForSale,
    vcOwner); 
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Part_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `Part_Select`(
    intIdGame     int
)
BEGIN

    select
        id_part, part_description, unit, volume, weight, 
        quantity_palette, current_stock, price_for_sale,
        owner
    from 
        t_part
    where
        id_game = intIdGame;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Player_Insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `Player_Insert`(
    vcName varchar(100), 
    vcNickName varchar(50), 
    vcEmail varchar(100),
    vcPassword varchar(20)
)
BEGIN
declare newIdPlayer int;
select ifnull(max(id_player)+1,1) into newIdPlayer from t_player;

INSERT INTO t_player(id_player, name, nick_name, email, password) 
VALUES (newIdPlayer, vcName, vcNickName, vcEmail, vcPassword); 

select newIdPlayer;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Player_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `Player_Select`(
    vcEmail     varchar(100),
    vcPassword  varchar(20)
)
BEGIN

    select
        id_player, name, nick_name, email, password
    from 
        t_player
    where 
        upper(email) = upper(vcEmail) 
        and password = vcPassword;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Player_Update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `Player_Update`(
    intIdPlayer     int,
    vcName          varchar(100),
    vcNickName      varchar(50),
    vcEmail         varchar(100),
    vcPassword      varchar(20)
)
BEGIN
    update  
        t_player
    set
        name = vcName,
        nick_name = vcNickName,
        email = vcEmail,
        password = vcPassword
    where
        id_player = intIdPlayer;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Player_ValidateEmail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `Player_ValidateEmail`(
    vcEmail     varchar(100)
)
BEGIN

    select
        count(*)
    from 
        t_player
    where 
        upper(email) = upper(vcEmail);

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Purchase_Insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `Purchase_Insert`(
    intIdPurchase   int,
    intIdStation    int,
    intIdSupplier   int,
    intOrderPoint   int,
    intOrderQuantity    int
)
BEGIN
    insert into t_purchase
        (id_purchase, id_station, id_supplier, order_point, order_quantity)
    values
        (intIdPurchase, intIdStation, intIdSupplier, intOrderPoint, intOrderQuantity);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Purchase_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `Purchase_Select`(
    intIdGame       int
)
BEGIN
    select
        p.id_purchase, p.id_station, a.id_part, a.activity_description,
        a.type_activity, a.id_next_activity, a.processing_time,
        p.id_supplier, p.order_point, p.order_quantity
    from
        t_purchase p, t_activity a
    where
        p.id_purchase = a.id_activity and
        a.id_game = intIdGame;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Ship_Insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `Ship_Insert`(
    intIdShip       int,
    intIdStation    int,
    intLoadQuantity  int
)
BEGIN
    insert into t_ship
        (id_ship, id_station, load_quantity)
    values
        (intIdShip, intIdStation, intLoadQuantity);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Ship_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `Ship_Select`(
    intIdGame       int
)
BEGIN
    select
        s.id_ship, s.load_quantity, a.id_part, a.activity_description,
        a.type_activity, a.id_next_activity, a.processing_time, s.id_station
    from
        t_ship s, t_activity a
    where
        s.id_ship = a.id_activity and
        a.id_game = intIdGame;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SkillPerOperator_Insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `SkillPerOperator_Insert`(
    intIdGame       int,
    intIdSkill      int,
    intIdOperator   int,
    decEfficiency   decimal(5,2)
)
BEGIN
    insert into t_skill_operator
        (id_game, id_skill, id_operator, efficiency)
    values
        (intIdGame, intIdSkill, intIdOperator, decEfficiency);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SkillPerOperator_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `SkillPerOperator_Select`(
    intIdGame       int,
    intIdOperator   int
)
BEGIN
    select
        id_skill, efficiency
    from
        t_skill_operator
    where
        id_game = intIdGame and
        id_operator = intIdOperator;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Skill_Insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `Skill_Insert`(
    intIdSkill  int,
    intIdGame   int,
    vcSkillDesc varchar(50)
)
BEGIN
    insert into t_skill
        (id_skill, id_game, skill_description)
    values
        (intIdSkill, intIdGame, vcSkillDesc);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Skill_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `Skill_Select`(
    intIdGame   int
)
BEGIN
    select
        id_skill, skill_description
    from
        t_skill
    where
        id_game = intIdGame;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Station_Insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `Station_Insert`(
    intIdStation            int,
    intIdGame               int,
    vcStationDesc           varchar(50),
    intStationLocationX     int,
    intStationLocationY     int,
    decSizeW                decimal(5,2),
    decSizeL                decimal(5,2),
    decPriceForPurchase     decimal(5,2),
    intInputPaletteCapacity int,
    intOutputPaletteCapacity    int,
    vcStatus                varchar(10),
    vcOwner                 varchar(10)
)
BEGIN
    insert into t_station
        (id_station, id_game, station_description, station_location_x, 
        station_location_y, size_w, size_l, price_for_purchase,
        input_palette_capacity, output_palette_capacity, status, owner)
    values
        (intIdStation, intIdGame, vcStationDesc, intStationLocationX, 
        intStationLocationY, decSizeW, decSizeL, decPriceForPurchase,
        intInputPaletteCapacity, intOutputPaletteCapacity,
        vcStatus, vcOwner);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Station_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `Station_Select`(
    intIdGame               int
)
BEGIN
    select
        id_station, station_description, station_location_x,
        station_location_y, size_w, size_l, price_for_purchase,
        input_palette_capacity, output_palette_capacity, 
        status, owner
    from
        t_station
    where
        id_game = intIdGame;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Supplier_Insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `Supplier_Insert`(
    intIdSupplier           int,
    intIdGame               int,
    vcSupplierDescription   varchar(50),
    intSupplierLocationX    int,
    intSupplierLocationY    int,
    decServiceLevel         decimal(5,2)
)
BEGIN
    insert into t_supplier
        (id_supplier, id_game, supplier_description, 
        supplier_location_x, supplier_location_y, service_level)
    values
        (intIdSupplier, intIdGame, vcSupplierDescription, 
        intSupplierLocationX, intSupplierLocationY, decServiceLevel);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Supplier_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `Supplier_Select`(
    intIdGame               int
)
BEGIN
    select
        id_supplier, supplier_description, supplier_location_x,
        supplier_location_y, service_level
    from
        t_supplier
    where
        id_game = intIdGame;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TransportStore_Insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `TransportStore_Insert`(
    intIdTransport  int,
    intUnitLoad     int,
    intIdMachine    int,
    intIdStationIni int,
    intIdStationEnd int
)
BEGIN
    insert into t_transport_store
        (id_transport, unit_load, id_machine, 
        id_station_ini, id_station_end)
    values
        (intIdTransport, intUnitLoad, intIdMachine,
        intIdStationIni, intIdStationEnd);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TransportStore_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `TransportStore_Select`(
    intIdGame       int
)
BEGIN
    select
        s.id_transport, s.unit_load, s.id_machine, s.id_station_ini,
        s.id_station_end, a.id_part, a.activity_description,
        a.type_activity, a.id_next_activity, a.processing_time
    from
        t_transport_store s, t_activity a
    where
        s.id_transport = a.id_activity and
        a.id_game = intIdGame;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TypeOperationPerSkill_Insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `TypeOperationPerSkill_Insert`(
    intIdGame           int,
    intIdSkill          int,
    intIdTypeOperation  int
)
BEGIN
    insert into t_skill_type_operation
        (id_type_operation, id_skill, id_game)
    values
        (intIdTypeOperation, intIdSkill, intIdGame);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TypeOperationPerSkill_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `TypeOperationPerSkill_Select`(
    intIdGame           int,
    intIdSkill          int
)
BEGIN
    Select 
        id_type_operation
    from
        t_skill_type_operation
    where
        intIdGame = id_game and
        intIdSkill = id_skill;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TypeOperation_Insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `TypeOperation_Insert`(
    intIdTypeOperation  int,
    intIdGame       int,
    vcOperationDesc varchar(50)
)
BEGIN
    insert into t_type_operation
        (id_type_operation, id_game, operation_description)
    values
        (intIdTypeOperation, intIdGame, vcOperationDesc);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TypeOperation_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `TypeOperation_Select`(
    intIdGame       int
)
BEGIN
    select
        id_type_operation, operation_description
    from
        t_type_operation
    where
        id_game = intIdGame;
END */;;
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

-- Dump completed on 2012-04-14 23:57:48
