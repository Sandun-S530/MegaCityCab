-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: megacitycab
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

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
-- Table structure for table `billing_settings`
--

DROP TABLE IF EXISTS `billing_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billing_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `base_rate` double NOT NULL,
  `tax_rate` double NOT NULL,
  `discount_threshold` double NOT NULL,
  `discount_rate` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billing_settings`
--

LOCK TABLES `billing_settings` WRITE;
/*!40000 ALTER TABLE `billing_settings` DISABLE KEYS */;
INSERT INTO `billing_settings` VALUES (1,20,0.08,100,0.05);
/*!40000 ALTER TABLE `billing_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bookings` (
  `booking_id` int(11) NOT NULL AUTO_INCREMENT,
  `booking_number` varchar(50) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `pickup_location` varchar(255) NOT NULL,
  `destination` varchar(255) NOT NULL,
  `booking_date` date NOT NULL,
  `booking_time` time NOT NULL,
  `required_vehicle_type` varchar(50) NOT NULL,
  `trip_km` decimal(10,2) NOT NULL,
  `estimated_bill` decimal(10,2) NOT NULL,
  `final_bill` decimal(10,2) DEFAULT NULL,
  `status` enum('pending','assigned','ongoing','completed','cancelled') DEFAULT 'pending',
  `driver_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`booking_id`),
  UNIQUE KEY `booking_number` (`booking_number`),
  KEY `customer_id` (`customer_id`),
  KEY `driver_id` (`driver_id`),
  CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`driver_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` VALUES (1,'BKG1740737140776',1,'Colombo','Kandy','2025-03-08','18:38:00','Van',10.00,100.00,100.00,'completed',4,'2025-02-28 15:35:40','2025-02-28 15:39:03'),(2,'BKG1740737212933',1,'Colombo','Kandy','2025-03-08','18:38:00','Van',10.00,100.00,100.00,'completed',4,'2025-02-28 15:36:52','2025-03-01 20:44:59'),(3,'BKG1740824490050',1,'Colombo','Colombo','2025-03-20','15:55:00','Car',5.00,50.00,50.00,'completed',3,'2025-03-01 15:51:30','2025-03-01 18:41:15'),(4,'BKG1740828403439',1,'Colombo','Kandy','2025-02-25','19:56:00','SUV',100.00,1000.00,NULL,'pending',NULL,'2025-03-01 16:56:43','2025-03-01 16:56:43'),(5,'BKG1740829249871',1,'Colombo','Kandy','2025-03-01','17:11:00','Van',5.00,50.00,54.00,'completed',4,'2025-03-01 17:10:49','2025-03-05 16:18:01'),(6,'BKG1740829948737',1,'Kandy','Colombo','2025-03-06','19:22:00','SUV',7.00,70.00,NULL,'pending',NULL,'2025-03-01 17:22:28','2025-03-01 17:22:28'),(7,'BKG1740830250132',1,'Kandy','Kandy','2025-03-07','20:27:00','Van',9.00,90.00,97.20,'completed',4,'2025-03-01 17:27:30','2025-03-05 16:18:03'),(8,'BKG1740830287958',1,'Kandy','Kandy','2025-03-07','20:27:00','Van',9.00,90.00,NULL,'assigned',4,'2025-03-01 17:28:07','2025-03-01 19:00:59'),(9,'BKG1740830404438',1,'Kandy','kjl','2025-03-07','17:31:00','SUV',90.00,900.00,NULL,'pending',NULL,'2025-03-01 17:30:04','2025-03-01 17:30:04'),(10,'BKG1740830609279',1,'Est in corrupti au','Quo ea id sunt vel q','2025-03-24','14:53:00','Van',51.00,510.00,NULL,'assigned',4,'2025-03-01 17:33:29','2025-03-01 19:01:22'),(11,'BKG1740830967687',1,'Ut labore maiores es','Aut possimus amet ','2025-09-09','03:22:00','Car',17.00,170.00,170.00,'completed',3,'2025-03-01 17:39:27','2025-03-01 19:56:17'),(12,'BKG1740831325961',1,'Asperiores consequat','Rerum in molestiae v','2025-08-23','14:01:00','Motorbike',13.00,130.00,NULL,'pending',NULL,'2025-03-01 17:45:25','2025-03-01 17:45:25'),(13,'BKG1740831443593',1,'Asperiores consequat','Rerum in molestiae v','2025-08-23','14:01:00','Motorbike',13.00,130.00,NULL,'pending',NULL,'2025-03-01 17:47:23','2025-03-01 17:47:23'),(14,'BKG1740837219225',1,'Occaecat mollitia te','Esse dolor nihil ve','2025-10-15','23:35:00','Car',32.00,320.00,320.00,'completed',3,'2025-03-01 19:23:39','2025-03-01 19:58:10'),(15,'BKG1740839265760',1,'Est doloribus porro ','Autem id quos venia','2025-06-07','07:32:00','Car',51.00,510.00,510.00,'completed',3,'2025-03-01 19:57:45','2025-03-01 19:58:11'),(16,'BKG1741002933826',1,'Reprehenderit quo r','Adipisicing reprehen','2025-05-20','18:52:00','Van',91.00,910.00,NULL,'assigned',4,'2025-03-03 17:25:33','2025-03-06 15:23:15'),(17,'BKG1741078124911',1,'Distinctio Voluptat','Labore dolore fugiat','2025-03-29','20:45:00','SUV',17.00,340.00,NULL,'pending',NULL,'2025-03-04 14:18:44','2025-03-04 14:18:44'),(18,'BKG1741086594328',1,'Dolor sint commodi ','Accusamus architecto','2025-06-04','05:14:00','Car',20.00,400.00,412.00,'completed',3,'2025-03-04 16:39:54','2025-03-04 16:40:38'),(19,'BKG1741090694485',1,'Rerum error eu corru','Dolore eos labore e','2025-11-04','12:41:00','Car',15.00,300.00,309.00,'completed',3,'2025-03-04 17:48:14','2025-03-04 17:48:57'),(20,'BKG1741092873347',1,'Quos non ut dolorum ','Consequat Facilis i','2025-06-02','16:22:00','Car',10.00,200.00,206.00,'completed',3,'2025-03-04 18:24:33','2025-03-05 14:14:24'),(21,'BKG1741170458752',1,'Ducimus corporis do','Esse ut qui repellen','2025-10-10','09:13:00','SUV',28.00,560.00,NULL,'pending',NULL,'2025-03-05 15:57:38','2025-03-05 15:57:38'),(22,'BKG1741171144196',1,'Dolor dolor sint mod','Est qui aliquid eaq','2025-10-17','08:41:00','Motorbike',30.00,600.00,NULL,'pending',NULL,'2025-03-05 16:09:04','2025-03-05 16:09:04'),(23,'BKG1741171333069',1,'Qui in molestiae sed','Deserunt modi dolore','2025-08-19','15:06:00','Van',8.00,160.00,NULL,'assigned',4,'2025-03-05 16:12:13','2025-03-05 16:17:30'),(24,'BKG1741171578436',1,'Qui modi lorem commo','Cum ullamco dolores ','2025-03-09','17:18:00','Car',25.00,500.00,515.00,'completed',3,'2025-03-05 16:16:18','2025-03-05 16:17:44');
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('customer','driver','admin') NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `address` varchar(255) NOT NULL,
  `nic` varchar(20) NOT NULL,
  `telephone` varchar(20) NOT NULL,
  `license_number` varchar(50) DEFAULT NULL,
  `vehicle_number` varchar(50) DEFAULT NULL,
  `vehicle_type` varchar(50) DEFAULT NULL,
  `registration_date` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'customer','customer','customer','Sandun Shamika','Rerumminima uy','1111111111','53635667',NULL,NULL,NULL,'2025-02-27 17:25:41'),(2,'admin','admin','admin','System Administrator','Colombo, Sri Lanka','987654321V','0112345678',NULL,NULL,NULL,'2025-02-27 17:27:27'),(3,'driver','driver','driver','Sandun Shamika','318/A, Thalawila Church, Palakudawa','956956v','86967','85458','8585v','Motorbike','2025-02-27 17:32:33'),(4,'driver2','driver2','driver','Giselle','Ut nihil ea ','9595v','7696979','75959754','847vb','Van','2025-02-28 15:38:17');
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

-- Dump completed on 2025-03-13 15:23:39
