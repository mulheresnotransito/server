# ************************************************************
# Sequel Pro SQL dump
# Versão 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.32)
# Base de Dados: db_mnt
# Tempo de Geração: 2021-05-06 18:46:31 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump da tabela available_times
# ------------------------------------------------------------

DROP TABLE IF EXISTS `available_times`;

CREATE TABLE `available_times` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` varchar(50) NOT NULL DEFAULT '0',
  `id_default_time` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `available_times` WRITE;
/*!40000 ALTER TABLE `available_times` DISABLE KEYS */;

INSERT INTO `available_times` (`id`, `id_user`, `id_default_time`)
VALUES
	(1,'3','1'),
	(2,'3','2'),
	(3,'3','3'),
	(4,'3','8'),
	(5,'3','9');

/*!40000 ALTER TABLE `available_times` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela cancellations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cancellations`;

CREATE TABLE `cancellations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user_client` varchar(50) NOT NULL DEFAULT '0',
  `id_lesson` varchar(50) DEFAULT '0',
  `text` varchar(10000) NOT NULL DEFAULT '0',
  `id_consultation` varchar(50) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `cancellations` WRITE;
/*!40000 ALTER TABLE `cancellations` DISABLE KEYS */;

INSERT INTO `cancellations` (`id`, `id_user_client`, `id_lesson`, `text`, `id_consultation`)
VALUES
	(1,'14','201','Dfsdfsdfs','0'),
	(2,'1','225','Qualquer um...','0'),
	(3,'1','218','Testando cancelamento','0'),
	(4,'1','218','Testando cancelamento','0'),
	(5,'1','218','Testando cancelamento','0'),
	(6,'1','218','Testando cancelamento','0'),
	(7,'1','227','Adasd','0'),
	(8,'1','223','23423','0'),
	(9,'1','224','Kjh','0'),
	(10,'1','229','Asd','0'),
	(11,'1','222','Dsds','0'),
	(12,'1','217','34545','0'),
	(13,'1','226','1231231','0'),
	(14,'1','220','Sdssd','0'),
	(15,'1','230','Asdas','0'),
	(16,'1','236','Teste','0'),
	(17,'1','235','Teste 2','0'),
	(18,'1','238','23423','0'),
	(19,'1','237','123213','0'),
	(20,'1','239','Dsfsdds','0'),
	(21,'1','240','Sdfsd','0'),
	(22,'1','243','213','0'),
	(23,'1','242','1232','0'),
	(24,'1','241','123123','0'),
	(25,'1','0','12312','5'),
	(26,'1','0','Asdsds','4'),
	(27,'1','0','213123swaad','3'),
	(28,'1','0','Teste','2'),
	(29,'1','0','123231','1'),
	(30,'1','0','Asasd','6'),
	(31,'1','245','Gggggg','0'),
	(32,'1','246','hshahahxkjdhaix','0'),
	(33,'1','244','hshahahxksi','0'),
	(34,'1','247','hdhsha','0');

/*!40000 ALTER TABLE `cancellations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela cars
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cars`;

CREATE TABLE `cars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model` varchar(200) DEFAULT '0',
  `license_plate` varchar(200) DEFAULT '0',
  `brand` varchar(200) DEFAULT '0',
  `id_user` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `cars` WRITE;
/*!40000 ALTER TABLE `cars` DISABLE KEYS */;

INSERT INTO `cars` (`id`, `model`, `license_plate`, `brand`, `id_user`)
VALUES
	(1,'HB20','AAA-2020','Hyundai',3),
	(2,'Onix','AAA-1234','Chevrolet',9),
	(3,'Onix Plus','BBB-1234','Chevrolet',8);

/*!40000 ALTER TABLE `cars` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela consultations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `consultations`;

CREATE TABLE `consultations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(1000) DEFAULT NULL,
  `id_user_client` int(11) NOT NULL,
  `id_user_psychologist` int(11) NOT NULL,
  `date` varchar(100) NOT NULL,
  `updated_at` varchar(100) NOT NULL,
  `status` varchar(50) NOT NULL,
  `id_default_time` varchar(11) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `consultations` WRITE;
/*!40000 ALTER TABLE `consultations` DISABLE KEYS */;

