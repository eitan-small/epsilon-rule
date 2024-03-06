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

 Date: 06/03/2024 11:11:52
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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of epsilon_chain
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of epsilon_rule
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of rule_menu
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
