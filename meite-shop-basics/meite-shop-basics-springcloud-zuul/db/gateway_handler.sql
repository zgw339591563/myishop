/*
 Navicat Premium Data Transfer

 Source Server         : 我
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : meite_gateway

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 21/07/2019 01:18:09
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gateway_handler
-- ----------------------------
DROP TABLE IF EXISTS `gateway_handler`;
CREATE TABLE `gateway_handler`  (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `handler_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `handler_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `prev_handler_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `next_handler_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `is_open` int(1) NULL DEFAULT NULL,
  `revision` int(20) NULL DEFAULT NULL,
  `created_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_time` datetime(0) NULL DEFAULT NULL,
  `updated_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `updated_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gateway_handler
-- ----------------------------
INSERT INTO `gateway_handler` VALUES (1, 'currentLimitHandler', 'currentLimitHandler', '-', 'blacklistHandler', 1, 0, 'zgw', '2019-07-21 00:12:48', '', NULL);
INSERT INTO `gateway_handler` VALUES (2, 'blacklistHandler', 'blacklistHandler', 'currentLimitHandler', 'toVerifyMapHandler', 1, 0, 'zgw', '2019-07-21 00:12:48', '', NULL);
INSERT INTO `gateway_handler` VALUES (3, 'toVerifyMapHandler', 'toVerifyMapHandler', 'blacklistHandler', 'apiAuthorityHandler', 1, 0, 'zgw', '2019-07-21 00:12:48', '', NULL);
INSERT INTO `gateway_handler` VALUES (4, 'apiAuthorityHandler', 'apiAuthorityHandler', 'toVerifyMapHandler', NULL, 1, 0, 'zgw', '2019-07-21 00:12:48', '', NULL);

SET FOREIGN_KEY_CHECKS = 1;
