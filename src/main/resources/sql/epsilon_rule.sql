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

 Date: 08/03/2024 08:47:43
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for epsilon_chain
-- ----------------------------
DROP TABLE IF EXISTS `epsilon_chain`;
CREATE TABLE `epsilon_chain`  (
  `chain_name` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '规则链名称',
  `application_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT 'epsilon-rule' COMMENT '应用名称',
  `chain_desc` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '规则链描述',
  `el_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT 'EL表达式',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `enable` tinyint(1) NULL DEFAULT 1 COMMENT '是否启用，默认为1（启用）',
  PRIMARY KEY (`chain_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of epsilon_chain
-- ----------------------------
INSERT INTO `epsilon_chain` VALUES ('0cc9c75127c44ddabadee0d8a106c985', 'epsilon-rule', '信贷客户实地检查', 'THEN(node(\"33e1b261f7d5409f9a44fcff6b25cdf7\"), node(\"2732c1f9a80d4f24ab56bead1b25651a\"));', '2024-03-06 18:11:51', 1);
INSERT INTO `epsilon_chain` VALUES ('3e9838674b4a4fe0bc7cb367d3144052', 'epsilon-rule', '信贷客户实地检查频率', 'THEN(node(\"94f35fab86554bb1b5fde760437e4538\"), node(\"c9e562455bc84fc2bf777baa5361fc16\"), node(\"c1e6cefa5a4d47b6b1f5173a5ff9acb4\"), node(\"4884f8a27ece4e3ead56e5a0b306279d\"), node(\"76ad329700174191b1f8b77579155e50\"));', '2024-03-06 18:26:12', 1);

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
INSERT INTO `epsilon_edge` VALUES ('38e5d151633a493d91d19450a960e982', 2, 'c9e562455bc84fc2bf777baa5361fc16', 'c1e6cefa5a4d47b6b1f5173a5ff9acb4', NULL, NULL, NULL, NULL, 0);
INSERT INTO `epsilon_edge` VALUES ('4a6d761ee8d242368e9fe22dde7d3a68', 2, '94f35fab86554bb1b5fde760437e4538', 'c9e562455bc84fc2bf777baa5361fc16', NULL, NULL, NULL, NULL, 0);
INSERT INTO `epsilon_edge` VALUES ('7079a9b2549d4422bbc304589d6120df', 2, '9581b4c4260e487a9daa9ac1df043819', '94f35fab86554bb1b5fde760437e4538', NULL, NULL, NULL, NULL, 0);
INSERT INTO `epsilon_edge` VALUES ('83376940306e409e8103b41c9e7b708e', 2, 'c1e6cefa5a4d47b6b1f5173a5ff9acb4', '4884f8a27ece4e3ead56e5a0b306279d', NULL, NULL, NULL, NULL, 0);
INSERT INTO `epsilon_edge` VALUES ('89b506253da4468abee8029e813b314b', 2, '4884f8a27ece4e3ead56e5a0b306279d', '76ad329700174191b1f8b77579155e50', NULL, NULL, NULL, NULL, 0);
INSERT INTO `epsilon_edge` VALUES ('b05a7698c7c045148d850add8dcfc208', 1, '8b54a97118c24ebeaa69696467ab20d7', '33e1b261f7d5409f9a44fcff6b25cdf7', NULL, NULL, NULL, NULL, 0);
INSERT INTO `epsilon_edge` VALUES ('d718bf6fb0fe46159899ef0cee7cc016', 1, '33e1b261f7d5409f9a44fcff6b25cdf7', '2732c1f9a80d4f24ab56bead1b25651a', NULL, NULL, NULL, NULL, 0);

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
INSERT INTO `epsilon_node` VALUES ('2732c1f9a80d4f24ab56bead1b25651a', 1, 'end-node', '结束节点', 580.00, 140.00, 'outputContext.put(\"isMatched\", inputContext.get(\"isMatched\"));', NULL, NULL, NULL, NULL, 0);
INSERT INTO `epsilon_node` VALUES ('33e1b261f7d5409f9a44fcff6b25cdf7', 1, 'calculate-node', '判断是否执行', 340.00, 140.00, 'if (inputContext.get(\"custType\") === \"01\") {\n  inputContext.put(\"isMatched\", true);\n}\nif (inputContext.get(\"custType\") !== \"01\") {\n  inputContext.put(\"isMatched\", false);\n}', NULL, NULL, NULL, NULL, 0);
INSERT INTO `epsilon_node` VALUES ('4884f8a27ece4e3ead56e5a0b306279d', 2, 'calculate-node', '取所有频率的最小值', 1040.00, 100.00, 'inputContext.put(\n  \"finalFeq\",\n  Math.min(\n    inputContext.get(\"finalFeq\"),\n    inputContext.get(\"feq1\"),\n    inputContext.get(\"feq2\"),\n    inputContext.get(\"feq3\"),\n    inputContext.get(\"feq4\"),\n    inputContext.get(\"feq5\"),\n    inputContext.get(\"feq6\")\n  )\n);\n', NULL, NULL, NULL, NULL, 0);
INSERT INTO `epsilon_node` VALUES ('76ad329700174191b1f8b77579155e50', 2, 'end-node', '结束节点', 1280.00, 100.00, 'outputContext.put(\"feq\", inputContext.get(\"finalFeq\"));\n', NULL, NULL, NULL, NULL, 0);
INSERT INTO `epsilon_node` VALUES ('8b54a97118c24ebeaa69696467ab20d7', 1, 'start-node', '开始节点', 100.00, 140.00, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `epsilon_node` VALUES ('94f35fab86554bb1b5fde760437e4538', 2, 'calculate-node', '转化基础频率', 320.00, 100.00, 'if (inputContext.get(\"custClassify\") === \"R1\") {\n  inputContext.put(\"basicFeqLev\", 3);\n}\nif (inputContext.get(\"custClassify\") === \"R2\") {\n  inputContext.put(\"basicFeqLev\", 2);\n}\nif (inputContext.get(\"custClassify\") === \"R3\") {\n  inputContext.put(\"basicFeqLev\", 1);\n}\ninputContext.put(\"finalFeqLev\", inputContext.get(\"basicFeqLev\"));\ninputContext.put(\"feq1\", Number.MAX_SAFE_INTEGER);\ninputContext.put(\"feq2\", Number.MAX_SAFE_INTEGER);\ninputContext.put(\"feq3\", Number.MAX_SAFE_INTEGER);\ninputContext.put(\"feq4\", Number.MAX_SAFE_INTEGER);\ninputContext.put(\"feq5\", Number.MAX_SAFE_INTEGER);\ninputContext.put(\"feq6\", Number.MAX_SAFE_INTEGER);\n', NULL, NULL, NULL, NULL, 0);
INSERT INTO `epsilon_node` VALUES ('9581b4c4260e487a9daa9ac1df043819', 2, 'start-node', '开始节点', 80.00, 100.00, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `epsilon_node` VALUES ('c1e6cefa5a4d47b6b1f5173a5ff9acb4', 2, 'calculate-node', '转化影响频率等级', 800.00, 100.00, 'if (inputContext.get(\"finalFeqLev\") === 1) {\n  inputContext.put(\"finalFeq\", 6);\n}\nif (inputContext.get(\"finalFeqLev\") === 2) {\n  inputContext.put(\"finalFeq\", 3);\n}\nif (inputContext.get(\"finalFeqLev\") >= 3) {\n  inputContext.put(\"finalFeq\", 1);\n}\n', NULL, NULL, NULL, NULL, 0);
INSERT INTO `epsilon_node` VALUES ('c9e562455bc84fc2bf777baa5361fc16', 2, 'calculate-node', '影响频率因素', 560.00, 100.00, '// 异地客户影响\n// 是异地客户且（不是供应链上下游客户或不承担最终偿付责任） 基础频率登记上调一档\nif (\n  inputContext.get(\"isOtherPlace\") === \"1\" &&\n  (inputContext.get(\"isDownstreamCust\") === \"0\" ||\n    inputContext.get(\"isPaymentDuty\") === \"0\")\n) {\n  inputContext.put(\"finalFeqLev\", inputContext.get(\"basicFeqLev\") + 1);\n}\n\n// 贷款种类影响\n// 城镇化建设贷款或房地产贷款或城市更新贷款 频率为1月/次\nif (\n  inputContext.get(\"busiType\").includes(\"1025\") ||\n  inputContext.get(\"busiType\").includes(\"1099\") ||\n  inputContext.get(\"busiType\").includes(\"城市更新贷款\")\n) {\n  inputContext.put(\"feq1\", 1);\n}\n// 经营性物业抵押贷款或其他固定资产贷款或并购贷款 基础频率登记上调一档\nif (\n  inputContext.get(\"busiType\").includes(\"1024\") ||\n  inputContext.get(\"busiType\").includes(\"其他固定资产贷款\") ||\n  inputContext.get(\"busiType\").includes(\"1026\")\n) {\n  inputContext.put(\"finalFeqLev\", inputContext.get(\"basicFeqLev\") + 1);\n}\n\n// 抵押物种类影响\n// 在建工程 频率为1月/次\nif (inputContext.get(\"guarTypeEx\").includes(\"在建工程\")) {\n  inputContext.put(\"feq2\", 1);\n}\n// 房地产或林权或农村承包土地经营权或公路、桥梁等收费权或股权 频率为3月/次\nif (\n  inputContext.get(\"guarTypeEx\").includes(\"房地产\") ||\n  inputContext.get(\"guarTypeEx\").includes(\"林权\") ||\n  inputContext.get(\"guarTypeEx\").includes(\"农村承包土地经营权\") ||\n  inputContext.get(\"guarTypeEx\").includes(\"公路、桥梁等收费权\") ||\n  inputContext.get(\"guarTypeEx\").includes(\"股权\")\n) {\n  inputContext.put(\"feq3\", 3);\n}\n\n// 客户环境和社会敏感度影响\n// A类客户且是固定资产贷款客户 频率为1月/次\nif (\n  inputContext.get(\"riskClassify\") === \"A类\" &&\n  inputContext.get(\"isFixedAssets\") === \"1\"\n) {\n  inputContext.put(\"feq4\", 1);\n}\n// B类客户或（A类客户且不是固定资产贷款客户） 频率为3月/次\nif (\n  inputContext.get(\"riskClassify\") === \"B类\" ||\n  (inputContext.get(\"riskClassify\") === \"A类\" &&\n    inputContext.get(\"isFixedAssets\") === \"0\")\n) {\n  inputContext.put(\"feq5\", 3);\n}\n// C类客户 频率为6月/次\nif (inputContext.get(\"riskClassify\") === \"C类\") {\n  inputContext.put(\"feq6\", 6);\n}\n', NULL, NULL, NULL, NULL, 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of epsilon_rule
-- ----------------------------
INSERT INTO `epsilon_rule` VALUES (1, '0cc9c75127c44ddabadee0d8a106c985', '判断是否进行信贷客户实地检查', 0, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `epsilon_rule` VALUES (2, '3e9838674b4a4fe0bc7cb367d3144052', '根据客户信息判断检查频率', 0, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `epsilon_rule` VALUES (3, '6daa351fc80040f69195c7d9d73f1b7f', '', 0, 0, NULL, NULL, NULL, NULL, 0);

-- ----------------------------
-- Table structure for epsilon_script
-- ----------------------------
DROP TABLE IF EXISTS `epsilon_script`;
CREATE TABLE `epsilon_script`  (
  `script_id` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '脚本ID',
  `application_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT 'epsilon-rule' COMMENT '应用名称',
  `script_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '脚本名称',
  `script_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '脚本数据',
  `script_type` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT 'script' COMMENT '脚本类型',
  `script_language` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT 'js' COMMENT '脚本语言',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `enable` tinyint(1) NULL DEFAULT 1 COMMENT '是否启用，默认为1（启用）',
  PRIMARY KEY (`script_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of epsilon_script
-- ----------------------------
INSERT INTO `epsilon_script` VALUES ('2732c1f9a80d4f24ab56bead1b25651a', 'epsilon-rule', '结束节点', 'outputContext.put(\"isMatched\", inputContext.get(\"isMatched\"));', 'script', 'js', '2024-03-06 17:23:05', 1);
INSERT INTO `epsilon_script` VALUES ('33e1b261f7d5409f9a44fcff6b25cdf7', 'epsilon-rule', '判断是否执行', 'if (inputContext.get(\"custType\") === \"01\") {\n  inputContext.put(\"isMatched\", true);\n}\nif (inputContext.get(\"custType\") !== \"01\") {\n  inputContext.put(\"isMatched\", false);\n}', 'script', 'js', '2024-03-06 17:22:52', 1);
INSERT INTO `epsilon_script` VALUES ('4884f8a27ece4e3ead56e5a0b306279d', 'epsilon-rule', '取所有频率的最小值', 'inputContext.put(\n  \"finalFeq\",\n  Math.min(\n    inputContext.get(\"finalFeq\"),\n    inputContext.get(\"feq1\"),\n    inputContext.get(\"feq2\"),\n    inputContext.get(\"feq3\"),\n    inputContext.get(\"feq4\"),\n    inputContext.get(\"feq5\"),\n    inputContext.get(\"feq6\")\n  )\n);\n', 'script', 'js', '2024-03-06 18:23:17', 1);
INSERT INTO `epsilon_script` VALUES ('76ad329700174191b1f8b77579155e50', 'epsilon-rule', '结束节点', 'outputContext.put(\"feq\", inputContext.get(\"finalFeq\"));\n', 'script', 'js', '2024-03-06 18:23:53', 1);
INSERT INTO `epsilon_script` VALUES ('94f35fab86554bb1b5fde760437e4538', 'epsilon-rule', '转化基础频率', 'if (inputContext.get(\"custClassify\") === \"R1\") {\n  inputContext.put(\"basicFeqLev\", 3);\n}\nif (inputContext.get(\"custClassify\") === \"R2\") {\n  inputContext.put(\"basicFeqLev\", 2);\n}\nif (inputContext.get(\"custClassify\") === \"R3\") {\n  inputContext.put(\"basicFeqLev\", 1);\n}\ninputContext.put(\"finalFeqLev\", inputContext.get(\"basicFeqLev\"));\ninputContext.put(\"feq1\", Number.MAX_SAFE_INTEGER);\ninputContext.put(\"feq2\", Number.MAX_SAFE_INTEGER);\ninputContext.put(\"feq3\", Number.MAX_SAFE_INTEGER);\ninputContext.put(\"feq4\", Number.MAX_SAFE_INTEGER);\ninputContext.put(\"feq5\", Number.MAX_SAFE_INTEGER);\ninputContext.put(\"feq6\", Number.MAX_SAFE_INTEGER);\n', 'script', 'js', '2024-03-06 18:16:18', 1);
INSERT INTO `epsilon_script` VALUES ('c1e6cefa5a4d47b6b1f5173a5ff9acb4', 'epsilon-rule', '转化影响频率等级', 'if (inputContext.get(\"finalFeqLev\") === 1) {\n  inputContext.put(\"finalFeq\", 6);\n}\nif (inputContext.get(\"finalFeqLev\") === 2) {\n  inputContext.put(\"finalFeq\", 3);\n}\nif (inputContext.get(\"finalFeqLev\") >= 3) {\n  inputContext.put(\"finalFeq\", 1);\n}\n', 'script', 'js', '2024-03-06 18:21:31', 1);
INSERT INTO `epsilon_script` VALUES ('c9e562455bc84fc2bf777baa5361fc16', 'epsilon-rule', '影响频率因素', '// 异地客户影响\n// 是异地客户且（不是供应链上下游客户或不承担最终偿付责任） 基础频率登记上调一档\nif (\n  inputContext.get(\"isOtherPlace\") === \"1\" &&\n  (inputContext.get(\"isDownstreamCust\") === \"0\" ||\n    inputContext.get(\"isPaymentDuty\") === \"0\")\n) {\n  inputContext.put(\"finalFeqLev\", inputContext.get(\"basicFeqLev\") + 1);\n}\n\n// 贷款种类影响\n// 城镇化建设贷款或房地产贷款或城市更新贷款 频率为1月/次\nif (\n  inputContext.get(\"busiType\").includes(\"1025\") ||\n  inputContext.get(\"busiType\").includes(\"1099\") ||\n  inputContext.get(\"busiType\").includes(\"城市更新贷款\")\n) {\n  inputContext.put(\"feq1\", 1);\n}\n// 经营性物业抵押贷款或其他固定资产贷款或并购贷款 基础频率登记上调一档\nif (\n  inputContext.get(\"busiType\").includes(\"1024\") ||\n  inputContext.get(\"busiType\").includes(\"其他固定资产贷款\") ||\n  inputContext.get(\"busiType\").includes(\"1026\")\n) {\n  inputContext.put(\"finalFeqLev\", inputContext.get(\"basicFeqLev\") + 1);\n}\n\n// 抵押物种类影响\n// 在建工程 频率为1月/次\nif (inputContext.get(\"guarTypeEx\").includes(\"在建工程\")) {\n  inputContext.put(\"feq2\", 1);\n}\n// 房地产或林权或农村承包土地经营权或公路、桥梁等收费权或股权 频率为3月/次\nif (\n  inputContext.get(\"guarTypeEx\").includes(\"房地产\") ||\n  inputContext.get(\"guarTypeEx\").includes(\"林权\") ||\n  inputContext.get(\"guarTypeEx\").includes(\"农村承包土地经营权\") ||\n  inputContext.get(\"guarTypeEx\").includes(\"公路、桥梁等收费权\") ||\n  inputContext.get(\"guarTypeEx\").includes(\"股权\")\n) {\n  inputContext.put(\"feq3\", 3);\n}\n\n// 客户环境和社会敏感度影响\n// A类客户且是固定资产贷款客户 频率为1月/次\nif (\n  inputContext.get(\"riskClassify\") === \"A类\" &&\n  inputContext.get(\"isFixedAssets\") === \"1\"\n) {\n  inputContext.put(\"feq4\", 1);\n}\n// B类客户或（A类客户且不是固定资产贷款客户） 频率为3月/次\nif (\n  inputContext.get(\"riskClassify\") === \"B类\" ||\n  (inputContext.get(\"riskClassify\") === \"A类\" &&\n    inputContext.get(\"isFixedAssets\") === \"0\")\n) {\n  inputContext.put(\"feq5\", 3);\n}\n// C类客户 频率为6月/次\nif (inputContext.get(\"riskClassify\") === \"C类\") {\n  inputContext.put(\"feq6\", 6);\n}\n', 'script', 'js', '2024-03-06 18:20:42', 1);

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
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of rule_menu
-- ----------------------------
INSERT INTO `rule_menu` VALUES (1, 1, '信贷客户实地检查', '2', 1, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `rule_menu` VALUES (2, 1, '信贷客户实地检查频率', '2', 2, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `rule_menu` VALUES (3, 1, '测试新建规则', '2', 3, NULL, NULL, NULL, NULL, NULL, 0);

SET FOREIGN_KEY_CHECKS = 1;
