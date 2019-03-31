/*
 Navicat Premium Data Transfer

 Source Server         : MARIADB
 Source Server Type    : MariaDB
 Source Server Version : 100137
 Source Host           : localhost:3306
 Source Schema         : web_base_codeigniter

 Target Server Type    : MariaDB
 Target Server Version : 100137
 File Encoding         : 65001

 Date: 11/02/2019 00:41:16
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for app_config
-- ----------------------------
DROP TABLE IF EXISTS `app_config`;
CREATE TABLE `app_config`  (
  `configuration_id` int(11) NOT NULL AUTO_INCREMENT,
  `configuration` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `value` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `created_date` date NULL DEFAULT NULL,
  `modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `modified_date` date NULL DEFAULT NULL,
  PRIMARY KEY (`configuration_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of app_config
-- ----------------------------
INSERT INTO `app_config` VALUES (1, 'APP.TEMPLATE.NAV.MENU.SIDEBAR', '1', 'nav menu sidebar behavior default', NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for app_constant
-- ----------------------------
DROP TABLE IF EXISTS `app_constant`;
CREATE TABLE `app_constant`  (
  `app_variable_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`app_variable_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for app_menu
-- ----------------------------
DROP TABLE IF EXISTS `app_menu`;
CREATE TABLE `app_menu`  (
  `menu_id` int(12) NOT NULL AUTO_INCREMENT,
  `menu_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `menu_icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `module_name` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `type_menu` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `seq_number` int(10) NULL DEFAULT NULL,
  `parent_id` int(10) NULL DEFAULT NULL,
  `status` enum('RA','RD') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `created_date` datetime(0) NULL DEFAULT NULL,
  `modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `modified_date` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 115 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of app_menu
-- ----------------------------
INSERT INTO `app_menu` VALUES (5, 'Configuration', 'fa-gear', 'app_config', '', 0, 97, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `app_menu` VALUES (6, 'Menu', '', 'app_menu', '', 1, 97, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `app_menu` VALUES (7, 'Role', '', 'app_role', '', 1, 97, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `app_menu` VALUES (9, 'Role Menu', '', 'app_role_menu', '', 1, 97, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `app_menu` VALUES (36, 'Table Sequence', '', 'app_table_sequence', '', 1, 97, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `app_menu` VALUES (96, 'User Access', '', 'app_resource', NULL, 6, 97, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `app_menu` VALUES (97, 'Control Panel', '', '#', '', 2, 0, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for app_resource
-- ----------------------------
DROP TABLE IF EXISTS `app_resource`;
CREATE TABLE `app_resource`  (
  `resource_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NULL DEFAULT NULL,
  `nip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` enum('INTERNAL','VENDOR') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` enum('RA','RD') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'RA',
  `created_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `created_date` date NULL DEFAULT NULL,
  `modified_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `modified_date` date NULL DEFAULT NULL,
  PRIMARY KEY (`resource_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '--------------------------------------------------------------------------------------------------------------------------------------------\r\nSTATUS TABLE SYSTEM column status\r\n--------------------------------------------------------------------------------------------------------------------------------------------\r\nRA = Active Record\r\nRD = Deteled Record' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of app_resource
-- ----------------------------
INSERT INTO `app_resource` VALUES (1, 1, '000001', NULL, 'Admin A', 'admin', '21232f297a57a5a743894a0e4a801fc3', 'RA', NULL, NULL, NULL, NULL);
INSERT INTO `app_resource` VALUES (2, 2, '000002', '', 'Admin B', 'authorize', '21232f297a57a5a743894a0e4a801fc3', 'RA', NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for app_role
-- ----------------------------
DROP TABLE IF EXISTS `app_role`;
CREATE TABLE `app_role`  (
  `role_id` int(10) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` enum('RA','RD') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'RA',
  `created_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `created_date` date NULL DEFAULT NULL,
  `modified_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `modified_date` date NULL DEFAULT NULL,
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of app_role
-- ----------------------------
INSERT INTO `app_role` VALUES (1, 'Super Admin', 'RA', NULL, '2017-04-29', NULL, NULL);
INSERT INTO `app_role` VALUES (2, 'SPV', 'RA', NULL, NULL, NULL, NULL);
INSERT INTO `app_role` VALUES (3, 'Guest', 'RA', NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for app_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `app_role_menu`;
CREATE TABLE `app_role_menu`  (
  `role_menu_id` int(12) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NULL DEFAULT NULL,
  `menu_id` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` enum('RA','RD') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `created_by` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `created_date` datetime(0) NULL DEFAULT NULL,
  `modified_by` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `modified_date` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`role_menu_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 249 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of app_role_menu
-- ----------------------------
INSERT INTO `app_role_menu` VALUES (14, 1, '6', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `app_role_menu` VALUES (15, 1, '7', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `app_role_menu` VALUES (17, 1, '9', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `app_role_menu` VALUES (177, 1, '36', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `app_role_menu` VALUES (185, 1, '5', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `app_role_menu` VALUES (212, 1, '96', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `app_role_menu` VALUES (231, 1, '97', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `app_role_menu` VALUES (241, 2, '5', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `app_role_menu` VALUES (242, 2, '6', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `app_role_menu` VALUES (243, 2, '7', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `app_role_menu` VALUES (244, 2, '9', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `app_role_menu` VALUES (245, 2, '36', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `app_role_menu` VALUES (246, 2, '96', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `app_role_menu` VALUES (248, 2, '97', NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for app_table_sequence
-- ----------------------------
DROP TABLE IF EXISTS `app_table_sequence`;
CREATE TABLE `app_table_sequence`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'table name or class name',
  `prefix` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `increment` int(1) NOT NULL DEFAULT 1,
  `pad` int(11) NOT NULL DEFAULT 8,
  `row` double NOT NULL DEFAULT 0,
  `used` double(5, 0) NOT NULL DEFAULT 0,
  `last_insert_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of app_table_sequence
-- ----------------------------
INSERT INTO `app_table_sequence` VALUES (1, 'sln_pesan', 'MSG', 1, 27, 176, 0, 'MSG000000000000000000000000176');
INSERT INTO `app_table_sequence` VALUES (2, 'sln_pesan_session', 'SPS', 1, 27, 43, 0, 'SPS000000000000000000000000043');
INSERT INTO `app_table_sequence` VALUES (3, 'sln_partisipan', 'SPN', 1, 27, 75, 0, 'SPN000000000000000000000000075');
INSERT INTO `app_table_sequence` VALUES (4, 'Sln_sample_generator', 'SSG', 1, 8, 0, 0, '');

-- ----------------------------
-- Table structure for test_sample_generator
-- ----------------------------
DROP TABLE IF EXISTS `test_sample_generator`;
CREATE TABLE `test_sample_generator`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `telp` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of test_sample_generator
-- ----------------------------
INSERT INTO `test_sample_generator` VALUES (1, 'Zuliadin', 'Tangerang', '081284190270');

SET FOREIGN_KEY_CHECKS = 1;
