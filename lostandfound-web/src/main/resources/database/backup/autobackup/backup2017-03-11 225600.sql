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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loginlog`
--

LOCK TABLES `loginlog` WRITE;
/*!40000 ALTER TABLE `loginlog` DISABLE KEYS */;
INSERT INTO `loginlog` VALUES (1,'2013143216','Windows 7 ','Chrome 56.0.2924','127.0.0.1','2017-03-09 07:12:57',4),(2,'2013143218','Windows 7 ','Chrome 55.0.2883','127.0.0.1','2017-03-09 05:13:00',1),(3,'2013143218','Windows 7 ','Chrome 55.0.2883','127.0.0.1','2017-03-09 09:23:42',1),(4,'2013031308','Windows 7 ','Firefox 51.0','127.0.0.1','2017-03-09 09:50:57',2),(5,'2013143218','Windows 7 ','Chrome 55.0.2883','127.0.0.1','2017-03-09 12:00:57',1),(6,'2013143218','Windows 7 ','Chrome 55.0.2883','127.0.0.1','2017-03-09 12:39:26',1),(7,'2013143218','Windows 7 ','Chrome 55.0.2883','127.0.0.1','2017-03-09 13:52:56',1),(8,'2013143218','Windows 7 ','Chrome 55.0.2883','127.0.0.1','2017-03-10 01:53:04',1),(9,'2013143218','Windows 7 ','Chrome 55.0.2883','127.0.0.1','2017-03-10 04:07:32',1),(10,'2013143218','Windows 7 ','Chrome 55.0.2883','127.0.0.1','2017-03-10 05:54:52',1),(11,'2013143218','Windows 7 ','Chrome 55.0.2883','127.0.0.1','2017-03-10 06:52:25',1),(12,'2013143218','Windows 7 ','Chrome 55.0.2883','127.0.0.1','2017-03-10 14:51:08',1),(13,'2013143217','Windows 7 ','IE 7.0','127.0.0.1','2017-03-10 15:48:52',5),(14,'2013143218','Windows 7 ','Chrome 55.0.2883','127.0.0.1','2017-03-11 09:02:12',1),(15,'2013143217','Windows 7 ','Chrome 55.0.2883','127.0.0.1','2017-03-11 09:27:05',5),(16,'2013143217','Windows 7 ','Chrome 55.0.2883','127.0.0.1','2017-03-11 10:18:20',5),(17,'2013143218','Windows 7 ','Chrome 55.0.2883','127.0.0.1','2017-03-11 12:56:35',1),(18,'2013143216','Windows 7 ','Chrome 56.0.2924','127.0.0.1','2017-03-11 14:52:25',4);
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
  `ThingsTitle` varchar(30) DEFAULT NULL COMMENT 'Ñ°ÕÒÎïÆ·µÄ±êÌâ',
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
INSERT INTO `lostthings` VALUES (1,'饭卡','教学楼','2016-11-28','卡类','524','static\\upload\\lost\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡','2016-11-28 19:35:24',1,1,NULL),(2,'银行卡','宿舍楼下','2016-11-23','卡类','223','static\\upload\\lost\\2013143218\\2017\\03\\20161130151920.jpg','一张银行卡','2016-11-23 14:17:04',1,1,NULL),(3,'饭卡','理学楼','2017-01-24','card','122','static\\upload\\lost\\2013143218\\2017\\03\\20161130151920.jpg','ererr','2017-01-24 21:27:29',1,1,NULL),(4,'饭卡','教学楼','2017-03-09','卡类','164','static\\upload\\lost\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡','2017-03-09 16:52:32',0,2,NULL),(6,'钱包','食堂','2017-03-09','per_eff',NULL,NULL,'钱包','2017-03-11 18:15:33',0,5,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menuitem`
--

