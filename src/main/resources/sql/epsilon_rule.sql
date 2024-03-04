/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 80034
 Source Host           : 127.0.0.1:3306
 Source Schema         : epsilon_rule

 Target Server Type    : MySQL
 Target Server Version : 80034
 File Encoding         : 65001

 Date: 04/03/2024 19:30:58
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for epsilon_chain
-- ----------------------------
DROP TABLE IF EXISTS `epsilon_chain`;
CREATE TABLE `epsilon_chain`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键自增长ID',
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
-- Table structure for epsilon_edge
-- ----------------------------
DROP TABLE IF EXISTS `epsilon_edge`;
CREATE TABLE `epsilon_edge`  (
  `edge_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '边的ID，唯一标识一条边',
  `rule_id` int UNSIGNED NOT NULL COMMENT '规则ID，关联到特定的规则',
  `source_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '起始节点ID',
  `target_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '目标节点ID',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '创建人',
  `updated_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '更新人',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`edge_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of epsilon_edge
-- ----------------------------
INSERT INTO `epsilon_edge` VALUES ('12d798c4-0717-4da1-acd9-9eddfa655402', 1, '94a06862-9f48-4d73-88fd-f56f722d51d5', '63e08af1-2961-4e05-b523-456011337edb', NULL, NULL, NULL, NULL, 0);
INSERT INTO `epsilon_edge` VALUES ('7a4ce01c-24fd-4f33-bf5e-f7fcff6339d8', 1, '94a06862-9f48-4d73-88fd-f56f722d51d5', 'ad8c02d4-9116-49b1-8022-276686b9e8e9', NULL, NULL, NULL, NULL, 0);
INSERT INTO `epsilon_edge` VALUES ('9303c338-8588-479b-b818-86d9242968a2', 1, 'ad8c02d4-9116-49b1-8022-276686b9e8e9', 'e0508d22-5f7b-4c68-ad18-54889162fb9c', NULL, NULL, NULL, NULL, 0);
INSERT INTO `epsilon_edge` VALUES ('b3c6953a-2416-428c-bb88-a133a282a115', 1, 'c9f9f386-8cbf-40f4-b230-cb5b8746fca2', '94a06862-9f48-4d73-88fd-f56f722d51d5', NULL, NULL, NULL, NULL, 0);
INSERT INTO `epsilon_edge` VALUES ('ee19fd29-a73d-40b8-8efd-ef5eb50fff55', 1, '63e08af1-2961-4e05-b523-456011337edb', 'e0508d22-5f7b-4c68-ad18-54889162fb9c', NULL, NULL, NULL, NULL, 0);
INSERT INTO `epsilon_edge` VALUES ('fbc93381-dc57-493f-85ce-5694d5637c68', 2, '51074b05-e381-4595-b13c-abce0df1d68a', 'deaa9821-8fc2-405d-8d4e-34634fc41a59', NULL, NULL, NULL, NULL, 0);

-- ----------------------------
-- Table structure for epsilon_node
-- ----------------------------
DROP TABLE IF EXISTS `epsilon_node`;
CREATE TABLE `epsilon_node`  (
  `node_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '节点ID，唯一标识一个节点',
  `rule_id` int UNSIGNED NOT NULL COMMENT '规则ID，关联到特定的规则',
  `shape` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '节点类型',
  `label` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '节点名称',
  `position_x` decimal(10, 2) NOT NULL COMMENT '节点的X坐标位置',
  `position_y` decimal(10, 2) NOT NULL COMMENT '节点的Y坐标位置',
  `epsilon_script` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '节点的脚本',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '创建人',
  `updated_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '更新人',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`node_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of epsilon_node
-- ----------------------------
INSERT INTO `epsilon_node` VALUES ('51074b05-e381-4595-b13c-abce0df1d68a', 2, 'start-node', NULL, 130.00, 150.00, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `epsilon_node` VALUES ('63e08af1-2961-4e05-b523-456011337edb', 1, 'calculate-node', NULL, 580.00, 180.00, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `epsilon_node` VALUES ('94a06862-9f48-4d73-88fd-f56f722d51d5', 1, 'switch-node', NULL, 320.00, 100.00, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `epsilon_node` VALUES ('ad8c02d4-9116-49b1-8022-276686b9e8e9', 1, 'calculate-node', NULL, 580.00, 100.00, 'hello world', NULL, NULL, NULL, NULL, 0);
INSERT INTO `epsilon_node` VALUES ('c9f9f386-8cbf-40f4-b230-cb5b8746fca2', 1, 'start-node', NULL, 80.00, 100.00, '', NULL, NULL, NULL, NULL, 0);
INSERT INTO `epsilon_node` VALUES ('deaa9821-8fc2-405d-8d4e-34634fc41a59', 2, 'end-node', NULL, 440.00, 150.00, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `epsilon_node` VALUES ('e0508d22-5f7b-4c68-ad18-54889162fb9c', 1, 'end-node', NULL, 920.00, 100.00, NULL, NULL, NULL, NULL, NULL, 0);

-- ----------------------------
-- Table structure for epsilon_rule
-- ----------------------------
DROP TABLE IF EXISTS `epsilon_rule`;
CREATE TABLE `epsilon_rule`  (
  `rule_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `chain_name` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '规则链名称',
  `rule_desc` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '规则描述',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '创建人',
  `updated_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '更新人',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`rule_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of epsilon_rule
-- ----------------------------
INSERT INTO `epsilon_rule` VALUES (1, 'A60C3CD3-E8FF-B7C8-C6CE-E688FC9C4F22', NULL, '2024-03-04 19:03:00', NULL, '2024-03-04 19:03:00', NULL, 0);
INSERT INTO `epsilon_rule` VALUES (2, '641424E7-364F-3B8F-5AAF-9B85F4B02C5D', NULL, '2024-03-04 19:03:09', NULL, '2024-03-04 19:03:09', NULL, 0);

-- ----------------------------
-- Table structure for epsilon_script
-- ----------------------------
DROP TABLE IF EXISTS `epsilon_script`;
CREATE TABLE `epsilon_script`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键自增长ID',
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
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `project_id` int NOT NULL COMMENT '项目ID',
  `menu_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '菜单名称',
  `menu_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '菜单类型 1:目录 | 2:名称',
  `rule_id` int NULL DEFAULT NULL COMMENT '规则ID，关联到特定的规则',
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
INSERT INTO `rule_menu` VALUES (2, 1, '信贷客户实地检查', '2', 1, 1, '2024-02-20 18:21:51', NULL, '2024-03-04 15:52:47', NULL, 0);
INSERT INTO `rule_menu` VALUES (3, 1, '信贷客户实地检查频率信贷客户实地检查频率', '2', 2, 1, '2024-02-20 18:22:54', NULL, '2024-03-04 15:52:53', NULL, 0);
INSERT INTO `rule_menu` VALUES (4, 1, '测试拖拽目录', '1', NULL, NULL, '2024-02-22 17:13:08', NULL, '2024-02-22 17:13:08', NULL, 0);

SET FOREIGN_KEY_CHECKS = 1;
