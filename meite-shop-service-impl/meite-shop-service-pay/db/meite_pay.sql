/*
 Navicat Premium Data Transfer

 Source Server         : 我
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : meite_pay

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 25/08/2019 17:17:38
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for payment_channel
-- ----------------------------
DROP TABLE IF EXISTS `payment_channel`;
CREATE TABLE `payment_channel`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `CHANNEL_NAME` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '渠道名称',
  `CHANNEL_ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '渠道ID',
  `MERCHANT_ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商户id',
  `SYNC_URL` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '同步回调URL',
  `ASYN_URL` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '异步回调URL',
  `PUBLIC_KEY` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '公钥',
  `PRIVATE_KEY` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '私钥',
  `CHANNEL_STATE` int(11) NULL DEFAULT 0 COMMENT '渠道状态 0开启1关闭',
  `REVISION` int(11) NULL DEFAULT NULL COMMENT '乐观锁',
  `CREATED_BY` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `CREATED_TIME` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `UPDATED_BY` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `UPDATED_TIME` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `CLASS_ADDRES` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接口实现地址',
  `retry_beanId` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '重试接口beanId',
  PRIMARY KEY (`ID`, `CHANNEL_ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '支付渠道 ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of payment_channel
-- ----------------------------
INSERT INTO `payment_channel` VALUES (1, '银联支付', 'yinlian_pay', ' 777290058172116', 'http://v6gdg3.natappfree.cc/front', 'http://v6gdg3.natappfree.cc/unionPayAsynCallback', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'com.mayikt.pay.strategy.impl.UnionPayStrategy', NULL);
INSERT INTO `payment_channel` VALUES (2, '支付宝', 'ali_pay', '777666655522521', 'test', 'test', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'com.mayikt.pay.strategy.impl.AliPayStrategy', NULL);

-- ----------------------------
-- Table structure for payment_transaction
-- ----------------------------
DROP TABLE IF EXISTS `payment_transaction`;
CREATE TABLE `payment_transaction`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `PAY_AMOUNT` int(11) NOT NULL COMMENT '支付金额',
  `PAYMENT_STATUS` int(11) NOT NULL DEFAULT 0 COMMENT '支付状态 0待支付1已经支付2支付超时3支付失败',
  `USER_ID` int(11) NOT NULL COMMENT '用户ID',
  `ORDER_ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单号码',
  `REVISION` int(11) NULL DEFAULT NULL COMMENT '乐观锁',
  `CREATED_BY` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `CREATED_TIME` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `UPDATED_BY` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `UPDATED_TIME` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `PARTYPAY_ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '第三方支付id 支付宝、银联等 在第三方支付渠道完成后分配一个支付id 对账使用',
  `PAYMENT_ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '支付id',
  `payment_Channel` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '支付渠道',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '支付交易 ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of payment_transaction
-- ----------------------------
INSERT INTO `payment_transaction` VALUES (1, 1000, 0, 1, '20180302101452', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `payment_transaction` VALUES (2, 1000, 0, 1, '20180302101452', NULL, NULL, '2019-03-21 19:06:15', NULL, '2019-03-21 19:06:15', NULL, NULL, NULL);
INSERT INTO `payment_transaction` VALUES (3, 1000, 0, 1, '20180302101452', NULL, NULL, '2019-03-21 19:31:42', NULL, '2019-03-21 19:31:42', NULL, NULL, NULL);
INSERT INTO `payment_transaction` VALUES (4, 1, 0, 644064, '20180302101452', NULL, NULL, '2019-03-23 15:09:05', NULL, '2019-03-23 15:09:05', NULL, NULL, NULL);
INSERT INTO `payment_transaction` VALUES (5, 1, 0, 644064, '20180302101452', NULL, NULL, '2019-03-23 15:13:08', NULL, '2019-03-23 15:13:08', NULL, NULL, NULL);
INSERT INTO `payment_transaction` VALUES (6, 1, 0, 644064, '20180302101452', NULL, NULL, '2019-03-23 15:17:23', NULL, '2019-03-23 15:17:23', NULL, NULL, NULL);
INSERT INTO `payment_transaction` VALUES (7, 1, 0, 644064, '20180302101452', NULL, NULL, '2019-03-23 15:59:37', NULL, '2019-03-23 15:59:37', '269342963258232832', NULL, NULL);
INSERT INTO `payment_transaction` VALUES (8, 1, 0, 644064, '20180302101452', NULL, NULL, '2019-03-23 16:06:34', NULL, '2019-03-23 16:06:34', NULL, '269344715239985152', NULL);
INSERT INTO `payment_transaction` VALUES (9, 1, 0, 644064, '20180302101452', NULL, NULL, '2019-03-23 16:12:41', NULL, '2019-03-23 16:12:41', NULL, '269346254797017088', NULL);
INSERT INTO `payment_transaction` VALUES (10, 10020, 0, 644064, '2019010203501501', NULL, NULL, '2019-03-23 16:15:22', NULL, '2019-03-23 16:15:22', NULL, '269346928683257856', NULL);
INSERT INTO `payment_transaction` VALUES (11, 10020, 0, 644064, '2019010203501501', NULL, NULL, '2019-03-23 17:40:15', NULL, '2019-03-23 17:40:15', NULL, '269368292148383744', NULL);
INSERT INTO `payment_transaction` VALUES (12, 10020, 0, 644064, '2019010203501501', NULL, NULL, '2019-03-23 17:40:25', NULL, '2019-03-23 17:40:25', NULL, '269368331461595136', NULL);
INSERT INTO `payment_transaction` VALUES (13, 10020, 0, 644064, '2019010203501501', NULL, NULL, '2019-03-23 20:14:45', NULL, '2019-03-23 20:14:45', NULL, '269407170557251584', NULL);
INSERT INTO `payment_transaction` VALUES (14, 10020, 0, 644064, '2019010203501501', NULL, NULL, '2019-03-23 20:28:30', NULL, '2019-03-23 20:28:30', NULL, '269410634171551744', NULL);
INSERT INTO `payment_transaction` VALUES (15, 20020, 0, 644064, '2019010203501501', NULL, NULL, '2019-03-23 20:28:43', NULL, '2019-03-23 20:28:43', NULL, '269410688940773376', NULL);
INSERT INTO `payment_transaction` VALUES (16, 20020, 0, 644064, '2019010203501501', NULL, NULL, '2019-03-23 20:35:52', NULL, '2019-03-23 20:35:52', NULL, '269412486262951936', NULL);
INSERT INTO `payment_transaction` VALUES (17, 30020, 0, 644064, '2019010203501501', NULL, NULL, '2019-03-23 20:36:39', NULL, '2019-03-23 20:36:39', NULL, '269412683504291840', NULL);
INSERT INTO `payment_transaction` VALUES (18, 30020, 0, 644064, '2019010203501501', NULL, NULL, '2019-03-23 20:58:41', NULL, '2019-03-23 20:58:41', NULL, '269418222355353600', NULL);
INSERT INTO `payment_transaction` VALUES (19, 30020, 0, 644064, '2019010203501501', NULL, NULL, '2019-03-23 21:13:19', NULL, '2019-03-23 21:13:19', NULL, '269421909492502528', NULL);
INSERT INTO `payment_transaction` VALUES (20, 10, 0, 98765, 'zgw123456', NULL, NULL, '2019-08-11 16:24:31', NULL, '2019-08-11 16:24:31', NULL, '320444471223390208', NULL);
INSERT INTO `payment_transaction` VALUES (21, 10000, 1, 1, '22222', NULL, NULL, '2019-08-25 16:21:03', NULL, '2019-08-25 16:21:03', NULL, '325518477672714240', NULL);
INSERT INTO `payment_transaction` VALUES (22, 100000, 1, 1, '22222', NULL, NULL, '2019-08-25 16:55:05', NULL, '2019-08-25 16:55:05', NULL, '325527044924510208', NULL);
INSERT INTO `payment_transaction` VALUES (23, 100000, 1, 1, '2222233', NULL, NULL, '2019-08-25 17:12:43', NULL, '2019-08-25 17:12:43', NULL, '325531481491509248', NULL);

-- ----------------------------
-- Table structure for payment_transaction_log
-- ----------------------------
DROP TABLE IF EXISTS `payment_transaction_log`;
CREATE TABLE `payment_transaction_log`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `SYNCH_LOG` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '同步回调日志',
  `ASYNC_LOG` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '异步回调日志',
  `CHANNEL_ID` int(11) NULL DEFAULT NULL COMMENT '支付渠道ID',
  `TRANSACTION_ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '支付交易ID',
  `REVISION` int(11) NULL DEFAULT NULL COMMENT '乐观锁',
  `CREATED_BY` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `CREATED_TIME` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `UPDATED_BY` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `UPDATED_TIME` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '支付交易日志表 ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of payment_transaction_log
-- ----------------------------
INSERT INTO `payment_transaction_log` VALUES (1, NULL, '{bizType=000201, orderId=325527044924510208, signature=AO0anFr9B0qX0uQ/QQvQE5Rk416E6p6cuIEmVKsgBoKq4hYki443KXuBhLVE7k9yUNdEVMJcBhjC1tWdyRUVrqRHoBmXO2Spu1VS2uCz9R3ABTKlLmh9R8mib8eM0oqIGIxC6FJt75wuFXPxeddqzaJniGlAPE/0mymNV6I5+wGUd1EtVUdi6k0PUQvWumveuSSDVa0h0y8zn1Mk1wC7ltkli4KLzytZaMR17t5XAbDetJ9chhRRgA9dZ+a8Xw83HzM96IStng2c7Pb3c4SR7IN5XKrEHg3bmW7M+QpY1ww6kKMgAYwLrGnTbWCgMlrTEXbAK7QVtkceutR8y7Badg==, traceNo=813753, settleAmt=100000, settleCurrencyCode=156, settleDate=0825, txnType=01, queryId=501908260055058137538, accessType=0, result=200, paymentId=325527044924510208, traceTime=0826005505, txnTime=20190826005505, signPubKeyCert=-----BEGIN CERTIFICATE-----\r\nMIIEQzCCAyugAwIBAgIFEBJJZVgwDQYJKoZIhvcNAQEFBQAwWDELMAkGA1UEBhMC\r\nQ04xMDAuBgNVBAoTJ0NoaW5hIEZpbmFuY2lhbCBDZXJ0aWZpY2F0aW9uIEF1dGhv\r\ncml0eTEXMBUGA1UEAxMOQ0ZDQSBURVNUIE9DQTEwHhcNMTcxMTAxMDcyNDA4WhcN\r\nMjAxMTAxMDcyNDA4WjB3MQswCQYDVQQGEwJjbjESMBAGA1UEChMJQ0ZDQSBPQ0Ex\r\nMQ4wDAYDVQQLEwVDVVBSQTEUMBIGA1UECxMLRW50ZXJwcmlzZXMxLjAsBgNVBAMU\r\nJTA0MUBaMjAxNy0xMS0xQDAwMDQwMDAwOlNJR05AMDAwMDAwMDEwggEiMA0GCSqG\r\nSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDDIWO6AESrg+34HgbU9mSpgef0sl6avr1d\r\nbD/IjjZYM63SoQi3CZHZUyoyzBKodRzowJrwXmd+hCmdcIfavdvfwi6x+ptJNp9d\r\nEtpfEAnJk+4quriQFj1dNiv6uP8ARgn07UMhgdYB7D8aA1j77Yk1ROx7+LFeo7rZ\r\nDdde2U1opPxjIqOPqiPno78JMXpFn7LiGPXu75bwY2rYIGEEImnypgiYuW1vo9UO\r\nG47NMWTnsIdy68FquPSw5FKp5foL825GNX3oJSZui8d2UDkMLBasf06Jz0JKz5AV\r\nblaI+s24/iCfo8r+6WaCs8e6BDkaijJkR/bvRCQeQpbX3V8WoTLVAgMBAAGjgfQw\r\ngfEwHwYDVR0jBBgwFoAUz3CdYeudfC6498sCQPcJnf4zdIAwSAYDVR0gBEEwPzA9\r\nBghggRyG7yoBATAxMC8GCCsGAQUFBwIBFiNodHRwOi8vd3d3LmNmY2EuY29tLmNu\r\nL3VzL3VzLTE0Lmh0bTA5BgNVHR8EMjAwMC6gLKAqhihodHRwOi8vdWNybC5jZmNh\r\nLmNvbS5jbi9SU0EvY3JsMjQ4NzIuY3JsMAsGA1UdDwQEAwID6DAdBgNVHQ4EFgQU\r\nmQQLyuqYjES7qKO+zOkzEbvdFwgwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUF\r\nBwMEMA0GCSqGSIb3DQEBBQUAA4IBAQAujhBuOcuxA+VzoUH84uoFt5aaBM3vGlpW\r\nKVMz6BUsLbIpp1ho5h+LaMnxMs6jdXXDh/du8X5SKMaIddiLw7ujZy1LibKy2jYi\r\nYYfs3tbZ0ffCKQtv78vCgC+IxUUurALY4w58fRLLdu8u8p9jyRFHsQEwSq+W5+bP\r\nMTh2w7cDd9h+6KoCN6AMI1Ly7MxRIhCbNBL9bzaxF9B5GK86ARY7ixkuDCEl4XCF\r\nJGxeoye9R46NqZ6AA/k97mJun//gmUjStmb9PUXA59fR5suAB5o/5lBySZ8UXkrI\r\npp/iLT8vIl1hNgLh0Ghs7DBSx99I+S3VuUzjHNxL6fGRhlix7Rb8\r\n-----END CERTIFICATE-----, txnSubType=01, accNo=6216***********0018, encoding=UTF-8, version=5.1.0, respMsg=成功[0000000], merId=777290058172116, currencyCode=156, respCode=00, signMethod=01, txnAmt=100000}', NULL, '325527044924510208', NULL, NULL, '2019-08-25 17:10:26', NULL, '2019-08-25 17:10:26');
INSERT INTO `payment_transaction_log` VALUES (2, NULL, '{bizType=000201, orderId=325531481491509248, signature=vqDnWVWlvNd9HSbACWVxgt9uXdaO39oABx+Jodic8/CdW93IA1e9zkpG1Q5TLzf7zltZOwyWwfGT2DveO5yKJ7nmcH+CNycWZ4JBN1EEwGAX16xUXFeMvSGwwBhxm/3q2Lilmp6j2FSHOoyh8k1pI9aMcwXC3u+uK1rZMdLcrr04fxP25C9u0qfsuS9peCUzUvwt/gyB0YOSeycKHiiPCiiCRTkHcoUABl9+tumGIkqti66qqkJm91M4i6QsRwRtvYOOMfFlJzYTIRPO2OqIkcZ2j0tRImoaK6Uo/VplUStBkdDYwi4XJrlnNu/VyRj//IJhrMR2BT28q516yO4x6g==, traceNo=797876, settleAmt=100000, settleCurrencyCode=156, settleDate=0825, txnType=01, queryId=881908260112437978768, accessType=0, result=200, paymentId=325531481491509248, traceTime=0826011243, txnTime=20190826011243, signPubKeyCert=-----BEGIN CERTIFICATE-----\r\nMIIEQzCCAyugAwIBAgIFEBJJZVgwDQYJKoZIhvcNAQEFBQAwWDELMAkGA1UEBhMC\r\nQ04xMDAuBgNVBAoTJ0NoaW5hIEZpbmFuY2lhbCBDZXJ0aWZpY2F0aW9uIEF1dGhv\r\ncml0eTEXMBUGA1UEAxMOQ0ZDQSBURVNUIE9DQTEwHhcNMTcxMTAxMDcyNDA4WhcN\r\nMjAxMTAxMDcyNDA4WjB3MQswCQYDVQQGEwJjbjESMBAGA1UEChMJQ0ZDQSBPQ0Ex\r\nMQ4wDAYDVQQLEwVDVVBSQTEUMBIGA1UECxMLRW50ZXJwcmlzZXMxLjAsBgNVBAMU\r\nJTA0MUBaMjAxNy0xMS0xQDAwMDQwMDAwOlNJR05AMDAwMDAwMDEwggEiMA0GCSqG\r\nSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDDIWO6AESrg+34HgbU9mSpgef0sl6avr1d\r\nbD/IjjZYM63SoQi3CZHZUyoyzBKodRzowJrwXmd+hCmdcIfavdvfwi6x+ptJNp9d\r\nEtpfEAnJk+4quriQFj1dNiv6uP8ARgn07UMhgdYB7D8aA1j77Yk1ROx7+LFeo7rZ\r\nDdde2U1opPxjIqOPqiPno78JMXpFn7LiGPXu75bwY2rYIGEEImnypgiYuW1vo9UO\r\nG47NMWTnsIdy68FquPSw5FKp5foL825GNX3oJSZui8d2UDkMLBasf06Jz0JKz5AV\r\nblaI+s24/iCfo8r+6WaCs8e6BDkaijJkR/bvRCQeQpbX3V8WoTLVAgMBAAGjgfQw\r\ngfEwHwYDVR0jBBgwFoAUz3CdYeudfC6498sCQPcJnf4zdIAwSAYDVR0gBEEwPzA9\r\nBghggRyG7yoBATAxMC8GCCsGAQUFBwIBFiNodHRwOi8vd3d3LmNmY2EuY29tLmNu\r\nL3VzL3VzLTE0Lmh0bTA5BgNVHR8EMjAwMC6gLKAqhihodHRwOi8vdWNybC5jZmNh\r\nLmNvbS5jbi9SU0EvY3JsMjQ4NzIuY3JsMAsGA1UdDwQEAwID6DAdBgNVHQ4EFgQU\r\nmQQLyuqYjES7qKO+zOkzEbvdFwgwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUF\r\nBwMEMA0GCSqGSIb3DQEBBQUAA4IBAQAujhBuOcuxA+VzoUH84uoFt5aaBM3vGlpW\r\nKVMz6BUsLbIpp1ho5h+LaMnxMs6jdXXDh/du8X5SKMaIddiLw7ujZy1LibKy2jYi\r\nYYfs3tbZ0ffCKQtv78vCgC+IxUUurALY4w58fRLLdu8u8p9jyRFHsQEwSq+W5+bP\r\nMTh2w7cDd9h+6KoCN6AMI1Ly7MxRIhCbNBL9bzaxF9B5GK86ARY7ixkuDCEl4XCF\r\nJGxeoye9R46NqZ6AA/k97mJun//gmUjStmb9PUXA59fR5suAB5o/5lBySZ8UXkrI\r\npp/iLT8vIl1hNgLh0Ghs7DBSx99I+S3VuUzjHNxL6fGRhlix7Rb8\r\n-----END CERTIFICATE-----, txnSubType=01, accNo=6216***********0018, encoding=UTF-8, version=5.1.0, respMsg=成功[0000000], merId=777290058172116, currencyCode=156, respCode=00, signMethod=01, txnAmt=100000}', NULL, '325531481491509248', NULL, NULL, '2019-08-25 17:16:55', NULL, '2019-08-25 17:16:55');

SET FOREIGN_KEY_CHECKS = 1;
