-- MySQL dump 10.13  Distrib 5.6.25, for Win32 (x86)
--
-- Host: localhost    Database: LostAndFound
-- ------------------------------------------------------
-- Server version	5.6.25-log

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
-- Table structure for table `academy`
--

DROP TABLE IF EXISTS `academy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `academy` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Academy ID 自增',
  `AcademyCode` varchar(8) NOT NULL COMMENT '二级学院代码',
  `AcademyName` varchar(30) NOT NULL COMMENT '二级学院名称',
  `SchoolCode` varchar(10) NOT NULL COMMENT '所属学校代码  （外键）',
  PRIMARY KEY (`ID`),
  KEY `SchoolCode` (`SchoolCode`),
  CONSTRAINT `academy_ibfk_1` FOREIGN KEY (`SchoolCode`) REFERENCES `school` (`SchoolCode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academy`
--

LOCK TABLES `academy` WRITE;
/*!40000 ALTER TABLE `academy` DISABLE KEYS */;
INSERT INTO `academy` VALUES (1,'14','信息工程学院','10684');
/*!40000 ALTER TABLE `academy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classes`
--

DROP TABLE IF EXISTS `classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classes` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Classes ID 自增',
  `ClassNo` varchar(10) NOT NULL COMMENT '班级编号',
  `Major` varchar(30) NOT NULL COMMENT '专业',
  `AcademyCode` varchar(8) NOT NULL COMMENT '所属二级学院代码 (外键）',
  PRIMARY KEY (`ID`),
  KEY `ClassNo` (`ClassNo`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classes`
--