LOCK TABLES `menuitem` WRITE;
/*!40000 ALTER TABLE `menuitem` DISABLE KEYS */;
INSERT INTO `menuitem` VALUES (1,'user-manager','用户管理',NULL,'-1',1,'用户管理',2,1),(2,'user-list','用户列表',NULL,'user-manager',1,'用户列表',2,1),(3,'u-list','用户列表','/admin/user-list.html','user-list',1,'用户列表',2,1),(4,'things-manager','物品管理','','-1',1,'物品管理',2,2),(5,'thinigs-list','物品列表','','things-manager',1,NULL,2,1),(6,'find-list','招领列表','/admin/find-list.html','thinigs-list',1,'招领列表',2,1),(7,'lost-list','寻物列表','/admin/lost-list.html','thinigs-list',1,'寻物列表',3,2),(8,'authority-manager','权限管理',NULL,'-1',1,'权限管理',3,3),(9,'sys-setting','系统设置',NULL,'-1',1,'系统设置',3,4),(10,'sys-pwd','密码',NULL,'sys-setting',1,NULL,3,1),(11,'s-pwd','修改密码','/admin/pwd-list.html','sys-pwd',1,NULL,3,1);
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
  `ThingsTitle` varchar(30) DEFAULT NULL COMMENT 'ÕÐÁìÎïÆ·µÄ±êÌâ',
  PRIMARY KEY (`ID`),
  KEY `UID` (`UID`),
  CONSTRAINT `pickthings_ibfk_1` FOREIGN KEY (`UID`) REFERENCES `user` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=236 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pickthings`
--

LOCK TABLES `pickthings` WRITE;
/*!40000 ALTER TABLE `pickthings` DISABLE KEYS */;
INSERT INTO `pickthings` VALUES (1,'校园卡','理学楼','2016-11-30','card','223','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张校园卡',NULL,'2016-11-30 17:27:13',1,1,NULL),(45,'校园卡','理学楼','2016-11-30','card','154','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张校园卡',NULL,'2016-11-30 15:20:43',0,1,NULL),(47,'校园卡','理学楼','2016-11-30','card','154','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张校园卡',NULL,'2016-11-30 15:20:45',1,1,NULL),(52,'校园卡','理学楼','2016-11-30','card','154','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张校园卡',NULL,'2016-11-30 17:36:24',1,2,NULL),(85,'饭卡','教学楼','2016-11-25','card','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,'2017-01-30 21:06:33',0,1,NULL),(95,'饭卡','教学楼','2016-11-25','card','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1,NULL),(102,'饭卡','教学楼','2016-11-25','book','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,'2017-01-28 21:07:05',0,1,NULL),(109,'饭卡','教学楼','2016-11-25','book','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,'2017-01-10 21:07:12',0,1,NULL),(115,'饭卡','教学楼','2016-11-25','other','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,'2017-01-01 21:07:16',0,1,NULL),(117,'饭卡','教学楼','2016-11-25','book','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1,NULL),(121,'饭卡','教学楼','2016-11-25','other','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,'2017-02-21 21:07:22',0,1,NULL),(124,'饭卡','教学楼','2016-11-25','book','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,'2017-01-30 21:07:27',0,1,NULL),(128,'饭卡','教学楼','2016-11-25','other','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1,NULL),(130,'饭卡','教学楼','2016-11-25','book','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1,NULL),(134,'饭卡','教学楼','2016-11-25','other','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1,NULL),(137,'饭卡','教学楼','2016-11-25','book','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1,NULL),(139,'饭卡','教学楼','2016-11-25','other','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1,NULL),(142,'饭卡','教学楼','2016-11-25','book','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1,NULL),(147,'饭卡','教学楼','2016-11-25','other','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1,NULL),(148,'饭卡','教学楼','2016-11-25','book','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1,NULL),(154,'饭卡','教学楼','2016-11-25','other','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1,NULL),(155,'饭卡','教学楼','2016-11-25','book','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1,NULL),(162,'饭卡','教学楼','2016-11-25','book','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1,NULL),(169,'饭卡','教学楼','2016-11-25','book','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1,NULL),(170,'饭卡','教学楼','2016-11-25','other','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1,NULL),(172,'饭卡','教学楼','2016-11-25','book','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1,NULL),(176,'饭卡','教学楼','2016-11-25','other','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1,NULL),(179,'饭卡','教学楼','2016-11-25','book','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1,NULL),(181,'饭卡','教学楼','2016-11-25','other','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1,NULL),(184,'饭卡','教学楼','2016-11-25','elec','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1,NULL),(186,'饭卡','教学楼','2016-11-25','book','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1,NULL),(190,'饭卡','教学楼','2016-11-25','elec','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1,NULL),(191,'饭卡','教学楼','2016-11-25','elec','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1,NULL),(194,'饭卡','教学楼','2016-11-25','book','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1,NULL),(195,'饭卡','教学楼','2016-11-25','elec','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1,NULL),(199,'饭卡','教学楼','2016-11-25','clo','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1,NULL),(200,'饭卡','教学楼','2016-11-25','elec','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1,NULL),(203,'饭卡','教学楼','2016-11-25','clo','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1,NULL),(204,'饭卡','教学楼','2016-11-25','clo','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1,NULL),(205,'饭卡','教学楼','2016-11-25','elec','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1,NULL),(207,'饭卡','教学楼','2016-11-25','clo','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1,NULL),(209,'饭卡','教学楼','2016-11-25','clo','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1,NULL),(211,'饭卡','教学楼','2016-11-25','elec','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,NULL,0,1,NULL),(214,'饭卡','教学楼','2016-11-30','clo','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,'2016-11-08 15:21:10',0,1,NULL),(217,'饭卡','教学楼','2016-11-30','clo','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,'2016-11-21 15:21:08',0,1,NULL),(220,'饭卡','教学楼','2016-11-30','elec','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,'2016-11-26 17:36:34',0,2,NULL),(221,'饭卡','教学楼','2016-11-30','card','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,'2016-11-30 15:21:15',0,1,NULL),(222,'饭卡','教学楼','2016-11-30','card','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,'2016-11-15 17:34:28',1,1,NULL),(224,'饭卡','教学楼','2016-11-30','clo','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,'2016-11-30 17:36:32',0,2,NULL),(226,'饭卡','教学楼','2016-11-30','clo','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,'2016-11-30 17:34:24',1,1,NULL),(227,'饭卡','教学楼','2016-11-30','clo','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,'2016-11-28 17:36:30',0,2,NULL),(229,'笔记本','理学楼','2016-11-30','clo','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一本书','教室','2016-12-08 18:32:29',1,2,NULL),(230,'饭卡','教学楼','2016-11-30','clo','164','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡',NULL,'2016-11-30 15:26:18',2,1,NULL),(231,'钱包','教学楼','2017-01-24','per_eff',NULL,'static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','红色钱包一个','','2017-01-24 20:50:34',0,1,NULL),(232,'饭卡','食堂','2017-03-09','card','123','static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','一张饭卡','','2017-03-09 17:24:54',0,1,NULL),(233,'钱包','理学楼','2017-03-09','per_eff',NULL,'static\\upload\\find\\2013143218\\2017\\03\\20161130151920.jpg','','','2017-03-09 20:02:45',0,1,NULL),(235,'饭卡','教学楼','2017-03-11','card','',NULL,'广东省 ','','2017-03-11 18:12:55',0,5,NULL);
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
INSERT INTO `school` VALUES (1,'10684','广西民族大学代号');
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
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
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
  `Password` varchar(20) NOT NULL,
  `NickName` varchar(10) DEFAULT NULL,
  `TelPhone` varchar(12) DEFAULT NULL,
  `Email` varchar(30) DEFAULT NULL,
  `QQ` varchar(15) DEFAULT NULL,
  `UserState` int(11) NOT NULL,
  `CreateTime` date NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'2013143218','lgllink','LinkMe','15802850670','408320080.qq.com','408320080',2,'2017-02-01'),(2,'2013031308','2013031308',NULL,NULL,NULL,'555555555',1,'2017-02-08'),(3,'admin@qq.com','admin','管理员',NULL,NULL,'244444',3,'2017-02-10'),(4,'2013143216','2013143216',NULL,NULL,NULL,'242222222',1,'2017-02-07'),(5,'2013143217','2013143217','李四',NULL,NULL,'242',0,'2017-02-12'),(6,'2013143218@qq.com','lgllink',NULL,NULL,NULL,NULL,2,'2017-03-11');
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

-- Dump completed on 2017-03-11 22:56:04