INSERT INTO `consultations` (`id`, `description`, `id_user_client`, `id_user_psychologist`, `date`, `updated_at`, `status`, `id_default_time`)
VALUES
	(1,'description test...',1,2,'15/05/2021','Thu May 06 2021 10:57:17 GMT-0300 (Horário Padrão de Brasília)','canceled','1'),
	(2,'Consulta 02',1,2,'15/05/2021','Thu May 06 2021 10:53:48 GMT-0300 (Horário Padrão de Brasília)','canceled','2'),
	(3,'description test...',1,2,'15/05/2021','Thu May 06 2021 10:32:40 GMT-0300 (Horário Padrão de Brasília)','canceled','3'),
	(4,'consultation test',1,2,'15/05/2021','Thu May 06 2021 10:32:21 GMT-0300 (Horário Padrão de Brasília)','canceled','4'),
	(5,'consultation test 2',1,2,'15/05/2021','Thu May 06 2021 10:31:51 GMT-0300 (Horário Padrão de Brasília)','canceled','5'),
	(6,'consultation test 2',1,2,'15/05/2021','Thu May 06 2021 14:34:06 GMT-0300 (Horário Padrão de Brasília)','canceled','6');

/*!40000 ALTER TABLE `consultations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela credits
# ------------------------------------------------------------

DROP TABLE IF EXISTS `credits`;

CREATE TABLE `credits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user_client` int(11) NOT NULL,
  `credit_classes` int(100) NOT NULL,
  `credit_consultations` int(100) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

LOCK TABLES `credits` WRITE;
/*!40000 ALTER TABLE `credits` DISABLE KEYS */;

INSERT INTO `credits` (`id`, `id_user_client`, `credit_classes`, `credit_consultations`)
VALUES
	(1,1,3,5);

/*!40000 ALTER TABLE `credits` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela default_times
# ------------------------------------------------------------

DROP TABLE IF EXISTS `default_times`;

CREATE TABLE `default_times` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `initial_hour` varchar(50) NOT NULL DEFAULT '0',
  `end_hour` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `default_times` WRITE;
/*!40000 ALTER TABLE `default_times` DISABLE KEYS */;

INSERT INTO `default_times` (`id`, `initial_hour`, `end_hour`)
VALUES
	(1,'07:00','07:50'),
	(2,'07:50','08:40'),
	(3,'08:40','09:30'),
	(4,'09:30','10:20'),
	(5,'10:20','11:10'),
	(7,'11:10','12:00'),
	(8,'12:00','12:50'),
	(9,'12:50','13:40'),
	(10,'13:40','14:30'),
	(11,'14:30','15:20'),
	(12,'15:20','16:10'),
	(6,'16:10','17:00'),
	(23,'17:00','17:50'),
	(24,'17:50','18:40');

/*!40000 ALTER TABLE `default_times` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela feedbacks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `feedbacks`;

CREATE TABLE `feedbacks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user_from` varchar(50) NOT NULL DEFAULT '0',
  `id_user_to` varchar(50) NOT NULL DEFAULT '0',
  `text` varchar(10000) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump da tabela lessons
# ------------------------------------------------------------

DROP TABLE IF EXISTS `lessons`;

CREATE TABLE `lessons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(1000) DEFAULT NULL,
  `id_user_client` int(11) NOT NULL,
  `id_user_driver` int(11) NOT NULL,
  `date` varchar(100) NOT NULL,
  `status` varchar(50) NOT NULL,
  `updated_at` varchar(100) NOT NULL,
  `starting_point` varchar(1000) NOT NULL,
  `id_default_time` varchar(11) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `lessons` WRITE;
/*!40000 ALTER TABLE `lessons` DISABLE KEYS */;

