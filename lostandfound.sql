/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50645
 Source Host           : localhost:3306
 Source Schema         : lostandfound

 Target Server Type    : MySQL
 Target Server Version : 50645
 File Encoding         : 65001

 Date: 21/03/2020 17:47:04
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for academy
-- ----------------------------
DROP TABLE IF EXISTS `academy`;
CREATE TABLE `academy`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Academy ID 自增',
  `AcademyCode` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '二级学院代码',
  `AcademyName` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '二级学院名称',
  `SchoolCode` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所属学校代码  （外键）',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SchoolCode`(`SchoolCode`) USING BTREE,
  CONSTRAINT `academy_ibfk_1` FOREIGN KEY (`SchoolCode`) REFERENCES `school` (`SchoolCode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of academy
-- ----------------------------
INSERT INTO `academy` VALUES (1, '14', '信息工程学院', '10684');

-- ----------------------------
-- Table structure for classes
-- ----------------------------
DROP TABLE IF EXISTS `classes`;
CREATE TABLE `classes`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Classes ID 自增',
  `ClassNo` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '班级编号',
  `Major` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '专业',
  `AcademyCode` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所属二级学院代码 (外键）',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `ClassNo`(`ClassNo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of classes
-- ----------------------------
INSERT INTO `classes` VALUES (1, '20131432', '软件工程', '14');

-- ----------------------------
-- Table structure for expressthanks
-- ----------------------------
DROP TABLE IF EXISTS `expressthanks`;
CREATE TABLE `expressthanks`  (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `Title` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '感谢标题',
  `Substance` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '感谢内容',
  `Status` int(11) NOT NULL COMMENT '状态',
  `UserName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '感谢人',
  `LeaveTime` datetime(0) NOT NULL COMMENT '感谢时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of expressthanks
-- ----------------------------
INSERT INTO `expressthanks` VALUES (1, '感谢测试', '感谢测试感谢测试感谢测试', 1, '2013143218', '2017-04-20 12:21:24');
INSERT INTO `expressthanks` VALUES (2, '感谢测试1', '感谢测试1感谢测试1感谢测试1', 1, '匿名', '2017-04-20 12:39:01');
INSERT INTO `expressthanks` VALUES (3, '测试啊测试', '哈哈哈，，是测试', 1, '2013143218', '2017-04-20 17:24:14');
INSERT INTO `expressthanks` VALUES (4, '继续测试', '继续测试继续测试继续测试继续测试继续测试继续测试继续测试继续测试继续测试继续测试继续测试', 1, '2013143218', '2017-04-20 17:31:08');
INSERT INTO `expressthanks` VALUES (5, '再次测试', '是再次测试是再次测试是再次测试是再次测试', 1, '2013143218', '2017-04-20 18:38:10');
INSERT INTO `expressthanks` VALUES (6, '感谢LinkMe', '感谢捡到我书包的那个LinkMe', 1, '匿名', '2017-04-20 18:39:13');
INSERT INTO `expressthanks` VALUES (7, '测试了的测试', '测试了很多遍，应该没有问题了，，，', 1, '2013031308', '2017-04-20 19:48:55');
INSERT INTO `expressthanks` VALUES (8, 'Chrome测试', '使用Chrome进行测试，，，', 1, '匿名', '2017-04-23 23:58:04');
INSERT INTO `expressthanks` VALUES (9, 'FireFox测试', '使用FireFox进行测试', 1, '2013031308', '2017-04-24 00:07:29');
INSERT INTO `expressthanks` VALUES (11, 'IE9测试', '使用IE9进行测试，，，', 1, '2013143207', '2017-04-24 00:13:02');
INSERT INTO `expressthanks` VALUES (12, '移动设备手机端测试', '使用手机进行测试，，，', 1, '匿名', '2017-04-24 00:16:31');
INSERT INTO `expressthanks` VALUES (13, '360浏览器测试', '360浏览器测试360浏览器测试，啊哈哈', 1, '2013143218', '2017-04-25 12:02:27');
INSERT INTO `expressthanks` VALUES (14, 'iOS手机测试', 'iOS测试，，，', 1, '2013143234', '2017-04-25 13:45:36');
INSERT INTO `expressthanks` VALUES (15, 'iOS自带浏览器测试', 'iOS自带浏览器测试，，，', 1, '匿名', '2017-04-25 14:05:10');

-- ----------------------------
-- Table structure for loginlog
-- ----------------------------
DROP TABLE IF EXISTS `loginlog`;
CREATE TABLE `loginlog`  (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '登录日志ID',
  `UserName` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `OSName` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作系统',
  `BrowserName` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '浏览器',
  `LoginIp` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '登录IP',
  `LoginTime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '登录时间',
  `UID` bigint(20) NOT NULL COMMENT '用户表 ID 外键',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `fk_loginlog`(`UID`) USING BTREE,
  CONSTRAINT `fk_loginlog` FOREIGN KEY (`UID`) REFERENCES `user` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 169 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of loginlog
-- ----------------------------
INSERT INTO `loginlog` VALUES (1, '2013143216', 'Windows 7 ', 'Chrome 56.0.2924', '127.0.0.1', '2017-03-09 15:12:57', 4);
INSERT INTO `loginlog` VALUES (2, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-03-09 13:13:00', 1);
INSERT INTO `loginlog` VALUES (3, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-03-09 17:23:42', 1);
INSERT INTO `loginlog` VALUES (4, '2013031308', 'Windows 7 ', 'Firefox 51.0', '127.0.0.1', '2017-03-09 17:50:57', 2);
INSERT INTO `loginlog` VALUES (5, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-03-09 20:00:57', 1);
INSERT INTO `loginlog` VALUES (6, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-03-09 20:39:26', 1);
INSERT INTO `loginlog` VALUES (14, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-03-11 17:02:12', 1);
INSERT INTO `loginlog` VALUES (22, '2013143218', 'Windows 7 ', 'Chrome 56.0.2924', '127.0.0.1', '2017-03-14 20:35:15', 1);
INSERT INTO `loginlog` VALUES (23, '2013143218', 'Windows 7 ', 'Chrome 56.0.2924', '127.0.0.1', '2017-03-19 17:25:49', 1);
INSERT INTO `loginlog` VALUES (24, '2013143218', 'Windows 7 ', 'Chrome 56.0.2924', '127.0.0.1', '2017-03-19 17:48:40', 1);
INSERT INTO `loginlog` VALUES (25, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-03-21 19:26:41', 1);
INSERT INTO `loginlog` VALUES (26, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-03-21 20:56:56', 1);
INSERT INTO `loginlog` VALUES (27, '2013143216', 'Windows 7 ', 'Chrome 45.0.2454', '127.0.0.1', '2017-03-21 21:03:13', 4);
INSERT INTO `loginlog` VALUES (28, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-03-22 23:25:42', 1);
INSERT INTO `loginlog` VALUES (29, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-03-22 23:39:50', 1);
INSERT INTO `loginlog` VALUES (30, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-03-23 00:46:08', 1);
INSERT INTO `loginlog` VALUES (31, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-03-27 15:56:36', 1);
INSERT INTO `loginlog` VALUES (32, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-03-28 16:30:35', 1);
INSERT INTO `loginlog` VALUES (33, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-03-28 19:44:04', 1);
INSERT INTO `loginlog` VALUES (34, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-03-28 20:31:56', 1);
INSERT INTO `loginlog` VALUES (35, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-03-28 21:58:51', 1);
INSERT INTO `loginlog` VALUES (36, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-03-30 12:28:49', 1);
INSERT INTO `loginlog` VALUES (37, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-01 09:45:03', 1);
INSERT INTO `loginlog` VALUES (38, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-03 21:24:56', 1);
INSERT INTO `loginlog` VALUES (39, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-03 23:58:03', 1);
INSERT INTO `loginlog` VALUES (40, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-03 23:58:36', 1);
INSERT INTO `loginlog` VALUES (41, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-03 23:59:09', 1);
INSERT INTO `loginlog` VALUES (42, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-04 00:15:31', 1);
INSERT INTO `loginlog` VALUES (43, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-04 00:15:54', 1);
INSERT INTO `loginlog` VALUES (44, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-04 00:16:28', 1);
INSERT INTO `loginlog` VALUES (45, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-04 00:19:54', 1);
INSERT INTO `loginlog` VALUES (46, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-04 00:30:14', 1);
INSERT INTO `loginlog` VALUES (47, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-04 00:30:42', 1);
INSERT INTO `loginlog` VALUES (48, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-04 00:34:58', 1);
INSERT INTO `loginlog` VALUES (49, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-04 00:40:05', 1);
INSERT INTO `loginlog` VALUES (50, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-04 01:09:00', 1);
INSERT INTO `loginlog` VALUES (51, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-04 01:49:55', 1);
INSERT INTO `loginlog` VALUES (52, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-04 01:50:12', 1);
INSERT INTO `loginlog` VALUES (53, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-04 01:50:42', 1);
INSERT INTO `loginlog` VALUES (54, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-04 01:51:10', 1);
INSERT INTO `loginlog` VALUES (55, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-04 02:01:32', 1);
INSERT INTO `loginlog` VALUES (56, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-04 02:31:49', 1);
INSERT INTO `loginlog` VALUES (57, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-04 02:53:08', 1);
INSERT INTO `loginlog` VALUES (58, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-04 02:59:38', 1);
INSERT INTO `loginlog` VALUES (59, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-06 23:13:08', 1);
INSERT INTO `loginlog` VALUES (60, '2013031308', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-07 00:50:44', 2);
INSERT INTO `loginlog` VALUES (61, '2013031308', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-07 01:08:47', 2);
INSERT INTO `loginlog` VALUES (62, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-07 01:26:53', 1);
INSERT INTO `loginlog` VALUES (63, '2013031308', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-07 01:54:03', 2);
INSERT INTO `loginlog` VALUES (64, '2013031308', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-07 02:14:33', 2);
INSERT INTO `loginlog` VALUES (65, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-07 02:28:49', 1);
INSERT INTO `loginlog` VALUES (66, '2013031308', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-07 02:33:55', 2);
INSERT INTO `loginlog` VALUES (67, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-07 02:36:19', 1);
INSERT INTO `loginlog` VALUES (68, '2013143216', 'Windows 7 ', 'Chrome 45.0.2454', '127.0.0.1', '2017-04-07 03:31:47', 4);
INSERT INTO `loginlog` VALUES (69, '2013143216', 'Windows 7 ', 'Chrome 45.0.2454', '127.0.0.1', '2017-04-07 15:10:11', 4);
INSERT INTO `loginlog` VALUES (70, '2013143216', 'Windows 7 ', 'Chrome 45.0.2454', '127.0.0.1', '2017-04-07 15:25:22', 4);
INSERT INTO `loginlog` VALUES (71, '2013143216', 'Windows 7 ', 'Chrome 45.0.2454', '127.0.0.1', '2017-04-07 15:27:58', 4);
INSERT INTO `loginlog` VALUES (72, '2013143216', 'Windows 7 ', 'Chrome 45.0.2454', '127.0.0.1', '2017-04-07 15:32:02', 4);
INSERT INTO `loginlog` VALUES (73, '2013143216', 'Windows 7 ', 'Chrome 45.0.2454', '127.0.0.1', '2017-04-07 15:35:06', 4);
INSERT INTO `loginlog` VALUES (74, '2013143216', 'Windows 7 ', 'Chrome 45.0.2454', '127.0.0.1', '2017-04-07 15:41:56', 4);
INSERT INTO `loginlog` VALUES (75, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-07 16:14:24', 1);
INSERT INTO `loginlog` VALUES (76, '2013031308', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-07 16:15:06', 2);
INSERT INTO `loginlog` VALUES (77, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-07 16:22:09', 1);
INSERT INTO `loginlog` VALUES (78, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-07 16:35:00', 1);
INSERT INTO `loginlog` VALUES (79, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-07 16:42:25', 1);
INSERT INTO `loginlog` VALUES (80, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-07 16:46:43', 1);
INSERT INTO `loginlog` VALUES (81, '2013031308', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-07 16:51:15', 2);
INSERT INTO `loginlog` VALUES (82, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-07 17:02:47', 1);
INSERT INTO `loginlog` VALUES (83, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-07 17:22:21', 1);
INSERT INTO `loginlog` VALUES (84, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-07 18:01:09', 1);
INSERT INTO `loginlog` VALUES (85, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-07 18:13:54', 1);
INSERT INTO `loginlog` VALUES (86, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-07 18:25:04', 1);
INSERT INTO `loginlog` VALUES (87, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-07 18:37:41', 1);
INSERT INTO `loginlog` VALUES (88, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-07 19:57:12', 1);
INSERT INTO `loginlog` VALUES (89, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-07 21:35:56', 1);
INSERT INTO `loginlog` VALUES (90, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-07 22:11:36', 1);
INSERT INTO `loginlog` VALUES (91, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-07 22:23:03', 1);
INSERT INTO `loginlog` VALUES (92, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-07 22:38:18', 1);
INSERT INTO `loginlog` VALUES (93, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-08 03:07:25', 1);
INSERT INTO `loginlog` VALUES (94, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-08 18:43:51', 1);
INSERT INTO `loginlog` VALUES (95, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '127.0.0.1', '2017-04-09 17:45:38', 1);
INSERT INTO `loginlog` VALUES (96, '2013143218', 'Android 6.0.1', 'Chrome Mobile 53.0.2785.146', '218.63.75.79', '2017-04-10 23:15:51', 1);
INSERT INTO `loginlog` VALUES (97, '2013143218', 'Android 6.0.1', 'Chrome Mobile 53.0.2785.146', '218.63.75.79', '2017-04-11 16:05:49', 1);
INSERT INTO `loginlog` VALUES (98, '2013141240', 'Windows 7 ', 'Chrome 45.0.2454', '218.63.75.76', '2017-04-11 22:39:33', 41);
INSERT INTO `loginlog` VALUES (99, '2013141240', 'Windows ', 'IE 7.0', '218.63.75.77', '2017-04-12 15:31:13', 41);
INSERT INTO `loginlog` VALUES (100, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '218.63.75.79', '2017-04-13 21:30:36', 1);
INSERT INTO `loginlog` VALUES (101, '2013143218', 'Android 6.0.1', 'Chrome Mobile 53.0.2785.146', '218.63.75.79', '2017-04-13 23:21:12', 1);
INSERT INTO `loginlog` VALUES (102, '2013143218', 'Android 6.0.1', 'Chrome Mobile 53.0.2785.146', '218.63.75.79', '2017-04-13 23:59:25', 1);
INSERT INTO `loginlog` VALUES (103, '2013143218', 'Android 6.0.1', 'Chrome Mobile 53.0.2785.49', '218.63.75.79', '2017-04-14 10:38:25', 1);
INSERT INTO `loginlog` VALUES (104, '2013042105', 'Android 4.2.2', 'Chrome Mobile 38.0.0.0', '218.63.75.76', '2017-04-14 12:56:46', 821);
INSERT INTO `loginlog` VALUES (105, '2013031308', 'Android 6.0.1', 'Chrome Mobile 53.0.2785.146', '218.63.75.79', '2017-04-14 13:05:06', 2);
INSERT INTO `loginlog` VALUES (106, '2013042105', 'Android 4.2.2', 'Chrome Mobile 38.0.0.0', '218.63.75.76', '2017-04-14 13:05:18', 821);
INSERT INTO `loginlog` VALUES (107, '2013042105', 'Android 4.2.2', 'Chrome Mobile 38.0.0.0', '218.63.75.76', '2017-04-14 13:12:14', 821);
INSERT INTO `loginlog` VALUES (108, '2013143205', 'Android 5.1', 'Chrome Mobile 45.0.2454.94', '218.63.75.79', '2017-04-14 13:16:34', 793);
INSERT INTO `loginlog` VALUES (109, '2013143201', 'Android 6.0', 'Chrome 37.0.0', '218.63.75.79', '2017-04-14 13:20:36', 789);
INSERT INTO `loginlog` VALUES (110, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '218.63.75.79', '2017-04-16 00:13:50', 1);
INSERT INTO `loginlog` VALUES (111, '2013143218', 'Windows 7 ', 'Chrome 55.0.2883', '218.63.75.79', '2017-04-16 15:06:42', 1);
INSERT INTO `loginlog` VALUES (112, '2013143216', 'Android 5.1', 'Chrome Mobile 53.0.2785.49', '180.130.10.215', '2017-04-16 15:11:23', 4);
INSERT INTO `loginlog` VALUES (113, '2013031308', 'Android 6.0.1', 'Chrome Mobile 53.0.2785.146', '218.63.75.79', '2017-04-16 15:51:30', 2);
INSERT INTO `loginlog` VALUES (115, '2013143218', 'Windows 7 ', 'Chrome 56.0.2924', '218.63.75.79', '2017-04-16 21:58:16', 1);
INSERT INTO `loginlog` VALUES (116, '2013132157', 'Android 6.0', 'Chrome Mobile 53.0.2785.49', '218.63.75.77', '2017-04-16 22:04:58', 825);
INSERT INTO `loginlog` VALUES (117, '2013041121', 'iOS 10.0.2', 'Mobile Safari 10.2', '117.136.16.84', '2017-04-16 22:11:37', 819);
INSERT INTO `loginlog` VALUES (118, '2013023120', 'Android 5.0.2', 'Chrome Mobile 53.0.2785.49', '117.136.16.68', '2017-04-16 22:18:39', 820);
INSERT INTO `loginlog` VALUES (119, '2014073120', 'iOS 10.3.1', 'Mobile Safari 10.1', '117.136.16.89', '2017-04-16 22:32:39', 823);
INSERT INTO `loginlog` VALUES (120, '2014073120', 'Android 5.1', 'Chrome Mobile 53.0.2785.49', '218.63.75.77', '2017-04-16 22:47:38', 823);
INSERT INTO `loginlog` VALUES (121, '2014073126', 'Android 5.1', 'Chrome Mobile 53.0.2785.49', '218.63.75.77', '2017-04-16 22:48:24', 827);
INSERT INTO `loginlog` VALUES (122, '2014073134', 'iOS 10.3.1', 'Mobile Safari 10.1', '218.63.75.76', '2017-04-16 22:52:35', 829);
INSERT INTO `loginlog` VALUES (123, '2014073103', 'iOS 10.3.1', 'Mobile Safari 10.1', '218.63.75.76', '2017-04-16 22:54:23', 845);
INSERT INTO `loginlog` VALUES (124, '2013143218', 'Windows 7 ', 'Chrome 56.0.2924', '218.63.75.79', '2017-04-16 23:24:26', 1);
INSERT INTO `loginlog` VALUES (125, '2014073103', 'Android 5.1', 'Chrome Mobile 53.0.2785.49', '218.63.75.77', '2017-04-17 11:54:56', 845);
INSERT INTO `loginlog` VALUES (126, '2013132157', 'Android 6.0', 'Chrome Mobile 53.0.2785.49', '218.63.75.77', '2017-04-17 13:50:42', 825);
INSERT INTO `loginlog` VALUES (127, '2014073103', 'Windows 7 ', 'Chrome 57.0.2987', '218.63.75.77', '2017-04-17 18:42:10', 845);
INSERT INTO `loginlog` VALUES (128, '2014073120', 'Windows 7 ', 'Chrome 57.0.2987', '218.63.75.77', '2017-04-17 18:43:07', 823);
INSERT INTO `loginlog` VALUES (129, '2014073102', 'Windows 7 ', 'Chrome 57.0.2987', '218.63.75.77', '2017-04-17 18:45:09', 830);
INSERT INTO `loginlog` VALUES (130, '2014073126', 'Windows 7 ', 'IE 7.0', '218.63.75.77', '2017-04-17 19:54:57', 827);
INSERT INTO `loginlog` VALUES (131, '2014073127', 'Windows 7 ', 'IE 7.0', '218.63.75.77', '2017-04-17 19:56:12', 828);
INSERT INTO `loginlog` VALUES (132, '2014073120', 'Windows 7 ', 'Chrome 57.0.2987', '218.63.75.77', '2017-04-17 19:57:27', 823);
INSERT INTO `loginlog` VALUES (133, '2014073126', 'Windows 7 ', 'IE 7.0', '218.63.75.77', '2017-04-17 19:59:18', 827);
INSERT INTO `loginlog` VALUES (134, '2014073103', 'Android 5.1', 'Chrome Mobile 53.0.2785.49', '218.63.75.77', '2017-04-17 20:01:11', 845);
INSERT INTO `loginlog` VALUES (135, '2013143218', 'Android 6.0.1', 'Chrome Mobile 53.0.2785.146', '218.63.75.79', '2017-04-17 21:03:30', 1);
INSERT INTO `loginlog` VALUES (136, '2013143216', 'Windows 7 ', 'IE 7.0', '218.63.75.79', '2017-04-17 21:21:17', 4);
INSERT INTO `loginlog` VALUES (137, '2013143218', 'Android 6.0.1', 'Chrome Mobile 53.0.2785.146', '10.56.14.179', '2017-04-17 21:22:19', 1);
INSERT INTO `loginlog` VALUES (138, '2013143218', 'Android 6.0.1', 'Chrome Mobile 53.0.2785.49', '10.56.14.179', '2017-04-17 21:28:31', 1);
INSERT INTO `loginlog` VALUES (139, '2013132157', 'Android 6.0', 'Chrome Mobile 53.0.2785.49', '117.136.16.36', '2017-04-18 11:49:02', 825);
INSERT INTO `loginlog` VALUES (140, '2013143234', 'iOS 9.3.5', 'Mobile Safari 9.5', '117.136.84.234', '2017-04-19 19:13:44', 814);
INSERT INTO `loginlog` VALUES (141, '2013031308', 'Android 6.0.1', 'Chrome Mobile 53.0.2785.146', '117.75.44.154', '2017-04-20 16:08:11', 2);
INSERT INTO `loginlog` VALUES (142, '2013031308', 'Android 6.0.1', 'Chrome Mobile 53.0.2785.146', '117.75.129.165', '2017-04-20 19:48:24', 2);
INSERT INTO `loginlog` VALUES (143, '2013031308', 'Android 6.0.1', 'Chrome Mobile 53.0.2785.146', '117.75.129.165', '2017-04-21 00:06:18', 2);
INSERT INTO `loginlog` VALUES (144, '2013143218', 'Windows 7 ', 'Chrome 56.0.2924', '117.75.129.165', '2017-04-21 03:54:47', 1);
INSERT INTO `loginlog` VALUES (145, '2013143218', 'Android 6.0.1', 'Chrome Mobile 53.0.2785.146', '117.75.139.19', '2017-04-21 17:40:06', 1);
INSERT INTO `loginlog` VALUES (146, '2013143218', 'Android 6.0.1', 'Chrome Mobile 53.0.2785.146', '117.75.19.126', '2017-04-23 01:01:29', 1);
INSERT INTO `loginlog` VALUES (147, '2013143207', 'Android 4.4.4', 'Chrome Mobile 53.0.2785.146', '117.75.19.126', '2017-04-23 12:17:27', 42);
INSERT INTO `loginlog` VALUES (148, '2013143218', 'Windows 7 ', 'Chrome 56.0.2924', '117.75.19.135', '2017-04-23 23:57:25', 1);
INSERT INTO `loginlog` VALUES (149, '2013031308', 'Windows 7 ', 'Firefox 52.0', '117.75.19.135', '2017-04-24 00:06:53', 2);
INSERT INTO `loginlog` VALUES (150, '2013143216', 'Windows 7 ', 'Chrome 56.0.2924', '117.75.19.135', '2017-04-24 00:07:51', 4);
INSERT INTO `loginlog` VALUES (151, '2013143207', 'Windows 7 ', 'IE 9.0', '117.75.19.135', '2017-04-24 00:12:33', 42);
INSERT INTO `loginlog` VALUES (152, '2013143205', 'Android 6.0.1', 'Chrome Mobile 53.0.2785.146', '117.75.19.135', '2017-04-24 00:15:43', 793);
INSERT INTO `loginlog` VALUES (153, '2013143218', 'Windows 7 ', 'Chrome 45.0.2454', '117.75.19.135', '2017-04-25 12:01:45', 1);
INSERT INTO `loginlog` VALUES (154, '2013143234', 'iOS 10.3.1', 'Mobile Safari 10.1', '117.75.19.135', '2017-04-25 13:42:43', 814);
INSERT INTO `loginlog` VALUES (155, '2013143234', 'iOS 10.3.1', 'Mobile Safari 10.0', '117.75.19.135', '2017-04-25 14:03:33', 814);
INSERT INTO `loginlog` VALUES (156, '2013143218', 'Windows 7 ', 'Chrome 45.0.2454', '117.75.19.135', '2017-04-25 18:09:57', 1);
INSERT INTO `loginlog` VALUES (157, '2013031308', 'Windows ', 'Chrome 77.0.3865', '127.0.0.1', '2020-03-18 04:34:26', 2);
INSERT INTO `loginlog` VALUES (158, '2013031308', 'Windows ', 'Chrome 77.0.3865', '127.0.0.1', '2020-03-18 13:27:44', 2);
INSERT INTO `loginlog` VALUES (159, '2013031308', 'Windows ', 'Chrome 77.0.3865', '127.0.0.1', '2020-03-18 13:47:25', 2);
INSERT INTO `loginlog` VALUES (160, '2013031308', 'Windows ', 'Chrome 77.0.3865', '127.0.0.1', '2020-03-18 14:45:50', 2);
INSERT INTO `loginlog` VALUES (161, '2013031308', 'Windows ', 'Chrome 77.0.3865', '127.0.0.1', '2020-03-18 18:09:32', 2);
INSERT INTO `loginlog` VALUES (162, '2013031308', 'Windows ', 'Chrome 77.0.3865', '127.0.0.1', '2020-03-18 18:32:22', 2);
INSERT INTO `loginlog` VALUES (163, '2013031308', 'Windows ', 'Chrome 77.0.3865', '127.0.0.1', '2020-03-18 18:52:48', 2);
INSERT INTO `loginlog` VALUES (164, '2013031308', 'Windows ', 'Chrome 77.0.3865', '127.0.0.1', '2020-03-18 19:01:57', 2);
INSERT INTO `loginlog` VALUES (165, '2013031308', 'Windows ', 'Chrome 77.0.3865', '127.0.0.1', '2020-03-18 19:15:27', 2);
INSERT INTO `loginlog` VALUES (166, '2013031308', 'Windows ', 'Chrome 77.0.3865', '127.0.0.1', '2020-03-18 19:32:08', 2);
INSERT INTO `loginlog` VALUES (167, '2013031308', 'Windows ', 'Chrome 77.0.3865', '127.0.0.1', '2020-03-18 19:44:34', 2);
INSERT INTO `loginlog` VALUES (168, '2013031308', 'Windows ', 'Chrome 77.0.3865', '127.0.0.1', '2020-03-21 07:01:27', 2);

-- ----------------------------
-- Table structure for lostthings
-- ----------------------------
DROP TABLE IF EXISTS `lostthings`;
CREATE TABLE `lostthings`  (
  `ID` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'LostThings ID 自增',
  `ThingsName` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '物品名称',
  `LostPlace` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '丢失地点',
  `LostTime` date NOT NULL COMMENT '丢失时间',
  `ThingsType` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '物品类型',
  `ThingsNo` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '物品编号',
  `ThingsImg` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '物品图片 可 null',
  `ThingsDes` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '物品描述',
  `PublishTime` datetime(0) NOT NULL COMMENT '发布时间',
  `Status` int(11) NOT NULL COMMENT '状态',
  `UserName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `UID` bigint(20) NOT NULL COMMENT '用户表 ID 外键',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `UID`(`UID`) USING BTREE,
  CONSTRAINT `lostthings_ibfk_1` FOREIGN KEY (`UID`) REFERENCES `user` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 212 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of lostthings
-- ----------------------------
INSERT INTO `lostthings` VALUES (6, '钱包', '食堂', '2017-03-09', 'per_eff', NULL, 'static\\upload\\lost\\2017\\03\\2013143218\\20161130151920.jpg', '钱包', '2017-03-11 18:15:33', 1, '2013031308', 2);
INSERT INTO `lostthings` VALUES (202, '饭卡1', '教学楼3', '2017-04-06', 'card', '145', 'static\\upload\\lost\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡1', '2017-04-06 00:04:02', 0, '2013143218', 1);
INSERT INTO `lostthings` VALUES (203, '饭卡2', '教学楼6', '2017-04-06', 'card', '145', 'static\\upload\\lost\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡2', '2017-04-06 00:04:02', 0, '2013143218', 1);
INSERT INTO `lostthings` VALUES (204, '饭卡3', '教学楼9', '2017-04-06', 'card', '145', 'static\\upload\\lost\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡3', '2017-04-06 00:04:02', 0, '2013143218', 1);
INSERT INTO `lostthings` VALUES (205, '饭卡4', '教学楼12', '2017-04-06', 'card', '145', 'static\\upload\\lost\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡4', '2017-04-06 00:04:03', 0, '2013143218', 1);
INSERT INTO `lostthings` VALUES (206, '饭卡5', '教学楼15', '2017-04-06', 'card', '145', 'static\\upload\\lost\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡5', '2017-04-06 00:04:03', 0, '2013143218', 1);
INSERT INTO `lostthings` VALUES (207, '饭卡6', '教学楼18', '2017-04-06', 'card', '145', 'static\\upload\\lost\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡6', '2017-04-06 00:04:03', 0, '2013143218', 1);
INSERT INTO `lostthings` VALUES (208, '饭卡7', '教学楼21', '2017-04-06', 'card', '145', 'static\\upload\\lost\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡7', '2017-04-06 00:04:03', 1, '2013143218', 1);
INSERT INTO `lostthings` VALUES (209, '饭卡8', '教学楼24', '2017-04-06', 'card', '145', 'static\\upload\\lost\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡8', '2017-04-06 00:04:03', 1, '2013143218', 1);
INSERT INTO `lostthings` VALUES (210, '饭卡9', '教学楼27', '2017-04-06', 'card', '145', 'static\\upload\\lost\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡9', '2017-04-06 00:04:03', 0, '2013143218', 1);
INSERT INTO `lostthings` VALUES (211, '饭卡10', '教学楼30', '2017-04-06', 'card', '145', 'static\\upload\\lost\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡10', '2017-04-06 00:04:03', 1, '2013143218', 1);

-- ----------------------------
-- Table structure for menuitem
-- ----------------------------
DROP TABLE IF EXISTS `menuitem`;
CREATE TABLE `menuitem`  (
  `ID` int(20) NOT NULL AUTO_INCREMENT,
  `MenuID` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单ID',
  `MenuItemName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称',
  `MenuItemUrl` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单url地址',
  `ParentId` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父菜单ID',
  `Status` int(11) NOT NULL COMMENT '状态',
  `MenuItemDes` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单描述',
  `Authority` int(11) NOT NULL COMMENT '菜单访问权限',
  `Sort` int(11) NULL DEFAULT NULL COMMENT '菜单排序',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `ParentId`(`ParentId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of menuitem
-- ----------------------------
INSERT INTO `menuitem` VALUES (1, 'user-manager', '用户管理', NULL, '-1', 1, '用户管理', 2, 1);
INSERT INTO `menuitem` VALUES (2, 'user-info', '用户信息', NULL, 'user-manager', 1, '用户信息', 2, 1);
INSERT INTO `menuitem` VALUES (3, 'user-list', '用户列表', '/admin/user-list.html', 'user-info', 1, '用户列表', 2, 1);
INSERT INTO `menuitem` VALUES (4, 'things-manager', '物品管理', '', '-1', 1, '物品管理', 2, 2);
INSERT INTO `menuitem` VALUES (5, 'things-info', '物品信息', '', 'things-manager', 1, '物品信息', 2, 1);
INSERT INTO `menuitem` VALUES (6, 'find-list', '招领列表', '/admin/find-list.html', 'things-info', 1, '招领列表', 2, 1);
INSERT INTO `menuitem` VALUES (7, 'lost-list', '寻物列表', '/admin/lost-list.html', 'things-info', 1, '寻物列表', 2, 2);
INSERT INTO `menuitem` VALUES (8, 'authority-manager', '权限管理', NULL, '-1', 1, '权限管理', 3, 3);
INSERT INTO `menuitem` VALUES (9, 'system-setting', '系统设置', NULL, '-1', 1, '系统设置', 2, 5);
INSERT INTO `menuitem` VALUES (10, 's-pwd', '修改密码', '/admin/password.html', 'system-setting', 1, '修改密码', 2, 1);
INSERT INTO `menuitem` VALUES (11, 'user-import', '用户导入', '/admin/user-import.html', 'user-info', 1, '用户导入', 2, 2);
INSERT INTO `menuitem` VALUES (12, 'user-log', '用户日志', '/admin/user-log.html', 'user-info', 1, '用户日志', 3, 3);
INSERT INTO `menuitem` VALUES (13, 'menu-manager', '菜单管理', NULL, '-1', 1, '菜单管理', 3, 4);
INSERT INTO `menuitem` VALUES (14, 'menu-list', '菜单列表', '/admin/menu-list.html', 'menu-manager', 1, '菜单列表', 3, 1);
INSERT INTO `menuitem` VALUES (15, 'authority-list', '权限列表', '/admin/authority-list.html', 'authority-manager', 1, '权限列表', 3, 1);
INSERT INTO `menuitem` VALUES (16, 'database-backup', '数据库备份', '/admin/database.html', 'system-setting', 1, '数据库备份', 3, 4);
INSERT INTO `menuitem` VALUES (17, 'notice-list', '公告列表', '/admin/notice-list.html', 'system-setting', 1, '公告列表', 3, 2);
INSERT INTO `menuitem` VALUES (18, 'system-log', '系统日志列表', '/admin/system-log.html', 'system-setting', 1, '系统日志列表', 3, 5);
INSERT INTO `menuitem` VALUES (19, 'leave-thsnks', '留言感谢列表', '/admin/leave-thanks-list.html', 'system-setting', 1, '留言感谢列表', 2, 3);

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `Title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `Substance` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'ÄÚÈÝ',
  `Status` int(11) NOT NULL COMMENT '状态（0显示,1不显示）',
  `PublishTime` datetime(0) NOT NULL COMMENT '发布时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (1, '平台上线通知公告', 'Hi!广西民族大学校园失物招领平台V1.0测试版上线啦~。 欢迎大家使用哦~~所有数据均为测试数据哦', 1, '2017-04-15 16:38:50');

-- ----------------------------
-- Table structure for pickthings
-- ----------------------------
DROP TABLE IF EXISTS `pickthings`;
CREATE TABLE `pickthings`  (
  `ID` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'LostThings ID 自增',
  `ThingsName` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '物品名称',
  `PickPlace` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '丢失地点',
  `PickTime` date NOT NULL COMMENT '丢失时间',
  `ThingsType` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '物品类型',
  `ThingsNo` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '物品编号',
  `ThingsImg` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '物品图片',
  `ThingsDes` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '物品描述',
  `StoragePlace` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '暂存地点',
  `TelPhone` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `PublishTime` datetime(0) NULL DEFAULT NULL COMMENT '发布时间',
  `Status` int(11) NOT NULL COMMENT '状态',
  `UserName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `UID` bigint(20) NOT NULL COMMENT '用户表 ID 外键',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `UID`(`UID`) USING BTREE,
  CONSTRAINT `pickthings_ibfk_1` FOREIGN KEY (`UID`) REFERENCES `user` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 271 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of pickthings
-- ----------------------------
INSERT INTO `pickthings` VALUES (1, '校园卡', '理学楼', '2016-11-30', 'card', '223', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张校园卡', NULL, NULL, '2016-11-30 17:27:13', 1, '2013031308', 2);
INSERT INTO `pickthings` VALUES (45, '校园卡', '理学楼', '2016-11-30', 'card', '154', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张校园卡', NULL, NULL, '2016-11-30 15:20:43', 0, '2013143218', 1);
INSERT INTO `pickthings` VALUES (47, '校园卡', '理学楼', '2016-11-30', 'card', '154', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张校园卡', NULL, NULL, '2016-11-30 15:20:45', 1, '2013143218', 1);
INSERT INTO `pickthings` VALUES (52, '校园卡', '理学楼', '2016-11-30', 'card', '154', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张校园卡', NULL, NULL, '2016-11-30 17:36:24', 1, '2013031308', 2);
INSERT INTO `pickthings` VALUES (85, '饭卡', '教学楼', '2016-11-25', 'card', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-11-30 21:06:33', 0, '2013143218', 1);
INSERT INTO `pickthings` VALUES (95, '饭卡', '教学楼', '2016-11-25', 'card', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-11-30 21:06:53', 0, '2013143216', 4);
INSERT INTO `pickthings` VALUES (102, '饭卡', '教学楼', '2016-11-25', 'book', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-11-30 21:07:05', 0, '2013143216', 4);
INSERT INTO `pickthings` VALUES (109, '饭卡', '教学楼', '2016-11-25', 'book', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-11-30 21:07:12', 0, '2013143218', 1);
INSERT INTO `pickthings` VALUES (117, '饭卡', '教学楼', '2016-11-25', 'book', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-11-30 21:07:18', 0, '2013143218', 1);
INSERT INTO `pickthings` VALUES (121, '饭卡', '教学楼', '2016-11-25', 'other', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-11-30 21:07:22', 0, '2013143218', 1);
INSERT INTO `pickthings` VALUES (124, '饭卡', '教学楼', '2016-11-25', 'book', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-11-30 21:07:27', 0, '2013143217', 787);
INSERT INTO `pickthings` VALUES (128, '饭卡', '教学楼', '2016-11-25', 'other', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-12-02 11:44:12', 0, '2013143218', 1);
INSERT INTO `pickthings` VALUES (134, '饭卡', '教学楼', '2016-11-25', 'other', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-12-02 11:44:12', 0, '2013143218', 1);
INSERT INTO `pickthings` VALUES (137, '饭卡', '教学楼', '2016-11-25', 'book', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-12-02 11:44:12', 0, '2013143218', 1);
INSERT INTO `pickthings` VALUES (139, '饭卡', '教学楼', '2016-11-25', 'other', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-12-03 11:44:12', 0, '2013143217', 787);
INSERT INTO `pickthings` VALUES (142, '饭卡', '教学楼', '2016-11-25', 'book', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-12-03 11:44:12', 0, '2013143218', 1);
INSERT INTO `pickthings` VALUES (148, '饭卡', '教学楼', '2016-11-25', 'book', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-12-03 11:44:12', 0, '2013143218', 1);
INSERT INTO `pickthings` VALUES (154, '饭卡', '教学楼', '2016-11-25', 'other', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-12-04 11:44:12', 0, '2013143218', 1);
INSERT INTO `pickthings` VALUES (155, '饭卡', '教学楼', '2016-11-25', 'book', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-12-04 11:44:12', 0, '2013143218', 1);
INSERT INTO `pickthings` VALUES (169, '饭卡', '教学楼', '2016-11-25', 'book', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-12-04 11:44:12', 0, '2013143218', 1);
INSERT INTO `pickthings` VALUES (170, '饭卡', '教学楼', '2016-11-25', 'other', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-12-04 11:44:12', 0, '2013143218', 1);
INSERT INTO `pickthings` VALUES (172, '饭卡', '教学楼', '2016-11-25', 'book', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-12-04 11:44:12', 0, '2013143218', 1);
INSERT INTO `pickthings` VALUES (176, '饭卡', '教学楼', '2016-11-25', 'other', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-12-05 11:44:12', 0, '2013143218', 1);
INSERT INTO `pickthings` VALUES (179, '饭卡', '教学楼', '2016-11-25', 'book', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-12-05 11:44:12', 0, '2013143218', 1);
INSERT INTO `pickthings` VALUES (181, '饭卡', '教学楼', '2016-11-25', 'other', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-12-05 11:44:12', 0, '2013143218', 1);
INSERT INTO `pickthings` VALUES (184, '饭卡', '教学楼', '2016-11-25', 'elec', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-12-05 11:44:12', 0, '2013143218', 1);
INSERT INTO `pickthings` VALUES (186, '饭卡', '教学楼', '2016-11-25', 'book', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-12-06 11:44:12', 0, '2013143216', 4);
INSERT INTO `pickthings` VALUES (190, '饭卡', '教学楼', '2016-11-25', 'elec', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-12-06 11:44:12', 0, '2013143218', 1);
INSERT INTO `pickthings` VALUES (191, '饭卡', '教学楼', '2016-11-25', 'elec', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-12-06 11:44:12', 0, '2013143217', 787);
INSERT INTO `pickthings` VALUES (194, '饭卡', '教学楼', '2016-11-25', 'book', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-12-07 11:44:12', 0, '2013143218', 1);
INSERT INTO `pickthings` VALUES (195, '饭卡', '教学楼', '2016-11-25', 'elec', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-12-07 11:44:12', 0, '2013143218', 1);
INSERT INTO `pickthings` VALUES (199, '饭卡', '教学楼', '2016-11-25', 'clo', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-12-07 11:44:12', 0, '2013143216', 4);
INSERT INTO `pickthings` VALUES (200, '饭卡', '教学楼', '2016-11-25', 'elec', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-12-07 11:34:12', 0, '2013143218', 1);
INSERT INTO `pickthings` VALUES (203, '饭卡', '教学楼', '2016-11-25', 'clo', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-12-08 11:48:12', 0, '2013143218', 1);
INSERT INTO `pickthings` VALUES (205, '饭卡', '教学楼', '2016-11-25', 'elec', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-12-08 11:44:12', 0, '2013143218', 1);
INSERT INTO `pickthings` VALUES (214, '饭卡', '教学楼', '2016-11-30', 'clo', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-12-08 15:21:10', 0, '2013143218', 1);
INSERT INTO `pickthings` VALUES (220, '饭卡', '教学楼', '2016-11-30', 'elec', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-12-26 17:36:34', 0, '2013031308', 2);
INSERT INTO `pickthings` VALUES (222, '饭卡', '教学楼', '2016-11-30', 'card', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-12-28 17:34:28', 1, '2013143218', 1);
INSERT INTO `pickthings` VALUES (224, '饭卡', '教学楼', '2016-11-30', 'clo', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-12-30 17:36:22', 0, '2013031308', 2);
INSERT INTO `pickthings` VALUES (227, '饭卡', '教学楼', '2016-11-30', 'clo', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-12-28 17:36:30', 0, '2013031308', 2);
INSERT INTO `pickthings` VALUES (230, '饭卡', '教学楼', '2016-11-30', 'clo', '164', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', NULL, NULL, '2016-12-30 15:26:18', 2, '2013021308', 2);
INSERT INTO `pickthings` VALUES (231, '钱包', '教学楼', '2017-01-24', 'per_eff', NULL, 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '红色钱包一个', '', NULL, '2017-01-24 20:50:34', 1, '2013143218', 1);
INSERT INTO `pickthings` VALUES (232, '饭卡', '食堂', '2017-03-09', 'card', '123', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡', '', NULL, '2017-03-09 17:24:54', 0, '2013143216', 4);
INSERT INTO `pickthings` VALUES (233, '钱包', '理学楼', '2017-03-09', 'per_eff', NULL, 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '', '', NULL, '2017-03-09 20:02:45', 0, '2013143218', 1);
INSERT INTO `pickthings` VALUES (254, '饭卡1', '教学楼3', '2017-04-06', 'card', '144', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡1', NULL, NULL, '2017-04-06 00:09:39', 0, '2013143218', 1);
INSERT INTO `pickthings` VALUES (255, '饭卡2', '教学楼6', '2017-04-06', 'card', '144', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡2', NULL, NULL, '2017-04-06 00:09:39', 0, '2013143218', 1);
INSERT INTO `pickthings` VALUES (256, '饭卡3', '教学楼9', '2017-04-06', 'card', '144', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡3', NULL, NULL, '2017-04-06 00:09:39', 0, '2013143218', 1);
INSERT INTO `pickthings` VALUES (257, '饭卡4', '教学楼12', '2017-04-06', 'card', '144', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡4', NULL, NULL, '2017-04-06 00:09:39', 0, '2013143218', 1);
INSERT INTO `pickthings` VALUES (258, '饭卡5', '教学楼15', '2017-04-06', 'card', '144', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡5', NULL, NULL, '2017-04-06 00:09:40', 0, '2013143218', 1);
INSERT INTO `pickthings` VALUES (259, '饭卡6', '教学楼18', '2017-04-06', 'card', '144', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡6', NULL, NULL, '2017-04-06 00:09:40', 0, '2013143218', 1);
INSERT INTO `pickthings` VALUES (260, '饭卡7', '教学楼21', '2017-04-06', 'card', '144', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡7', NULL, NULL, '2017-04-06 00:09:40', 1, '2013143218', 1);
INSERT INTO `pickthings` VALUES (261, '饭卡8', '教学楼24', '2017-04-06', 'card', '144', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡8', NULL, NULL, '2017-04-06 00:09:40', 1, '2013143218', 1);
INSERT INTO `pickthings` VALUES (262, '饭卡9', '教学楼27', '2017-04-06', 'card', '144', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡9', NULL, NULL, '2017-04-06 00:09:40', 1, '2013143218', 1);
INSERT INTO `pickthings` VALUES (263, '饭卡10', '教学楼30', '2017-04-06', 'card', '144', 'static\\upload\\find\\2017\\03\\2013143218\\20161130151920.jpg', '一张饭卡10', NULL, NULL, '2017-04-06 00:09:40', 1, '2013143218', 1);
INSERT INTO `pickthings` VALUES (264, '钥匙', '食堂', '2017-04-06', 'per_eff', NULL, NULL, '一串白色的钥匙，上面有个U盘', '食堂', '15802850670', '2017-04-07 20:00:10', 1, '2013143218', 1);
INSERT INTO `pickthings` VALUES (267, '钱包', '回宿舍的路上', '2017-04-07', 'per_eff', NULL, NULL, '', '', '', '2017-04-08 03:08:00', 0, '2013143218', 1);
INSERT INTO `pickthings` VALUES (269, '钥匙', '路上', '2017-04-19', 'per_eff', NULL, 'static\\upload/find\\2017\\04\\2013143218/20170421035808787.png', '一串白色的钥匙', '', '', '2017-04-21 03:58:09', 2, '2013143218', 1);
INSERT INTO `pickthings` VALUES (270, 'test', 'test', '2020-03-10', 'card', '343', 'static\\upload/find\\2020\\03\\2013031308/20200321150148984.png', 'test', '', '', '2020-03-21 07:01:49', 0, '2013031308', 2);

-- ----------------------------
-- Table structure for school
-- ----------------------------
DROP TABLE IF EXISTS `school`;
CREATE TABLE `school`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'School ID 自增',
  `SchoolCode` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '学校代码',
  `SchoolName` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '学校名称',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SchoolCode`(`SchoolCode`) USING BTREE,
  INDEX `ID`(`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of school
-- ----------------------------
INSERT INTO `school` VALUES (1, '10684', '广西民族大学');

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `StudentNo` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '学号',
  `StudentName` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `ClassNo` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '班级',
  `Sex` char(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '性别',
  `Birth` date NOT NULL COMMENT '生日',
  `IdCard` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '身份证号码',
  `TelPhone` char(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '联系电话',
  PRIMARY KEY (`StudentNo`) USING BTREE,
  INDEX `pk_classno`(`ClassNo`) USING BTREE,
  CONSTRAINT `pk_classno` FOREIGN KEY (`ClassNo`) REFERENCES `classes` (`ClassNo`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('2013143218', '黎国林', '20131432', '1', '2017-03-12', '1234444', '1132324');

-- ----------------------------
-- Table structure for systemlog
-- ----------------------------
DROP TABLE IF EXISTS `systemlog`;
CREATE TABLE `systemlog`  (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '描述',
  `ExceptionCode` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '异常代码',
  `Type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型',
  `RequestIp` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求人IP',
  `ExceptionDetail` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '异常详细信息',
  `Method` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '请求方法',
  `Params` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '请求参数',
  `CreateBy` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '操作人',
  `CreateDate` datetime(0) NOT NULL COMMENT '操作时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 945 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of systemlog
-- ----------------------------
INSERT INTO `systemlog` VALUES (1, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143218', '2017-04-15 15:56:10');
INSERT INTO `systemlog` VALUES (2, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-15 15:56:33');
INSERT INTO `systemlog` VALUES (4, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-15 15:58:06');
INSERT INTO `systemlog` VALUES (5, '搜索', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.searchAll()', NULL, '2013143218', '2017-04-15 15:58:19');
INSERT INTO `systemlog` VALUES (6, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-15 15:59:20');
INSERT INTO `systemlog` VALUES (7, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143218', '2017-04-15 16:40:18');
INSERT INTO `systemlog` VALUES (14, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-15 18:20:35');
INSERT INTO `systemlog` VALUES (15, '获取登录视图', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.LoginController.loginView()', NULL, NULL, '2017-04-15 18:22:24');
INSERT INTO `systemlog` VALUES (16, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143218', '2017-04-15 18:22:25');
INSERT INTO `systemlog` VALUES (17, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-15 18:22:46');
INSERT INTO `systemlog` VALUES (18, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-15 18:23:27');
INSERT INTO `systemlog` VALUES (19, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-15 18:29:02');
INSERT INTO `systemlog` VALUES (20, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-15 18:29:04');
INSERT INTO `systemlog` VALUES (21, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-15 18:33:07');
INSERT INTO `systemlog` VALUES (22, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-15 18:46:17');
INSERT INTO `systemlog` VALUES (23, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143218', '2017-04-15 18:46:25');
INSERT INTO `systemlog` VALUES (24, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-15 18:46:41');
INSERT INTO `systemlog` VALUES (25, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-15 18:46:51');
INSERT INTO `systemlog` VALUES (26, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143218', '2017-04-15 18:47:03');
INSERT INTO `systemlog` VALUES (27, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-15 18:48:06');
INSERT INTO `systemlog` VALUES (28, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-15 18:56:59');
INSERT INTO `systemlog` VALUES (29, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-15 18:57:10');
INSERT INTO `systemlog` VALUES (30, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143218', '2017-04-15 18:57:21');
INSERT INTO `systemlog` VALUES (31, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-15 23:00:34');
INSERT INTO `systemlog` VALUES (32, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-15 23:00:39');
INSERT INTO `systemlog` VALUES (33, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143218', '2017-04-15 23:00:41');
INSERT INTO `systemlog` VALUES (34, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-15 23:00:44');
INSERT INTO `systemlog` VALUES (35, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143218', '2017-04-15 23:00:57');
INSERT INTO `systemlog` VALUES (36, '网页登录', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.LoginController.login()', NULL, NULL, '2017-04-16 00:13:50');
INSERT INTO `systemlog` VALUES (37, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143218', '2017-04-16 00:14:38');
INSERT INTO `systemlog` VALUES (38, '获取发招领贴页面', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.publishPickThingsView()', NULL, '2013143218', '2017-04-16 00:14:54');
INSERT INTO `systemlog` VALUES (39, '发招领贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.publishPickThings()', NULL, '2013143218', '2017-04-16 00:15:12');
INSERT INTO `systemlog` VALUES (40, '保存（修改）个人信息', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.UserController.saveUserInfo()', NULL, '2013143218', '2017-04-16 00:30:45');
INSERT INTO `systemlog` VALUES (41, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 00:36:06');
INSERT INTO `systemlog` VALUES (42, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 00:45:39');
INSERT INTO `systemlog` VALUES (43, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 00:46:13');
INSERT INTO `systemlog` VALUES (44, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 00:48:52');
INSERT INTO `systemlog` VALUES (45, '获取登录视图', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.LoginController.loginView()', NULL, NULL, '2017-04-16 13:25:38');
INSERT INTO `systemlog` VALUES (46, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 13:25:38');
INSERT INTO `systemlog` VALUES (47, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 13:25:50');
INSERT INTO `systemlog` VALUES (48, '访问主页', NULL, '0', '101.226.66.192', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 13:27:55');
INSERT INTO `systemlog` VALUES (49, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 14:18:49');
INSERT INTO `systemlog` VALUES (50, '访问主页', NULL, '0', '10.56.14.179', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 14:19:36');
INSERT INTO `systemlog` VALUES (51, '访问主页', NULL, '0', '10.56.14.179', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 14:19:45');
INSERT INTO `systemlog` VALUES (58, '访问主页', NULL, '0', '180.130.10.215', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 15:04:32');
INSERT INTO `systemlog` VALUES (59, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 15:05:24');
INSERT INTO `systemlog` VALUES (60, '网页登录', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.LoginController.login()', NULL, NULL, '2017-04-16 15:06:42');
INSERT INTO `systemlog` VALUES (61, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143218', '2017-04-16 15:06:44');
INSERT INTO `systemlog` VALUES (62, '进入聊天室', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143218', '2017-04-16 15:08:02');
INSERT INTO `systemlog` VALUES (63, '进入聊天室', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143218', '2017-04-16 15:08:33');
INSERT INTO `systemlog` VALUES (64, '访问主页', NULL, '0', '180.130.10.215', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 15:10:17');
INSERT INTO `systemlog` VALUES (65, '访问主页', NULL, '0', '180.130.10.215', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 15:10:37');
INSERT INTO `systemlog` VALUES (66, '访问主页', NULL, '0', '101.226.125.16', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 15:10:46');
INSERT INTO `systemlog` VALUES (67, '移动设备登录', NULL, '0', '180.130.10.215', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-16 15:11:23');
INSERT INTO `systemlog` VALUES (68, '进入聊天室', NULL, '0', '180.130.10.215', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143216', '2017-04-16 15:11:36');
INSERT INTO `systemlog` VALUES (69, '访问主页', NULL, '0', '112.112.188.88', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 15:30:20');
INSERT INTO `systemlog` VALUES (70, '进入聊天室', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143218', '2017-04-16 15:44:57');
INSERT INTO `systemlog` VALUES (71, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 15:50:37');
INSERT INTO `systemlog` VALUES (72, '移动设备登录', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-16 15:51:05');
INSERT INTO `systemlog` VALUES (73, '移动设备登录', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-16 15:51:30');
INSERT INTO `systemlog` VALUES (74, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013031308', '2017-04-16 15:51:31');
INSERT INTO `systemlog` VALUES (75, '进入聊天室', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013031308', '2017-04-16 15:52:01');
INSERT INTO `systemlog` VALUES (76, '访问主页', NULL, '0', '112.112.188.88', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 16:05:38');
INSERT INTO `systemlog` VALUES (77, '进入用户中心页面', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.UserController.userCenter()', NULL, '2013031308', '2017-04-16 16:29:57');
INSERT INTO `systemlog` VALUES (78, '保存（修改）个人信息', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.UserController.saveUserInfo()', NULL, '2013031308', '2017-04-16 16:30:20');
INSERT INTO `systemlog` VALUES (79, '搜索', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.searchAll()', NULL, '2013031308', '2017-04-16 16:31:23');
INSERT INTO `systemlog` VALUES (80, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013031308', '2017-04-16 16:31:40');
INSERT INTO `systemlog` VALUES (81, '获取发招领贴页面', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.publishPickThingsView()', NULL, '2013031308', '2017-04-16 16:31:42');
INSERT INTO `systemlog` VALUES (82, '获取发寻物贴页面', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.LostThingsController.publishLostThingsView()', NULL, '2013031308', '2017-04-16 16:31:46');
INSERT INTO `systemlog` VALUES (83, '快速查看招领信息上一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.previous()', NULL, '2013031308', '2017-04-16 16:32:31');
INSERT INTO `systemlog` VALUES (84, '快速查看招领信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, '2013031308', '2017-04-16 16:32:42');
INSERT INTO `systemlog` VALUES (85, '快速查看招领信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, '2013031308', '2017-04-16 16:32:48');
INSERT INTO `systemlog` VALUES (86, '快速查看招领信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, '2013031308', '2017-04-16 16:32:52');
INSERT INTO `systemlog` VALUES (87, '快速查看招领信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, '2013031308', '2017-04-16 16:32:54');
INSERT INTO `systemlog` VALUES (88, '进入聊天室', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013031308', '2017-04-16 16:34:25');
INSERT INTO `systemlog` VALUES (89, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013031308', '2017-04-16 16:34:40');
INSERT INTO `systemlog` VALUES (90, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143218', '2017-04-16 16:37:42');
INSERT INTO `systemlog` VALUES (91, '获取发招领贴页面', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.publishPickThingsView()', NULL, '2013143218', '2017-04-16 16:38:38');
INSERT INTO `systemlog` VALUES (92, '获取发招领贴页面', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.publishPickThingsView()', NULL, '2013143218', '2017-04-16 16:38:38');
INSERT INTO `systemlog` VALUES (93, '获取发招领贴页面', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.publishPickThingsView()', NULL, '2013143218', '2017-04-16 16:38:39');
INSERT INTO `systemlog` VALUES (94, '获取发招领贴页面', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.publishPickThingsView()', NULL, '2013143218', '2017-04-16 16:38:39');
INSERT INTO `systemlog` VALUES (95, '获取发寻物贴页面', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.LostThingsController.publishLostThingsView()', NULL, '2013143218', '2017-04-16 16:38:39');
INSERT INTO `systemlog` VALUES (96, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143218', '2017-04-16 16:39:37');
INSERT INTO `systemlog` VALUES (97, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143218', '2017-04-16 16:40:06');
INSERT INTO `systemlog` VALUES (98, '获取登录视图', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.LoginController.loginView()', NULL, NULL, '2017-04-16 17:24:06');
INSERT INTO `systemlog` VALUES (99, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 17:24:07');
INSERT INTO `systemlog` VALUES (100, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:20:27');
INSERT INTO `systemlog` VALUES (101, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:21:01');
INSERT INTO `systemlog` VALUES (102, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:21:19');
INSERT INTO `systemlog` VALUES (103, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:21:31');
INSERT INTO `systemlog` VALUES (104, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:21:41');
INSERT INTO `systemlog` VALUES (105, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:21:42');
INSERT INTO `systemlog` VALUES (106, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:21:44');
INSERT INTO `systemlog` VALUES (107, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:21:45');
INSERT INTO `systemlog` VALUES (108, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:22:36');
INSERT INTO `systemlog` VALUES (109, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:22:43');
INSERT INTO `systemlog` VALUES (110, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:22:52');
INSERT INTO `systemlog` VALUES (111, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:22:59');
INSERT INTO `systemlog` VALUES (112, '搜索', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.searchAll()', NULL, NULL, '2017-04-16 18:23:26');
INSERT INTO `systemlog` VALUES (113, '搜索', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.searchAll()', NULL, NULL, '2017-04-16 18:23:28');
INSERT INTO `systemlog` VALUES (114, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:24:09');
INSERT INTO `systemlog` VALUES (115, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:24:15');
INSERT INTO `systemlog` VALUES (116, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:24:18');
INSERT INTO `systemlog` VALUES (117, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:24:29');
INSERT INTO `systemlog` VALUES (118, '快速查看招领信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-04-16 18:24:30');
INSERT INTO `systemlog` VALUES (119, '快速查看招领信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-04-16 18:24:44');
INSERT INTO `systemlog` VALUES (120, '快速查看招领信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-04-16 18:24:46');
INSERT INTO `systemlog` VALUES (121, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:24:48');
INSERT INTO `systemlog` VALUES (122, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:24:48');
INSERT INTO `systemlog` VALUES (123, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:24:48');
INSERT INTO `systemlog` VALUES (124, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:24:48');
INSERT INTO `systemlog` VALUES (125, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:24:49');
INSERT INTO `systemlog` VALUES (126, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:24:49');
INSERT INTO `systemlog` VALUES (127, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:24:49');
INSERT INTO `systemlog` VALUES (128, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:24:49');
INSERT INTO `systemlog` VALUES (129, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:24:54');
INSERT INTO `systemlog` VALUES (130, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:24:58');
INSERT INTO `systemlog` VALUES (131, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:24:58');
INSERT INTO `systemlog` VALUES (132, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:24:58');
INSERT INTO `systemlog` VALUES (133, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:24:59');
INSERT INTO `systemlog` VALUES (134, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:25:30');
INSERT INTO `systemlog` VALUES (135, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:25:32');
INSERT INTO `systemlog` VALUES (136, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:25:48');
INSERT INTO `systemlog` VALUES (137, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:25:51');
INSERT INTO `systemlog` VALUES (138, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:25:52');
INSERT INTO `systemlog` VALUES (139, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:25:57');
INSERT INTO `systemlog` VALUES (140, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:26:06');
INSERT INTO `systemlog` VALUES (141, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:26:08');
INSERT INTO `systemlog` VALUES (142, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:26:09');
INSERT INTO `systemlog` VALUES (143, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:26:22');
INSERT INTO `systemlog` VALUES (144, '搜索', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.searchAll()', NULL, NULL, '2017-04-16 18:26:22');
INSERT INTO `systemlog` VALUES (145, '搜索', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.searchAll()', NULL, NULL, '2017-04-16 18:26:22');
INSERT INTO `systemlog` VALUES (146, '搜索', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.searchAll()', NULL, NULL, '2017-04-16 18:26:22');
INSERT INTO `systemlog` VALUES (147, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:26:25');
INSERT INTO `systemlog` VALUES (148, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:26:27');
INSERT INTO `systemlog` VALUES (149, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:26:57');
INSERT INTO `systemlog` VALUES (150, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:26:57');
INSERT INTO `systemlog` VALUES (151, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:26:57');
INSERT INTO `systemlog` VALUES (152, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:26:57');
INSERT INTO `systemlog` VALUES (153, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:27:51');
INSERT INTO `systemlog` VALUES (154, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:27:51');
INSERT INTO `systemlog` VALUES (155, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:27:52');
INSERT INTO `systemlog` VALUES (156, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:27:53');
INSERT INTO `systemlog` VALUES (157, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:27:53');
INSERT INTO `systemlog` VALUES (158, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:27:53');
INSERT INTO `systemlog` VALUES (159, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:27:53');
INSERT INTO `systemlog` VALUES (160, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:28:13');
INSERT INTO `systemlog` VALUES (161, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:29:00');
INSERT INTO `systemlog` VALUES (162, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:29:03');
INSERT INTO `systemlog` VALUES (163, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:29:18');
INSERT INTO `systemlog` VALUES (164, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:30:30');
INSERT INTO `systemlog` VALUES (165, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:30:30');
INSERT INTO `systemlog` VALUES (166, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:30:30');
INSERT INTO `systemlog` VALUES (167, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:31:13');
INSERT INTO `systemlog` VALUES (168, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:31:47');
INSERT INTO `systemlog` VALUES (169, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:31:48');
INSERT INTO `systemlog` VALUES (170, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:31:49');
INSERT INTO `systemlog` VALUES (171, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:32:06');
INSERT INTO `systemlog` VALUES (172, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:32:07');
INSERT INTO `systemlog` VALUES (173, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:32:07');
INSERT INTO `systemlog` VALUES (174, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:32:12');
INSERT INTO `systemlog` VALUES (175, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:32:12');
INSERT INTO `systemlog` VALUES (176, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:32:14');
INSERT INTO `systemlog` VALUES (177, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:32:30');
INSERT INTO `systemlog` VALUES (178, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:33:07');
INSERT INTO `systemlog` VALUES (179, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:33:15');
INSERT INTO `systemlog` VALUES (180, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:33:20');
INSERT INTO `systemlog` VALUES (181, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:33:34');
INSERT INTO `systemlog` VALUES (182, '访问主页', NULL, '0', '220.181.132.214', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:33:45');
INSERT INTO `systemlog` VALUES (183, '访问主页', NULL, '0', '220.181.132.198', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:33:57');
INSERT INTO `systemlog` VALUES (184, '访问主页', NULL, '0', '182.118.20.146', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:33:58');
INSERT INTO `systemlog` VALUES (185, '访问主页', NULL, '0', '220.181.132.214', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:34:03');
INSERT INTO `systemlog` VALUES (186, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:34:07');
INSERT INTO `systemlog` VALUES (187, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:34:07');
INSERT INTO `systemlog` VALUES (188, '访问主页', NULL, '0', '101.199.108.53', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:34:09');
INSERT INTO `systemlog` VALUES (189, '访问主页', NULL, '0', '220.181.132.194', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:34:19');
INSERT INTO `systemlog` VALUES (190, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:34:33');
INSERT INTO `systemlog` VALUES (191, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:34:53');
INSERT INTO `systemlog` VALUES (192, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:34:54');
INSERT INTO `systemlog` VALUES (193, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:34:56');
INSERT INTO `systemlog` VALUES (194, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:34:56');
INSERT INTO `systemlog` VALUES (195, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:35:23');
INSERT INTO `systemlog` VALUES (196, '快速查看寻物信息上一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.LostThingsController.previous()', NULL, NULL, '2017-04-16 18:35:29');
INSERT INTO `systemlog` VALUES (197, '快速查看寻物信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-04-16 18:35:32');
INSERT INTO `systemlog` VALUES (198, '快速查看寻物信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-04-16 18:35:33');
INSERT INTO `systemlog` VALUES (199, '快速查看寻物信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-04-16 18:35:34');
INSERT INTO `systemlog` VALUES (200, '快速查看寻物信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-04-16 18:35:37');
INSERT INTO `systemlog` VALUES (201, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:35:38');
INSERT INTO `systemlog` VALUES (202, '快速查看寻物信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-04-16 18:35:43');
INSERT INTO `systemlog` VALUES (203, '快速查看寻物信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-04-16 18:35:45');
INSERT INTO `systemlog` VALUES (204, '快速查看寻物信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-04-16 18:35:48');
INSERT INTO `systemlog` VALUES (205, '快速查看寻物信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-04-16 18:35:56');
INSERT INTO `systemlog` VALUES (206, '快速查看寻物信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-04-16 18:35:59');
INSERT INTO `systemlog` VALUES (207, '快速查看寻物信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-04-16 18:36:01');
INSERT INTO `systemlog` VALUES (208, '快速查看寻物信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-04-16 18:36:05');
INSERT INTO `systemlog` VALUES (209, '快速查看招领信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-04-16 18:36:12');
INSERT INTO `systemlog` VALUES (210, '快速查看招领信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-04-16 18:36:14');
INSERT INTO `systemlog` VALUES (211, '快速查看招领信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-04-16 18:36:14');
INSERT INTO `systemlog` VALUES (212, '快速查看招领信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-04-16 18:36:14');
INSERT INTO `systemlog` VALUES (213, '快速查看招领信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-04-16 18:36:14');
INSERT INTO `systemlog` VALUES (214, '快速查看招领信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-04-16 18:36:14');
INSERT INTO `systemlog` VALUES (215, '快速查看招领信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-04-16 18:36:14');
INSERT INTO `systemlog` VALUES (216, '快速查看招领信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-04-16 18:36:17');
INSERT INTO `systemlog` VALUES (217, '快速查看招领信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-04-16 18:36:18');
INSERT INTO `systemlog` VALUES (218, '快速查看招领信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-04-16 18:36:18');
INSERT INTO `systemlog` VALUES (219, '快速查看招领信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-04-16 18:36:18');
INSERT INTO `systemlog` VALUES (220, '快速查看招领信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-04-16 18:36:18');
INSERT INTO `systemlog` VALUES (221, '快速查看招领信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-04-16 18:36:24');
INSERT INTO `systemlog` VALUES (222, '快速查看招领信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-04-16 18:36:24');
INSERT INTO `systemlog` VALUES (223, '快速查看招领信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-04-16 18:36:24');
INSERT INTO `systemlog` VALUES (224, '快速查看招领信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-04-16 18:36:24');
INSERT INTO `systemlog` VALUES (225, '快速查看招领信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-04-16 18:36:25');
INSERT INTO `systemlog` VALUES (226, '快速查看招领信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-04-16 18:36:26');
INSERT INTO `systemlog` VALUES (227, '快速查看招领信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-04-16 18:36:27');
INSERT INTO `systemlog` VALUES (228, '快速查看招领信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-04-16 18:36:28');
INSERT INTO `systemlog` VALUES (229, '快速查看招领信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-04-16 18:36:28');
INSERT INTO `systemlog` VALUES (230, '快速查看招领信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-04-16 18:36:28');
INSERT INTO `systemlog` VALUES (231, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:36:52');
INSERT INTO `systemlog` VALUES (232, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:36:54');
INSERT INTO `systemlog` VALUES (233, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:36:54');
INSERT INTO `systemlog` VALUES (234, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:36:54');
INSERT INTO `systemlog` VALUES (235, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:36:54');
INSERT INTO `systemlog` VALUES (236, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:37:32');
INSERT INTO `systemlog` VALUES (237, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:37:35');
INSERT INTO `systemlog` VALUES (238, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:37:37');
INSERT INTO `systemlog` VALUES (239, '快速查看招领信息上一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.previous()', NULL, NULL, '2017-04-16 18:37:55');
INSERT INTO `systemlog` VALUES (240, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:38:12');
INSERT INTO `systemlog` VALUES (241, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:38:15');
INSERT INTO `systemlog` VALUES (242, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:38:16');
INSERT INTO `systemlog` VALUES (243, '搜索', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.searchAll()', NULL, NULL, '2017-04-16 18:38:19');
INSERT INTO `systemlog` VALUES (244, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:38:52');
INSERT INTO `systemlog` VALUES (245, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:38:57');
INSERT INTO `systemlog` VALUES (246, '搜索', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.searchAll()', NULL, NULL, '2017-04-16 18:39:01');
INSERT INTO `systemlog` VALUES (247, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:39:06');
INSERT INTO `systemlog` VALUES (248, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:40:12');
INSERT INTO `systemlog` VALUES (249, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:40:27');
INSERT INTO `systemlog` VALUES (250, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:40:40');
INSERT INTO `systemlog` VALUES (251, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:41:20');
INSERT INTO `systemlog` VALUES (252, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:41:28');
INSERT INTO `systemlog` VALUES (253, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:41:38');
INSERT INTO `systemlog` VALUES (254, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:41:48');
INSERT INTO `systemlog` VALUES (255, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:42:06');
INSERT INTO `systemlog` VALUES (256, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:42:08');
INSERT INTO `systemlog` VALUES (257, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:42:10');
INSERT INTO `systemlog` VALUES (258, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:42:16');
INSERT INTO `systemlog` VALUES (259, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:42:16');
INSERT INTO `systemlog` VALUES (260, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:42:17');
INSERT INTO `systemlog` VALUES (261, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:42:20');
INSERT INTO `systemlog` VALUES (262, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:42:21');
INSERT INTO `systemlog` VALUES (263, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:42:37');
INSERT INTO `systemlog` VALUES (264, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:42:40');
INSERT INTO `systemlog` VALUES (265, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:42:58');
INSERT INTO `systemlog` VALUES (266, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:43:22');
INSERT INTO `systemlog` VALUES (267, '搜索', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.searchAll()', NULL, NULL, '2017-04-16 18:43:22');
INSERT INTO `systemlog` VALUES (268, '搜索', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.searchAll()', NULL, NULL, '2017-04-16 18:43:25');
INSERT INTO `systemlog` VALUES (269, '搜索', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.searchAll()', NULL, NULL, '2017-04-16 18:43:32');
INSERT INTO `systemlog` VALUES (270, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:44:34');
INSERT INTO `systemlog` VALUES (271, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:44:38');
INSERT INTO `systemlog` VALUES (272, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:46:31');
INSERT INTO `systemlog` VALUES (273, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:47:10');
INSERT INTO `systemlog` VALUES (274, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:47:28');
INSERT INTO `systemlog` VALUES (275, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:47:34');
INSERT INTO `systemlog` VALUES (276, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:47:50');
INSERT INTO `systemlog` VALUES (277, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:47:57');
INSERT INTO `systemlog` VALUES (278, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:48:00');
INSERT INTO `systemlog` VALUES (279, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:48:00');
INSERT INTO `systemlog` VALUES (280, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:48:00');
INSERT INTO `systemlog` VALUES (281, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:48:01');
INSERT INTO `systemlog` VALUES (282, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:48:01');
INSERT INTO `systemlog` VALUES (283, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:48:01');
INSERT INTO `systemlog` VALUES (284, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:48:01');
INSERT INTO `systemlog` VALUES (285, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:48:01');
INSERT INTO `systemlog` VALUES (286, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:48:02');
INSERT INTO `systemlog` VALUES (287, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:48:02');
INSERT INTO `systemlog` VALUES (288, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:48:02');
INSERT INTO `systemlog` VALUES (289, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:48:10');
INSERT INTO `systemlog` VALUES (290, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:48:11');
INSERT INTO `systemlog` VALUES (291, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:48:11');
INSERT INTO `systemlog` VALUES (292, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:48:11');
INSERT INTO `systemlog` VALUES (293, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:48:11');
INSERT INTO `systemlog` VALUES (294, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:48:25');
INSERT INTO `systemlog` VALUES (295, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:53:20');
INSERT INTO `systemlog` VALUES (296, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:53:48');
INSERT INTO `systemlog` VALUES (297, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:53:51');
INSERT INTO `systemlog` VALUES (298, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:53:56');
INSERT INTO `systemlog` VALUES (299, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:54:09');
INSERT INTO `systemlog` VALUES (300, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:54:46');
INSERT INTO `systemlog` VALUES (301, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:55:05');
INSERT INTO `systemlog` VALUES (302, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:56:35');
INSERT INTO `systemlog` VALUES (303, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:56:40');
INSERT INTO `systemlog` VALUES (304, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 18:57:26');
INSERT INTO `systemlog` VALUES (305, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 19:07:23');
INSERT INTO `systemlog` VALUES (306, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 19:07:43');
INSERT INTO `systemlog` VALUES (307, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 19:08:14');
INSERT INTO `systemlog` VALUES (308, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 19:08:16');
INSERT INTO `systemlog` VALUES (309, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 19:11:10');
INSERT INTO `systemlog` VALUES (310, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 19:11:32');
INSERT INTO `systemlog` VALUES (311, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 19:11:52');
INSERT INTO `systemlog` VALUES (312, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 19:11:53');
INSERT INTO `systemlog` VALUES (313, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 19:11:54');
INSERT INTO `systemlog` VALUES (314, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 19:11:54');
INSERT INTO `systemlog` VALUES (315, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 19:12:21');
INSERT INTO `systemlog` VALUES (316, '网页登录', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.LoginController.login()', NULL, NULL, '2017-04-16 19:14:05');
INSERT INTO `systemlog` VALUES (317, '进入聊天室', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143217', '2017-04-16 19:14:13');
INSERT INTO `systemlog` VALUES (318, '进入聊天室', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143217', '2017-04-16 19:15:20');
INSERT INTO `systemlog` VALUES (319, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 19:16:08');
INSERT INTO `systemlog` VALUES (320, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 19:18:32');
INSERT INTO `systemlog` VALUES (321, '快速查看招领信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-04-16 19:18:54');
INSERT INTO `systemlog` VALUES (322, '快速查看招领信息上一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.previous()', NULL, NULL, '2017-04-16 19:18:56');
INSERT INTO `systemlog` VALUES (323, '快速查看招领信息下一贴', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-04-16 19:18:58');
INSERT INTO `systemlog` VALUES (324, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 19:18:59');
INSERT INTO `systemlog` VALUES (325, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 19:19:40');
INSERT INTO `systemlog` VALUES (326, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 19:20:18');
INSERT INTO `systemlog` VALUES (327, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 19:20:57');
INSERT INTO `systemlog` VALUES (328, '搜索', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.searchAll()', NULL, NULL, '2017-04-16 19:21:18');
INSERT INTO `systemlog` VALUES (329, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 19:21:57');
INSERT INTO `systemlog` VALUES (330, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 19:32:49');
INSERT INTO `systemlog` VALUES (331, '访问主页', NULL, '0', '101.226.66.181', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 19:33:14');
INSERT INTO `systemlog` VALUES (332, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 19:33:20');
INSERT INTO `systemlog` VALUES (333, '访问主页', NULL, '0', '117.136.16.38', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 19:33:22');
INSERT INTO `systemlog` VALUES (334, '访问主页', NULL, '0', '117.136.16.38', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 19:33:37');
INSERT INTO `systemlog` VALUES (335, '访问主页', NULL, '0', '117.136.16.38', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 19:33:55');
INSERT INTO `systemlog` VALUES (336, '访问主页', NULL, '0', '117.136.16.38', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 19:34:31');
INSERT INTO `systemlog` VALUES (337, '访问主页', NULL, '0', '117.136.16.38', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 19:34:52');
INSERT INTO `systemlog` VALUES (338, '访问主页', NULL, '0', '117.136.16.38', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 19:44:23');
INSERT INTO `systemlog` VALUES (339, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 20:09:26');
INSERT INTO `systemlog` VALUES (340, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 20:25:11');
INSERT INTO `systemlog` VALUES (341, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 20:25:28');
INSERT INTO `systemlog` VALUES (342, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 20:25:58');
INSERT INTO `systemlog` VALUES (343, '搜索', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.searchAll()', NULL, NULL, '2017-04-16 20:31:09');
INSERT INTO `systemlog` VALUES (344, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 20:36:03');
INSERT INTO `systemlog` VALUES (345, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 20:37:13');
INSERT INTO `systemlog` VALUES (346, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 21:53:47');
INSERT INTO `systemlog` VALUES (347, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 21:54:47');
INSERT INTO `systemlog` VALUES (348, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 21:54:58');
INSERT INTO `systemlog` VALUES (349, '移动设备登录', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-16 21:55:38');
INSERT INTO `systemlog` VALUES (350, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 21:55:52');
INSERT INTO `systemlog` VALUES (351, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 21:55:57');
INSERT INTO `systemlog` VALUES (352, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 21:56:12');
INSERT INTO `systemlog` VALUES (353, '快速查看招领信息下一贴', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-04-16 21:56:26');
INSERT INTO `systemlog` VALUES (354, '快速查看招领信息下一贴', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-04-16 21:56:28');
INSERT INTO `systemlog` VALUES (355, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 21:56:41');
INSERT INTO `systemlog` VALUES (356, '网页登录', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.LoginController.login()', NULL, NULL, '2017-04-16 21:58:16');
INSERT INTO `systemlog` VALUES (357, '进入聊天室', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143218', '2017-04-16 21:58:21');
INSERT INTO `systemlog` VALUES (358, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 22:01:37');
INSERT INTO `systemlog` VALUES (359, '移动设备登录', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-16 22:04:58');
INSERT INTO `systemlog` VALUES (360, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013132157', '2017-04-16 22:04:59');
INSERT INTO `systemlog` VALUES (361, '获取发招领贴页面', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.PickThingsController.publishPickThingsView()', NULL, '2013132157', '2017-04-16 22:05:15');
INSERT INTO `systemlog` VALUES (362, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013132157', '2017-04-16 22:06:27');
INSERT INTO `systemlog` VALUES (363, '访问主页', NULL, '0', '180.153.206.17', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 22:07:35');
INSERT INTO `systemlog` VALUES (364, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013132157', '2017-04-16 22:07:44');
INSERT INTO `systemlog` VALUES (365, '获取发寻物贴页面', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.LostThingsController.publishLostThingsView()', NULL, '2013132157', '2017-04-16 22:07:50');
INSERT INTO `systemlog` VALUES (366, '进入用户中心页面', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.UserController.userCenter()', NULL, '2013132157', '2017-04-16 22:07:59');
INSERT INTO `systemlog` VALUES (367, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013132157', '2017-04-16 22:09:04');
INSERT INTO `systemlog` VALUES (368, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013132157', '2017-04-16 22:09:35');
INSERT INTO `systemlog` VALUES (369, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013132157', '2017-04-16 22:09:41');
INSERT INTO `systemlog` VALUES (370, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013132157', '2017-04-16 22:10:17');
INSERT INTO `systemlog` VALUES (371, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013132157', '2017-04-16 22:10:40');
INSERT INTO `systemlog` VALUES (372, '访问主页', NULL, '0', '117.136.16.84', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 22:10:54');
INSERT INTO `systemlog` VALUES (373, '搜索', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.searchAll()', NULL, '2013132157', '2017-04-16 22:11:15');
INSERT INTO `systemlog` VALUES (374, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013132157', '2017-04-16 22:11:37');
INSERT INTO `systemlog` VALUES (375, '移动设备登录', NULL, '0', '117.136.16.84', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-16 22:11:37');
INSERT INTO `systemlog` VALUES (376, '访问主页', NULL, '0', '117.136.16.84', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013041121', '2017-04-16 22:11:38');
INSERT INTO `systemlog` VALUES (377, '进入聊天室', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013132157', '2017-04-16 22:11:47');
INSERT INTO `systemlog` VALUES (378, '访问主页', NULL, '0', '117.136.16.84', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013041121', '2017-04-16 22:12:19');
INSERT INTO `systemlog` VALUES (379, '进入聊天室', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143218', '2017-04-16 22:12:26');
INSERT INTO `systemlog` VALUES (380, '访问主页', NULL, '0', '117.136.16.84', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013041121', '2017-04-16 22:12:48');
INSERT INTO `systemlog` VALUES (381, '进入聊天室', NULL, '0', '117.136.16.84', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013041121', '2017-04-16 22:13:14');
INSERT INTO `systemlog` VALUES (382, '进入聊天室', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143218', '2017-04-16 22:15:39');
INSERT INTO `systemlog` VALUES (383, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013132157', '2017-04-16 22:15:47');
INSERT INTO `systemlog` VALUES (384, '进入聊天室', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013132157', '2017-04-16 22:15:56');
INSERT INTO `systemlog` VALUES (385, '访问主页', NULL, '0', '117.136.16.68', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 22:18:04');
INSERT INTO `systemlog` VALUES (386, '移动设备登录', NULL, '0', '117.136.16.68', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-16 22:18:39');
INSERT INTO `systemlog` VALUES (387, '访问主页', NULL, '0', '117.136.16.68', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013023120', '2017-04-16 22:18:39');
INSERT INTO `systemlog` VALUES (388, '进入聊天室', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143218', '2017-04-16 22:19:04');
INSERT INTO `systemlog` VALUES (389, '移动设备登录', NULL, '0', '117.136.16.89', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-16 22:32:39');
INSERT INTO `systemlog` VALUES (395, '进入聊天室', NULL, '0', '117.136.16.89', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2014073120', '2017-04-16 22:34:27');
INSERT INTO `systemlog` VALUES (399, '进入聊天室', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143218', '2017-04-16 22:46:44');
INSERT INTO `systemlog` VALUES (400, '移动设备登录', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-16 22:47:03');
INSERT INTO `systemlog` VALUES (401, '移动设备登录', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-16 22:47:38');
INSERT INTO `systemlog` VALUES (402, '进入聊天室', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2014073120', '2017-04-16 22:47:50');
INSERT INTO `systemlog` VALUES (403, '注销', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.LoginController.logout()', NULL, '2014073120', '2017-04-16 22:47:59');
INSERT INTO `systemlog` VALUES (404, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 22:48:00');
INSERT INTO `systemlog` VALUES (405, '注销', NULL, '0', '101.226.33.205', NULL, 'com.lin.lostandfound.controller.LoginController.logout()', NULL, NULL, '2017-04-16 22:48:09');
INSERT INTO `systemlog` VALUES (406, '访问主页', NULL, '0', '101.226.33.205', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 22:48:09');
INSERT INTO `systemlog` VALUES (407, '移动设备登录', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-16 22:48:24');
INSERT INTO `systemlog` VALUES (408, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2014073126', '2017-04-16 22:48:25');
INSERT INTO `systemlog` VALUES (409, '注销', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.LoginController.logout()', NULL, '2014073126', '2017-04-16 22:48:38');
INSERT INTO `systemlog` VALUES (410, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 22:48:38');
INSERT INTO `systemlog` VALUES (411, '移动设备登录', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-16 22:49:24');
INSERT INTO `systemlog` VALUES (412, '注销', NULL, '0', '218.63.75.76', NULL, 'com.lin.lostandfound.controller.LoginController.logout()', NULL, '2014073120', '2017-04-16 22:49:57');
INSERT INTO `systemlog` VALUES (413, '访问主页', NULL, '0', '218.63.75.76', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 22:49:57');
INSERT INTO `systemlog` VALUES (414, '移动设备登录', NULL, '0', '218.63.75.76', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-16 22:50:33');
INSERT INTO `systemlog` VALUES (415, '移动设备登录', NULL, '0', '218.63.75.76', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-16 22:50:45');
INSERT INTO `systemlog` VALUES (416, '移动设备登录', NULL, '0', '218.63.75.76', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-16 22:52:23');
INSERT INTO `systemlog` VALUES (417, '移动设备登录', NULL, '0', '218.63.75.76', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-16 22:52:35');
INSERT INTO `systemlog` VALUES (418, '进入聊天室', NULL, '0', '218.63.75.76', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2014073134', '2017-04-16 22:52:41');
INSERT INTO `systemlog` VALUES (419, '进入聊天室', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143218', '2017-04-16 22:53:15');
INSERT INTO `systemlog` VALUES (420, '注销', NULL, '0', '218.63.75.76', NULL, 'com.lin.lostandfound.controller.LoginController.logout()', NULL, '2014073134', '2017-04-16 22:53:37');
INSERT INTO `systemlog` VALUES (421, '访问主页', NULL, '0', '218.63.75.76', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 22:53:37');
INSERT INTO `systemlog` VALUES (422, '移动设备登录', NULL, '0', '218.63.75.76', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-16 22:54:23');
INSERT INTO `systemlog` VALUES (423, '进入聊天室', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143218', '2017-04-16 22:56:53');
INSERT INTO `systemlog` VALUES (424, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143218', '2017-04-16 23:07:10');
INSERT INTO `systemlog` VALUES (425, '获取登录视图', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.LoginController.loginView()', NULL, NULL, '2017-04-16 23:23:37');
INSERT INTO `systemlog` VALUES (426, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 23:23:38');
INSERT INTO `systemlog` VALUES (427, '网页登录', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.LoginController.login()', NULL, NULL, '2017-04-16 23:24:26');
INSERT INTO `systemlog` VALUES (428, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143218', '2017-04-16 23:24:28');
INSERT INTO `systemlog` VALUES (429, '进入聊天室', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143218', '2017-04-16 23:25:35');
INSERT INTO `systemlog` VALUES (430, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-16 23:42:46');
INSERT INTO `systemlog` VALUES (431, '移动设备登录', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-16 23:43:35');
INSERT INTO `systemlog` VALUES (432, '移动设备登录', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-16 23:44:00');
INSERT INTO `systemlog` VALUES (433, '访问主页', NULL, '0', '10.56.14.179', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-17 00:10:49');
INSERT INTO `systemlog` VALUES (434, '访问主页', NULL, '0', '10.56.14.179', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-17 00:12:19');
INSERT INTO `systemlog` VALUES (435, '移动设备登录', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-17 11:54:41');
INSERT INTO `systemlog` VALUES (436, '移动设备登录', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-17 11:54:56');
INSERT INTO `systemlog` VALUES (437, '进入聊天室', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2014073103', '2017-04-17 11:55:03');
INSERT INTO `systemlog` VALUES (438, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-17 13:26:44');
INSERT INTO `systemlog` VALUES (439, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-17 13:47:53');
INSERT INTO `systemlog` VALUES (440, '移动设备登录', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-17 13:48:31');
INSERT INTO `systemlog` VALUES (441, '移动设备登录', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-17 13:50:42');
INSERT INTO `systemlog` VALUES (442, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013132157', '2017-04-17 13:50:43');
INSERT INTO `systemlog` VALUES (443, '进入聊天室', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013132157', '2017-04-17 13:51:28');
INSERT INTO `systemlog` VALUES (444, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-17 15:29:26');
INSERT INTO `systemlog` VALUES (445, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-17 15:29:26');
INSERT INTO `systemlog` VALUES (446, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-17 15:29:45');
INSERT INTO `systemlog` VALUES (447, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-17 15:33:43');
INSERT INTO `systemlog` VALUES (448, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-17 15:33:49');
INSERT INTO `systemlog` VALUES (449, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-17 16:29:47');
INSERT INTO `systemlog` VALUES (450, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-17 16:30:39');
INSERT INTO `systemlog` VALUES (451, '快速查看寻物信息下一贴', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-04-17 16:33:03');
INSERT INTO `systemlog` VALUES (452, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-17 17:10:28');
INSERT INTO `systemlog` VALUES (453, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-17 18:15:27');
INSERT INTO `systemlog` VALUES (454, '网页登录', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.LoginController.login()', NULL, NULL, '2017-04-17 18:42:10');
INSERT INTO `systemlog` VALUES (455, '进入聊天室', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2014073103', '2017-04-17 18:42:21');
INSERT INTO `systemlog` VALUES (456, '注销', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.LoginController.logout()', NULL, '2014073103', '2017-04-17 18:42:39');
INSERT INTO `systemlog` VALUES (457, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-17 18:42:39');
INSERT INTO `systemlog` VALUES (458, '网页登录', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.LoginController.login()', NULL, NULL, '2017-04-17 18:42:58');
INSERT INTO `systemlog` VALUES (459, '网页登录', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.LoginController.login()', NULL, NULL, '2017-04-17 18:43:07');
INSERT INTO `systemlog` VALUES (460, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2014073120', '2017-04-17 18:43:09');
INSERT INTO `systemlog` VALUES (461, '进入聊天室', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2014073120', '2017-04-17 18:43:29');
INSERT INTO `systemlog` VALUES (462, '注销', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.LoginController.logout()', NULL, '2014073120', '2017-04-17 18:44:47');
INSERT INTO `systemlog` VALUES (463, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-17 18:44:47');
INSERT INTO `systemlog` VALUES (464, '网页登录', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.LoginController.login()', NULL, NULL, '2017-04-17 18:45:09');
INSERT INTO `systemlog` VALUES (465, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2014073102', '2017-04-17 18:45:11');
INSERT INTO `systemlog` VALUES (466, '进入聊天室', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2014073102', '2017-04-17 18:45:19');
INSERT INTO `systemlog` VALUES (467, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-17 19:34:23');
INSERT INTO `systemlog` VALUES (468, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-17 19:36:34');
INSERT INTO `systemlog` VALUES (469, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-17 19:36:42');
INSERT INTO `systemlog` VALUES (470, '网页登录', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.LoginController.login()', NULL, NULL, '2017-04-17 19:54:57');
INSERT INTO `systemlog` VALUES (471, '注销', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.LoginController.logout()', NULL, '2014073126', '2017-04-17 19:55:26');
INSERT INTO `systemlog` VALUES (472, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-17 19:55:26');
INSERT INTO `systemlog` VALUES (473, '网页登录', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.LoginController.login()', NULL, NULL, '2017-04-17 19:56:12');
INSERT INTO `systemlog` VALUES (474, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2014073127', '2017-04-17 19:56:14');
INSERT INTO `systemlog` VALUES (475, '进入聊天室', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2014073127', '2017-04-17 19:56:35');
INSERT INTO `systemlog` VALUES (476, '进入聊天室', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2014073127', '2017-04-17 19:56:52');
INSERT INTO `systemlog` VALUES (477, '进入聊天室', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2014073127', '2017-04-17 19:57:03');
INSERT INTO `systemlog` VALUES (478, '网页登录', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.LoginController.login()', NULL, NULL, '2017-04-17 19:57:27');
INSERT INTO `systemlog` VALUES (479, '进入聊天室', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2014073120', '2017-04-17 19:57:34');
INSERT INTO `systemlog` VALUES (480, '进入聊天室', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2014073127', '2017-04-17 19:57:49');
INSERT INTO `systemlog` VALUES (481, '注销', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.LoginController.logout()', NULL, '2014073127', '2017-04-17 19:58:20');
INSERT INTO `systemlog` VALUES (482, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-17 19:58:20');
INSERT INTO `systemlog` VALUES (483, '注销', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.LoginController.logout()', NULL, NULL, '2017-04-17 19:58:32');
INSERT INTO `systemlog` VALUES (484, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-17 19:58:32');
INSERT INTO `systemlog` VALUES (485, '网页登录', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.LoginController.login()', NULL, NULL, '2017-04-17 19:59:18');
INSERT INTO `systemlog` VALUES (486, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2014073126', '2017-04-17 19:59:20');
INSERT INTO `systemlog` VALUES (487, '进入聊天室', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2014073126', '2017-04-17 19:59:29');
INSERT INTO `systemlog` VALUES (488, '移动设备登录', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-17 20:01:11');
INSERT INTO `systemlog` VALUES (489, '进入聊天室', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2014073103', '2017-04-17 20:01:23');
INSERT INTO `systemlog` VALUES (490, '注销', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.LoginController.logout()', NULL, '2014073126', '2017-04-17 20:03:39');
INSERT INTO `systemlog` VALUES (491, '访问主页', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-17 20:03:39');
INSERT INTO `systemlog` VALUES (492, '获取发寻物贴页面', NULL, '0', '218.63.75.77', NULL, 'com.lin.lostandfound.controller.LostThingsController.publishLostThingsView()', NULL, '2014073120', '2017-04-17 20:07:47');
INSERT INTO `systemlog` VALUES (493, '访问主页', NULL, '0', '117.136.16.50', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-17 20:37:10');
INSERT INTO `systemlog` VALUES (494, '移动设备登录', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-17 21:03:30');
INSERT INTO `systemlog` VALUES (495, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143218', '2017-04-17 21:03:36');
INSERT INTO `systemlog` VALUES (496, '注销', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.LoginController.logout()', NULL, '2013143218', '2017-04-17 21:03:40');
INSERT INTO `systemlog` VALUES (497, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-17 21:03:40');
INSERT INTO `systemlog` VALUES (498, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-17 21:19:17');
INSERT INTO `systemlog` VALUES (499, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-17 21:19:56');
INSERT INTO `systemlog` VALUES (500, '访问主页', NULL, '0', '220.181.132.214', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-17 21:20:23');
INSERT INTO `systemlog` VALUES (501, '访问主页', NULL, '0', '101.199.108.57', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-17 21:20:41');
INSERT INTO `systemlog` VALUES (502, '网页登录', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.LoginController.login()', NULL, NULL, '2017-04-17 21:21:17');
INSERT INTO `systemlog` VALUES (503, '进入聊天室', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143216', '2017-04-17 21:21:49');
INSERT INTO `systemlog` VALUES (504, '移动设备登录', NULL, '0', '10.56.14.179', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-17 21:22:19');
INSERT INTO `systemlog` VALUES (505, '进入聊天室', NULL, '0', '10.56.14.179', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143218', '2017-04-17 21:22:29');
INSERT INTO `systemlog` VALUES (506, '进入聊天室', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143216', '2017-04-17 21:23:54');
INSERT INTO `systemlog` VALUES (507, '进入聊天室', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143216', '2017-04-17 21:24:10');
INSERT INTO `systemlog` VALUES (508, '进入聊天室', NULL, '0', '10.56.14.179', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143218', '2017-04-17 21:24:18');
INSERT INTO `systemlog` VALUES (509, '进入聊天室', NULL, '0', '10.56.14.179', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143218', '2017-04-17 21:25:26');
INSERT INTO `systemlog` VALUES (510, '获取发招领贴页面', NULL, '0', '10.56.14.179', NULL, 'com.lin.lostandfound.controller.PickThingsController.publishPickThingsView()', NULL, '2013143218', '2017-04-17 21:25:54');
INSERT INTO `systemlog` VALUES (511, '获取发寻物贴页面', NULL, '0', '10.56.14.179', NULL, 'com.lin.lostandfound.controller.LostThingsController.publishLostThingsView()', NULL, '2013143218', '2017-04-17 21:26:08');
INSERT INTO `systemlog` VALUES (512, '访问主页', NULL, '0', '10.56.14.179', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143218', '2017-04-17 21:26:13');
INSERT INTO `systemlog` VALUES (513, '注销', NULL, '0', '10.56.14.179', NULL, 'com.lin.lostandfound.controller.LoginController.logout()', NULL, '2013143218', '2017-04-17 21:27:53');
INSERT INTO `systemlog` VALUES (514, '访问主页', NULL, '0', '10.56.14.179', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-17 21:27:54');
INSERT INTO `systemlog` VALUES (515, '移动设备登录', NULL, '0', '10.56.14.179', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-17 21:28:31');
INSERT INTO `systemlog` VALUES (516, '进入聊天室', NULL, '0', '10.56.14.179', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143218', '2017-04-17 21:28:36');
INSERT INTO `systemlog` VALUES (517, '访问主页', NULL, '0', '10.56.14.179', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143218', '2017-04-17 21:29:14');
INSERT INTO `systemlog` VALUES (518, '获取发招领贴页面', NULL, '0', '10.56.14.179', NULL, 'com.lin.lostandfound.controller.PickThingsController.publishPickThingsView()', NULL, '2013143218', '2017-04-17 21:29:17');
INSERT INTO `systemlog` VALUES (519, '获取发寻物贴页面', NULL, '0', '10.56.14.179', NULL, 'com.lin.lostandfound.controller.LostThingsController.publishLostThingsView()', NULL, '2013143218', '2017-04-17 21:29:19');
INSERT INTO `systemlog` VALUES (520, '进入聊天室', NULL, '0', '10.56.14.179', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143218', '2017-04-17 21:29:28');
INSERT INTO `systemlog` VALUES (521, '进入聊天室', NULL, '0', '10.56.14.179', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143218', '2017-04-17 21:30:18');
INSERT INTO `systemlog` VALUES (522, '进入用户中心页面', NULL, '0', '10.56.14.179', NULL, 'com.lin.lostandfound.controller.UserController.userCenter()', NULL, '2013143218', '2017-04-17 21:30:24');
INSERT INTO `systemlog` VALUES (523, '访问主页', NULL, '0', '10.56.14.179', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143218', '2017-04-17 21:30:43');
INSERT INTO `systemlog` VALUES (524, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-17 22:33:31');
INSERT INTO `systemlog` VALUES (525, '访问主页', NULL, '0', '220.181.132.214', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-17 22:34:12');
INSERT INTO `systemlog` VALUES (526, '访问主页', NULL, '0', '101.199.108.57', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-17 22:34:31');
INSERT INTO `systemlog` VALUES (527, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-17 23:01:52');
INSERT INTO `systemlog` VALUES (528, '访问主页', NULL, '0', '218.63.75.79', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-17 23:41:56');
INSERT INTO `systemlog` VALUES (529, '访问主页', NULL, '0', '117.136.16.36', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-18 11:48:13');
INSERT INTO `systemlog` VALUES (530, '移动设备登录', NULL, '0', '117.136.16.36', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-18 11:49:02');
INSERT INTO `systemlog` VALUES (531, '访问主页', NULL, '0', '117.136.16.36', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013132157', '2017-04-18 11:49:05');
INSERT INTO `systemlog` VALUES (532, '获取发寻物贴页面', NULL, '0', '117.136.16.36', NULL, 'com.lin.lostandfound.controller.LostThingsController.publishLostThingsView()', NULL, '2013132157', '2017-04-18 11:49:09');
INSERT INTO `systemlog` VALUES (533, '访问主页', NULL, '0', '183.224.9.104', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-18 14:41:12');
INSERT INTO `systemlog` VALUES (534, '访问主页', NULL, '0', '117.136.16.134', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-19 09:24:55');
INSERT INTO `systemlog` VALUES (535, '访问主页', NULL, '0', '117.136.84.234', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-19 19:11:44');
INSERT INTO `systemlog` VALUES (536, '访问主页', NULL, '0', '117.136.84.234', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-19 19:11:46');
INSERT INTO `systemlog` VALUES (537, '访问主页', NULL, '0', '117.136.84.234', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-19 19:12:23');
INSERT INTO `systemlog` VALUES (538, '移动设备登录', NULL, '0', '117.136.84.234', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-19 19:13:44');
INSERT INTO `systemlog` VALUES (539, '访问主页', NULL, '0', '117.136.84.234', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143234', '2017-04-19 19:13:46');
INSERT INTO `systemlog` VALUES (540, '进入聊天室', NULL, '0', '117.136.84.234', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143234', '2017-04-19 19:13:59');
INSERT INTO `systemlog` VALUES (541, '进入聊天室', NULL, '0', '117.136.84.234', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143234', '2017-04-19 19:14:22');
INSERT INTO `systemlog` VALUES (542, '获取发招领贴页面', NULL, '0', '117.136.84.234', NULL, 'com.lin.lostandfound.controller.PickThingsController.publishPickThingsView()', NULL, '2013143234', '2017-04-19 19:14:53');
INSERT INTO `systemlog` VALUES (543, '访问主页', NULL, '0', '117.136.84.234', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143234', '2017-04-19 19:15:08');
INSERT INTO `systemlog` VALUES (544, '获取发招领贴页面', NULL, '0', '117.136.84.234', NULL, 'com.lin.lostandfound.controller.PickThingsController.publishPickThingsView()', NULL, '2013143234', '2017-04-19 19:15:15');
INSERT INTO `systemlog` VALUES (545, '访问主页', NULL, '0', '117.136.84.234', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143234', '2017-04-19 19:16:03');
INSERT INTO `systemlog` VALUES (546, '搜索', NULL, '0', '117.136.84.234', NULL, 'com.lin.lostandfound.controller.IndexController.searchAll()', NULL, '2013143234', '2017-04-19 19:16:29');
INSERT INTO `systemlog` VALUES (547, '搜索', NULL, '0', '117.136.84.234', NULL, 'com.lin.lostandfound.controller.IndexController.searchAll()', NULL, '2013143234', '2017-04-19 19:16:43');
INSERT INTO `systemlog` VALUES (548, '进入聊天室', NULL, '0', '112.117.159.231', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143234', '2017-04-19 19:18:56');
INSERT INTO `systemlog` VALUES (549, '进入聊天室', NULL, '0', '112.117.159.231', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143234', '2017-04-19 19:19:57');
INSERT INTO `systemlog` VALUES (550, '进入聊天室', NULL, '0', '112.117.159.231', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143234', '2017-04-19 19:20:39');
INSERT INTO `systemlog` VALUES (551, '进入聊天室', NULL, '0', '112.117.159.231', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143234', '2017-04-19 19:21:17');
INSERT INTO `systemlog` VALUES (552, '访问主页', NULL, '0', '117.75.44.154', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-20 16:00:27');
INSERT INTO `systemlog` VALUES (553, '访问主页', NULL, '0', '117.75.44.154', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-20 16:00:50');
INSERT INTO `systemlog` VALUES (554, '访问主页', NULL, '0', '117.75.44.154', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-20 16:06:45');
INSERT INTO `systemlog` VALUES (555, '快速查看寻物信息上一贴', NULL, '0', '117.75.44.154', NULL, 'com.lin.lostandfound.controller.LostThingsController.previous()', NULL, NULL, '2017-04-20 16:07:03');
INSERT INTO `systemlog` VALUES (556, '快速查看寻物信息下一贴', NULL, '0', '117.75.44.154', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-04-20 16:07:05');
INSERT INTO `systemlog` VALUES (557, '快速查看寻物信息下一贴', NULL, '0', '117.75.44.154', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-04-20 16:07:07');
INSERT INTO `systemlog` VALUES (558, '移动设备登录', NULL, '0', '117.75.44.154', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-20 16:08:11');
INSERT INTO `systemlog` VALUES (559, '进入聊天室', NULL, '0', '117.75.44.154', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013031308', '2017-04-20 16:08:18');
INSERT INTO `systemlog` VALUES (560, '进入聊天室', NULL, '0', '117.75.44.154', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013031308', '2017-04-20 16:10:34');
INSERT INTO `systemlog` VALUES (561, '访问主页', NULL, '0', '117.75.19.123', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-20 16:52:04');
INSERT INTO `systemlog` VALUES (562, '访问主页', NULL, '0', '117.75.19.123', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-20 16:52:16');
INSERT INTO `systemlog` VALUES (563, '访问主页', NULL, '0', '117.75.19.123', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-20 16:52:23');
INSERT INTO `systemlog` VALUES (564, '访问主页', NULL, '0', '117.75.19.123', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-20 16:52:29');
INSERT INTO `systemlog` VALUES (565, '访问主页', NULL, '0', '117.75.19.123', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-20 16:52:31');
INSERT INTO `systemlog` VALUES (566, '访问主页', NULL, '0', '117.75.19.123', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-20 17:15:57');
INSERT INTO `systemlog` VALUES (567, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-20 19:36:58');
INSERT INTO `systemlog` VALUES (568, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-20 19:47:45');
INSERT INTO `systemlog` VALUES (569, '移动设备登录', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-20 19:48:24');
INSERT INTO `systemlog` VALUES (570, '保存感谢信息', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.UserController.saveThanks()', NULL, '2013031308', '2017-04-20 19:48:55');
INSERT INTO `systemlog` VALUES (571, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-20 23:00:20');
INSERT INTO `systemlog` VALUES (572, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-20 23:41:11');
INSERT INTO `systemlog` VALUES (573, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-20 23:41:30');
INSERT INTO `systemlog` VALUES (574, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 00:04:26');
INSERT INTO `systemlog` VALUES (575, '搜索', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.searchAll()', NULL, NULL, '2017-04-21 00:04:49');
INSERT INTO `systemlog` VALUES (576, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 00:05:11');
INSERT INTO `systemlog` VALUES (577, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 00:05:50');
INSERT INTO `systemlog` VALUES (578, '移动设备登录', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-21 00:06:18');
INSERT INTO `systemlog` VALUES (579, '保存感谢信息', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.UserController.saveThanks()', NULL, '2013031308', '2017-04-21 00:07:00');
INSERT INTO `systemlog` VALUES (580, '保存感谢信息', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.UserController.saveThanks()', NULL, '2013031308', '2017-04-21 00:19:00');
INSERT INTO `systemlog` VALUES (581, '进入聊天室', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013031308', '2017-04-21 00:38:01');
INSERT INTO `systemlog` VALUES (582, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 01:47:24');
INSERT INTO `systemlog` VALUES (583, '获取登录视图', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.LoginController.loginView()', NULL, NULL, '2017-04-21 01:47:45');
INSERT INTO `systemlog` VALUES (584, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 01:47:45');
INSERT INTO `systemlog` VALUES (585, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 01:48:30');
INSERT INTO `systemlog` VALUES (586, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 01:50:43');
INSERT INTO `systemlog` VALUES (587, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 01:52:13');
INSERT INTO `systemlog` VALUES (588, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 01:52:21');
INSERT INTO `systemlog` VALUES (589, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 02:07:33');
INSERT INTO `systemlog` VALUES (590, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 02:08:30');
INSERT INTO `systemlog` VALUES (591, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 02:08:40');
INSERT INTO `systemlog` VALUES (592, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 02:11:43');
INSERT INTO `systemlog` VALUES (593, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 02:11:56');
INSERT INTO `systemlog` VALUES (594, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 02:19:11');
INSERT INTO `systemlog` VALUES (595, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 02:23:37');
INSERT INTO `systemlog` VALUES (596, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 02:28:16');
INSERT INTO `systemlog` VALUES (597, '快速查看寻物信息下一贴', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-04-21 02:28:26');
INSERT INTO `systemlog` VALUES (598, '快速查看寻物信息下一贴', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-04-21 02:28:27');
INSERT INTO `systemlog` VALUES (599, '快速查看寻物信息下一贴', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-04-21 02:28:29');
INSERT INTO `systemlog` VALUES (600, '快速查看寻物信息下一贴', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-04-21 02:28:30');
INSERT INTO `systemlog` VALUES (601, '快速查看寻物信息下一贴', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-04-21 02:28:32');
INSERT INTO `systemlog` VALUES (602, '快速查看寻物信息下一贴', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-04-21 02:28:33');
INSERT INTO `systemlog` VALUES (603, '快速查看寻物信息上一贴', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.LostThingsController.previous()', NULL, NULL, '2017-04-21 02:28:36');
INSERT INTO `systemlog` VALUES (604, '快速查看寻物信息上一贴', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.LostThingsController.previous()', NULL, NULL, '2017-04-21 02:28:37');
INSERT INTO `systemlog` VALUES (605, '快速查看寻物信息上一贴', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.LostThingsController.previous()', NULL, NULL, '2017-04-21 02:28:39');
INSERT INTO `systemlog` VALUES (606, '快速查看寻物信息上一贴', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.LostThingsController.previous()', NULL, NULL, '2017-04-21 02:28:40');
INSERT INTO `systemlog` VALUES (607, '快速查看寻物信息上一贴', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.LostThingsController.previous()', NULL, NULL, '2017-04-21 02:28:41');
INSERT INTO `systemlog` VALUES (608, '快速查看寻物信息上一贴', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.LostThingsController.previous()', NULL, NULL, '2017-04-21 02:28:42');
INSERT INTO `systemlog` VALUES (609, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 02:28:44');
INSERT INTO `systemlog` VALUES (610, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 02:29:17');
INSERT INTO `systemlog` VALUES (611, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 02:30:03');
INSERT INTO `systemlog` VALUES (612, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 02:30:18');
INSERT INTO `systemlog` VALUES (613, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 02:32:31');
INSERT INTO `systemlog` VALUES (614, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 02:32:47');
INSERT INTO `systemlog` VALUES (615, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 02:33:59');
INSERT INTO `systemlog` VALUES (616, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 02:34:30');
INSERT INTO `systemlog` VALUES (617, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 02:35:05');
INSERT INTO `systemlog` VALUES (618, '快速查看寻物信息下一贴', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-04-21 02:35:15');
INSERT INTO `systemlog` VALUES (619, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 02:35:18');
INSERT INTO `systemlog` VALUES (620, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 02:35:46');
INSERT INTO `systemlog` VALUES (621, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 02:37:03');
INSERT INTO `systemlog` VALUES (622, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 02:37:46');
INSERT INTO `systemlog` VALUES (623, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 02:39:01');
INSERT INTO `systemlog` VALUES (624, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 02:39:34');
INSERT INTO `systemlog` VALUES (625, '网页登录', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.LoginController.login()', NULL, NULL, '2017-04-21 03:54:47');
INSERT INTO `systemlog` VALUES (626, '获取发招领贴页面', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.PickThingsController.publishPickThingsView()', NULL, '2013143218', '2017-04-21 03:55:17');
INSERT INTO `systemlog` VALUES (627, '发招领贴', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.PickThingsController.publishPickThings()', NULL, '2013143218', '2017-04-21 03:58:09');
INSERT INTO `systemlog` VALUES (628, '进入用户中心页面', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.UserController.userCenter()', NULL, '2013143218', '2017-04-21 04:01:15');
INSERT INTO `systemlog` VALUES (629, '批量删除招领贴信息', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.UserController.removeFindInfoList()', NULL, '2013143218', '2017-04-21 04:01:24');
INSERT INTO `systemlog` VALUES (630, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 04:35:24');
INSERT INTO `systemlog` VALUES (631, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 04:36:16');
INSERT INTO `systemlog` VALUES (632, '访问主页', NULL, '0', '117.75.129.165', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 14:14:55');
INSERT INTO `systemlog` VALUES (633, '访问主页', NULL, '0', '117.75.139.19', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 17:34:27');
INSERT INTO `systemlog` VALUES (634, '移动设备登录', NULL, '0', '117.75.139.19', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-21 17:40:06');
INSERT INTO `systemlog` VALUES (635, '进入聊天室', NULL, '0', '117.75.139.19', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143218', '2017-04-21 17:40:12');
INSERT INTO `systemlog` VALUES (636, '访问主页', NULL, '0', '117.75.139.19', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143218', '2017-04-21 17:43:44');
INSERT INTO `systemlog` VALUES (637, '进入用户中心页面', NULL, '0', '117.75.139.19', NULL, 'com.lin.lostandfound.controller.UserController.userCenter()', NULL, '2013143218', '2017-04-21 17:43:59');
INSERT INTO `systemlog` VALUES (638, '获取发招领贴页面', NULL, '0', '117.75.139.19', NULL, 'com.lin.lostandfound.controller.PickThingsController.publishPickThingsView()', NULL, '2013143218', '2017-04-21 17:44:45');
INSERT INTO `systemlog` VALUES (639, '获取发寻物贴页面', NULL, '0', '117.75.139.19', NULL, 'com.lin.lostandfound.controller.LostThingsController.publishLostThingsView()', NULL, '2013143218', '2017-04-21 17:44:48');
INSERT INTO `systemlog` VALUES (640, '搜索', NULL, '0', '117.75.139.19', NULL, 'com.lin.lostandfound.controller.IndexController.searchAll()', NULL, '2013143218', '2017-04-21 17:44:58');
INSERT INTO `systemlog` VALUES (641, '搜索', NULL, '0', '117.75.139.19', NULL, 'com.lin.lostandfound.controller.IndexController.searchAll()', NULL, '2013143218', '2017-04-21 17:45:04');
INSERT INTO `systemlog` VALUES (642, '搜索', NULL, '0', '117.75.139.19', NULL, 'com.lin.lostandfound.controller.IndexController.searchAll()', NULL, '2013143218', '2017-04-21 17:46:36');
INSERT INTO `systemlog` VALUES (643, '搜索', NULL, '0', '117.75.139.19', NULL, 'com.lin.lostandfound.controller.IndexController.searchAll()', NULL, '2013143218', '2017-04-21 17:46:47');
INSERT INTO `systemlog` VALUES (644, '访问主页', NULL, '0', '183.57.53.177', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 22:35:16');
INSERT INTO `systemlog` VALUES (645, '访问主页', NULL, '0', '180.153.201.15', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-21 22:35:25');
INSERT INTO `systemlog` VALUES (646, '访问主页', NULL, '0', '117.75.19.117', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-22 04:49:47');
INSERT INTO `systemlog` VALUES (647, '访问主页', NULL, '0', '117.75.149.142', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-22 18:24:34');
INSERT INTO `systemlog` VALUES (648, '访问主页', NULL, '0', '117.75.149.142', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-22 18:24:51');
INSERT INTO `systemlog` VALUES (649, '访问主页', NULL, '0', '117.75.149.142', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-22 18:27:13');
INSERT INTO `systemlog` VALUES (650, '访问主页', NULL, '0', '39.130.49.56', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-22 19:20:40');
INSERT INTO `systemlog` VALUES (651, '访问主页', NULL, '0', '117.136.72.87', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-22 23:37:14');
INSERT INTO `systemlog` VALUES (652, '访问主页', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-23 00:40:41');
INSERT INTO `systemlog` VALUES (653, '访问主页', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-23 00:43:37');
INSERT INTO `systemlog` VALUES (654, '移动设备登录', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-23 01:01:29');
INSERT INTO `systemlog` VALUES (655, '访问主页', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143218', '2017-04-23 01:01:30');
INSERT INTO `systemlog` VALUES (656, '进入聊天室', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143218', '2017-04-23 01:01:44');
INSERT INTO `systemlog` VALUES (657, '进入用户中心页面', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.UserController.userCenter()', NULL, '2013143218', '2017-04-23 01:03:07');
INSERT INTO `systemlog` VALUES (658, '获取发招领贴页面', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.PickThingsController.publishPickThingsView()', NULL, '2013143218', '2017-04-23 01:07:29');
INSERT INTO `systemlog` VALUES (659, '进入用户中心页面', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.UserController.userCenter()', NULL, '2013143218', '2017-04-23 01:08:11');
INSERT INTO `systemlog` VALUES (660, '访问主页', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143218', '2017-04-23 01:08:14');
INSERT INTO `systemlog` VALUES (661, '快速查看寻物信息下一贴', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, '2013143218', '2017-04-23 01:08:25');
INSERT INTO `systemlog` VALUES (662, '快速查看寻物信息下一贴', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, '2013143218', '2017-04-23 01:08:26');
INSERT INTO `systemlog` VALUES (663, '快速查看寻物信息下一贴', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, '2013143218', '2017-04-23 01:08:27');
INSERT INTO `systemlog` VALUES (664, '访问主页', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143218', '2017-04-23 01:10:29');
INSERT INTO `systemlog` VALUES (665, '搜索', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.IndexController.searchAll()', NULL, '2013143218', '2017-04-23 01:11:26');
INSERT INTO `systemlog` VALUES (666, '访问主页', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143218', '2017-04-23 01:12:04');
INSERT INTO `systemlog` VALUES (667, '进入用户中心页面', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.UserController.userCenter()', NULL, '2013143218', '2017-04-23 01:34:04');
INSERT INTO `systemlog` VALUES (668, '获取发招领贴页面', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.PickThingsController.publishPickThingsView()', NULL, '2013143218', '2017-04-23 01:34:24');
INSERT INTO `systemlog` VALUES (669, '获取发寻物贴页面', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.LostThingsController.publishLostThingsView()', NULL, '2013143218', '2017-04-23 01:34:26');
INSERT INTO `systemlog` VALUES (670, '访问主页', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143218', '2017-04-23 01:34:51');
INSERT INTO `systemlog` VALUES (671, '获取发寻物贴页面', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.LostThingsController.publishLostThingsView()', NULL, '2013143218', '2017-04-23 01:34:56');
INSERT INTO `systemlog` VALUES (672, '访问主页', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-23 12:13:55');
INSERT INTO `systemlog` VALUES (673, '访问主页', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-23 12:15:24');
INSERT INTO `systemlog` VALUES (674, '网页登录', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.LoginController.login()', NULL, NULL, '2017-04-23 12:17:27');
INSERT INTO `systemlog` VALUES (675, '进入用户中心页面', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.UserController.userCenter()', NULL, '2013143207', '2017-04-23 12:17:47');
INSERT INTO `systemlog` VALUES (676, '获取发招领贴页面', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.PickThingsController.publishPickThingsView()', NULL, '2013143207', '2017-04-23 12:17:59');
INSERT INTO `systemlog` VALUES (677, '访问主页', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143207', '2017-04-23 12:18:21');
INSERT INTO `systemlog` VALUES (678, '访问主页', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143207', '2017-04-23 12:21:34');
INSERT INTO `systemlog` VALUES (679, '进入聊天室', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143207', '2017-04-23 12:22:02');
INSERT INTO `systemlog` VALUES (680, '进入聊天室', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143207', '2017-04-23 12:22:18');
INSERT INTO `systemlog` VALUES (681, '注销', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.LoginController.logout()', NULL, '2013143207', '2017-04-23 12:27:56');
INSERT INTO `systemlog` VALUES (682, '访问主页', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-23 12:27:56');
INSERT INTO `systemlog` VALUES (683, '访问主页', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-23 12:34:43');
INSERT INTO `systemlog` VALUES (684, '访问主页', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-23 12:36:16');
INSERT INTO `systemlog` VALUES (685, '访问主页', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-23 12:36:19');
INSERT INTO `systemlog` VALUES (686, '访问主页', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-23 12:36:21');
INSERT INTO `systemlog` VALUES (687, '访问主页', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-23 12:36:24');
INSERT INTO `systemlog` VALUES (688, '访问主页', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-23 12:36:26');
INSERT INTO `systemlog` VALUES (689, '访问主页', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-23 12:36:42');
INSERT INTO `systemlog` VALUES (690, '访问主页', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-23 12:37:04');
INSERT INTO `systemlog` VALUES (691, '访问主页', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-23 12:37:15');
INSERT INTO `systemlog` VALUES (692, '访问主页', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-23 12:39:17');
INSERT INTO `systemlog` VALUES (693, '访问主页', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-23 12:39:17');
INSERT INTO `systemlog` VALUES (694, '访问主页', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-23 12:44:05');
INSERT INTO `systemlog` VALUES (695, '访问主页', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-23 12:53:01');
INSERT INTO `systemlog` VALUES (696, '访问主页', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-23 12:57:05');
INSERT INTO `systemlog` VALUES (697, '访问主页', NULL, '0', '117.75.19.126', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-23 12:58:14');
INSERT INTO `systemlog` VALUES (698, '访问主页', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-23 23:15:33');
INSERT INTO `systemlog` VALUES (699, '访问主页', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-23 23:26:55');
INSERT INTO `systemlog` VALUES (700, '网页登录', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.LoginController.login()', NULL, NULL, '2017-04-23 23:57:25');
INSERT INTO `systemlog` VALUES (701, '保存感谢信息', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.UserController.saveThanks()', NULL, '2013143218', '2017-04-23 23:58:04');
INSERT INTO `systemlog` VALUES (702, '访问主页', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-24 00:06:11');
INSERT INTO `systemlog` VALUES (703, '网页登录', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.LoginController.login()', NULL, NULL, '2017-04-24 00:06:53');
INSERT INTO `systemlog` VALUES (704, '保存感谢信息', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.UserController.saveThanks()', NULL, '2013031308', '2017-04-24 00:07:29');
INSERT INTO `systemlog` VALUES (705, '网页登录', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.LoginController.login()', NULL, NULL, '2017-04-24 00:07:51');
INSERT INTO `systemlog` VALUES (706, '保存感谢信息', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.UserController.saveThanks()', NULL, '2013143216', '2017-04-24 00:09:00');
INSERT INTO `systemlog` VALUES (707, '网页登录', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.LoginController.login()', NULL, NULL, '2017-04-24 00:12:33');
INSERT INTO `systemlog` VALUES (708, '保存感谢信息', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.UserController.saveThanks()', NULL, '2013143207', '2017-04-24 00:13:02');
INSERT INTO `systemlog` VALUES (709, '进入聊天室', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143207', '2017-04-24 00:13:12');
INSERT INTO `systemlog` VALUES (710, '进入聊天室', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143218', '2017-04-24 00:13:59');
INSERT INTO `systemlog` VALUES (711, '进入聊天室', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013031308', '2017-04-24 00:14:03');
INSERT INTO `systemlog` VALUES (712, '移动设备登录', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-24 00:15:28');
INSERT INTO `systemlog` VALUES (713, '移动设备登录', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-24 00:15:43');
INSERT INTO `systemlog` VALUES (714, '保存感谢信息', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.UserController.saveThanks()', NULL, '2013143205', '2017-04-24 00:16:31');
INSERT INTO `systemlog` VALUES (715, '进入用户中心页面', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.UserController.userCenter()', NULL, '2013143205', '2017-04-24 00:20:09');
INSERT INTO `systemlog` VALUES (716, '访问主页', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143205', '2017-04-24 00:25:18');
INSERT INTO `systemlog` VALUES (717, '获取发招领贴页面', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.PickThingsController.publishPickThingsView()', NULL, '2013143205', '2017-04-24 00:25:52');
INSERT INTO `systemlog` VALUES (718, '进入用户中心页面', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.UserController.userCenter()', NULL, '2013143205', '2017-04-24 00:26:24');
INSERT INTO `systemlog` VALUES (719, '获取发招领贴页面', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.PickThingsController.publishPickThingsView()', NULL, '2013143205', '2017-04-24 00:26:26');
INSERT INTO `systemlog` VALUES (720, '获取发寻物贴页面', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.LostThingsController.publishLostThingsView()', NULL, '2013143205', '2017-04-24 00:26:29');
INSERT INTO `systemlog` VALUES (721, '访问主页', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143205', '2017-04-24 00:26:50');
INSERT INTO `systemlog` VALUES (722, '注销', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.LoginController.logout()', NULL, '2013143205', '2017-04-24 00:27:11');
INSERT INTO `systemlog` VALUES (723, '访问主页', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-24 00:27:11');
INSERT INTO `systemlog` VALUES (724, '获取登录视图', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.LoginController.loginView()', NULL, NULL, '2017-04-24 00:27:37');
INSERT INTO `systemlog` VALUES (775, '快速查看招领信息下一贴', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-04-25 03:30:54');
INSERT INTO `systemlog` VALUES (776, '快速查看招领信息下一贴', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-04-25 03:30:56');
INSERT INTO `systemlog` VALUES (777, '访问主页', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-25 03:31:50');
INSERT INTO `systemlog` VALUES (778, '网页登录', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.LoginController.login()', NULL, NULL, '2017-04-25 12:01:45');
INSERT INTO `systemlog` VALUES (779, '保存感谢信息', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.UserController.saveThanks()', NULL, '2013143218', '2017-04-25 12:02:27');
INSERT INTO `systemlog` VALUES (780, '访问主页', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-25 13:41:18');
INSERT INTO `systemlog` VALUES (781, '访问主页', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-25 13:41:20');
INSERT INTO `systemlog` VALUES (782, '移动设备登录', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-25 13:42:43');
INSERT INTO `systemlog` VALUES (783, '保存感谢信息', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.UserController.saveThanks()', NULL, '2013143234', '2017-04-25 13:45:36');
INSERT INTO `systemlog` VALUES (784, '进入聊天室', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143234', '2017-04-25 13:45:51');
INSERT INTO `systemlog` VALUES (785, '进入聊天室', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143234', '2017-04-25 13:46:11');
INSERT INTO `systemlog` VALUES (786, '访问主页', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-25 13:51:13');
INSERT INTO `systemlog` VALUES (787, '访问主页', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-25 13:52:00');
INSERT INTO `systemlog` VALUES (788, '访问主页', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-25 13:55:40');
INSERT INTO `systemlog` VALUES (789, '访问主页', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143234', '2017-04-25 14:00:08');
INSERT INTO `systemlog` VALUES (790, '访问主页', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143234', '2017-04-25 14:00:14');
INSERT INTO `systemlog` VALUES (791, '移动设备登录', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-25 14:01:34');
INSERT INTO `systemlog` VALUES (792, '移动设备登录', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.LoginController.mobileLogin()', NULL, NULL, '2017-04-25 14:03:33');
INSERT INTO `systemlog` VALUES (793, '保存感谢信息', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.UserController.saveThanks()', NULL, '2013143234', '2017-04-25 14:05:10');
INSERT INTO `systemlog` VALUES (794, '进入聊天室', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.ChatMessageController.chat()', NULL, '2013143234', '2017-04-25 14:05:22');
INSERT INTO `systemlog` VALUES (795, '进入用户中心页面', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.UserController.userCenter()', NULL, '2013143234', '2017-04-25 14:05:31');
INSERT INTO `systemlog` VALUES (796, '保存（修改）个人信息', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.UserController.saveUserInfo()', NULL, '2013143234', '2017-04-25 14:05:40');
INSERT INTO `systemlog` VALUES (797, '访问主页', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143234', '2017-04-25 14:06:32');
INSERT INTO `systemlog` VALUES (798, '获取发招领贴页面', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.PickThingsController.publishPickThingsView()', NULL, '2013143234', '2017-04-25 14:06:43');
INSERT INTO `systemlog` VALUES (799, '获取发寻物贴页面', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.LostThingsController.publishLostThingsView()', NULL, '2013143234', '2017-04-25 14:07:43');
INSERT INTO `systemlog` VALUES (800, '访问主页', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143234', '2017-04-25 14:07:54');
INSERT INTO `systemlog` VALUES (801, '快速查看招领信息下一贴', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, '2013143234', '2017-04-25 14:08:10');
INSERT INTO `systemlog` VALUES (802, '快速查看招领信息下一贴', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, '2013143234', '2017-04-25 14:08:14');
INSERT INTO `systemlog` VALUES (803, '快速查看招领信息下一贴', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, '2013143234', '2017-04-25 14:08:16');
INSERT INTO `systemlog` VALUES (804, '快速查看招领信息下一贴', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, '2013143234', '2017-04-25 14:08:18');
INSERT INTO `systemlog` VALUES (805, '快速查看招领信息下一贴', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, '2013143234', '2017-04-25 14:08:20');
INSERT INTO `systemlog` VALUES (806, '快速查看招领信息下一贴', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, '2013143234', '2017-04-25 14:08:21');
INSERT INTO `systemlog` VALUES (807, '快速查看招领信息下一贴', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, '2013143234', '2017-04-25 14:08:23');
INSERT INTO `systemlog` VALUES (808, '快速查看招领信息下一贴', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, '2013143234', '2017-04-25 14:08:24');
INSERT INTO `systemlog` VALUES (809, '快速查看招领信息下一贴', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, '2013143234', '2017-04-25 14:08:27');
INSERT INTO `systemlog` VALUES (810, '快速查看招领信息下一贴', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, '2013143234', '2017-04-25 14:08:29');
INSERT INTO `systemlog` VALUES (811, '快速查看招领信息下一贴', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, '2013143234', '2017-04-25 14:08:30');
INSERT INTO `systemlog` VALUES (812, '快速查看招领信息下一贴', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, '2013143234', '2017-04-25 14:08:32');
INSERT INTO `systemlog` VALUES (813, '快速查看招领信息下一贴', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, '2013143234', '2017-04-25 14:08:33');
INSERT INTO `systemlog` VALUES (814, '快速查看招领信息下一贴', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, '2013143234', '2017-04-25 14:08:35');
INSERT INTO `systemlog` VALUES (815, '快速查看招领信息下一贴', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, '2013143234', '2017-04-25 14:08:36');
INSERT INTO `systemlog` VALUES (816, '快速查看招领信息下一贴', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, '2013143234', '2017-04-25 14:08:38');
INSERT INTO `systemlog` VALUES (817, '快速查看招领信息下一贴', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, '2013143234', '2017-04-25 14:08:39');
INSERT INTO `systemlog` VALUES (818, '快速查看招领信息下一贴', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, '2013143234', '2017-04-25 14:08:40');
INSERT INTO `systemlog` VALUES (819, '快速查看招领信息下一贴', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, '2013143234', '2017-04-25 14:08:42');
INSERT INTO `systemlog` VALUES (820, '快速查看招领信息下一贴', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, '2013143234', '2017-04-25 14:08:43');
INSERT INTO `systemlog` VALUES (821, '快速查看招领信息下一贴', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, '2013143234', '2017-04-25 14:08:44');
INSERT INTO `systemlog` VALUES (822, '快速查看招领信息下一贴', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, '2013143234', '2017-04-25 14:08:46');
INSERT INTO `systemlog` VALUES (823, '快速查看招领信息下一贴', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, '2013143234', '2017-04-25 14:08:47');
INSERT INTO `systemlog` VALUES (824, '快速查看招领信息下一贴', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, '2013143234', '2017-04-25 14:08:48');
INSERT INTO `systemlog` VALUES (825, '访问主页', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143234', '2017-04-25 14:08:58');
INSERT INTO `systemlog` VALUES (826, '网页登录', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.LoginController.login()', NULL, NULL, '2017-04-25 18:09:57');
INSERT INTO `systemlog` VALUES (827, '进入用户中心页面', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.UserController.userCenter()', NULL, '2013143218', '2017-04-25 18:10:02');
INSERT INTO `systemlog` VALUES (828, '获取发招领贴页面', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.PickThingsController.publishPickThingsView()', NULL, '2013143218', '2017-04-25 18:11:42');
INSERT INTO `systemlog` VALUES (829, '获取发寻物贴页面', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.LostThingsController.publishLostThingsView()', NULL, '2013143218', '2017-04-25 18:13:21');
INSERT INTO `systemlog` VALUES (830, '访问主页', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143218', '2017-04-25 18:14:37');
INSERT INTO `systemlog` VALUES (831, '进入用户中心页面', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.UserController.userCenter()', NULL, '2013143218', '2017-04-25 18:14:49');
INSERT INTO `systemlog` VALUES (832, '访问主页', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, '2013143218', '2017-04-25 18:24:02');
INSERT INTO `systemlog` VALUES (833, '注销', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.LoginController.logout()', NULL, NULL, '2017-04-25 21:26:11');
INSERT INTO `systemlog` VALUES (834, '访问主页', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-25 21:26:12');
INSERT INTO `systemlog` VALUES (861, '访问主页', NULL, '0', '101.226.33.220', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-27 20:40:28');
INSERT INTO `systemlog` VALUES (862, '访问主页', NULL, '0', '117.75.19.135', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-27 20:41:40');
INSERT INTO `systemlog` VALUES (864, '访问主页', NULL, '0', '218.63.75.78', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-27 22:06:54');
INSERT INTO `systemlog` VALUES (865, '访问主页', NULL, '0', '117.136.16.18', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-04-27 23:11:56');
INSERT INTO `systemlog` VALUES (866, '获取登录视图', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.LoginController.loginView()', NULL, NULL, '2017-05-01 18:10:02');
INSERT INTO `systemlog` VALUES (867, '访问主页', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-05-01 18:10:06');
INSERT INTO `systemlog` VALUES (868, '快速查看招领信息上一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.previous()', NULL, NULL, '2017-05-02 11:38:50');
INSERT INTO `systemlog` VALUES (869, '快速查看招领信息上一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.previous()', NULL, NULL, '2017-05-02 11:38:52');
INSERT INTO `systemlog` VALUES (870, '快速查看招领信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-05-02 11:38:55');
INSERT INTO `systemlog` VALUES (871, '快速查看招领信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-05-02 11:38:57');
INSERT INTO `systemlog` VALUES (872, '快速查看招领信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-05-02 11:39:01');
INSERT INTO `systemlog` VALUES (873, '快速查看招领信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-05-02 11:39:02');
INSERT INTO `systemlog` VALUES (874, '快速查看招领信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-05-02 11:39:05');
INSERT INTO `systemlog` VALUES (875, '快速查看招领信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-05-02 11:39:32');
INSERT INTO `systemlog` VALUES (876, '快速查看招领信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-05-02 11:39:35');
INSERT INTO `systemlog` VALUES (880, '访问主页', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-05-08 21:57:14');
INSERT INTO `systemlog` VALUES (881, '访问主页', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-05-16 15:36:07');
INSERT INTO `systemlog` VALUES (882, '快速查看寻物信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-05-16 15:36:58');
INSERT INTO `systemlog` VALUES (883, '访问主页', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-05-16 15:45:41');
INSERT INTO `systemlog` VALUES (884, '访问主页', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-05-16 16:08:05');
INSERT INTO `systemlog` VALUES (885, '访问主页', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-05-16 16:08:26');
INSERT INTO `systemlog` VALUES (886, '访问主页', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-05-16 19:55:10');
INSERT INTO `systemlog` VALUES (887, '访问主页', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-05-19 23:16:22');
INSERT INTO `systemlog` VALUES (888, '快速查看招领信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-05-19 23:18:12');
INSERT INTO `systemlog` VALUES (889, '快速查看招领信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-05-19 23:18:16');
INSERT INTO `systemlog` VALUES (890, '快速查看招领信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-05-19 23:18:19');
INSERT INTO `systemlog` VALUES (891, '快速查看招领信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-05-19 23:18:21');
INSERT INTO `systemlog` VALUES (892, '快速查看招领信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-05-19 23:18:23');
INSERT INTO `systemlog` VALUES (893, '快速查看招领信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-05-19 23:18:25');
INSERT INTO `systemlog` VALUES (894, '快速查看招领信息上一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.previous()', NULL, NULL, '2017-05-19 23:18:30');
INSERT INTO `systemlog` VALUES (895, '快速查看招领信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-05-19 23:33:50');
INSERT INTO `systemlog` VALUES (896, '快速查看招领信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-05-19 23:33:53');
INSERT INTO `systemlog` VALUES (897, '快速查看招领信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-05-19 23:33:55');
INSERT INTO `systemlog` VALUES (898, '快速查看招领信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-05-19 23:33:58');
INSERT INTO `systemlog` VALUES (899, '快速查看招领信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-05-19 23:34:03');
INSERT INTO `systemlog` VALUES (900, '快速查看招领信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-05-19 23:34:06');
INSERT INTO `systemlog` VALUES (901, '快速查看招领信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-05-19 23:34:08');
INSERT INTO `systemlog` VALUES (902, '快速查看招领信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-05-19 23:34:11');
INSERT INTO `systemlog` VALUES (903, '快速查看招领信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-05-19 23:34:15');
INSERT INTO `systemlog` VALUES (904, '快速查看招领信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-05-19 23:34:19');
INSERT INTO `systemlog` VALUES (905, '快速查看招领信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-05-19 23:34:22');
INSERT INTO `systemlog` VALUES (906, '快速查看招领信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-05-19 23:34:25');
INSERT INTO `systemlog` VALUES (907, '快速查看招领信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-05-19 23:34:27');
INSERT INTO `systemlog` VALUES (908, '快速查看招领信息上一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.previous()', NULL, NULL, '2017-05-19 23:34:30');
INSERT INTO `systemlog` VALUES (909, '快速查看招领信息上一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.previous()', NULL, NULL, '2017-05-19 23:34:32');
INSERT INTO `systemlog` VALUES (910, '快速查看招领信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-05-19 23:34:36');
INSERT INTO `systemlog` VALUES (911, '快速查看招领信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-05-19 23:34:52');
INSERT INTO `systemlog` VALUES (912, '快速查看招领信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-05-19 23:34:54');
INSERT INTO `systemlog` VALUES (913, '快速查看招领信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-05-19 23:34:57');
INSERT INTO `systemlog` VALUES (914, '快速查看招领信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-05-19 23:35:54');
INSERT INTO `systemlog` VALUES (915, '快速查看招领信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.PickThingsController.next()', NULL, NULL, '2017-05-19 23:35:57');
INSERT INTO `systemlog` VALUES (916, '访问主页', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-05-20 10:33:48');
INSERT INTO `systemlog` VALUES (917, '搜索', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.IndexController.searchAll()', NULL, NULL, '2017-05-24 14:43:09');
INSERT INTO `systemlog` VALUES (918, '访问主页', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-05-24 14:44:39');
INSERT INTO `systemlog` VALUES (919, '访问主页', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-05-24 14:46:58');
INSERT INTO `systemlog` VALUES (920, '访问主页', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-05-24 14:48:14');
INSERT INTO `systemlog` VALUES (921, '访问主页', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-05-24 23:07:32');
INSERT INTO `systemlog` VALUES (922, '快速查看寻物信息上一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.LostThingsController.previous()', NULL, NULL, '2017-05-24 23:08:49');
INSERT INTO `systemlog` VALUES (923, '快速查看寻物信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-05-24 23:08:59');
INSERT INTO `systemlog` VALUES (924, '快速查看寻物信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-05-24 23:09:03');
INSERT INTO `systemlog` VALUES (925, '快速查看寻物信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-05-24 23:09:06');
INSERT INTO `systemlog` VALUES (926, '快速查看寻物信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-05-24 23:09:09');
INSERT INTO `systemlog` VALUES (927, '快速查看寻物信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-05-24 23:09:11');
INSERT INTO `systemlog` VALUES (928, '快速查看寻物信息上一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.LostThingsController.previous()', NULL, NULL, '2017-05-24 23:09:20');
INSERT INTO `systemlog` VALUES (929, '快速查看寻物信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-05-24 23:09:23');
INSERT INTO `systemlog` VALUES (930, '快速查看寻物信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-05-24 23:09:25');
INSERT INTO `systemlog` VALUES (931, '快速查看寻物信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-05-24 23:09:34');
INSERT INTO `systemlog` VALUES (932, '快速查看寻物信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-05-24 23:09:38');
INSERT INTO `systemlog` VALUES (933, '快速查看寻物信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-05-24 23:09:42');
INSERT INTO `systemlog` VALUES (934, '快速查看寻物信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-05-24 23:09:43');
INSERT INTO `systemlog` VALUES (935, '快速查看寻物信息上一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.LostThingsController.previous()', NULL, NULL, '2017-05-24 23:11:09');
INSERT INTO `systemlog` VALUES (936, '快速查看寻物信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-05-24 23:11:10');
INSERT INTO `systemlog` VALUES (937, '快速查看寻物信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-05-24 23:11:12');
INSERT INTO `systemlog` VALUES (938, '快速查看寻物信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-05-24 23:11:14');
INSERT INTO `systemlog` VALUES (939, '快速查看寻物信息上一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.LostThingsController.previous()', NULL, NULL, '2017-05-24 23:11:21');
INSERT INTO `systemlog` VALUES (940, '快速查看寻物信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-05-24 23:11:23');
INSERT INTO `systemlog` VALUES (941, '快速查看寻物信息下一贴', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.LostThingsController.next()', NULL, NULL, '2017-05-24 23:11:25');
INSERT INTO `systemlog` VALUES (942, '获取登录视图', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.LoginController.loginView()', NULL, NULL, '2017-10-16 17:05:10');
INSERT INTO `systemlog` VALUES (943, '访问主页', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-10-16 17:05:11');
INSERT INTO `systemlog` VALUES (944, '访问主页', NULL, '0', '127.0.0.1', NULL, 'com.lin.lostandfound.controller.IndexController.index()', NULL, NULL, '2017-10-16 17:05:45');

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher`  (
  `TeacherNo` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '工号',
  `TeacherName` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `Sex` char(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '性别',
  `Birth` date NOT NULL COMMENT '生日',
  `IdCard` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '身份证号码',
  `TelPhone` char(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '联系电话',
  PRIMARY KEY (`TeacherNo`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID自增',
  `UserName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `Password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `Grade` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '年级',
  `Name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `NickName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `TelPhone` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '联系电话',
  `Email` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `QQ` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'qq',
  `State` int(11) NOT NULL COMMENT '状态',
  `CreateTime` date NOT NULL COMMENT '创建时间',
  `IsNew` int(11) NOT NULL DEFAULT 0 COMMENT '原始密码（0） 修改后（1）',
  `LastLoginTime` datetime(0) NULL DEFAULT NULL COMMENT '最后一次登录时间',
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE INDEX `UserName`(`UserName`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 847 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '2013143218', '8675b5a4a8b23e503b49375b4aad3a14', '2013', '黎国林', 'LinkMe', '15802850670', '1254403440@qq.com', '1254403440', 2, '2017-02-01', 0, '2017-04-25 18:09:57');
INSERT INTO `user` VALUES (2, '2013031308', '83191f3c855fd8a52ced79d5345083b5', '2013', '范国凤', '', '15752114062', '', '', 2, '2017-02-07', 0, '2020-03-21 07:01:27');
INSERT INTO `user` VALUES (3, 'admin@qq.com', '246f2c2bb41070898938cd0a65694f21', 'ADMIN', '系统管理员', '系统管理员', '15802850670', '1254403440@qq.com', '', 3, '2017-02-01', 0, NULL);
INSERT INTO `user` VALUES (4, '2013143216', 'cff920327dfabc7862e40c85aea1f844', '2013', '惠润', '', '15187894220', '', '', 1, '2017-02-08', 0, '2017-04-24 00:07:51');
INSERT INTO `user` VALUES (5, 'lgllink@163.com', '9c34d1a869eee7ccc1cbde33a8d83031', 'ADMIN', '系统管理员', '系统管理员', '15887497814', 'lgllink@163.com', '1254403440', 3, '2017-02-01', 0, NULL);
INSERT INTO `user` VALUES (41, '2013141240', '3c6ba8bd5e1cbf61ef7fcf5c86727e28', '2013', '和军', '', '18388310533', '', '', 1, '2017-03-21', 0, NULL);
INSERT INTO `user` VALUES (42, '2013143207', '73613434e48246550bfa9a327cf93740', '2013', '汪金才', '', '18388307901', '', '', 1, '2017-04-07', 0, '2017-04-24 00:12:33');
INSERT INTO `user` VALUES (787, '2013143217', '26e1887d8bde43a1be40d47c7cc911d3', '2013', '蒋鑫海', '', '18388308836', '', '', 1, '2017-04-08', 0, '2017-04-16 19:14:05');
INSERT INTO `user` VALUES (788, '2013143219', '99d86f9e4f1f12c3fe173dc4ec7d5243', '2013', '李冬梅', '', '18388306826', '', '', 1, '2017-04-08', 1, '2017-04-04 18:54:53');
INSERT INTO `user` VALUES (789, '2013143201', 'b617354addafbb0f6782a6139e0a3a7c', '2013', '王林进', '', '18388308943', '', '', 1, '2017-04-08', 0, '2017-04-14 13:20:36');
INSERT INTO `user` VALUES (790, '2013143202', '13ea32e400656ec6809014218f3cb73f', '2013', '肖爵波', '', '18388308998', '', '', 1, '2017-04-08', 0, NULL);
INSERT INTO `user` VALUES (791, '2013143203', '7e40b156f7d56d009728b85a7119cf37', '2013', '罗大菊', '', '13095273867', '', '', 1, '2017-04-08', 0, NULL);
INSERT INTO `user` VALUES (792, '2013143204', '509c4ea40ee4cea34c34f6adad2e54e2', '2013', '段鑫薇', '', '18608741704', '', '', 1, '2017-04-08', 0, NULL);
INSERT INTO `user` VALUES (793, '2013143205', '5ed4d1a98264e7f0fd682fe138be89bb', '2013', '高增辉', '', '18388575815', '', '', 1, '2017-04-08', 0, '2017-04-24 00:15:43');
INSERT INTO `user` VALUES (794, '2013143206', '495441a011db6197dda30cc83206cbdc', '2013', '普斌', '', '18388309251', '', '', 1, '2017-04-08', 0, NULL);
INSERT INTO `user` VALUES (795, '2013143208', '3de5fe25ba42c3a430a47cc8a749ff56', '2013', '王雪艳', '', '15087489315', '', '', 1, '2017-04-08', 0, NULL);
INSERT INTO `user` VALUES (796, '2013143209', '893f3377311dcf176b8b72967e3668c2', '2013', '杨建锋', '', '15187403022', '', '', 1, '2017-04-08', 0, NULL);
INSERT INTO `user` VALUES (797, '2013143210', '1fd39fd261a55324725c4bd6d9a44d95', '2013', '杨英', '', '18388307830', '', '', 1, '2017-04-08', 0, NULL);
INSERT INTO `user` VALUES (798, '2013143211', '6c3ca59acea8c19b0175d208dca61729', '2013', '尹莎', '', '15911417659', '', '', 1, '2017-04-08', 0, NULL);
INSERT INTO `user` VALUES (799, '2013143213', '7f7ea39c0871d5bae2712e58dfc1359d', '2013', '张继', '', '17096573759', '', '', 1, '2017-04-08', 0, NULL);
INSERT INTO `user` VALUES (800, '2013143215', '64674e3a5d5091d0f72389a37f8cac3e', '2013', '何金仙', '', '15187496706', '', '', 1, '2017-04-08', 0, NULL);
INSERT INTO `user` VALUES (801, '2013143220', '28de931af1c7a126c04e45506fb28fae', '2013', '刘四茹', '', '18388309259', '', '', 1, '2017-04-08', 0, NULL);
INSERT INTO `user` VALUES (802, '2013143221', 'aa6a3f523972f8ae2a70dc9948f2af14', '2013', '吕会芬', '', '13038675250', '', '', 1, '2017-04-08', 0, NULL);
INSERT INTO `user` VALUES (803, '2013143222', '8764ceb31b9d362e695f73d2223bdbff', '2013', '孙远程', '', '15187890758', '', '', 1, '2017-04-08', 0, NULL);
INSERT INTO `user` VALUES (804, '2013143223', 'be731aacd08f5779625ef87fe3117a6c', '2013', '胥联鑫', '', '13508740410', '', '', 1, '2017-04-08', 0, NULL);
INSERT INTO `user` VALUES (805, '2013143224', 'fbbbd1e36472bdce557c25e1ddbd4efe', '2013', '杨丽萍', '', '18608741854', '', '', 1, '2017-04-08', 0, NULL);
INSERT INTO `user` VALUES (806, '2013143225', '5fc6e951cb588324564bbce1a5bbeb8d', '2013', '杨蒙蒙', '', '18687454371', '', '', 1, '2017-04-08', 0, NULL);
INSERT INTO `user` VALUES (807, '2013143226', '386f53973616bf7586c154ca19fb1e97', '2013', '张鑫', '', '15208740933', '', '', 1, '2017-04-08', 0, NULL);
INSERT INTO `user` VALUES (808, '2013143228', '50bc7c6072be04948dac7694c27f7b75', '2013', '郑飞', '', '15825045307', '', '', 1, '2017-04-08', 0, NULL);
INSERT INTO `user` VALUES (809, '2013143229', '0d5025a4818422525597bef5cc1da551', '2013', '周丽娟', '', '15287432400', '', '', 1, '2017-04-08', 0, NULL);
INSERT INTO `user` VALUES (810, '2013143230', 'c9c18c7339239f1fc13a316b10f760a0', '2013', '朱德兵', '', '18313532754', '', '', 1, '2017-04-08', 0, NULL);
INSERT INTO `user` VALUES (811, '2013143231', 'b66c8a154608510dc83ab352823cc4a3', '2013', '陈璐', '', '13529576935', '', '', 1, '2017-04-08', 0, NULL);
INSERT INTO `user` VALUES (812, '2013143232', 'aac8878102b341bd76473fcccc9a857a', '2013', '丁智涛', '', '18288449053', '', '', 1, '2017-04-08', 0, NULL);
INSERT INTO `user` VALUES (813, '2013143233', 'b2b328b70fa59e5d0b7d52181803e09e', '2013', '冯智海', '', '18608894492', '', '', 1, '2017-04-08', 0, NULL);
INSERT INTO `user` VALUES (814, '2013143234', 'bb137953964873ad3b818d227e469159', '2013', '覃常鸿', '', '18388306501', '', '', 1, '2017-04-08', 0, '2017-04-25 14:03:33');
INSERT INTO `user` VALUES (816, '2013143236', '6f6d246b1274916475553e4d617411f6', '2013', '张志宏', '', '18388310351', '', '', 1, '2017-04-08', 0, NULL);
INSERT INTO `user` VALUES (817, '2013143237', '819b93127d144df2716affcc8b4002f4', '2013', '郑华仙', '', '18388308955', '', '', 1, '2017-04-08', 0, NULL);
INSERT INTO `user` VALUES (818, '2013143239', 'ebbfba584518e7f29469e6d8cdf586eb', '2013', '李瑞冬', '', '15187403022', '', '', 1, '2017-04-08', 0, NULL);
INSERT INTO `user` VALUES (819, '2013041121', 'df7ebbc0ece216b893e15b858073bfc2', '2013', '黎妍', '', '15287996972', '', '', 1, '2017-04-12', 0, '2017-04-16 22:11:37');
INSERT INTO `user` VALUES (820, '2013023120', '0afc51e894e90b3257066ed2b8307882', '2013', '梁艳丽', '', '18388307336', '', '', 2, '2017-04-13', 0, '2017-04-16 22:18:39');
INSERT INTO `user` VALUES (821, '2013042105', '859c11f0e3ca399888c736f22f1a43bf', '2013', '朱洪', '', '18388580302', '', '', 1, '2017-04-13', 0, '2017-04-14 13:12:14');
INSERT INTO `user` VALUES (822, '2013023108', '0dce071a36b4b16b6fa82f1e9d58e32e', '2013', '段月銮安', '', '18388306190', '', '', 2, '2017-04-14', 0, NULL);
INSERT INTO `user` VALUES (823, '2014073120', '33bdba77e687f3fac180d36a6f906a65', '2014', '毛乙帆', '', '15287448048', '', '', 2, '2017-04-16', 0, '2017-04-17 19:57:27');
INSERT INTO `user` VALUES (824, '2013043104', '33be6379093baf5fe7c37784891007e6', '2013', '董殷江', '', '18287484862', '', '', 1, '2017-04-16', 0, NULL);
INSERT INTO `user` VALUES (825, '2013132157', 'a32526588ed6d93f85d6cc82bfb5524e', '2013', '曾侣斌', '', '183885477873', '', '', 1, '2017-04-16', 0, '2017-04-18 11:49:02');
INSERT INTO `user` VALUES (827, '2014073126', '4865cfc7c9f9392bfdcdaae0876da4db', '2014', '张月萍', NULL, '18315303875', NULL, NULL, 1, '2017-04-16', 0, '2017-04-17 19:59:18');
INSERT INTO `user` VALUES (828, '2014073127', 'e27c6f45b01dc54331e9ced4d91940e6', '2014', '黄云清', NULL, '18487446309', NULL, NULL, 1, '2017-04-16', 0, '2017-04-17 19:56:12');
INSERT INTO `user` VALUES (829, '2014073134', '23154635ac6322495c3a2d579bdb6ddb', '2014', '文朴春', NULL, '18388376009', NULL, NULL, 1, '2017-04-16', 0, '2017-04-16 22:52:35');
INSERT INTO `user` VALUES (830, '2014073102', '386062c607110b6763680a1355fbd2ef', '2014', '许敏', NULL, '18388373832', NULL, NULL, 1, '2017-04-16', 0, '2017-04-17 18:45:09');
INSERT INTO `user` VALUES (831, '2014073119', '9155888fcd59ae6d7e159477b8dafa73', '2014', '包倩', NULL, '15287492642', NULL, NULL, 1, '2017-04-16', 0, NULL);
INSERT INTO `user` VALUES (832, '2014073105', '7df70509ddc0fe84037b10d8931b829a', '2014', '王爱妮', NULL, '15388743324', NULL, NULL, 1, '2017-04-16', 0, NULL);
INSERT INTO `user` VALUES (833, '2014073108', '78b806da1c76d33f3e6d9c693e068d5d', '2014', '朱全珍', NULL, '18388375740', NULL, NULL, 1, '2017-04-16', 0, NULL);
INSERT INTO `user` VALUES (834, '2014073109', '5e11b9085e7748c4658b3ded4fb4104a', '2014', '符惠静', NULL, '18213778224', NULL, NULL, 1, '2017-04-16', 0, NULL);
INSERT INTO `user` VALUES (835, '2014073113', 'f3bd47d18b13b96047f72e593ac28510', '2014', '丁鸿江', NULL, '15087404531', NULL, NULL, 1, '2017-04-16', 0, NULL);
INSERT INTO `user` VALUES (836, '2014073114', '2f0afdc96c459a70444cebef0f647694', '2014', '王惠南', NULL, '13408744955', NULL, NULL, 1, '2017-04-16', 0, NULL);
INSERT INTO `user` VALUES (837, '2014073125', '77ffbb2b4d836b4cd8d77dc2fe5195b4', '2014', '黄琦', NULL, '18388373220', NULL, NULL, 1, '2017-04-16', 0, NULL);
INSERT INTO `user` VALUES (838, '2014073128', '5f988a6ffa99e572c188f0cdde6688a9', '2014', '陆容', NULL, '15108675470', NULL, NULL, 1, '2017-04-16', 0, NULL);
INSERT INTO `user` VALUES (839, '2014073129', 'cd3ff6fd9e29a57199699e579ced2779', '2014', '杨娜', NULL, '18287493451', NULL, NULL, 1, '2017-04-16', 0, NULL);
INSERT INTO `user` VALUES (840, '2014073148', 'c9950c5149eb3c7d37f060367dc375c9', '2014', '张晓蕾', NULL, '18388374368', NULL, NULL, 1, '2017-04-16', 0, NULL);
INSERT INTO `user` VALUES (841, '2014073142', '6aef4c8617d5b079fae249387b60d408', '2014', '骆林', NULL, '18287408558', NULL, NULL, 1, '2017-04-16', 0, NULL);
INSERT INTO `user` VALUES (842, '2014073146', '00b65e1a4ae7b0735085b2fe9d9ed3c0', '2014', '刘云娣', NULL, '15987446538', NULL, NULL, 1, '2017-04-16', 0, NULL);
INSERT INTO `user` VALUES (843, '2014073147', '1d1c6f454e0b608562868ba424a54552', '2014', '罗荣芬', NULL, '18388372468', NULL, NULL, 1, '2017-04-16', 0, NULL);
INSERT INTO `user` VALUES (844, '2014073161', '9d20a28bd6c41517070762be05a213c4', '2014', '夏付雨', NULL, '15559986730', NULL, NULL, 1, '2017-04-16', 0, NULL);
INSERT INTO `user` VALUES (845, '2014073103', '9d7385a38feef762623aef22ea234c31', '2014', '林丽娟', '', '18388374709', '', '', 1, '2017-04-16', 0, '2017-04-17 20:01:11');
INSERT INTO `user` VALUES (846, '2016143218', 'b65c80f8b8f956470ae875c2055ec76a', '2016', '2016143218', '', '18028092345', '', '', 1, '2020-03-18', 0, NULL);

SET FOREIGN_KEY_CHECKS = 1;
