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

 Date: 05/03/2024 19:11:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for epsilon_chain
-- ----------------------------
DROP TABLE IF EXISTS `epsilon_chain`;
CREATE TABLE `epsilon_chain`  (
  `chain_name` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '规则链名称',
  `application_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '应用名称',
  `chain_desc` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '规则链描述',
  `el_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT 'EL表达式',
  `create_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `enable` tinyint(1) NULL DEFAULT 1 COMMENT '是否启用，默认为1（启用）',
  PRIMARY KEY (`chain_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of epsilon_chain
-- ----------------------------
INSERT INTO `epsilon_chain` VALUES ('D647585A0A2142C9910769FD2E324CA2', 'epsilon-rule', '测试流程1', 'THEN(E5B478F47717AC2281620BEFB19E8108,E5B478F47717AC2281620BEFB19E8108,C73C64F1CB73FAC3DE943EB70D024D25);', '2024-03-05 18:59:47', 1);

-- ----------------------------
-- Table structure for epsilon_edge
-- ----------------------------
DROP TABLE IF EXISTS `epsilon_edge`;
CREATE TABLE `epsilon_edge`  (
  `edge_id` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '边的ID，唯一标识一条边',
  `rule_id` int UNSIGNED NOT NULL COMMENT '规则ID，关联到特定的规则',
  `source_id` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '起始节点ID',
  `target_id` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '目标节点ID',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '创建人',
  `updated_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '更新人',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`edge_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of epsilon_edge
-- ----------------------------
INSERT INTO `epsilon_edge` VALUES ('249d3f444a6c49008d7296e8c38eeb01', 1, 'e60346c7cedd4b0394342ab7be573088', 'ce14d072489d433e9a9f1cbe32769d4b', NULL, NULL, NULL, NULL, 0);
INSERT INTO `epsilon_edge` VALUES ('259ab08185194a80a29672e234387ec2', 1, 'b6fcf0d627e44ab5b58408229175cf40', 'e60346c7cedd4b0394342ab7be573088', NULL, NULL, NULL, NULL, 0);
INSERT INTO `epsilon_edge` VALUES ('9965f89025734e2282ce11d33995ad53', 1, 'e60346c7cedd4b0394342ab7be573088', '9649430e7ad04d64ba2a01faba137fd6', NULL, NULL, NULL, NULL, 0);
INSERT INTO `epsilon_edge` VALUES ('b3ec5cf1167b41f2aee798711a12ddee', 1, '9649430e7ad04d64ba2a01faba137fd6', '36ad0e86cf1e4527a48fd117125d210e', NULL, NULL, NULL, NULL, 0);
INSERT INTO `epsilon_edge` VALUES ('e2f4e8a1bc874ea090aad1252b6e3449', 1, 'ce14d072489d433e9a9f1cbe32769d4b', '36ad0e86cf1e4527a48fd117125d210e', NULL, NULL, NULL, NULL, 0);

-- ----------------------------
-- Table structure for epsilon_node
-- ----------------------------
DROP TABLE IF EXISTS `epsilon_node`;
CREATE TABLE `epsilon_node`  (
  `node_id` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '节点ID，唯一标识一个节点',
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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of epsilon_node
-- ----------------------------
INSERT INTO `epsilon_node` VALUES ('36ad0e86cf1e4527a48fd117125d210e', 1, 'end-node', '结束节点', 920.00, 100.00, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `epsilon_node` VALUES ('9649430e7ad04d64ba2a01faba137fd6', 1, 'calculate-node', '赋值运算节点', 650.00, 160.00, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `epsilon_node` VALUES ('b6fcf0d627e44ab5b58408229175cf40', 1, 'start-node', '开始节点', 100.00, 100.00, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `epsilon_node` VALUES ('ce14d072489d433e9a9f1cbe32769d4b', 1, 'calculate-node', '赋值运算节点', 650.00, 100.00, 'hello world', NULL, NULL, NULL, NULL, 0);
INSERT INTO `epsilon_node` VALUES ('e60346c7cedd4b0394342ab7be573088', 1, 'switch-node', '条件分支节点', 370.00, 100.00, NULL, NULL, NULL, NULL, NULL, 0);

-- ----------------------------
-- Table structure for epsilon_project
-- ----------------------------
DROP TABLE IF EXISTS `epsilon_project`;
CREATE TABLE `epsilon_project`  (
  `project_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '项目ID',
  `project_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '项目名称',
  `project_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '项目描述',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '创建人',
  `updated_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '更新人',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`project_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of epsilon_project
-- ----------------------------

-- ----------------------------
-- Table structure for epsilon_rule
-- ----------------------------
DROP TABLE IF EXISTS `epsilon_rule`;
CREATE TABLE `epsilon_rule`  (
  `rule_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `chain_name` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '规则链名称',
  `rule_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '规则描述',
  `enable` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '是否启用，默认为0（未启用）',
  `validated` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '是否校验，默认为0（未校验）',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '创建人',
  `updated_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '更新人',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`rule_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of epsilon_rule
-- ----------------------------
INSERT INTO `epsilon_rule` VALUES (1, 'D647585A0A2142C9910769FD2E324CA2', NULL, 1, 0, '2024-03-05 18:59:56', NULL, '2024-03-05 19:03:07', NULL, 0);
INSERT INTO `epsilon_rule` VALUES (2, '4CC1EA710E9A00B55A645596FD171E4D', NULL, 0, 0, '2024-03-05 19:00:19', NULL, '2024-03-05 19:00:19', NULL, 0);

-- ----------------------------
-- Table structure for epsilon_script
-- ----------------------------
DROP TABLE IF EXISTS `epsilon_script`;
CREATE TABLE `epsilon_script`  (
  `script_id` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '脚本ID',
  `application_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '应用名称',
  `script_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '脚本名称',
  `script_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '脚本数据',
  `script_type` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '脚本类型',
  `script_language` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '脚本语言',
  `create_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `enable` tinyint(1) NULL DEFAULT 1 COMMENT '是否启用，默认为1（启用）',
  PRIMARY KEY (`script_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of epsilon_script
-- ----------------------------
INSERT INTO `epsilon_script` VALUES ('3C326B03A831635F4FDCB177DD8CCEDA', 'epsilon-rule', '脚本s2', 'inputContext.put(\"s2\",\"hello\")', 'script', 'groovy', '2024-03-05 17:12:49', 1);
INSERT INTO `epsilon_script` VALUES ('C73C64F1CB73FAC3DE943EB70D024D25', 'epsilon-rule', '脚本s3', 'outputContext.put(\"s2\",inputContext.get(\"s2\"))\r\noutputContext.put(\"demoDate\",inputContext.get(\"demoDate\"))\r\noutputContext.put(\"student\",inputContext.get(\"student\"))\r\noutputContext.put(\"s1\",inputContext.get(\"s1\"))', 'script', 'groovy', '2024-03-05 17:12:56', 1);
INSERT INTO `epsilon_script` VALUES ('E5B478F47717AC2281620BEFB19E8108', 'epsilon-rule', '脚本s1', 'import cn.hutool.core.date.DateUtil\r\ndef date = DateUtil.parse(\"2022-10-17 13:31:43\")\r\nprintln(date)\r\ninputContext.put(\"demoDate\", date)\r\nclass Student {\r\nint studentID\r\nString studentName\r\n}\r\nStudent student = new Student()\r\nstudent.studentID = 100301\r\nstudent.studentName = \"张三\" \r\ninputContext.put(\"student\",student)\r\ndef a=3\r\ndef b=2\r\ninputContext.put(\"s1\",a*b)', 'script', 'groovy', '2024-03-05 17:23:28', 1);

-- ----------------------------
-- Table structure for rule_menu
-- ----------------------------
DROP TABLE IF EXISTS `rule_menu`;
CREATE TABLE `rule_menu`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `project_id` int NOT NULL COMMENT '项目ID',
  `menu_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '菜单名称',
  `menu_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '菜单类型 1:目录 | 2:名称',
  `rule_id` int NULL DEFAULT NULL COMMENT '规则ID，关联到特定的规则',
  `parent_id` int NULL DEFAULT NULL COMMENT '父菜单ID，指向上级菜单的ID',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '创建人',
  `updated_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '更新人',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of rule_menu
-- ----------------------------
INSERT INTO `rule_menu` VALUES (1, 1, '测试规则目录', '1', NULL, NULL, '2024-02-20 18:13:15', NULL, '2024-02-21 14:07:23', NULL, 0);
INSERT INTO `rule_menu` VALUES (2, 1, '信贷客户实地检查', '2', 1, 1, '2024-02-20 18:21:51', NULL, '2024-03-04 15:52:47', NULL, 0);
INSERT INTO `rule_menu` VALUES (3, 1, '信贷客户实地检查频率信贷客户实地检查频率信贷客户实地检查频率信贷客户实地检查频率', '2', 2, 1, '2024-02-20 18:22:54', NULL, '2024-03-05 11:05:13', NULL, 0);
INSERT INTO `rule_menu` VALUES (4, 1, '测试拖拽目录', '1', NULL, NULL, '2024-02-22 17:13:08', NULL, '2024-02-22 17:13:08', NULL, 0);

SET FOREIGN_KEY_CHECKS = 1;
