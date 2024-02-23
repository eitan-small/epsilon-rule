/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80034
 Source Host           : localhost:3306
 Source Schema         : epsilon_rule

 Target Server Type    : MySQL
 Target Server Version : 80034
 File Encoding         : 65001

 Date: 23/02/2024 18:51:12
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for epsilon_chain
-- ----------------------------
DROP TABLE IF EXISTS `epsilon_chain`;
CREATE TABLE `epsilon_chain`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键自增长ID',
  `application_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '应用名称',
  `chain_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '规则链名称',
  `chain_desc` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '规则链描述',
  `el_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT 'EL表达式',
  `create_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `enable` tinyint(1) NULL DEFAULT 1 COMMENT '是否启用，默认为1（启用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of epsilon_chain
-- ----------------------------
INSERT INTO `epsilon_chain` VALUES (1, 'epsilon-rule', 'chain1', '测试流程1', 'THEN(s1,s2,s3);', '2024-02-18 19:36:06', 1);

-- ----------------------------
-- Table structure for epsilon_script
-- ----------------------------
DROP TABLE IF EXISTS `epsilon_script`;
CREATE TABLE `epsilon_script`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键自增长ID',
  `application_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '应用名称',
  `script_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '脚本ID',
  `script_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '脚本名称',
  `script_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '脚本数据',
  `script_type` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '脚本类型',
  `script_language` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '脚本语言',
  `create_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `enable` tinyint(1) NULL DEFAULT 1 COMMENT '是否启用，默认为1（启用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of epsilon_script
-- ----------------------------
INSERT INTO `epsilon_script` VALUES (1, 'epsilon-rule', 's1', '脚本s1', 'import cn.hutool.core.date.DateUtil\r\ndef date = DateUtil.parse(\"2022-10-17 13:31:43\")\r\nprintln(date)\r\ninputContext.put(\"demoDate\", date)\r\nclass Student {\r\nint studentID\r\nString studentName\r\n}\r\nStudent student = new Student()\r\nstudent.studentID = 100301\r\nstudent.studentName = \"张三\" \r\ninputContext.put(\"student\",student)\r\ndef a=3\r\ndef b=2\r\ninputContext.put(\"s1\",a*b)', 'script', 'groovy', '2024-02-18 19:35:59', 1);
INSERT INTO `epsilon_script` VALUES (2, 'epsilon-rule', 's2', '脚本s2', 'inputContext.put(\"s2\",\"hello\")', 'script', 'groovy', '2024-02-18 19:35:59', 1);
INSERT INTO `epsilon_script` VALUES (3, 'epsilon-rule', 's3', '脚本s3', 'outputContext.put(\"s2\",inputContext.get(\"s2\"))\r\noutputContext.put(\"demoDate\",inputContext.get(\"demoDate\"))\r\noutputContext.put(\"student\",inputContext.get(\"student\"))\r\noutputContext.put(\"s1\",inputContext.get(\"s1\"))', 'script', 'groovy', '2024-02-18 19:36:25', 1);

-- ----------------------------
-- Table structure for rule_menu
-- ----------------------------
DROP TABLE IF EXISTS `rule_menu`;
CREATE TABLE `rule_menu`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `project_id` int NOT NULL COMMENT '项目ID',
  `menu_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '菜单名称',
  `menu_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '菜单类型 1:目录 | 2:名称',
  `chain_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '规则链名称',
  `parent_id` int NULL DEFAULT NULL COMMENT '父菜单ID，指向上级菜单的ID',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '创建人',
  `updated_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '更新人',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rule_menu
-- ----------------------------
INSERT INTO `rule_menu` VALUES (1, 1, '测试规则目录', '1', NULL, NULL, '2024-02-20 18:13:15', NULL, '2024-02-21 14:07:23', NULL, 0);
INSERT INTO `rule_menu` VALUES (2, 1, '信贷客户实地检查', '2', '0CFC037C3387B44FDC8E86BAEF6AB864', 1, '2024-02-20 18:21:51', NULL, '2024-02-21 10:04:24', NULL, 0);
INSERT INTO `rule_menu` VALUES (3, 1, '信贷客户实地检查频率信贷客户实地检查频率', '2', '568DF5FB1BBBD9A196E1D2431ABFD506', 1, '2024-02-20 18:22:54', NULL, '2024-02-21 16:01:51', NULL, 0);
INSERT INTO `rule_menu` VALUES (4, 1, '测试拖拽目录', '1', NULL, NULL, '2024-02-22 17:13:08', NULL, '2024-02-22 17:13:08', NULL, 0);

SET FOREIGN_KEY_CHECKS = 1;