INSERT INTO `lessons` (`id`, `description`, `id_user_client`, `id_user_driver`, `date`, `status`, `updated_at`, `starting_point`, `id_default_time`)
VALUES
	(235,NULL,1,8,'07/05/2021','canceled','Thu May 06 2021 08:41:49 GMT-0300 (Horário Padrão de Brasília)','undefined','1'),
	(236,NULL,1,8,'07/05/2021','canceled','Thu May 06 2021 08:41:39 GMT-0300 (Horário Padrão de Brasília)','undefined','2'),
	(237,NULL,1,3,'07/05/2021','canceled','Thu May 06 2021 08:44:20 GMT-0300 (Horário Padrão de Brasília)','undefined','3'),
	(238,NULL,1,3,'07/05/2021','canceled','Thu May 06 2021 08:43:41 GMT-0300 (Horário Padrão de Brasília)','undefined','4'),
	(239,NULL,1,9,'07/05/2021','canceled','Thu May 06 2021 08:45:25 GMT-0300 (Horário Padrão de Brasília)','undefined','4'),
	(240,NULL,1,8,'07/05/2021','canceled','Thu May 06 2021 08:47:26 GMT-0300 (Horário Padrão de Brasília)','undefined','4'),
	(241,NULL,1,3,'07/05/2021','canceled','Thu May 06 2021 08:48:04 GMT-0300 (Horário Padrão de Brasília)','undefined','1'),
	(242,NULL,1,9,'07/05/2021','canceled','Thu May 06 2021 08:47:58 GMT-0300 (Horário Padrão de Brasília)','undefined','2'),
	(243,NULL,1,8,'07/05/2021','canceled','Thu May 06 2021 08:47:50 GMT-0300 (Horário Padrão de Brasília)','undefined','3'),
	(244,NULL,1,3,'07/05/2021','canceled','Thu May 06 2021 15:40:03 GMT-0300 (Horário Padrão de Brasília)','undefined','2'),
	(245,NULL,1,9,'07/05/2021','canceled','Thu May 06 2021 15:38:07 GMT-0300 (Horário Padrão de Brasília)','undefined','1'),
	(246,NULL,1,9,'07/05/2021','canceled','Thu May 06 2021 15:39:54 GMT-0300 (Horário Padrão de Brasília)','undefined','3'),
	(247,NULL,1,9,'08/05/2021','canceled','Thu May 06 2021 15:40:32 GMT-0300 (Horário Padrão de Brasília)','undefined','5');

/*!40000 ALTER TABLE `lessons` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela notices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `notices`;

CREATE TABLE `notices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(1000) NOT NULL DEFAULT '0',
  `text` longtext NOT NULL,
  `description` longtext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `notices` WRITE;
/*!40000 ALTER TABLE `notices` DISABLE KEYS */;

INSERT INTO `notices` (`id`, `title`, `text`, `description`)
VALUES
	(1,'Notícia teste 1','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the indust'),
	(2,'Notícia teste 2','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the indust'),
	(3,'Notícia teste 3','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the indust'),
	(4,'Notícia teste 4','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the indust'),
	(5,'Notícia teste 5','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the indust'),
	(6,'Notícia teste 6','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the indust'),
	(7,'Notícia teste 7','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.','asdasdasdas');

