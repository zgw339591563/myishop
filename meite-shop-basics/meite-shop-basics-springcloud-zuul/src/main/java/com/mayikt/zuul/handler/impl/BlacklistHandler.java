package com.mayikt.zuul.handler.impl;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mayikt.zuul.build.GatewayBuild;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.mayikt.zuul.handler.GatewayHandler;
import com.netflix.zuul.context.RequestContext;

import lombok.extern.slf4j.Slf4j;

/**
 * 黑名单Handler
 * 
 * 
 * @description:
 * @author: 97后互联网架构师-余胜军
 * @contact: QQ644064779、微信yushengjun644 www.mayikt.com
 * @date: 2019年1月3日 下午3:03:17
 * @version V1.0
 * @Copyright 该项目“基于SpringCloud2.x构建微服务电商项目”由每特教育|蚂蚁课堂版权所有，未经过允许的情况下，
 *            私自分享视频和源码属于违法行为。
 */
@Component
@Slf4j
public class BlacklistHandler extends BaseHandler implements GatewayHandler {


	@Resource(name = "verificationBuild")
	private GatewayBuild gatewayBuild;

	@Override
	public void service(RequestContext ctx, HttpServletRequest req, HttpServletResponse response) {
		log.info(">>>>>>>第二关黑名单Handler执行>>>>");
		// 执行下一个handler执行
		Boolean aBoolean = gatewayBuild.blackBlock(ctx, getIpAddr(req), response);
		if(aBoolean){
			nextGatewayHandler.service(ctx, req, response);
		}
	}



	// 有多种 可以使用模版方案设计模式或者 base

}
