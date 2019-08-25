/*
 Navicat Premium Data Transfer

 Source Server         : 我
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : meite_integral

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 25/08/2019 22:32:35
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for meite_integral
-- ----------------------------
DROP TABLE IF EXISTS `meite_integral`;
CREATE TABLE `meite_integral`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户ID',
  `payment_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '支付ID',
  `integral` int(11) NULL DEFAULT NULL COMMENT '积分',
  `availability` int(1) NULL DEFAULT NULL COMMENT '是否可用',
  `revision` int(11) NULL DEFAULT NULL COMMENT '乐观锁',
  `created_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `created_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_by` varchar(0) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of meite_integral
-- ----------------------------
INSERT INTO `meite_integral` VALUES (1, '123456', '1566739121314', 100, 1, 0, NULL, '2019-08-25 21:19:52', NULL, '2019-08-25 21:19:52');

SET FOREIGN_KEY_CHECKS = 1;