/*!40000 ALTER TABLE `notices` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela payments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `payments`;

CREATE TABLE `payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user_client` int(11) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `value` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump da tabela users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `birthday` varchar(100) NOT NULL,
  `sex` varchar(100) NOT NULL,
  `language` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  `is_client` tinyint(1) DEFAULT '0',
  `is_psychologist` tinyint(1) DEFAULT '0',
  `is_driver` tinyint(1) DEFAULT '0',
  `is_logged` varchar(50) DEFAULT '0',
  `classes_credits` varchar(50) DEFAULT '0',
  `consultations_credits` varchar(50) DEFAULT '0',
  `profile_photo` varchar(100) NOT NULL DEFAULT '',
  `balance` varchar(50) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password`, `birthday`, `sex`, `language`, `country`, `is_client`, `is_psychologist`, `is_driver`, `is_logged`, `classes_credits`, `consultations_credits`, `profile_photo`, `balance`)
VALUES
	(1,'Joana','Maria','cliente@teste','123','07/09/1998','male','portuguese','brazil',1,0,0,'true','24','12','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG','0'),
	(2,'Marta','Vieira','psicologa@teste','123','01/01/1990','female','portuguese','brazil',0,1,0,'false','44','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG','0'),
	(3,'Bianca','Silva','motorista@teste','123','01/01/1990','male','portuguese','brazil',0,0,1,'false','2','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG','0'),
	(8,'teste','teste','teste','teste','07/09/1998','male','portuguese','brazil',1,1,1,'true','10','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG','0'),
	(9,'Maria','Saramalho','maria@mnt.com','123','01/01/1990','female','portuguese','brazil',0,0,1,'false','4','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG','0'),
	(10,'undefined','undefined','caio@caio.com','123','undefined','undefined','undefined','undefined',1,0,0,NULL,'33','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG','0'),
	(11,'caio','caio','caio','123','07/09','male','portuguese','brazil',1,0,0,'true','22','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG','0'),
	(12,'A','a','A','A','undefined','undefined','undefined','undefined',1,0,0,'true','11','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG','0'),
	(13,'E','e','E','E','undefined','undefined','undefined','undefined',1,0,0,NULL,'0','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG','0'),
	(14,'D','d','D','D','undefined','undefined','undefined','undefined',1,0,0,'true','128','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG','0'),
	(15,'G','g','G','G','undefined','undefined','undefined','undefined',1,0,0,NULL,'0','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG','0'),
	(16,'Gd','d','Gd','Gd','undefined','undefined','undefined','undefined',1,0,0,NULL,'0','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG','0'),
	(17,'F','F','F','f','undefined','undefined','undefined','undefined',1,0,0,'true','0','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG','0'),
	(18,'Psychologist','Temporary','F','f','undefined','undefined','undefined','undefined',0,1,0,'true','0','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG','0'),
	(19,'Psychologist','Temporary','F','f','undefined','undefined','undefined','undefined',0,1,0,'true','0','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG','0'),
	(20,'Psychologist','Temporary','F','f','undefined','undefined','undefined','undefined',0,1,0,'true','0','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG','0'),
	(21,'Psychologist','Temporary','F','f','undefined','undefined','undefined','undefined',0,1,0,'true','0','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG','0'),
	(22,'Psychologist','Temporary','F','f','undefined','undefined','undefined','undefined',0,1,0,'true','0','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG','0'),
	(23,'Psychologist','Temporary','F','f','undefined','undefined','undefined','undefined',0,1,0,'true','0','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG','0'),
	(24,'Psychologist','Temporary','F','f','undefined','undefined','undefined','undefined',0,1,0,'true','0','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG','0'),
	(25,'Psychologist','Temporary','F','f','undefined','undefined','undefined','undefined',0,1,0,'true','0','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG','0'),
	(26,'Psychologist','Temporary','F','f','undefined','undefined','undefined','undefined',0,1,0,'true','0','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG','0'),
	(27,'Psychologist','Temporary','F','f','undefined','undefined','undefined','undefined',0,1,0,'true','0','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG','0'),
	(28,'Psychologist','Temporary','F','f','undefined','undefined','undefined','undefined',0,1,0,'true','0','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG','0'),
	(29,'Psychologist','Temporary','F','f','undefined','undefined','undefined','undefined',0,1,0,'true','0','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG','0'),
	(30,'Psychologist','Temporary','F','f','undefined','undefined','undefined','undefined',0,1,0,'true','0','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG','0'),
	(31,'Psychologist','Temporary','F','f','undefined','undefined','undefined','undefined',0,1,0,'true','0','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG','0'),
	(32,'Psychologist','Temporary','F','f','undefined','undefined','undefined','undefined',0,1,0,'true','0','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG','0');

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
