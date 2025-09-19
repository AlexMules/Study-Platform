CREATE DATABASE  IF NOT EXISTS `proiect` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `proiect`;
-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: proiect
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `activitati`
--

DROP TABLE IF EXISTS `activitati`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activitati` (
  `id_activitati` int NOT NULL AUTO_INCREMENT,
  `id_materii_activitati` int DEFAULT NULL,
  `nr_participanti_activitate` int DEFAULT NULL,
  `procent` double DEFAULT NULL,
  `descriere` varchar(30) DEFAULT NULL,
  `ziua` varchar(10) DEFAULT NULL,
  `ora` time DEFAULT NULL,
  `nr_max_participanti` int DEFAULT NULL,
  `id_profesor_activitate` int DEFAULT NULL,
  PRIMARY KEY (`id_activitati`),
  KEY `fk_id_materii` (`id_materii_activitati`),
  KEY `fk_activitate_profesor` (`id_profesor_activitate`),
  CONSTRAINT `fk_activitate_profesor` FOREIGN KEY (`id_profesor_activitate`) REFERENCES `profesori` (`profesor_id`),
  CONSTRAINT `fk_id_materii` FOREIGN KEY (`id_materii_activitati`) REFERENCES `materii` (`id_materii`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activitati`
--

LOCK TABLES `activitati` WRITE;
/*!40000 ALTER TABLE `activitati` DISABLE KEYS */;
INSERT INTO `activitati` VALUES (1,1,1,20,'seminar','luni','08:00:00',5,2),(2,1,1,10,'curs','marti','08:00:00',20,2),(3,1,1,70,'laborator','miercuri','08:00:00',20,2),(4,6,0,25,'Seminar','Marti','08:00:00',15,1),(5,6,1,25,'Seminar','Joi','08:00:00',15,1),(6,6,1,10,'Curs','Vineri','09:00:00',14,1),(7,6,1,65,'Laborator','Marti','15:00:00',18,1),(8,1,1,20,'Curs','Marti','08:00:00',15,7),(9,1,1,10,'Seminar','Joi','08:00:00',20,7),(10,1,1,70,'Laborator','Luni','09:00:00',16,7),(11,1,0,10,'Curs','Luni','12:00:00',15,2),(12,1,0,20,'Seminar','Marti','12:00:00',15,2),(13,1,0,70,'Laborator','Miercuri','12:00:00',15,2),(14,6,0,0,'curs','luni','13:00:00',14,1),(15,6,0,0,'Curs','Marti','13:00:00',13,1),(16,7,0,20,'curs','Marti','19:00:00',100,5),(17,7,0,20,'seminar','Joi','19:00:00',100,5),(18,7,0,60,'Laborator','Miercuri','19:00:00',100,5);
/*!40000 ALTER TABLE `activitati` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_before_insert_activitati` BEFORE INSERT ON `activitati` FOR EACH ROW BEGIN
  DECLARE var_nr_curent_ore INT;
  DECLARE var_nr_max_ore INT;
  
  SELECT nr_curent_ore
  INTO var_nr_curent_ore
  FROM profesori
  WHERE profesor_id = NEW.id_profesor_activitate;

  SELECT nr_max_ore
  INTO var_nr_max_ore
  FROM profesori
  WHERE profesor_id = NEW.id_profesor_activitate;

  IF var_nr_curent_ore = var_nr_max_ore THEN
	 SIGNAL SQLSTATE '45000'
	 SET MESSAGE_TEXT = 'Profesorul nu mai are suficiente ore disponibile.';
  ELSE
	  UPDATE profesori
	  SET nr_curent_ore = nr_curent_ore + 2
	  WHERE profesor_id = NEW.id_profesor_activitate;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TriggerRecalculeazaNoteFinala` AFTER UPDATE ON `activitati` FOR EACH ROW BEGIN
    -- Verifică dacă procentul a fost modificat
    IF OLD.procent <> NEW.procent THEN
        -- Recalculează notele pentru toți studenții înscriși la activitatea afectată
        UPDATE catalog c
        SET c.nota = ROUND((
            SELECT SUM(cal.nota_activitate * (IFNULL(a.procent, 0) / 100))
            FROM calendar cal
            JOIN activitati a ON cal.activitate_id_calendar = a.id_activitati
            WHERE cal.student_id_calendar = c.id_student_catalog
            AND a.id_materii_activitati = NEW.id_materii_activitati
        ), 2)
        WHERE c.id_materie_catalog = NEW.id_materii_activitati;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admins` (
  `admin_id_user` int DEFAULT NULL,
  `admin_id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `admin_id_user` (`admin_id_user`),
  CONSTRAINT `fk_admin` FOREIGN KEY (`admin_id_user`) REFERENCES `utilizatori` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (35,1),(36,2),(37,3),(38,4),(39,5);
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calendar`
--

DROP TABLE IF EXISTS `calendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendar` (
  `activitate_id_calendar` int NOT NULL,
  `student_id_calendar` int NOT NULL,
  `nota_activitate` double DEFAULT NULL,
  PRIMARY KEY (`activitate_id_calendar`,`student_id_calendar`),
  KEY `fk_calendar_student` (`student_id_calendar`),
  CONSTRAINT `calendar_ibfk_1` FOREIGN KEY (`activitate_id_calendar`) REFERENCES `activitati` (`id_activitati`),
  CONSTRAINT `fk_calendar_student` FOREIGN KEY (`student_id_calendar`) REFERENCES `studenti` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar`
--

LOCK TABLES `calendar` WRITE;
/*!40000 ALTER TABLE `calendar` DISABLE KEYS */;
INSERT INTO `calendar` VALUES (1,1,8),(2,1,10),(3,1,8),(5,1,6),(6,1,7),(7,1,8),(8,2,6),(9,2,10),(10,2,8);
/*!40000 ALTER TABLE `calendar` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_activity_enrollment` BEFORE INSERT ON `calendar` FOR EACH ROW BEGIN
    DECLARE activity_time TIME;
    DECLARE activity_day VARCHAR(10);
    DECLARE current_participants INT;
    DECLARE max_participants INT;
    DECLARE student_conflict INT;
    -- Obține ora și ziua activității la care studentul încearcă să se înscrie
    SELECT ora, ziua
    INTO activity_time, activity_day
    FROM activitati
    WHERE id_activitati = NEW.activitate_id_calendar;
    -- Verifică dacă există locuri disponibile pentru activitatea respectivă
    SELECT Nr_participanti_activitate, nr_max_participanti
    INTO current_participants, max_participants
    FROM activitati
    WHERE id_activitati = NEW.activitate_id_calendar;
    IF current_participants >= max_participants THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Nu sunt locuri disponibile pentru această activitate.';
    ELSE
        -- Verifică dacă studentul are alte activități care se suprapun
        SELECT COUNT(*) INTO student_conflict
        FROM calendar c
        JOIN activitati a ON c.activitate_id_calendar = a.id_activitati
        WHERE c.student_id_calendar = NEW.student_id_calendar
        AND a.ziua = activity_day
        AND a.ora = activity_time;
        IF student_conflict > 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Conflict de orar cu o altă activitate!';
        ELSE
            -- Dacă nu există conflicte, actualizează numărul de participanți în activitate
            UPDATE activitati
            SET Nr_participanti_activitate = Nr_participanti_activitate + 1
            WHERE id_activitati = NEW.activitate_id_calendar;
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `catalog`
--

DROP TABLE IF EXISTS `catalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalog` (
  `id_materie_catalog` int NOT NULL,
  `id_student_catalog` int NOT NULL,
  `nota` int DEFAULT NULL,
  PRIMARY KEY (`id_materie_catalog`,`id_student_catalog`),
  KEY `fk_catalog_student` (`id_student_catalog`),
  CONSTRAINT `catalog_ibfk_1` FOREIGN KEY (`id_materie_catalog`) REFERENCES `materii` (`id_materii`),
  CONSTRAINT `fk_catalog_student` FOREIGN KEY (`id_student_catalog`) REFERENCES `studenti` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog`
--

LOCK TABLES `catalog` WRITE;
/*!40000 ALTER TABLE `catalog` DISABLE KEYS */;
INSERT INTO `catalog` VALUES (1,1,8),(1,2,8),(1,9,NULL),(2,1,NULL),(4,1,NULL),(6,1,7),(8,1,NULL);
/*!40000 ALTER TABLE `catalog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grup_activitati`
--

DROP TABLE IF EXISTS `grup_activitati`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grup_activitati` (
  `id_activitate_grup` int NOT NULL AUTO_INCREMENT,
  `id_grup` int DEFAULT NULL,
  `nr_curent_participanti` int DEFAULT NULL,
  `nr_min_participanti` int DEFAULT NULL,
  `ziua_calendaristica` date DEFAULT NULL,
  `ora` time DEFAULT NULL,
  `descriere` varchar(50) DEFAULT NULL,
  `durata` int DEFAULT NULL,
  `timp_expirare` int DEFAULT NULL,
  `status_activitate` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id_activitate_grup`),
  KEY `fk_grup_activitati` (`id_grup`),
  CONSTRAINT `fk_grup_activitati` FOREIGN KEY (`id_grup`) REFERENCES `grup_studiu` (`id_grup`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grup_activitati`
--

LOCK TABLES `grup_activitati` WRITE;
/*!40000 ALTER TABLE `grup_activitati` DISABLE KEYS */;
INSERT INTO `grup_activitati` VALUES (1,1,1,1,'2026-01-01','14:00:00','a',2,2,1),(2,1,1,1,'2026-04-14','12:00:00','jdk',2,2,1),(3,1,0,1,'2026-01-01','15:00:00','lawjdbahvd',2,1,0),(4,1,0,1,'2026-07-07','12:00:00','asddad',2,1,2),(5,2,1,1,'2026-10-08','15:20:00','Studiu',2,1,2),(6,2,0,20,'2026-09-06','16:00:00','Hai la invatat',2,1,0),(7,1,1,1,'2026-08-30','20:30:00','Studiu',2,2,2),(8,1,1,1,'2026-08-30','20:30:00','Studiu',2,2,1),(9,4,1,1,'2026-01-01','15:20:00','Studiu',2,2,2),(10,8,0,30,'2026-01-30','20:30:00','Studiu',2,1,0),(11,8,1,1,'2026-02-03','15:20:00','Studiu',2,1,2),(12,8,0,2,'2026-02-01','20:30:00','Studiu',2,2,0);
/*!40000 ALTER TABLE `grup_activitati` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grup_activitati_studenti`
--

DROP TABLE IF EXISTS `grup_activitati_studenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grup_activitati_studenti` (
  `id_activitate_grup` int NOT NULL,
  `id_student` int NOT NULL,
  PRIMARY KEY (`id_activitate_grup`,`id_student`),
  KEY `fk_grup_activitate_student` (`id_student`),
  CONSTRAINT `fk_grup_activitate` FOREIGN KEY (`id_activitate_grup`) REFERENCES `grup_activitati` (`id_activitate_grup`),
  CONSTRAINT `fk_grup_activitate_student` FOREIGN KEY (`id_student`) REFERENCES `studenti` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grup_activitati_studenti`
--

LOCK TABLES `grup_activitati_studenti` WRITE;
/*!40000 ALTER TABLE `grup_activitati_studenti` DISABLE KEYS */;
INSERT INTO `grup_activitati_studenti` VALUES (1,1),(2,1),(5,1),(7,1),(8,1),(9,1),(11,1);
/*!40000 ALTER TABLE `grup_activitati_studenti` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_insert_activitate_student` BEFORE INSERT ON `grup_activitati_studenti` FOR EACH ROW BEGIN
    DECLARE nr_participanti_curenti INT;
    DECLARE grup_associat_id INT;
    -- Obținem id-ul grupului asociat activității
    SELECT id_grup INTO grup_associat_id
    FROM grup_activitati
    WHERE id_activitate_grup = NEW.id_activitate_grup;
    -- Verificăm dacă studentul face parte din grupul respectiv
    IF NOT EXISTS (
        SELECT 1
        FROM grup_studiu_studenti
        WHERE id_student = NEW.id_student
        AND id_grup = grup_associat_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Studentul nu face parte din acest grup de studiu!';
    END IF;
    -- Creștem numărul curent de participanți pentru activitate
    SELECT nr_curent_participanti
    INTO nr_participanti_curenti
    FROM grup_activitati
    WHERE id_activitate_grup = NEW.id_activitate_grup;
    -- Actualizăm numărul curent de participanți (doar dacă studentul este validat)
    UPDATE grup_activitati
    SET nr_curent_participanti = nr_participanti_curenti + 1
    WHERE id_activitate_grup = NEW.id_activitate_grup;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `grup_studiu`
--

DROP TABLE IF EXISTS `grup_studiu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grup_studiu` (
  `id_grup` int NOT NULL AUTO_INCREMENT,
  `id_materie` int DEFAULT NULL,
  PRIMARY KEY (`id_grup`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grup_studiu`
--

LOCK TABLES `grup_studiu` WRITE;
/*!40000 ALTER TABLE `grup_studiu` DISABLE KEYS */;
INSERT INTO `grup_studiu` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8);
/*!40000 ALTER TABLE `grup_studiu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grup_studiu_studenti`
--

DROP TABLE IF EXISTS `grup_studiu_studenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grup_studiu_studenti` (
  `id_grup` int NOT NULL,
  `id_student` int NOT NULL,
  PRIMARY KEY (`id_grup`,`id_student`),
  KEY `fk_student` (`id_student`),
  CONSTRAINT `fk_grup_studiu_studenti` FOREIGN KEY (`id_grup`) REFERENCES `grup_studiu` (`id_grup`),
  CONSTRAINT `fk_student` FOREIGN KEY (`id_student`) REFERENCES `studenti` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grup_studiu_studenti`
--

LOCK TABLES `grup_studiu_studenti` WRITE;
/*!40000 ALTER TABLE `grup_studiu_studenti` DISABLE KEYS */;
INSERT INTO `grup_studiu_studenti` VALUES (1,1),(2,1),(4,1),(8,1);
/*!40000 ALTER TABLE `grup_studiu_studenti` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_grup_studiu_student_insert` BEFORE INSERT ON `grup_studiu_studenti` FOR EACH ROW BEGIN
    DECLARE materie_id INT; -- Variabilă pentru a reține materia asociată grupului
    DECLARE student_este_inscris BOOLEAN; -- Variabilă pentru a verifica înscrierea studentului
    -- Obținem materia asociată grupului
    SELECT id_materie INTO materie_id
    FROM grup_studiu
    WHERE id_grup = NEW.id_grup;
    -- Dacă grupul nu există, aruncăm o eroare
    IF materie_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Grupul specificat nu există.';
    END IF;
    -- Verificăm dacă studentul este înscris la materia grupului
    SELECT COUNT(*) > 0 INTO student_este_inscris
    FROM catalog
    WHERE id_student_catalog = NEW.id_student
      AND id_materie_catalog = materie_id;
    -- Dacă studentul nu este înscris, aruncăm o eroare
    IF NOT student_este_inscris THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Studentul nu este înscris la materia asociată grupului.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `materii`
--

DROP TABLE IF EXISTS `materii`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `materii` (
  `id_materii` int NOT NULL,
  `nume_materii` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id_materii`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materii`
--

LOCK TABLES `materii` WRITE;
/*!40000 ALTER TABLE `materii` DISABLE KEYS */;
INSERT INTO `materii` VALUES (1,'Algebra liniara'),(2,'Matematici speciale in inginerie'),(3,'Baze de date'),(4,'Programare orientata pe obiecte'),(5,'Arhitectura calculatoarelor'),(6,'Retele de Calculatoare'),(7,'Proiectarea Sistemelor Numerice'),(8,'Tehnici de programare');
/*!40000 ALTER TABLE `materii` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_insert_materii` AFTER INSERT ON `materii` FOR EACH ROW BEGIN
    INSERT INTO grup_studiu(id_materie)
    VALUES (NEW.id_materii);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `mesaje`
--

DROP TABLE IF EXISTS `mesaje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mesaje` (
  `id_mesaj` int NOT NULL AUTO_INCREMENT,
  `id_grup_mesaj` int DEFAULT NULL,
  `student_id_mesaj` int DEFAULT NULL,
  `mesaj` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_mesaj`),
  KEY `fk_mesaj_grup` (`id_grup_mesaj`),
  KEY `fk_mesaj_grup_stud_studenti` (`student_id_mesaj`),
  CONSTRAINT `fk_mesaj_grup` FOREIGN KEY (`id_grup_mesaj`) REFERENCES `grup_studiu` (`id_grup`),
  CONSTRAINT `fk_mesaj_grup_stud_studenti` FOREIGN KEY (`student_id_mesaj`) REFERENCES `studenti` (`student_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mesaje`
--

LOCK TABLES `mesaje` WRITE;
/*!40000 ALTER TABLE `mesaje` DISABLE KEYS */;
INSERT INTO `mesaje` VALUES (1,2,1,'Salut!'),(2,1,1,'Salut!'),(3,8,1,'Salut!');
/*!40000 ALTER TABLE `mesaje` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profesori`
--

DROP TABLE IF EXISTS `profesori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profesori` (
  `profesor_id_user` int DEFAULT NULL,
  `nr_max_ore` int DEFAULT NULL,
  `nr_min_ore` int DEFAULT NULL,
  `departament` varchar(50) DEFAULT NULL,
  `nr_max_studenti` int DEFAULT NULL,
  `id_profesor_materie` int DEFAULT NULL,
  `numar_curent_studenti` int DEFAULT NULL,
  `nr_curent_ore` int DEFAULT NULL,
  `profesor_id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`profesor_id`),
  UNIQUE KEY `profesor_id_user` (`profesor_id_user`),
  KEY `fk_id_materii_profesori` (`id_profesor_materie`),
  CONSTRAINT `fk_id_materii_profesori` FOREIGN KEY (`id_profesor_materie`) REFERENCES `materii` (`id_materii`),
  CONSTRAINT `fk_profesori` FOREIGN KEY (`profesor_id_user`) REFERENCES `utilizatori` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profesori`
--

LOCK TABLES `profesori` WRITE;
/*!40000 ALTER TABLE `profesori` DISABLE KEYS */;
INSERT INTO `profesori` VALUES (21,30,6,'Hardware',60,6,1,NULL,1),(22,12,6,'Matematica',55,1,1,NULL,2),(23,10,6,'Hardware',70,5,0,NULL,3),(24,20,6,'Hardware',80,5,0,NULL,4),(25,24,6,'Hardware',40,7,0,NULL,5),(26,16,6,'Hardware',63,7,0,NULL,6),(27,32,6,'Matematica',120,1,1,NULL,7),(28,22,6,'Software',60,8,1,NULL,8),(29,10,6,'Software',55,4,1,NULL,9),(30,8,6,'Software',49,4,0,NULL,10),(31,28,6,'Software',40,3,0,NULL,11),(32,18,6,'Matematica',30,1,1,NULL,12),(33,26,6,'Software',50,8,0,NULL,13),(34,20,6,'Matematica',99,2,1,NULL,14);
/*!40000 ALTER TABLE `profesori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol` (
  `Rol_id` int NOT NULL,
  `Rol_nume` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`Rol_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol`
--

LOCK TABLES `rol` WRITE;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` VALUES (0,'Super-Admin'),(1,'Admin'),(2,'Profesor'),(3,'Student');
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studenti`
--

DROP TABLE IF EXISTS `studenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `studenti` (
  `student_id_user` int DEFAULT NULL,
  `an_de_studiu` int DEFAULT NULL,
  `numar_ore_sustinute` int DEFAULT NULL,
  `student_id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`student_id`),
  UNIQUE KEY `student_id_user` (`student_id_user`),
  CONSTRAINT `fk_studenti` FOREIGN KEY (`student_id_user`) REFERENCES `utilizatori` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studenti`
--

LOCK TABLES `studenti` WRITE;
/*!40000 ALTER TABLE `studenti` DISABLE KEYS */;
INSERT INTO `studenti` VALUES (1,1,20,1),(2,1,20,2),(3,1,20,3),(4,2,25,4),(5,2,25,5),(6,2,25,6),(7,3,22,7),(8,3,22,8),(9,3,22,9),(10,4,15,10),(11,1,20,11),(12,1,20,12),(13,1,20,13),(14,2,25,14),(15,2,25,15),(16,2,25,16),(17,3,22,17),(18,3,22,18),(19,3,22,19),(20,4,15,20),(40,2,20,21);
/*!40000 ALTER TABLE `studenti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studenti_profesori`
--

DROP TABLE IF EXISTS `studenti_profesori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `studenti_profesori` (
  `id_student` int NOT NULL,
  `id_profesor` int NOT NULL,
  PRIMARY KEY (`id_student`,`id_profesor`),
  KEY `fk_catre_profesori` (`id_profesor`),
  CONSTRAINT `fk_catre_profesori` FOREIGN KEY (`id_profesor`) REFERENCES `profesori` (`profesor_id`),
  CONSTRAINT `fk_catre_studenti` FOREIGN KEY (`id_student`) REFERENCES `studenti` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studenti_profesori`
--

LOCK TABLES `studenti_profesori` WRITE;
/*!40000 ALTER TABLE `studenti_profesori` DISABLE KEYS */;
INSERT INTO `studenti_profesori` VALUES (1,1),(1,2),(2,7),(1,8),(1,9),(9,12),(1,14);
/*!40000 ALTER TABLE `studenti_profesori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utilizatori`
--

DROP TABLE IF EXISTS `utilizatori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utilizatori` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `CNP` varchar(13) DEFAULT NULL,
  `nume` varchar(30) DEFAULT NULL,
  `prenume` varchar(30) DEFAULT NULL,
  `NumarTelefon` char(10) DEFAULT NULL,
  `Adresa` varchar(100) DEFAULT NULL,
  `IBAN` char(24) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `Nr_contract` int DEFAULT NULL,
  `Rol_id` int DEFAULT NULL,
  `parola` varchar(30) NOT NULL,
  PRIMARY KEY (`user_id`),
  KEY `fk_rol` (`Rol_id`),
  CONSTRAINT `fk_rol` FOREIGN KEY (`Rol_id`) REFERENCES `rol` (`Rol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utilizatori`
--

LOCK TABLES `utilizatori` WRITE;
/*!40000 ALTER TABLE `utilizatori` DISABLE KEYS */;
INSERT INTO `utilizatori` VALUES (1,'5041006325698','Popa','Andrei','0741234567','Strada Grivita, Nr. 26, Dumbraveni','RO49AAAA1B31007593840000','popa.andrei@yahoo.com',20,3,'mate20'),(2,'5031013325598','Popescu','Razvan','0742523456','Strada Semaforului, Nr. 25, Sibiu','RO50BCAB1B31007526840000','popescu_razvan@gmail.com',32,3,'12samsung'),(3,'5020923428698','Stoica','Ianis','0734234587','Strada Mihai Viteazu, Nr. 187, Cluj-Napoca','RO29AABC1A31008873840000','ianis.stoica23@outlook.com',54,3,'fotbal123*'),(4,'5010529426678','Cristea','Andrei','0703234299','Strada Nicolae Iorga, Nr. 26, Arad','RO49BACD1B81008693840000','andrei_cristea2001@gmail.com',80,3,'foto12!'),(5,'5050616565795','Munteanu','George','0752233597','Calea Cisnadiei, Nr. 10, Timisoara','RO56ABCA1B31008573910000','george.munteanu@yahoo.com',100,3,'temesvar'),(6,'6041025334610','Florea','Andreea','0742344567','Strada Observatorului, Nr. 250, Cluj-Napoca','RO18ABCA1B31887587840000','florea_andreea@gmail.com',39,3,'masina_21'),(7,'6030202346688','Toma','Cristiana','0746784627','Strada Hipodromului, Nr. 15, Sibiu','RO78AAAA1C31006491240000','cristiana.toma83@outlook.com',100,3,'flori56'),(8,'6010903425798','Rusu','Amalia','0751238855','Strada Republicii, Nr. 52, Cluj-Napoca','RO52ABBA1B31007893740000','amaliarusu@yahoo.com',147,3,'cezifrumoasa'),(9,'6020101478198','Lazar','Irina','0721235662','Strada Abrud, Nr. 158, Timisoara','RO06ABBA1B31027595842200','irina_lazar@gmail.com',248,3,'matematica67'),(10,'6041006325698','Dinu','Liliana','0756238592','Strada Arenei, Nr. 17, Oradea','RO80AADD1B75008493740000','liliana.dinu@gmail.com',7,3,'koka_kola'),(11,'5041016326698','Ionescu','Bogdan','0762234567','Bulevardul Muncii, Nr. 100, Cluj-Napoca','RO49AAAA1B31007584840000','ionescu.bogdan@gmail.com',160,3,'hop-asa'),(12,'5040907326689','Slavescu','Alex','0777234567','Calea Manastur, Nr. 56, Cluj-Napoca','RO49AAAA1B41007584850000','andrei_slavescu@gmail.com',194,3,'bijuterie'),(13,'5040102327699','Badea','Mihaela','0784243557','Strada Bicazului, Nr. 90, Cluj-Napoca','RO50ABBC1B41107584850000','badea.mihaela@yahoo.com',294,3,'koka-kola'),(14,'5040620897313','Dinescu','Robert','0794243687','Aleea Biruintei, Nr. 6, Sibiu','RO60ADBC1B41117524860000','robert_dinescu@outlook.com',31,3,'actorie'),(15,'5040906897420','Negoita','Teodora','0712263627','Piata Rahovei, Nr. 25, Sibiu','RO24BDBC1B41117522860029','teodora.negoita@gmail.com',210,3,'starwars'),(16,'5041224897420','Tomescu','Andreea','0713263569','Strada Cibinului, Nr. 86, Sibiu','RO34BACC1B42227522862029','tomescu_andreea@gmail.com',478,3,'boss'),(17,'5041101897042','Voinea','Cristina','0731236596','Aleea Armoniei, Nr. 290, Satu Mare','RO43BAAA1B42272522862092','cristina.voinea@outlook.com',555,3,'satu-mare'),(18,'5040404827021','Ursu','Marian','0745346526','Piata 1 Mai, Nr. 12, Satu Mare','RO55BCAD1B42282532562992','marian.ursu@gmail.com',667,3,'adu_telefonu'),(19,'5040506837012','Petrescu','Dan','0726356529','Bulevardul Unirii, Nr. 232, Bucuresti','RO55BCDA1B42282537562722','dan.petrescu@yahoo.com',2,3,'cfr_cluj'),(20,'5030202837025','Sumudica','Marius','0722375517','Strada Libertatii, Nr. 20, Bucuresti','RO23BCDA1B44582537562724','marius.sumudica@gmail.com',63,3,'astra.giurgiu'),(21,'1960123456789','Popescu','Ion','0723456789','Str. Progresu, nr. 10, București','RO49AAAA1B31007593840000','ion.popescu@email.com',123456,2,'parola123'),(22,'2971234567891','Ionescu','Maria','0734567890','Str. Libertății, nr. 20, Cluj-Napoca','RO12BBBB1C31007654320000','maria.ionescu@gmail.com',654321,2,'lala'),(23,'1861123456785','Georgescu','Adrian','0745678901','Str. Mihai Eminescu, nr. 15, Timișoara','RO30CCCC1D31007765410000','adrian.georgescu@gmail.com',987654,2,'maremunte'),(24,'2990987654321','Dumitrescu','Elena','0756789012','Str. Păcii, nr. 25, Iași','RO78DDDD1E31007890120000','elena.dumitrescu@gmail.com',112233,2,'lapte'),(25,'1931230987654','Vasilescu','Andrei','0767890123','Str. Victoriei, nr. 30, Constanța','RO45EEEE1F31007987650000','andrei.vasilescu@email.com',445566,2,'clujBucuresti'),(26,'2881234567890','Marinescu','Cristina','0778901234','Str. Unirii, nr. 40, Brașov','RO90FFFF1G31008012340000','cristina.marinescu@email.com',778899,2,'judec'),(27,'1781207278127','Pop','Vasile','0722234597','Strada Zorilor, Nr. 48, Cluj-Napoca','RO49AABB1B31005493730000','vasile.pop@yahoo.com',156,2,'algebra_culegere'),(28,'1781203129143','Rus','Tudor','0712434527','Calea Dorobantilor, Nr. 120, Cluj-Napoca','RO56AABB1B24006493730000','tudor.rus@gmail.com',186,2,'pisica782'),(29,'1810204126368','Baciu','Marian','0716434539','Strada Alesd, Nr. 201, Cluj-Napoca','RO86AABB1B24007498940000','baciu.marian@yahoo.com',368,2,'c++'),(30,'1660414120413','Suciu','Ioan','0721229587','Strada Actorului, Nr. 26, Cluj-Napoca','RO98AABB1B31005473830100','ioan_suciu@outlook.com',1000,2,'12tranzistor21'),(31,'1721017123273','Albu','Dorian','0736784516','Piata Muzeului, Nr. 21, Cluj-Napoca','RO99AABB1B31075492730099','albu.dorian@gmail.com',196,2,'hatz'),(32,'2750604128284','Sava','Maria','0722634797','Strada Alunului, Nr. 75, Cluj-Napoca','RO49AABB1B31805493830000','maria_sava@yahoo.com',72,2,'baze_de_date'),(33,'2800713127196','Chiriac','Adela','0735244897','Strada Avram Iancu, Nr. 50, Cluj-Napoca','RO25AABB1B31005494730200','adela.chiriac@yahoo.com',37,2,'floricele'),(34,'2770203127169','Nita','Cristiana','0722784512','Piata Cipariu, Nr. 88, Cluj-Napoca','RO68AABC1B51005497330000','nita_cristiana@gmail.com',246,2,'86campie78!'),(35,'1910921123456','Marin','Cristina','0723987654','Calea Victoriei, Nr. 99','RO23ACBA1C31006794840088','cristina.marin@email.com',52,1,'adminull'),(36,'1800322123467','Ilie','Mihai','0723654321','Strada Universitatii, Nr. 21','RO56ACBA1D31006894840077','mihai.ilie@email.com',76,1,'secureadmin2'),(37,'1800823125229','Stanciu','Nicolae','0723355676','Strada Aviatorilor, Nr. 12','RO88ACBA1B31006594840099','nicolae_stanciu@yahoo.com',19,1,'admin12'),(38,'2890606124564','Tanase','Adriana','0723765687','Bulevardul Eroilor, Nr. 54','RO19ACBA1B31006694841299','tanase_adriana@gmail.com',28,1,'404admin404'),(39,'1700210329979','Bucur','Alexandru','0723455777','Strada Berariei, Nr. 62','RO78ACBA1D31006594850099','alex.bucur@gmail.com',105,0,'adminu_shef'),(40,'5040513320352','Bestean','Radu','0772255246','Bd. Vasile Milea, Sibiu','RO88ACBA1B31006594840098','radu.bestean@gmail.com',275,3,'123');
/*!40000 ALTER TABLE `utilizatori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `view_profesor`
--

DROP TABLE IF EXISTS `view_profesor`;
/*!50001 DROP VIEW IF EXISTS `view_profesor`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_profesor` AS SELECT 
 1 AS `user_id`,
 1 AS `id_profesor_materie`,
 1 AS `CNP`,
 1 AS `nume`,
 1 AS `prenume`,
 1 AS `NumarTelefon`,
 1 AS `Adresa`,
 1 AS `IBAN`,
 1 AS `email`,
 1 AS `Nr_contract`,
 1 AS `profesor_id`,
 1 AS `nr_max_ore`,
 1 AS `nr_min_ore`,
 1 AS `departament`,
 1 AS `nr_max_studenti`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_studenti`
--

DROP TABLE IF EXISTS `view_studenti`;
/*!50001 DROP VIEW IF EXISTS `view_studenti`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_studenti` AS SELECT 
 1 AS `user_id`,
 1 AS `student_id`,
 1 AS `CNP`,
 1 AS `nume`,
 1 AS `prenume`,
 1 AS `NumarTelefon`,
 1 AS `adresa`,
 1 AS `IBAN`,
 1 AS `email`,
 1 AS `Nr_contract`,
 1 AS `an_de_studiu`,
 1 AS `numar_ore_sustinute`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_studenti_note`
--

DROP TABLE IF EXISTS `view_studenti_note`;
/*!50001 DROP VIEW IF EXISTS `view_studenti_note`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_studenti_note` AS SELECT 
 1 AS `student_id`,
 1 AS `nume`,
 1 AS `prenume`,
 1 AS `nota`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'proiect'
--

--
-- Dumping routines for database 'proiect'
--
/*!50003 DROP PROCEDURE IF EXISTS `AdaugaActivitateGrup` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AdaugaActivitateGrup`(
    IN grupID INT,
    IN nr_min_participanti INT,
    IN ziua_calendaristica DATE,
    IN ora TIME,
    IN descriere VARCHAR(50),
    IN durata INT,
    IN timp_expirare INT
)
BEGIN
    DECLARE activitateID INT;

    -- Verifică dacă activitatea este în viitor
    IF NOW() > TIMESTAMP(ziua_calendaristica, ora) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O activitate poate fi programată doar în viitor!';
    ELSE
        -- 1. Inserează activitatea
        INSERT INTO grup_activitati(
            id_grup, nr_curent_participanti, nr_min_participanti,
            ziua_calendaristica, ora, descriere, durata, timp_expirare, status_activitate
        ) 
        VALUES (grupID, 0, nr_min_participanti, ziua_calendaristica, ora, descriere, durata, timp_expirare, 1);

        -- 2. Obține ID-ul activității
        SET activitateID = LAST_INSERT_ID();
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AdaugaAdmin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AdaugaAdmin`(
	IN CNP VARCHAR(13), 
    IN nume VARCHAR(30), 
    IN prenume VARCHAR(30), 
    IN NumarTelefon CHAR(10), 
    IN Adresa VARCHAR(100), 
    IN IBAN CHAR(24), 
    IN email VARCHAR(30), 
    IN Nr_contract INT, 
    IN parola VARCHAR(30)
)
BEGIN
	DECLARE last_user_id INT;
    
    INSERT INTO utilizatori(CNP, nume, prenume, NumarTelefon, Adresa, IBAN, email, Nr_contract, Rol_id, parola) VALUES
	(CNP, nume, prenume, NumarTelefon, Adresa, IBAN, email, Nr_contract, 1, parola);
    
    SET last_user_id = LAST_INSERT_ID();
    
    INSERT INTO admins (admin_id_user) VALUES (last_user_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AdaugaProfesor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AdaugaProfesor`(
	IN materie VARCHAR(60),
	IN CNP VARCHAR(13), 
    IN nume VARCHAR(30), 
    IN prenume VARCHAR(30), 
    IN NumarTelefon CHAR(10), 
    IN Adresa VARCHAR(100), 
    IN IBAN CHAR(24), 
    IN email VARCHAR(30), 
    IN Nr_contract INT, 
    IN parola VARCHAR(30),
	IN nr_max_ore INT,
	IN nr_min_ore INT,
    IN departament varchar(50),
    IN nr_max_studenti INT
)
BEGIN
	DECLARE last_user_id INT;
    DECLARE materieID INT;
    DECLARE exista_materia INT;
    
    SELECT COUNT(*) INTO exista_materia
    FROM materii
    WHERE nume_materii = materie;
    
    IF exista_materia > 0 THEN
		SELECT id_materii INTO materieID
		FROM materii
		WHERE nume_materii = materie;

		INSERT INTO utilizatori(CNP, nume, prenume, NumarTelefon, Adresa, IBAN, email, Nr_contract, Rol_id, parola) VALUES
		(CNP, nume, prenume, NumarTelefon, Adresa, IBAN, email, Nr_contract, 2, parola);
    
		SET last_user_id = LAST_INSERT_ID();
    
		INSERT INTO profesori(profesor_id_user, nr_max_ore, nr_min_ore, departament, nr_max_studenti, id_profesor_materie, 
		numar_curent_studenti, nr_curent_ore) VALUES
		(last_user_id, nr_max_ore, nr_min_ore, departament, nr_max_studenti, materieID, 0, 0);
	ELSE
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Nu exista aceasta materie!';
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AdaugaStudent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AdaugaStudent`(
	IN CNP VARCHAR(13), 
    IN nume VARCHAR(30), 
    IN prenume VARCHAR(30), 
    IN NumarTelefon CHAR(10), 
    IN Adresa VARCHAR(100), 
    IN IBAN CHAR(24), 
    IN email VARCHAR(30), 
    IN Nr_contract INT, 
    IN parola VARCHAR(30),
    IN an_de_studiu INT, 
    IN numar_ore_sustinute INT
)
BEGIN
	DECLARE last_user_id INT;

	INSERT INTO utilizatori(CNP, nume, prenume, NumarTelefon, Adresa, IBAN, email, Nr_contract, Rol_id, parola) VALUES
    (CNP, nume, prenume, NumarTelefon, Adresa, IBAN, email, Nr_contract, 3, parola);
    
    SET last_user_id = LAST_INSERT_ID();
    
    INSERT INTO studenti (student_id_user, an_de_studiu, numar_ore_sustinute) VALUES
    (last_user_id, an_de_studiu, numar_ore_sustinute);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AfisareGrupuriDeStudiu` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AfisareGrupuriDeStudiu`(IN studentID int)
BEGIN
	SELECT gss.id_grup AS ID_grup_studiu, m.nume_materii AS Materie
    FROM grup_studiu_studenti gss
    JOIN grup_studiu gr ON gr.id_grup = gss.id_grup
    JOIN materii m ON gr.id_materie = m.id_materii
    WHERE gss.id_student = studentID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetActivitatiStudent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetActivitatiStudent`(
    IN ziua_saptamanii VARCHAR(10),
    IN id_student INT
)
BEGIN
    SELECT
		m.nume_materii AS Nume_Materie,
        a.descriere AS Descriere_Activitate,
        a.ora AS Ora_Activitatii
    FROM 
        calendar c
    JOIN 
        activitati a ON c.activitate_id_calendar = a.id_activitati
    JOIN 
        materii m ON a.id_materii_activitati = m.id_materii
    WHERE 
        c.student_id_calendar = id_student 
        AND a.ziua = ziua_saptamanii;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAdminData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAdminData`(IN userId INT)
BEGIN
    SELECT 
        u.user_id AS id_user,
        u.nume AS Nume,
        u.prenume AS Prenume,
        u.CNP,
        u.NumarTelefon AS Numar_Telefon,
        u.adresa AS Adresa,
        u.IBAN,
        u.email AS Email,
        u.Nr_contract,
        r.Rol_nume AS Rol
    FROM utilizatori u
    JOIN rol r ON u.Rol_id = r.Rol_id
    WHERE u.user_id = userId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetMateriiProfesor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetMateriiProfesor`(
    IN profesor_id INT
)
BEGIN
    -- Selectează materiile asociate profesorului
    SELECT m.id_materii
    FROM materii m
    JOIN activitati a ON m.id_materii = a.id_materii_activitati
    WHERE a.id_profesor_activitate = profesor_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetProfesorData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetProfesorData`(IN userId INT)
BEGIN
    SELECT 
        u.user_id AS id_user,
        u.nume AS Nume,
        u.prenume AS Prenume,
        u.CNP,
        u.NumarTelefon AS Numar_Telefon,
        u.adresa AS Adresa,
        u.IBAN,
        u.email AS Email,
        u.Nr_contract,
        m.nume_materii AS Materie_predata,
        p.departament AS Departament,
        p.nr_min_ore AS Nr_minim_ore,
        p.nr_max_ore AS Nr_maxim_ore,
        p.nr_curent_ore AS Nr_curent_ore,
        p.nr_max_studenti AS Nr_maxim_studenti,
        p.numar_curent_studenti AS Nr_curent_studenti
    FROM utilizatori u
    JOIN profesori p ON u.user_id = p.profesor_id_user
    JOIN materii m ON p.id_profesor_materie = m.id_materii
    WHERE u.user_id = userId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetStudentData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetStudentData`(IN userId INT)
BEGIN
    SELECT 
        u.user_id AS user_id,
        u.nume AS Nume,
        u.prenume AS Prenume,
        u.CNP,
        u.NumarTelefon AS Numar_Telefon,
        u.adresa AS Adresa,
        u.IBAN,
        u.email AS Email,
        u.Nr_contract,
        s.an_de_studiu AS An_de_studiu,
        s.numar_ore_sustinute AS Numar_ore_sustinute
    FROM utilizatori u
    JOIN studenti s ON u.user_id = s.student_id_user
    WHERE u.user_id = userId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetStudentNote` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetStudentNote`(IN studentID INT)
BEGIN
    SELECT 
        m.nume_materii AS Materie,
        c.nota AS Nota
    FROM catalog c
    JOIN materii m ON c.id_materie_catalog = m.id_materii
    JOIN studenti s ON c.id_student_catalog = s.student_id
    WHERE s.student_id = studentID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InscriereActivitate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InscriereActivitate`(IN activitateID INT, IN studentID INT)
BEGIN
    DECLARE materieID INT;
    DECLARE activitateTip VARCHAR(30);

    -- Obține id-ul materiei și tipul activității curente
    SELECT id_materii_activitati, descriere
    INTO materieID, activitateTip
    FROM activitati
    WHERE id_activitati = activitateID;

    -- Verifică dacă studentul este deja înscris la același tip de activitate din aceeași materie
    IF EXISTS (
        SELECT 1
        FROM calendar c
        JOIN activitati a ON c.activitate_id_calendar = a.id_activitati
        WHERE c.student_id_calendar = studentID
          AND a.id_materii_activitati = materieID
          AND a.descriere = activitateTip
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Esti deja înscris la acest tip de activitate pentru aceasta materie.';
    ELSE
        -- Inscrie studentul în activitate
        INSERT INTO calendar (activitate_id_calendar, student_id_calendar)
        VALUES (activitateID, studentID);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InscriereActivitateGrup` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InscriereActivitateGrup`(IN studentID int, IN activitateID int)
BEGIN
    DECLARE zi_activitate DATE;
    DECLARE ora_activitate TIME;
    DECLARE status_activ BOOLEAN;

    -- Preia ziua calendaristică a activității
    SELECT ziua_calendaristica, ora, status_activitate INTO zi_activitate, ora_activitate, status_activ
    FROM grup_activitati 
    WHERE id_activitate_grup = activitateID;

    -- Verifică dacă `NOW()` este mai mic decât ziua activității
    IF NOW() < TIMESTAMP(zi_activitate, ora_activitate) AND status_activ = 1 THEN
        -- Inserare în tabel
        INSERT INTO grup_activitati_studenti(id_activitate_grup, id_student) 
        VALUES (activitateID, studentID);
    ELSE
        -- Aruncă o eroare
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Nu te poți înscrie la această activitate deoarece nu mai este valabila!';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InscriereGrupStudiu` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InscriereGrupStudiu`(IN studentID INT, IN materieID INT)
BEGIN
    DECLARE grupID INT;

    -- Obține id_grup asociat materiei
    SELECT id_grup
    INTO grupID
    FROM grup_studiu
    WHERE id_materie = materieID;

    -- Verifică dacă studentul este înscris la materia respectivă
    IF EXISTS (
        SELECT 1
        FROM catalog c
        WHERE c.id_student_catalog = studentID
          AND c.id_materie_catalog = materieID
    ) THEN
        -- Inscrie studentul în grupul de studiu
        INSERT INTO grup_studiu_studenti (id_grup, id_student)
        VALUES (grupID, studentID);
    ELSE
        -- Generează eroare dacă studentul nu este înscris la materie
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Nu esti inscris la materia asociata acestui grup de studiu!';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ProfesorProgramareActivitate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ProfesorProgramareActivitate`(
	IN profID INT,
    IN var_descriere VARCHAR(30),
    IN var_ziua VARCHAR(10),
    IN var_ora TIME,
    IN var_nr_max_participanti INT
)
BEGIN
	DECLARE materieID int;
    DECLARE activitate_existenta INT DEFAULT 0;
    
	-- Selectăm materia asociată profesorului
	SELECT id_profesor_materie
    INTO materieID
	FROM profesori
	WHERE profesor_id = profID;
    
     -- Verificăm dacă există deja o activitate în aceeași zi și la aceeași oră pentru profesor
	SELECT COUNT(*)
    INTO activitate_existenta
    FROM activitati
    WHERE id_profesor_activitate = profID AND ziua = var_ziua AND ora = var_ora;
    
	-- Dacă există o astfel de activitate, generăm o eroare
    IF activitate_existenta > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Aveti deja o activitate programată la această zi și oră.';
    ELSE
        -- Dacă nu există conflicte, facem inserția
		INSERT INTO activitati (id_materii_activitati, nr_participanti_activitate, descriere, ziua, ora, nr_max_participanti, id_profesor_activitate, procent) VALUES
    (materieID, 0, var_descriere, var_ziua, var_ora, var_nr_max_participanti, profID, 0);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ResetAutoIncrement` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ResetAutoIncrement`()
BEGIN
    DECLARE next_auto_increment INT;

    -- Get MAX(user_id) + 1
    SELECT IFNULL(MAX(user_id), 0) + 1 INTO next_auto_increment FROM utilizatori;

    -- Set AUTO_INCREMENT to the next value
    SET @sql = CONCAT('ALTER TABLE utilizatori AUTO_INCREMENT = ', next_auto_increment);
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SelectActivitatiProfesor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectActivitatiProfesor`(
    IN profID INT,
    IN materieID INT
)
BEGIN
    SELECT 
        a.id_activitati AS ActivitateID,
        a.descriere AS Descriere,
        a.ziua AS Ziua,
        a.ora AS Ora
    FROM activitati a
    WHERE a.id_profesor_activitate = profID
      AND a.id_materii_activitati = materieID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SelecteazaMesajeGrup` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelecteazaMesajeGrup`(
    IN grupID INT
)
BEGIN
    SELECT 
        u.nume AS NumeStudent,
        u.prenume AS PrenumeStudent,
        m.mesaj AS Mesaj
    FROM mesaje m
    JOIN studenti s ON m.student_id_mesaj = s.student_id
    JOIN utilizatori u ON s.student_id_user = u.user_id
    WHERE m.id_grup_mesaj = grupID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SelecteazaProfesor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelecteazaProfesor`(
    IN materieID INT,
    IN studentID INT
)
BEGIN
    SELECT 
        p.profesor_id AS ProfesorID,
        u.nume AS Nume,
        u.prenume AS Prenume
    FROM studenti_profesori sp
    JOIN profesori p ON sp.id_profesor = p.profesor_id
    JOIN utilizatori u ON p.profesor_id_user = u.user_id
    WHERE sp.id_student = studentID
      AND p.id_profesor_materie = materieID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SelecteazaStudentiProfesor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelecteazaStudentiProfesor`(
    IN profesor_id INT
)
BEGIN
    SELECT 
        s.student_id,
        u.nume AS Nume,
        u.prenume AS Prenume,
        MAX(CASE WHEN a.descriere = 'Seminar' THEN c.nota_activitate ELSE NULL END) AS Nota_Seminar,
        MAX(CASE WHEN a.descriere = 'Laborator' THEN c.nota_activitate ELSE NULL END) AS Nota_Laborator,
        MAX(CASE WHEN a.descriere = 'Curs' THEN c.nota_activitate ELSE NULL END) AS Nota_Curs
    FROM 
        studenti s
    JOIN 
        utilizatori u ON s.student_id_user = u.user_id
    JOIN 
        studenti_profesori sp ON s.student_id = sp.id_student
    JOIN 
        calendar c ON s.student_id = c.student_id_calendar
    JOIN 
        activitati a ON c.activitate_id_calendar = a.id_activitati
    WHERE 
        sp.id_profesor = profesor_id
        AND a.id_profesor_activitate = profesor_id -- Filtrare pentru activitățile profesorului
    GROUP BY 
        s.student_id, u.nume, u.prenume;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SetareNoteStudent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SetareNoteStudent`(
    IN nota_seminar DOUBLE,
    IN nota_curs DOUBLE,
    IN nota_lab DOUBLE,
    IN profID INT,
    IN studentID INT,
    IN id_materie INT
)
BEGIN
    -- Actualizează notele activităților în tabela 'calendar'
    UPDATE calendar c
    JOIN activitati a ON c.activitate_id_calendar = a.id_activitati
    SET c.nota_activitate = CASE
        WHEN LOWER(a.descriere) LIKE '%seminar%' THEN nota_seminar
        WHEN LOWER(a.descriere) LIKE '%curs%' THEN nota_curs
        WHEN LOWER(a.descriere) LIKE '%laborator%' THEN nota_lab
        ELSE c.nota_activitate -- Păstrează valoarea existentă dacă nu există o descriere relevantă
    END
    WHERE c.student_id_calendar = studentID
    AND a.id_materii_activitati = id_materie
    AND a.id_profesor_activitate = profID;

    -- Calculează și actualizează nota finală în tabela 'catalog'
    UPDATE catalog c
    JOIN studenti s ON c.id_student_catalog = s.student_id
    SET c.nota = ROUND((
        SELECT SUM(cal.nota_activitate * (IFNULL(a.procent, 0) / 100))
        FROM calendar cal
        JOIN activitati a ON cal.activitate_id_calendar = a.id_activitati
        WHERE cal.student_id_calendar = studentID
        AND a.id_materii_activitati = id_materie
        AND a.id_profesor_activitate = profID
    ), 2)
    WHERE c.id_student_catalog = studentID
    AND c.id_materie_catalog = id_materie;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SeteazaProcenteActivitatiProfesor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SeteazaProcenteActivitatiProfesor`(
    IN p_profesor_id INT,
    IN p_procent_curs DOUBLE,
    IN p_procent_seminar DOUBLE,
    IN p_procent_laborator DOUBLE
)
BEGIN
    -- Setează procentul pentru toate cursurile profesorului
    UPDATE activitati
    SET procent = p_procent_curs
    WHERE id_profesor_activitate = p_profesor_id
      AND descriere = 'curs';
 
    -- Setează procentul pentru toate seminariile profesorului
    UPDATE activitati
    SET procent = p_procent_seminar
    WHERE id_profesor_activitate = p_profesor_id
      AND descriere = 'seminar';
 
    -- Setează procentul pentru toate laboratoarele profesorului
    UPDATE activitati
    SET procent = p_procent_laborator
    WHERE id_profesor_activitate = p_profesor_id
      AND descriere = 'laborator';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `StudentInscriereMaterie` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `StudentInscriereMaterie`(IN studentID INT, IN materieID INT)
BEGIN
	DECLARE selected_professor INT;
    
	INSERT INTO catalog (id_materie_catalog, id_student_catalog) VALUES
    (materieID, studentID);
    
    SELECT profesor_id
    INTO selected_professor
    FROM Profesori
    WHERE id_profesor_materie = materieID
      AND numar_curent_studenti < nr_max_studenti
    ORDER BY numar_curent_studenti ASC
    LIMIT 1;
    
    -- Dacă a fost găsit un profesor disponibil, actualizează numărul curent de studenți
    IF selected_professor IS NOT NULL THEN
        UPDATE Profesori
        SET numar_curent_studenti = numar_curent_studenti + 1
        WHERE profesor_id = selected_professor;
	END IF;
    
    INSERT INTO studenti_profesori(id_student, id_profesor) VALUES
    (studentID, selected_professor);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `StudentRenuntareMaterie` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `StudentRenuntareMaterie`(IN studentID INT,IN materieID INT)
BEGIN
    DECLARE profesorID INT;

    -- 1. Șterge din catalog notele studentului pentru materia respectivă
    DELETE FROM catalog
    WHERE id_student_catalog = studentID
      AND id_materie_catalog = materieID;

    -- 2. Scade nr_participanti_activitate pentru activitățile asociate studentului
    UPDATE activitati a
    JOIN calendar c ON a.id_activitati = c.activitate_id_calendar
    SET a.nr_participanti_activitate = a.nr_participanti_activitate - 1
    WHERE c.student_id_calendar = studentID
      AND a.id_materii_activitati = materieID;

    -- 3. Șterge activitățile din calendar pentru student legate de materia respectivă
    DELETE c
    FROM calendar c
    JOIN activitati a ON c.activitate_id_calendar = a.id_activitati
    WHERE c.student_id_calendar = studentID
      AND a.id_materii_activitati = materieID;

    -- 4. Identifică profesorul asociat materiei și studentului
    -- Obține profesorID pentru student, legat de materia respectivă
	SELECT sp.id_profesor
	INTO profesorID
	FROM studenti_profesori sp
	JOIN profesori p ON sp.id_profesor = p.profesor_id
	WHERE sp.id_student = studentID AND p.id_profesor_materie = materieID
	LIMIT 1;

    -- 5. Scade numar_curent_studenti pentru profesorul respectiv
    UPDATE profesori
    SET numar_curent_studenti = numar_curent_studenti - 1
    WHERE profesor_id = profesorID;
    
    -- 6. Sterge din studenti_profesori
    DELETE FROM studenti_profesori
    WHERE id_student = studentID AND id_profesor = profesorID;
    
	-- 7. Șterge studentul din grup_studiu_studenti pentru grupurile asociate materiei
    DELETE gss
    FROM grup_studiu_studenti gss
    JOIN grup_studiu gs ON gss.id_grup = gs.id_grup
    WHERE gss.id_student = studentID
      AND gs.id_materie = materieID;

    -- 8. Actualizează numărul curent de participanți pentru activitățile asociate grupurilor
    UPDATE grup_activitati ga
    JOIN grup_activitati_studenti gas ON ga.id_activitate_grup = gas.id_activitate_grup
    JOIN grup_studiu gs ON ga.id_grup = gs.id_grup
    SET ga.nr_curent_participanti = ga.nr_curent_participanti - 1
    WHERE gas.id_student = studentID
      AND gs.id_materie = materieID;

    -- 9. Șterge studentul din grup_activitati_studenti pentru activitățile asociate materiei
    DELETE gas
    FROM grup_activitati_studenti gas
    JOIN grup_activitati ga ON gas.id_activitate_grup = ga.id_activitate_grup
    JOIN grup_studiu gs ON ga.id_grup = gs.id_grup
    WHERE gas.id_student = studentID
      AND gs.id_materie = materieID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TrimiteMesaj` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TrimiteMesaj`(
    IN studentID INT,
    IN mesaj VARCHAR(100),
    IN grupID INT
)
BEGIN
	INSERT INTO mesaje (id_grup_mesaj, student_id_mesaj, mesaj) VALUES
    (grupID, studentID, mesaj);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `VeziActivitatiGrup` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `VeziActivitatiGrup`(IN grupID int)
BEGIN
	SELECT
		grup_activitati.id_activitate_grup AS ID_activitate, 
        grup_activitati.id_grup AS ID_grup, 
        grup_activitati.nr_curent_participanti AS Nr_curent_participanti, 
        grup_activitati.nr_min_participanti AS Nr_min_participanti, 
        grup_activitati.ziua_calendaristica AS Ziua, 
        grup_activitati.ora AS Ora, 
        grup_activitati.descriere AS Descriere, 
        grup_activitati.durata AS Durata, 
		grup_activitati.timp_expirare AS Timp_expirare
    FROM grup_activitati
    JOIN grup_studiu ON grup_activitati.id_grup = grup_studiu.id_grup
    WHERE grup_activitati.id_grup = grupID AND grup_activitati.status_activitate=1 
			AND TIMESTAMP(grup_activitati.ziua_calendaristica, grup_activitati.ora) > NOW();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `VeziMembriGrup` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `VeziMembriGrup`(IN grupID int)
BEGIN
	SELECT 
    u.nume AS Nume,
    u.prenume AS Prenume
FROM 
    grup_studiu_studenti gss
JOIN 
    studenti s ON gss.id_student = s.student_id
JOIN 
    utilizatori u ON s.student_id_user = u.user_id
WHERE 
    gss.id_grup = grupID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `VeziProfesoriMaterie` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `VeziProfesoriMaterie`(IN materieID INT)
BEGIN
    SELECT 
        u.nume AS Nume,
        u.prenume AS Prenume,
        u.email AS Email
    FROM 
        profesori p
    JOIN 
        utilizatori u ON p.profesor_id_user = u.user_id
    JOIN 
        materii m ON p.id_profesor_materie = m.id_materii
    WHERE 
        m.id_materii = materieID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `VeziStudentiMaterie` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `VeziStudentiMaterie`(IN materieID INT)
BEGIN
    SELECT 
        u.nume AS Nume,
        u.prenume AS Prenume,
        u.email AS Email
    FROM 
        studenti s
    JOIN 
        utilizatori u ON s.student_id_user = u.user_id
    JOIN 
        catalog c ON c.id_student_catalog = s.student_id
    WHERE 
       c.id_materie_catalog=materieID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `view_profesor`
--

/*!50001 DROP VIEW IF EXISTS `view_profesor`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_profesor` AS select `u`.`user_id` AS `user_id`,`p`.`id_profesor_materie` AS `id_profesor_materie`,`u`.`CNP` AS `CNP`,`u`.`nume` AS `nume`,`u`.`prenume` AS `prenume`,`u`.`NumarTelefon` AS `NumarTelefon`,`u`.`Adresa` AS `Adresa`,`u`.`IBAN` AS `IBAN`,`u`.`email` AS `email`,`u`.`Nr_contract` AS `Nr_contract`,`p`.`profesor_id` AS `profesor_id`,`p`.`nr_max_ore` AS `nr_max_ore`,`p`.`nr_min_ore` AS `nr_min_ore`,`p`.`departament` AS `departament`,`p`.`nr_max_studenti` AS `nr_max_studenti` from (`utilizatori` `u` join `profesori` `p` on((`u`.`user_id` = `p`.`profesor_id_user`))) where (`u`.`Rol_id` = 2) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_studenti`
--

/*!50001 DROP VIEW IF EXISTS `view_studenti`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_studenti` AS select `u`.`user_id` AS `user_id`,`s`.`student_id` AS `student_id`,`u`.`CNP` AS `CNP`,`u`.`nume` AS `nume`,`u`.`prenume` AS `prenume`,`u`.`NumarTelefon` AS `NumarTelefon`,`u`.`Adresa` AS `adresa`,`u`.`IBAN` AS `IBAN`,`u`.`email` AS `email`,`u`.`Nr_contract` AS `Nr_contract`,`s`.`an_de_studiu` AS `an_de_studiu`,`s`.`numar_ore_sustinute` AS `numar_ore_sustinute` from (`utilizatori` `u` join `studenti` `s` on((`u`.`user_id` = `s`.`student_id_user`))) where (`u`.`Rol_id` = 3) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_studenti_note`
--

/*!50001 DROP VIEW IF EXISTS `view_studenti_note`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_studenti_note` AS select `s`.`student_id` AS `student_id`,`u`.`nume` AS `nume`,`u`.`prenume` AS `prenume`,`c`.`nota` AS `nota` from ((`studenti` `s` join `utilizatori` `u` on((`u`.`user_id` = `s`.`student_id_user`))) join `catalog` `c` on((`c`.`id_student_catalog` = `s`.`student_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-19 19:00:50