LOCK TABLES `classes` WRITE;
/*!40000 ALTER TABLE `classes` DISABLE KEYS */;
INSERT INTO `classes` VALUES (1,'20131432','软件工程','14');
/*!40000 ALTER TABLE `classes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loginlog`
--

DROP TABLE IF EXISTS `loginlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `loginlog` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '登录日志ID',
  `UserName` varchar(12) NOT NULL COMMENT '用户名',
  `OSName` varchar(30) DEFAULT NULL COMMENT '操作系统',
  `BrowserName` varchar(30) DEFAULT NULL COMMENT '浏览器',
  `LoginIp` varchar(30) NOT NULL COMMENT '登录IP',
  `LoginTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '登录时间',
  `UID` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_loginlog` (`UID`),
  CONSTRAINT `fk_loginlog` FOREIGN KEY (`UID`) REFERENCES `user` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loginlog`
--

LOCK TABLES `loginlog` WRITE;
/*!40000 ALTER TABLE `loginlog` DISABLE KEYS */;
INSERT INTO `loginlog` VALUES (1,'2013143216','Windows 7 ','Chrome 56.0.2924','127.0.0.1','2017-03-09 07:12:57',4),(2,'2013143218','Windows 7 ','Chrome 55.0.2883','127.0.0.1','2017-03-09 05:13:00',1),(3,'2013143218','Windows 7 ','Chrome 55.0.2883','127.0.0.1','2017-03-09 09:23:42',1),(4,'2013031308','Windows 7 ','Firefox 51.0','127.0.0.1','2017-03-09 09:50:57',2),(5,'2013143218','Windows 7 ','Chrome 55.0.2883','127.0.0.1','2017-03-09 12:00:57',1),(6,'2013143218','Windows 7 ','Chrome 55.0.2883','127.0.0.1','2017-03-09 12:39:26',1),(13,'2013143217','Windows 7 ','IE 7.0','127.0.0.1','2017-03-10 15:48:52',5),(14,'2013143218','Windows 7 ','Chrome 55.0.2883','127.0.0.1','2017-03-11 09:02:12',1),(15,'2013143217','Windows 7 ','Chrome 55.0.2883','127.0.0.1','2017-03-11 09:27:05',5),(16,'2013143217','Windows 7 ','Chrome 55.0.2883','127.0.0.1','2017-03-11 10:18:20',5),(22,'2013143218','Windows 7 ','Chrome 56.0.2924','127.0.0.1','2017-03-14 12:35:15',1),(23,'2013143218','Windows 7 ','Chrome 56.0.2924','127.0.0.1','2017-03-19 09:25:49',1),(24,'2013143218','Windows 7 ','Chrome 56.0.2924','127.0.0.1','2017-03-19 09:48:40',1),(25,'2013143218','Windows 7 ','Chrome 55.0.2883','127.0.0.1','2017-03-21 11:26:41',1),(26,'2013143218','Windows 7 ','Chrome 55.0.2883','127.0.0.1','2017-03-21 12:56:56',1),(27,'2013143216','Windows 7 ','Chrome 45.0.2454','127.0.0.1','2017-03-21 13:03:13',4),(28,'2013143218','Windows 7 ','Chrome 55.0.2883','127.0.0.1','2017-03-22 15:25:42',1),(29,'2013143218','Windows 7 ','Chrome 55.0.2883','127.0.0.1','2017-03-22 15:39:50',1),(30,'2013143218','Windows 7 ','Chrome 55.0.2883','127.0.0.1','2017-03-22 16:46:08',1),(31,'2013143218','Windows 7 ','Chrome 55.0.2883','127.0.0.1','2017-03-27 07:56:36',1),(32,'2013143218','Windows 7 ','Chrome 55.0.2883','127.0.0.1','2017-03-28 08:30:35',1),(33,'2013143218','Windows 7 ','Chrome 55.0.2883','127.0.0.1','2017-03-28 11:44:04',1),(34,'2013143218','Windows 7 ','Chrome 55.0.2883','127.0.0.1','2017-03-28 12:31:56',1),(35,'2013143218','Windows 7 ','Chrome 55.0.2883','127.0.0.1','2017-03-28 13:58:51',1),(36,'2013143218','Windows 7 ','Chrome 55.0.2883','127.0.0.1','2017-03-30 04:28:49',1);
/*!40000 ALTER TABLE `loginlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lostthings`
--

DROP TABLE IF EXISTS `lostthings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lostthings` (
  `ID` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'LostThings ID 自增',
  `ThingsName` varchar(30) NOT NULL COMMENT '物品名称',
  `LostPlace` varchar(30) NOT NULL COMMENT '丢失地点',
  `LostTime` date NOT NULL COMMENT '丢失时间',
  `ThingsType` varchar(15) NOT NULL COMMENT '物品类型',
  `ThingsNo` varchar(10) DEFAULT NULL COMMENT '物品编号 可 null',
  `ThingsImg` text COMMENT '物品图片 可 null',
  `ThingsDes` text NOT NULL COMMENT '物品描述',
  `PublishTime` datetime NOT NULL COMMENT '发布时间',
  `Status` int(11) NOT NULL COMMENT '状态',
  `UID` bigint(20) NOT NULL COMMENT '用户表 ID 外键',
  PRIMARY KEY (`ID`),
  KEY `UID` (`UID`),
  CONSTRAINT `lostthings_ibfk_1` FOREIGN KEY (`UID`) REFERENCES `user` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lostthings`
--

LOCK TABLES `lostthings` WRITE;
/*!40000 ALTER TABLE `lostthings` DISABLE KEYS */;
INSERT INTO `lostthings` VALUES (3,'饭卡','理学楼','2017-01-24','card','122','static\\upload\\lost\\2013143218\\2017\\03\\20161130151920.jpg','ererr','2017-01-24 21:27:29',1,1),(6,'钱包','食堂','2017-03-09','per_eff',NULL,NULL,'钱包','2017-03-11 18:15:33',0,5);
/*!40000 ALTER TABLE `lostthings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menuitem`
--

DROP TABLE IF EXISTS `menuitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menuitem` (
  `ID` int(20) NOT NULL AUTO_INCREMENT,
  `MenuID` varchar(20) NOT NULL,
  `MenuItemName` varchar(20) NOT NULL,
  `MenuItemUrl` varchar(30) DEFAULT NULL,
  `ParentId` varchar(20) DEFAULT NULL,
  `Status` int(11) NOT NULL,
  `MenuItemDes` varchar(30) DEFAULT NULL,
  `Authority` int(11) NOT NULL,
  `Sort` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ParentId` (`ParentId`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menuitem`
--

LOCK TABLES `menuitem` WRITE;
/*!40000 ALTER TABLE `menuitem` DISABLE KEYS */;
INSERT INTO `menuitem` VALUES (1,'user-manager','用户管理',NULL,'-1',1,'用户管理',2,1),(2,'user-info','用户信息',NULL,'user-manager',1,'用户信息',2,1),(3,'user-list','用户列表','/admin/user-list.html','user-info',1,'用户列表',2,1),(4,'things-manager','物品管理','','-1',1,'物品管理',2,2),(5,'things-info','物品信息','','things-manager',1,'物品信息',2,1),(6,'find-list','招领列表','/admin/find-list.html','things-info',1,'招领列表',2,1),(7,'lost-list','寻物列表','/admin/lost-list.html','things-info',1,'寻物列表',2,2),(8,'authority-manager','权限管理',NULL,'-1',1,'权限管理',3,3),(9,'system-setting','系统设置',NULL,'-1',1,'系统设置',2,5),(10,'sys-password','密码',NULL,'system-setting',1,NULL,2,1),(11,'s-pwd','修改密码','/admin/password-list.html','sys-password',1,NULL,2,1),(12,'user-import','用户导入','/admin/user-import.html','user-info',1,'用户导入',2,2),(13,'user-log','用户日志','/admin/user-log.html','user-info',1,'用户日志',3,3),(14,'menu-manager','菜单管理',NULL,'-1',1,'菜单管理',3,4),(15,'menu-list','菜单列表','/admin/menu-list.html','menu-manager',1,'菜单列表',3,1),(16,'authority-list','权限列表','/admin/authority-list.html','authority-manager',1,'权限列表',3,1),(17,'database-backup','数据库备份与还原','/admin/database.html','system-setting',1,NULL,3,2);
/*!40000 ALTER TABLE `menuitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pickthings`
--

DROP TABLE IF EXISTS `pickthings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pickthings` (
  `ID` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'LostThings ID 自增',
  `ThingsName` varchar(30) NOT NULL COMMENT '物品名称',
  `PickPlace` varchar(30) NOT NULL COMMENT '丢失地点',
  `PickTime` date NOT NULL COMMENT '丢失时间',
  `ThingsType` varchar(15) NOT NULL COMMENT '物品类型',
  `ThingsNo` varchar(10) DEFAULT NULL COMMENT '物品编号 可 null',
  `ThingsImg` text COMMENT '物品图片 可 null',
  `ThingsDes` text NOT NULL COMMENT '物品描述',
  `StoragePlace` text COMMENT '暂存地点',
  `PublishTime` datetime DEFAULT NULL COMMENT '发布时间',
  `Status` int(11) NOT NULL COMMENT '状态',
  `UID` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `UID` (`UID`),
  CONSTRAINT `pickthings_ibfk_1` FOREIGN KEY (`UID`) REFERENCES `user` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=234 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pickthings`
--

LOCK TABLES `pickthings` WRITE;
/*!40000 ALTER TABLE `pickthings` DISABLE KEYS */;
INSERT INTO `pickthings` VALUES (1,'校园卡','理学楼','2016-11-30','card','223','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张校园卡',NULL,'2016-11-30 17:27:13',1,2),(45,'校园卡','理学楼','2016-11-30','card','154','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张校园卡',NULL,'2016-11-30 15:20:43',0,1),(47,'校园卡','理学楼','2016-11-30','card','154','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张校园卡',NULL,'2016-11-30 15:20:45',1,1),(52,'校园卡','理学楼','2016-11-30','card','154','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张校园卡',NULL,'2016-11-30 17:36:24',1,2),(85,'饭卡','教学楼','2016-11-25','card','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,'2017-01-30 21:06:33',0,1),(95,'饭卡','教学楼','2016-11-25','card','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,4),(102,'饭卡','教学楼','2016-11-25','book','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,'2017-01-28 21:07:05',0,4),(109,'饭卡','教学楼','2016-11-25','book','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,'2017-01-10 21:07:12',0,1),(117,'饭卡','教学楼','2016-11-25','book','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1),(121,'饭卡','教学楼','2016-11-25','other','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,'2017-02-21 21:07:22',0,1),(124,'饭卡','教学楼','2016-11-25','book','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,'2017-01-30 21:07:27',0,5),(128,'饭卡','教学楼','2016-11-25','other','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1),(134,'饭卡','教学楼','2016-11-25','other','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1),(137,'饭卡','教学楼','2016-11-25','book','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1),(139,'饭卡','教学楼','2016-11-25','other','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,5),(142,'饭卡','教学楼','2016-11-25','book','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1),(148,'饭卡','教学楼','2016-11-25','book','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1),(154,'饭卡','教学楼','2016-11-25','other','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1),(155,'饭卡','教学楼','2016-11-25','book','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1),(169,'饭卡','教学楼','2016-11-25','book','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1),(170,'饭卡','教学楼','2016-11-25','other','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1),(172,'饭卡','教学楼','2016-11-25','book','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1),(176,'饭卡','教学楼','2016-11-25','other','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1),(179,'饭卡','教学楼','2016-11-25','book','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1),(181,'饭卡','教学楼','2016-11-25','other','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1),(184,'饭卡','教学楼','2016-11-25','elec','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1),(186,'饭卡','教学楼','2016-11-25','book','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,4),(190,'饭卡','教学楼','2016-11-25','elec','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1),(191,'饭卡','教学楼','2016-11-25','elec','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,5),(194,'饭卡','教学楼','2016-11-25','book','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1),(195,'饭卡','教学楼','2016-11-25','elec','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1),(199,'饭卡','教学楼','2016-11-25','clo','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,4),(200,'饭卡','教学楼','2016-11-25','elec','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1),(203,'饭卡','教学楼','2016-11-25','clo','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1),(205,'饭卡','教学楼','2016-11-25','elec','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1),(214,'饭卡','教学楼','2016-11-30','clo','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,'2016-11-08 15:21:10',0,1),(220,'饭卡','教学楼','2016-11-30','elec','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,'2016-11-26 17:36:34',0,2),(222,'饭卡','教学楼','2016-11-30','card','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,'2016-11-15 17:34:28',1,1),(224,'饭卡','教学楼','2016-11-30','clo','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,'2016-11-30 17:36:32',0,2),(227,'饭卡','教学楼','2016-11-30','clo','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,'2016-11-28 17:36:30',0,2),(230,'饭卡','教学楼','2016-11-30','clo','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,'2016-11-30 15:26:18',2,2),(231,'钱包','教学楼','2017-01-24','per_eff',NULL,'static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','红色钱包一个','','2017-01-24 20:50:34',0,1),(232,'饭卡','食堂','2017-03-09','card','123','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡','','2017-03-09 17:24:54',0,4),(233,'钱包','理学楼','2017-03-09','per_eff',NULL,'static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','','','2017-03-09 20:02:45',0,1);
/*!40000 ALTER TABLE `pickthings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school`
--

DROP TABLE IF EXISTS `school`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'School ID 自增',
  `SchoolCode` varchar(10) NOT NULL COMMENT '学校代码',
  `SchoolName` varchar(30) NOT NULL COMMENT '学校名称',
  PRIMARY KEY (`ID`),
  KEY `SchoolCode` (`SchoolCode`),
  KEY `ID` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school`
--

LOCK TABLES `school` WRITE;
/*!40000 ALTER TABLE `school` DISABLE KEYS */;
INSERT INTO `school` VALUES (1,'10684','广西民族大学');
/*!40000 ALTER TABLE `school` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student` (
  `StudentNo` varchar(15) NOT NULL COMMENT '学号',
  `StudentName` varchar(16) NOT NULL COMMENT '姓名',
  `ClassNo` varchar(10) NOT NULL COMMENT '班级',
  `Sex` char(2) NOT NULL COMMENT '性别',
  `Birth` date NOT NULL COMMENT '生日',
  `IdCard` char(20) NOT NULL COMMENT '身份证号码',
  `TelPhone` char(12) NOT NULL COMMENT '联系电话',
  PRIMARY KEY (`StudentNo`),
  KEY `pk_classno` (`ClassNo`),
  CONSTRAINT `pk_classno` FOREIGN KEY (`ClassNo`) REFERENCES `classes` (`ClassNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES ('2013143218','黎国林','20131432','1','2017-03-12','1234444','1132324');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `systemlog`
--

DROP TABLE IF EXISTS `systemlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `systemlog` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `systemlog`
--

LOCK TABLES `systemlog` WRITE;
/*!40000 ALTER TABLE `systemlog` DISABLE KEYS */;
/*!40000 ALTER TABLE `systemlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher`
--

DROP TABLE IF EXISTS `teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teacher` (
  `TeacherNo` varchar(10) NOT NULL COMMENT '工号',
  `TeacherName` varchar(16) NOT NULL COMMENT '姓名',
  `Sex` char(2) NOT NULL COMMENT '性别',
  `Birth` date NOT NULL COMMENT '生日',
  `IdCard` char(20) NOT NULL COMMENT '身份证号码',
  `TelPhone` char(12) NOT NULL COMMENT '联系电话',
  PRIMARY KEY (`TeacherNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher`
--

LOCK TABLES `teacher` WRITE;
/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
/*!40000 ALTER TABLE `teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(20) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `Grade` varchar(10) NOT NULL COMMENT '年级',
  `Name` varchar(20) DEFAULT NULL,
  `NickName` varchar(10) DEFAULT NULL,
  `TelPhone` varchar(12) NOT NULL,
  `Email` varchar(30) DEFAULT NULL,
  `QQ` varchar(15) DEFAULT NULL,
  `State` int(11) NOT NULL,
  `CreateTime` date NOT NULL,
  `IsNew` int(11) NOT NULL DEFAULT '0' COMMENT '原始密码（0） 修改后（1）',
  `LastLoginTime` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`,`UserName`),
  UNIQUE KEY `UserName` (`UserName`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'2013143218','5e4e3c59ccfcddc31e54336b8a8b2137','2013',NULL,'LinkMe','15802850670','408320080@qq.com','408320080',2,'2017-02-01',0,NULL),(2,'2013031308','83191f3c855fd8a52ced79d5345083b5','2013',NULL,NULL,'1234567889',NULL,'',1,'2017-02-08',0,NULL),(3,'admin@qq.com','21232f297a57a5a743894a0e4a801fc3','2013',NULL,'系统管理员','1234567889',NULL,'',3,'2017-02-10',0,NULL),(4,'2013143216','cff920327dfabc7862e40c85aea1f844','2013',NULL,NULL,'1234567889',NULL,'',1,'2017-02-07',0,NULL),(5,'2013143217','26e1887d8bde43a1be40d47c7cc911d3','2013',NULL,'李四','1234567889',NULL,'',0,'2017-02-12',0,NULL),(7,'2013143219','99d86f9e4f1f12c3fe173dc4ec7d5243','2013',NULL,NULL,'1234567889',NULL,NULL,1,'2017-03-11',0,NULL),(17,'2013143233','2013143233','2013',NULL,NULL,'2222222525',NULL,NULL,1,'2017-03-14',0,NULL),(19,'2013143213','2013143213','2013',NULL,NULL,'2013143213',NULL,NULL,1,'2017-03-14',0,NULL),(20,'2013143211','2013143211','2013',NULL,NULL,'2013143211',NULL,NULL,1,'2017-03-14',0,NULL),(21,'2013143210','2013143210','2013',NULL,NULL,'2013143210',NULL,NULL,1,'2017-03-14',0,NULL),(27,'2013143215','2013143215','2013',NULL,NULL,'2013143215',NULL,NULL,1,'2017-03-14',0,NULL),(40,'2013143232','2013143232','2013',NULL,NULL,'2013143232',NULL,NULL,1,'2017-03-14',0,NULL),(41,'2013141240','3c6ba8bd5e1cbf61ef7fcf5c86727e28','2013',NULL,NULL,'18388310533',NULL,NULL,1,'2017-03-21',0,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-04-01  9:28:30
