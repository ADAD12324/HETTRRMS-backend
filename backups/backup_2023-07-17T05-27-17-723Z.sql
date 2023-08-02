-- MariaDB dump 10.19  Distrib 10.4.27-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: backend
-- ------------------------------------------------------
-- Server version	10.4.27-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `business_partner_records`
--

DROP TABLE IF EXISTS `business_partner_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `business_partner_records` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fileName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `business_partner_records`
--

LOCK TABLES `business_partner_records` WRITE;
/*!40000 ALTER TABLE `business_partner_records` DISABLE KEYS */;
INSERT INTO `business_partner_records` VALUES (6,'records\\1688625445492.docx');
/*!40000 ALTER TABLE `business_partner_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client_records`
--

DROP TABLE IF EXISTS `client_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_records` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `file` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_records`
--

LOCK TABLES `client_records` WRITE;
/*!40000 ALTER TABLE `client_records` DISABLE KEYS */;
INSERT INTO `client_records` VALUES (3,31,'template\\Adriane Nunez-Bicol Tour37.docx'),(4,31,'template\\Adriane Nunez-Bicol Tour34.docx'),(5,31,'template\\Adriane Nunez-Bicol Tour35.docx'),(6,31,'template\\Adriane Nunez-Bicol Tour36.docx'),(7,31,'template\\Adriane Nunez-Bicol Tour36.docx'),(8,31,'template\\Adriane Nunez-Bicol Tour36.docx'),(9,31,'template\\Adriane Nunez-Bicol Tour36.docx'),(10,31,'template\\Adriane Nunez-Bicol Tour36.docx'),(11,31,'template\\Adriane Nunez-Bicol Tour36.docx'),(12,31,'template\\Adriane Nunez-National Tour39.docx'),(13,31,'template\\Adriane Nunez-National Tour39.docx'),(14,31,'template\\Adriane Nunez-National Tour39.docx');
/*!40000 ALTER TABLE `client_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `international`
--

DROP TABLE IF EXISTS `international`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `international` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `image` varchar(255) NOT NULL,
  `itinerary` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `international`
--

LOCK TABLES `international` WRITE;
/*!40000 ALTER TABLE `international` DISABLE KEYS */;
INSERT INTO `international` VALUES (1,'Japan Package Tour','Airplane\r\nResort\r\nHotel\r\nRestaurant',80000.00,'uploads\\1681177958726.jpg','uploads\\1681177958728.pdf');
/*!40000 ALTER TABLE `international` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `national`
--

DROP TABLE IF EXISTS `national`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `national` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `image` varchar(255) NOT NULL,
  `itinerary` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `national`
--

LOCK TABLES `national` WRITE;
/*!40000 ALTER TABLE `national` DISABLE KEYS */;
INSERT INTO `national` VALUES (1,'National Tour','Air Conditioned Van \r\nResort\r\nHotel',50000.00,'uploads\\1681132903079.jpg','uploads\\1681132903081.pdf'),(2,'National Tour','-Resort \r\n-Hotel\r\n-Meals and other foods\r\n-Airconditioned Van \r\n-Tour Guide',30000.00,'uploads\\1687755456664.jpg','\"[{\\\"day\\\":\\\"\\\",\\\"activities\\\":[{\\\"name\\\":\\\"Gliding\\\",\\\"startTime\\\":\\\"08:00\\\",\\\"endTime\\\":\\\"09:00\\\"},{\\\"name\\\":\\\"Diving under the sea\\\",\\\"startTime\\\":\\\"09:00\\\",\\\"endTime\\\":\\\"11:00\\\"},{\\\"name\\\":\\\"lunch break\\\",\\\"startTime\\\":\\\"11:00\\\",\\\"endTime\\\":\\\"12:00\\\"},{\\\"name\\\":\\\"other activity \\\",\\\"startTime\\\":\\\"12:00\\\",\\\"endTime\\\":\\\"17:00\\\"}]},{\\\"day\\\":\\\"\\\",\\\"activities\\\":[{\\\"name\\\":\\\"sample act\\\",\\\"startTime\\\":\\\"08:00\\\",\\\"endTime\\\":\\\"09:00\\\"},{\\\"name\\\":\\\"sample act 2\\\",\\\"startTime\\\":\\\"09:00\\\",\\\"endTime\\\":\\\"11:00\\\"}]}]\"'),(3,'Natioinal Tour Package','- Resort \r\n-Airconditioned van \r\n-Tourist guide ',30000.00,'uploads\\1689360634040.jpg','\"[{\\\"day\\\":\\\"\\\",\\\"activities\\\":[{\\\"name\\\":\\\"Act1\\\",\\\"startTime\\\":\\\"08:00\\\",\\\"endTime\\\":\\\"09:00\\\"}]},{\\\"day\\\":\\\"\\\",\\\"activities\\\":[{\\\"name\\\":\\\"Act2\\\",\\\"startTime\\\":\\\"08:00\\\",\\\"endTime\\\":\\\"09:00\\\"}]}]\"');
/*!40000 ALTER TABLE `national` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (1,'New booking made by Adriane Nunez for Bicol Tour','2023-04-03 02:36:17'),(3,'New booking made by Joshua Vinas for Bicol Tour','2023-04-03 14:56:21'),(4,'New booking made by Aljen Paulite for Bicol Tour','2023-04-03 15:36:34'),(5,'New booking made by Tyrone Manlangit for Bicol Adv','2023-04-05 06:45:46'),(6,'New booking made by Rubern Amador for Bicol Adv','2023-04-05 12:15:55'),(7,'New booking made by Ryan Guerrero for Bicol Adv','2023-04-05 14:00:50'),(8,'New booking made by try for Bicol Adv','2023-04-05 14:30:50'),(9,'New booking made by Kim Toledo for Bicol Adv','2023-04-10 02:47:12'),(10,'New booking made by Steven James Mendez for Bicol Adv','2023-04-14 05:23:39'),(11,'New booking made by Steven Mendez for Bicol Adv New ','2023-04-14 14:25:51'),(12,'New booking made by Steven Mendez for Bicol Adv New ','2023-04-15 14:25:03'),(13,'New booking made by Steven Mendez for Japan Package Tour','2023-04-15 14:36:57'),(14,'New booking made by Steven Mendez for Bicol Tour','2023-04-15 14:58:05'),(15,'New booking made by Steven Mendez for National Tour','2023-04-15 15:23:10'),(16,'New booking made by Steven Mendez for Bicol Adv New ','2023-04-15 15:29:54'),(17,'New booking made by Steven Mendez for National Tour','2023-04-15 16:12:13'),(18,'New booking made by joshua vinas for Bicol Adv','2023-04-24 08:44:24'),(19,'New booking made by Steven Mendez for Japan Package Tour','2023-04-27 01:52:58'),(20,'New booking made by Steven Mendez for Japan Package Tour','2023-04-27 16:49:16'),(21,'New booking made by Steven Mendez for Bicol Adv New ','2023-04-27 18:09:39'),(22,'New booking made by try for Bicol Adv','2023-04-27 18:14:23'),(23,'New booking made by try2 for Bicol Adv New ','2023-04-28 04:07:50'),(24,'New booking made by Steven Mendez for Bicol Adv New ','2023-04-28 18:30:19'),(27,'New booking made by jayvee for Bicol Tour','2023-05-02 17:14:15'),(28,'New booking made by tev for National Tour','2023-05-02 17:20:29'),(29,'New booking made by aljen for Japan Package Tour','2023-05-02 17:21:43'),(30,'New booking made by Adriane Nunez for Bicol Tour','2023-05-21 03:53:17'),(31,'New booking made by Adriane Nunez for Bicol Tour','2023-05-24 06:44:37'),(32,'New booking made by Adriane Nunez for Bicol Tour','2023-05-24 10:51:08'),(33,'New booking made by Adriane Nunez for Bicol Tour','2023-06-16 12:32:01'),(34,'New booking made by Adriane for National Tour','2023-06-30 01:51:06'),(35,'A request change date has been submitted in booking ID: 38 by user ID: 31','2023-06-30 03:16:06'),(36,'New booking made by Adriane Nunez for National Tour','2023-07-04 17:40:07'),(37,'New booking made by Adriane for Bicol Tour','2023-07-12 16:20:47'),(38,'New booking made by Adriane Nunez for Bicol Tour','2023-07-12 17:23:51'),(39,'New booking made by Adriane Nunez for National Tour','2023-07-12 18:02:38'),(40,'New booking made by Adriane Nunez for National Tour','2023-07-12 18:20:59'),(41,'New booking made by Adriane Nunez for National Tour','2023-07-13 05:18:07'),(42,'New booking made by Adriane Nunez for Bicol Tour','2023-07-13 05:47:07'),(43,'New booking made by Adriane Nunez for Bicol Tour','2023-07-13 06:15:57'),(44,'New booking made by Adriane Nunez for Bicol Tour','2023-07-13 06:19:14'),(45,'New booking made by Adriane Nunez for National Tour','2023-07-13 17:02:24'),(46,'New booking made by Adriane Nunez for National Tour','2023-07-13 17:08:17'),(47,'New booking made by leesin for National Tour','2023-07-13 17:12:38'),(48,'New booking made by Adriane Nunez for Bicol Tour','2023-07-14 15:17:52');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `packages`
--

DROP TABLE IF EXISTS `packages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `packages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `image` varchar(255) NOT NULL,
  `itinerary` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `packages`
--

LOCK TABLES `packages` WRITE;
/*!40000 ALTER TABLE `packages` DISABLE KEYS */;
INSERT INTO `packages` VALUES (74,'Bicol Tour','Hotel: Hotel Centro\r\nResort: Dos Montes\r\nAirconditioned van\r\nTour Guide',0.00,'uploads\\1679553758258.jpg',''),(75,'Bicol Adv','hotel',30000.00,'uploads\\1679559930273.jpg',''),(76,'Bicol Tour','Hotel\r\nResort\r\nVan\r\nMeals\r\nTour Guide',30000.00,'uploads\\1679573868681.jpg',''),(77,'Bicol Adv New ','Meals\r\nHotel: St. Ellis \r\nResort: Minas Resort\r\nAirconditioned van',30000.00,'uploads\\1679662648811.jpg',''),(78,'Bicol Tour','Resort: MInas Resort \r\nAirconditioned van\r\nHotel: St. Ellis ',30000.00,'uploads\\1683475789621.jpg','\"[{\\\"day\\\":\\\"\\\",\\\"activities\\\":[{\\\"name\\\":\\\"dasdasdasdsa\\\",\\\"startTime\\\":\\\"08:00\\\",\\\"endTime\\\":\\\"09:30\\\"},{\\\"name\\\":\\\"dasdaaas\\\",\\\"startTime\\\":\\\"09:30\\\",\\\"endTime\\\":\\\"11:00\\\"}]},{\\\"day\\\":\\\"\\\",\\\"activities\\\":[{\\\"name\\\":\\\"sdasdasd\\\",\\\"startTime\\\":\\\"08:00\\\",\\\"endTime\\\":\\\"21:30\\\"}]}]\"');
/*!40000 ALTER TABLE `packages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_proof`
--

DROP TABLE IF EXISTS `payment_proof`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_proof` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `booking_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `destination` varchar(255) NOT NULL,
  `departure_date` date NOT NULL,
  `return_date` date NOT NULL,
  `num_travelers` int(11) NOT NULL,
  `travelers` text NOT NULL,
  `total_payment` decimal(10,2) NOT NULL,
  `needtoPay` decimal(10,2) NOT NULL,
  `amountpaid` decimal(10,2) NOT NULL,
  `payment_proof_path` varchar(255) NOT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `booking_id` (`booking_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `payment_proof_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `travel_booking` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `payment_proof_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_proof`
--

LOCK TABLES `payment_proof` WRITE;
/*!40000 ALTER TABLE `payment_proof` DISABLE KEYS */;
INSERT INTO `payment_proof` VALUES (1,15,17,'Steven James Mendez','tev@gmail.com','Bicol Adv','2023-04-16','2023-04-21',2,'[{\"name\":\"Steven Mendez\",\"age\":\"22\"},{\"name\":\"Joshua Barcelon Vinas\",\"age\":\"25\"}]',60000.00,0.00,0.00,'uploads\\1681912518626.jpg','2023-04-19 13:55:18'),(4,24,17,'Steven Mendez','tev@gmail.com','Japan Package Tour','2023-04-28','2023-04-30',2,'[]',160000.00,0.00,0.00,'uploads\\1682574906832.jpg','2023-04-27 05:55:06'),(5,25,17,'Steven Mendez','tev@gmail.com','Japan Package Tour','2023-04-25','2023-04-27',2,'[{\"name\":\"Steven Mendez\",\"age\":\"23\"},{\"name\":\"Rubern Amador\",\"age\":\"23\"}]',160000.00,0.00,0.00,'uploads\\1682614503809.jpg','2023-04-27 16:55:03'),(7,30,17,'Steven Mendez','tev@gmail.com','National Tour','2023-04-25','2023-04-28',2,'[{\"name\":\"Steven Mendez\",\"age\":\"23\"},{\"name\":\"Joshua Vinas\",\"age\":\"24\"}]',100000.00,0.00,0.00,'uploads\\1682706955741.jpg','2023-04-28 18:35:55'),(8,21,16,'Steven Mendez','tev@gmail.com','Bicol Adv New ','2023-04-16','2023-04-18',1,'[{\"name\":\"Steven Mendez\",\"age\":\"22\"}]',30000.00,0.00,0.00,'uploads\\1683026055479.jpg','2023-05-02 11:14:15'),(9,30,17,'Steven Mendez','tev@gmail.com','National Tour','2023-04-25','2023-04-28',2,'[{\"name\":\"Steven Mendez\",\"age\":\"23\"},{\"name\":\"Joshua Vinas\",\"age\":\"24\"}]',100000.00,0.00,0.00,'uploads\\1683026473787.jpg','2023-05-02 11:21:13'),(10,31,30,'jayvee','jayvee@gmail.com','Bicol Tour','2023-05-20','2023-05-30',2,'[{\"name\":\"jayvee\",\"age\":\"22\"},{\"name\":\"jay\",\"age\":\"30\"}]',0.00,0.00,0.00,'uploads\\1683047830501.jpg','2023-05-02 17:17:10'),(11,33,30,'aljen','aljen@gmail.com','Japan Package Tour','2023-04-30','2023-05-03',1,'[]',80000.00,0.00,0.00,'uploads\\1683048242717.jpg','2023-05-02 17:24:02'),(12,32,30,'tev','tev@gmail.com','National Tour','2023-05-04','2023-05-07',1,'[{\"name\":\"tev\",\"age\":\"29\"}]',50000.00,0.00,0.00,'uploads\\1683048284185.jpg','2023-05-02 17:24:44'),(13,34,31,'Adriane Nunez','adad@gmail.com','Bicol Tour','2023-05-25','2023-05-28',2,'[{\"name\":\"Steven Mendez\",\"age\":\"22\"},{\"name\":\"Joshua Vinas\",\"age\":\"24\"}]',60000.00,45000.00,15000.00,'uploads\\1684664744099.jfif','2023-05-21 10:25:44'),(14,34,31,'Adriane Nunez','adad@gmail.com','Bicol Tour','2023-05-25','2023-05-28',2,'[{\"name\":\"Steven Mendez\",\"age\":\"22\"},{\"name\":\"Joshua Vinas\",\"age\":\"24\"}]',60000.00,30000.00,15000.00,'uploads\\1684664803069.jfif','2023-05-21 10:26:43'),(15,34,31,'Adriane Nunez','adad@gmail.com','Bicol Tour','2023-05-25','2023-05-28',2,'[{\"name\":\"Steven Mendez\",\"age\":\"22\"},{\"name\":\"Joshua Vinas\",\"age\":\"24\"}]',60000.00,0.00,30000.00,'uploads\\1684690386880.jfif','2023-05-21 17:33:06'),(17,35,31,'Adriane Nunez','adrianenunez@gmail.com','Bicol Tour','2023-05-25','2023-05-29',2,'[{\"name\":\"Adriane Nunez\",\"age\":\"22\"},{\"name\":\"Steven Mendez\",\"age\":\"23\"}]',60000.00,30000.00,30000.00,'uploads\\1684912691956.jfif','2023-05-24 07:18:11'),(19,35,31,'Adriane Nunez','adrianenunez@gmail.com','Bicol Tour','2023-05-25','2023-05-29',2,'[{\"name\":\"Adriane Nunez\",\"age\":\"22\"},{\"name\":\"Steven Mendez\",\"age\":\"23\"}]',60000.00,0.00,30000.00,'uploads\\1684920064728.jfif','2023-05-24 09:21:04'),(22,34,31,'Adriane Nunez','adad@gmail.com','Bicol Tour','2023-05-25','2023-05-28',2,'[{\"name\":\"Steven Mendez\",\"age\":\"22\"},{\"name\":\"Joshua Vinas\",\"age\":\"24\"}]',60000.00,0.00,30000.00,'uploads\\1685029503401.jfif','2023-05-25 15:45:03'),(23,37,31,'Adriane Nunez','adad@gmail.com','Bicol Tour','2023-06-24','2023-06-27',2,'[{\"name\":\"Adriane Nunez\",\"age\":\"22\"},{\"name\":\"Steven Mendez\",\"age\":\"23\"}]',60000.00,45000.00,15000.00,'uploads\\1687149877969.jfif','2023-06-19 04:44:37'),(24,38,31,'Adriane','adad@gmail.com','National Tour','2023-07-10','2023-07-14',2,'[{\"name\":\"Joshua Vinas\",\"age\":\"22\"},{\"name\":\"Rubern Amador\",\"age\":\"21\"}]',60000.00,45000.00,15000.00,'uploads\\1688089958920.jfif','2023-06-30 01:52:38');
/*!40000 ALTER TABLE `payment_proof` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `request_change_date`
--

DROP TABLE IF EXISTS `request_change_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `request_change_date` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `departure_date` date NOT NULL,
  `return_date` date NOT NULL,
  `request_status` varchar(20) NOT NULL DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `request_change_date_ibfk_1` (`booking_id`),
  KEY `request_change_date_ibfk_2` (`user_id`),
  CONSTRAINT `request_change_date_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `travel_booking` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `request_change_date_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `request_change_date`
--

LOCK TABLES `request_change_date` WRITE;
/*!40000 ALTER TABLE `request_change_date` DISABLE KEYS */;
INSERT INTO `request_change_date` VALUES (2,31,38,'2023-07-13','2023-07-17','accepted','2023-06-30 03:16:06');
/*!40000 ALTER TABLE `request_change_date` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `booking_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `destination` varchar(255) NOT NULL,
  `departure_date` date NOT NULL,
  `return_date` date NOT NULL,
  `num_travelers` int(11) NOT NULL,
  `travelers` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `total_payment` decimal(10,2) NOT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (1,34,31,'Adriane Nunez','adad@gmail.com','Bicol Tour','2023-05-25','2023-05-28',2,'[{\"name\":\"Steven Mendez\",\"age\":\"22\"},{\"name\":\"Joshua Vinas\",\"age\":\"24\"}]',60000.00,'2023-05-25 05:58:51'),(3,35,31,'Adriane Nunez','adrianenunez@gmail.com','Bicol Tour','2023-05-25','2023-05-29',2,'[{\"name\":\"Adriane Nunez\",\"age\":\"22\"},{\"name\":\"Steven Mendez\",\"age\":\"23\"}]',60000.00,'2023-05-25 05:58:51'),(5,36,31,'Adriane Nunez','adnunez@gmail.com','Bicol Tour','2023-05-29','2023-06-01',1,'[{\"name\":\"Steven Mendez\",\"age\":\"22\"}]',30000.00,'2023-05-25 05:58:51'),(6,37,31,'Adriane Nunez','adad@gmail.com','Bicol Tour','2023-06-24','2023-06-27',2,'[{\"name\":\"Adriane Nunez\",\"age\":\"22\"},{\"name\":\"Steven Mendez\",\"age\":\"23\"}]',60000.00,'2023-06-19 04:44:37'),(7,38,31,'Adriane','adad@gmail.com','National Tour','2023-07-13','2023-07-17',2,'[{\"name\":\"Joshua Vinas\",\"age\":\"22\"},{\"name\":\"Rubern Amador\",\"age\":\"21\"}]',60000.00,'2023-06-30 01:52:38'),(8,39,31,'Adriane Nunez','adad@gmail.com','National Tour','2023-07-01','2023-07-05',2,'[{\"name\":\"Steven Mendez\",\"age\":\"22\"},{\"name\":\"Adriane Nunez\",\"age\":\"21\"}]',60000.00,'2023-07-04 17:42:26');
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule`
--

DROP TABLE IF EXISTS `schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `booking_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule`
--

LOCK TABLES `schedule` WRITE;
/*!40000 ALTER TABLE `schedule` DISABLE KEYS */;
INSERT INTO `schedule` VALUES (26,36,'Adriane Nunez - Bicol Tour','2023-05-29 00:00:00','2023-06-01 00:00:00'),(27,37,'Adriane Nunez - Bicol Tour','2023-06-24 00:00:00','2023-06-27 00:00:00'),(28,38,'Adriane - National Tour','2023-07-13 00:00:00','2023-07-17 00:00:00'),(29,39,'Adriane Nunez - National Tour','2023-07-01 00:00:00','2023-07-05 00:00:00'),(30,0,'Adriane Trial schedule','2023-07-08 23:11:00','2023-07-13 08:00:00'),(37,0,'Adriane National Tour','2023-07-08 00:00:00','2023-07-08 00:00:00');
/*!40000 ALTER TABLE `schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `travel_booking`
--

DROP TABLE IF EXISTS `travel_booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `travel_booking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name1` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `destination` varchar(255) NOT NULL,
  `departureDate` date NOT NULL,
  `returnDate` date NOT NULL,
  `numTravelers` int(11) NOT NULL,
  `travelers` text NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'pending',
  `totalPayment` decimal(10,2) NOT NULL,
  `needtoPay` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `travel_booking_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `travel_booking`
--

LOCK TABLES `travel_booking` WRITE;
/*!40000 ALTER TABLE `travel_booking` DISABLE KEYS */;
INSERT INTO `travel_booking` VALUES (15,17,'Steven James Mendez','tev@gmail.com','Bicol Adv','2023-04-17','2023-04-22',2,'[{\"name\":\"Steven Mendez\",\"age\":\"22\"},{\"name\":\"Joshua Barcelon Vinas\",\"age\":\"25\"}]','accepted',60000.00,0.00),(16,17,'Steven Mendez','tev@gmail.com','Bicol Adv New ','2023-04-17','2023-04-22',2,'[{\"name\":\"Steven Mendez\",\"age\":\"22\"},{\"name\":\"Rubern Amador\",\"age\":\"23\"}]','accepted',60000.00,0.00),(17,17,'Steven Mendez','tev@gmail.com','Bicol Adv New ','2023-04-17','2023-04-22',2,'[{\"name\":\"Steven Mendez\",\"age\":\"24\"},{\"name\":\"Adriane Nunez\",\"age\":\"20\"}]','accepted',60000.00,0.00),(18,17,'Steven Mendez','tev@gmail.com','Japan Package Tour','2023-04-17','2023-04-22',2,'[{\"name\":\"Steven Mendez\",\"age\":\"24\"},{\"name\":\"Adriane Nunez\",\"age\":\"22\"}]','accepted',160000.00,0.00),(19,17,'Steven Mendez','tev@gmail.com','Bicol Tour','2023-04-17','2023-04-22',1,'[{\"name\":\"Steven Mendez\",\"age\":\"24\"},{\"name\":\"Adriane Nunez\",\"age\":\"22\"}]','declined',0.00,0.00),(20,17,'Steven Mendez','tev@gmail.com','National Tour','2023-04-17','2023-04-19',2,'[{\"name\":\"Steven Mendez\",\"age\":\"22\"},{\"name\":\"Adriane Nunez\",\"age\":\"21\"}]','accepted',100000.00,0.00),(21,16,'Steven Mendez','tev@gmail.com','Bicol Adv New ','2023-04-16','2023-04-18',1,'[{\"name\":\"Steven Mendez\",\"age\":\"22\"}]','accepted',30000.00,0.00),(22,17,'Steven Mendez','tev@gmail.com','National Tour','2023-04-18','2023-04-21',1,'[{\"name\":\"Steven Mendez\",\"age\":\"22\"}]','accepted',50000.00,0.00),(23,17,'joshua vinas','jv@gmail.com','Bicol Adv','2023-04-25','2023-04-27',2,'[{\"name\":\"Joshua Vinas\",\"age\":\"23\"},{\"name\":\"Steven Mendez\",\"age\":\"23\"}]','accepted',60000.00,0.00),(24,17,'Steven Mendez','tev@gmail.com','Japan Package Tour','2023-04-28','2023-04-30',2,'[]','accepted',160000.00,0.00),(25,17,'Steven Mendez','tev@gmail.com','Japan Package Tour','2023-04-25','2023-04-27',2,'[{\"name\":\"Steven Mendez\",\"age\":\"23\"},{\"name\":\"Rubern Amador\",\"age\":\"23\"}]','accepted',160000.00,0.00),(26,17,'Steven Mendez','tev@gmail.com','Bicol Adv New ','2023-04-29','2023-05-01',2,'[{\"name\":\"Steven Mendez\",\"age\":\"23\"},{\"name\":\"Adriane Nunez\",\"age\":\"21\"}]','accepted',60000.00,0.00),(30,17,'Steven Mendez','tev@gmail.com','National Tour','2023-04-25','2023-04-28',2,'[{\"name\":\"Steven Mendez\",\"age\":\"23\"},{\"name\":\"Joshua Vinas\",\"age\":\"24\"}]','accepted',100000.00,0.00),(31,30,'jayvee','jayvee@gmail.com','Bicol Tour','2023-05-20','2023-05-30',2,'[{\"name\":\"jayvee\",\"age\":\"22\"},{\"name\":\"jay\",\"age\":\"30\"}]','accepted',0.00,0.00),(32,30,'tev','tev@gmail.com','National Tour','2023-05-04','2023-05-07',1,'[{\"name\":\"tev\",\"age\":\"29\"}]','accepted',50000.00,0.00),(33,30,'aljen','aljen@gmail.com','Japan Package Tour','2023-04-30','2023-05-03',1,'[]','accepted',80000.00,0.00),(34,31,'Adriane Nunez','adad@gmail.com','Bicol Tour','2023-05-25','2023-05-28',2,'[{\"name\":\"Steven Mendez\",\"age\":\"22\"},{\"name\":\"Joshua Vinas\",\"age\":\"24\"}]','accepted',60000.00,0.00),(35,31,'Adriane Nunez','adrianenunez@gmail.com','Bicol Tour','2023-05-25','2023-05-29',2,'[{\"name\":\"Adriane Nunez\",\"age\":\"22\"},{\"name\":\"Steven Mendez\",\"age\":\"23\"}]','accepted',60000.00,0.00),(37,31,'Adriane Nunez','adad@gmail.com','Bicol Tour','2023-06-24','2023-06-27',2,'[{\"name\":\"Adriane Nunez\",\"age\":\"22\"},{\"name\":\"Steven Mendez\",\"age\":\"23\"}]','accepted',60000.00,45000.00),(38,31,'Adriane','adad@gmail.com','National Tour','2023-07-13','2023-07-17',2,'[{\"name\":\"Joshua Vinas\",\"age\":\"22\"},{\"name\":\"Rubern Amador\",\"age\":\"21\"}]','accepted',60000.00,45000.00),(47,31,'Adriane Nunez','adad@gmail.com','National Tour','2023-07-28','2023-07-31',1,'[{\"name\":\"Adriane Nunez\",\"age\":\"22\"}]','accepted',30000.00,30000.00),(54,31,'Adriane Nunez','adad@gmail.com','Bicol Tour','2023-08-08','2023-08-12',1,'[{\"name\":\"Adriane Nunez\",\"age\":\"22\"}]','accepted',30000.00,30000.00);
/*!40000 ALTER TABLE `travel_booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_notification`
--

DROP TABLE IF EXISTS `user_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_notification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `message` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_notification_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_notification`
--

LOCK TABLES `user_notification` WRITE;
/*!40000 ALTER TABLE `user_notification` DISABLE KEYS */;
INSERT INTO `user_notification` VALUES (2,17,'Your booking with id 16 has been accepted.','2023-04-14 14:27:11'),(3,17,'Your booking with id 17 has been accepted.','2023-04-15 14:26:20'),(4,17,'Your booking with id 18 has been accepted.','2023-04-15 14:37:25'),(5,17,'Your booking with id 19 has been accepted.','2023-04-15 14:58:21'),(6,17,'Your booking with id 20 has been accepted.','2023-04-15 15:23:23'),(7,16,'Your booking with id 21 has been accepted.','2023-04-15 15:30:04'),(8,17,'Your booking with id 22 has been accepted.','2023-04-15 16:12:32'),(10,17,'Your booking with id 23 has been accepted.','2023-04-24 08:46:50'),(11,17,'Your booking with id 28 has been accepted.','2023-04-28 04:08:02'),(12,17,'Your booking for travel to Bicol Adv New  has been accepted.','2023-04-28 18:30:30'),(13,17,'Your booking for travel to National Tour has been accepted.','2023-04-28 18:35:11'),(14,30,'Your booking for travel to Bicol Tour has been accepted.','2023-05-02 17:15:22'),(15,30,'Your booking for travel to National Tour has been accepted.','2023-05-02 17:22:50'),(16,30,'Your booking for travel to Japan Package Tour has been accepted.','2023-05-02 17:22:53'),(17,31,'Your booking for travel to Bicol Tour has been accepted.','2023-05-21 07:55:23'),(18,31,'Your booking for travel to Bicol Tour has been accepted.','2023-05-24 06:45:04'),(19,31,'Your booking for travel to Bicol Tour has been accepted.','2023-05-24 10:52:06'),(20,31,'Your booking for travel to Bicol Tour has been accepted.','2023-06-16 14:10:32'),(21,17,'Your booking for travel to Bicol Adv New  has been accepted.','2023-06-28 14:19:15'),(22,31,'Your booking for travel to National Tour has been accepted.','2023-06-30 01:51:23'),(23,31,'Your booking for travel to National Tour has been accepted.','2023-07-04 17:40:23'),(24,31,'Your booking for travel to National Tour has been accepted.','2023-07-14 15:14:25'),(25,31,'Your booking for travel to Bicol Tour has been accepted.','2023-07-14 15:18:48');
/*!40000 ALTER TABLE `user_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phoneNumber` varchar(255) NOT NULL,
  `birthdate` date NOT NULL,
  `age` int(2) NOT NULL,
  `gender` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `idImage` varchar(255) NOT NULL,
  `userImage` varchar(255) NOT NULL,
  `role` varchar(10) DEFAULT 'user',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (16,'Adriane','Nunez','ad@gmail.com','9562314578','0000-00-00',0,'male','Adminriane','$2b$10$h..T5bQxOtATCw1Azv106O1gKic1VTmpWyp9XGIZdmgHq8oluD7Qe','1676955435763.jpg','','admin'),(17,'Steven','Mendez','tev@gmail.com','9865234678','0000-00-00',0,'male','KupalTev','$2b$10$wtvsXUb2m/lA.VCsMjVoa.Z5W/cUtEXjRjbtQDsKB/NwcoKwroUxq','1676968166066.jpg','1684553913331.jpg','user'),(28,'Adriane','Nunez','ad@gmail.com','9273797184','0000-00-00',0,'male','Trial','$2b$10$FEwS.t5915ex3V27ezgFD.n89LMZsVEedbbiVVDXOrD1MUO1e2VFK','1682954327395.jpg','1682954327400.jpg','user'),(29,'Adriane','Nunez','ad@gmail.com','9273797184','2001-07-31',21,'male','Trial1','$2b$10$7F67tdNk7ZqiN8kkFNjtKO2D82GD8eeaW6/xjZG4dvYvcbOzM8phm','1682954609026.jpg','1682954609027.jpg','user'),(30,'jayvee','lumabi','jayvee@gmail.com','9123456789','2000-01-03',23,'male','jayv','$2b$10$fjxF43CY.d/WUVPGypiMsOIH.dxfGNV3BctcNExm9C51R6tQKsxJm','1683047309755.jpg','1683047309756.jpg','user'),(31,'Adriane','Nunez','nunez.ad55@gmail.com','+639273797184','2001-08-01',21,'male','adad','$2b$10$Llw6sexcwKhz67xbrSz0l.X2Y4Rovs58CmOXGpeMPbrLt1F0574Xm','1683961651745.jpg','1684249831568.jpg','user'),(32,'Adriane','Nunez','adad@gmail.com','9273798546','2001-08-05',21,'male','client1','$2b$10$MC3ALZ/4mfB4iO7cSDFfzu.4FTfs6J/YYX91KTAXsRUVRG0wBmJFO','1688965792801.jpg','1688965792801.png','user');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-07-17 13:27:18
