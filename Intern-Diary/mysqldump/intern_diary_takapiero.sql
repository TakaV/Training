-- MySQL dump 10.13  Distrib 5.5.20, for osx10.6 (i386)
--
-- Host: localhost    Database: intern_diary_takapiero
-- ------------------------------------------------------
-- Server version	5.5.20

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
-- Table structure for table `entry`
--

DROP TABLE IF EXISTS `entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entry` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `title` varbinary(255) NOT NULL,
  `body` blob NOT NULL,
  `is_deleted` tinyint(4) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`,`is_deleted`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entry`
--

LOCK TABLES `entry` WRITE;
/*!40000 ALTER TABLE `entry` DISABLE KEYS */;
INSERT INTO `entry` VALUES (1,1,'初めての日記','音楽に興味があります！みんなコメントして欲しいです！',0,'2012-10-12 17:49:22','2012-10-12 17:49:22'),(2,2,'初めての日記','音楽に興味があります！みんなコメントして欲しいです！',0,'2012-10-12 17:52:06','2012-10-12 17:52:06');
/*!40000 ALTER TABLE `entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tutorial_question`
--

DROP TABLE IF EXISTS `tutorial_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tutorial_question` (
  `id` int(10) unsigned NOT NULL,
  `category` int(10) unsigned NOT NULL,
  `title` varbinary(255) NOT NULL,
  `description` varbinary(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tutorial_question`
--

LOCK TABLES `tutorial_question` WRITE;
/*!40000 ALTER TABLE `tutorial_question` DISABLE KEYS */;
INSERT INTO `tutorial_question` VALUES (1001,1,'質問1','今日の朝食は何を食べましたか？'),(1002,1,'質問1','昨日の夕食は何を食べましたか？'),(2001,2,'質問2','音楽は好きですか？'),(2002,2,'質問2','読書は好きですか？'),(3001,3,'質問3','あだ名を教えてください'),(3002,3,'質問3','好きな食べ物を教えてください');
/*!40000 ALTER TABLE `tutorial_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varbinary(32) NOT NULL,
  `tutorial_step` int(10) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'takapiero',99,'2012-10-12 17:49:07','2012-10-12 17:49:22'),(2,'kondo',99,'2012-10-12 17:52:02','2012-10-12 17:52:06');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_tutorial_question_log`
--

DROP TABLE IF EXISTS `user_tutorial_question_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_tutorial_question_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `question_id` int(10) unsigned NOT NULL,
  `answer_id` int(10) unsigned DEFAULT NULL,
  `answer_text` varbinary(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`question_id`),
  KEY `user_id_2` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_tutorial_question_log`
--

LOCK TABLES `user_tutorial_question_log` WRITE;
/*!40000 ALTER TABLE `user_tutorial_question_log` DISABLE KEYS */;
INSERT INTO `user_tutorial_question_log` VALUES (1,1,1,2,'','2012-10-12 17:49:21'),(2,1,7,0,'音楽に興味があります！みんなコメントして欲しいです！','2012-10-12 17:49:22'),(3,1,4,1,'','2012-10-12 17:49:22'),(4,2,1,2,'','2012-10-12 17:52:06'),(5,2,4,1,'','2012-10-12 17:52:06'),(6,2,7,0,'音楽に興味があります！みんなコメントして欲しいです！','2012-10-12 17:52:06');
/*!40000 ALTER TABLE `user_tutorial_question_log` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-10-12 17:55:08
