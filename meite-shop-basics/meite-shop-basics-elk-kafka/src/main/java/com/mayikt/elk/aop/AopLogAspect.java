package com.mayikt.elk.aop;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.alibaba.fastjson.JSONObject;
import com.mayikt.elk.kafka.KafkaSender;

/**
 * 
 * 
 * 
 * @description: ELK拦截日志信息
 * @author: 97后互联网架构师-余胜军
 * @contact: QQ644064779、微信yushengjun644 www.mayikt.com
 * @date: 2019年1月3日 下午3:03:17
 * @version V1.0
 * @Copyright 该项目“基于SpringCloud2.x构建微服务电商项目”由每特教育|蚂蚁课堂版权所有，未经过允许的情况下，
 *            私自分享视频和源码属于违法行为。
 */
@Aspect
@Component
public class AopLogAspect {
	@Autowired
	private KafkaSender<JSONObject> kafkaSender;

	// 申明一个切点 里面是 execution表达式
	@Pointcut("execution(* com.mayikt.*.api.service.impl.*.*(..))")
	private void serviceAspect() {
	}

	// 请求method前打印内容
	@Before(value = "serviceAspect()")
	public void methodBefore(JoinPoint joinPoint) {
		ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder
				.getRequestAttributes();
		HttpServletRequest request = requestAttributes.getRequest();

		// // 打印请求内容
		// log.info("===============请求内容===============");
		// log.info("请求地址:" + request.getRequestURL().toString());
		// log.info("请求方式:" + request.getMethod());
		// log.info("请求类方法:" + joinPoint.getSignature());
		// log.info("请求类方法参数:" + Arrays.toString(joinPoint.getArgs()));
		// log.info("===============请求内容===============");

		JSONObject jsonObject = new JSONObject();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
		// 请求时间
		jsonObject.put("request_time", df.format(new Date()));
		// 请求URL
		jsonObject.put("request_url", request.getRequestURL().toString());
		// 请求的方法
		jsonObject.put("request_method", request.getMethod());
		// 请求类方法
		jsonObject.put("signature", joinPoint.getSignature());
		// 请求参数
		jsonObject.put("request_args", Arrays.toString(joinPoint.getArgs()));

		// 加上ip和端口号
		JSONObject requestJsonObject = new JSONObject();
		requestJsonObject.put("request", jsonObject);

		kafkaSender.send(requestJsonObject);
	}

	// 在方法执行完结后打印返回内容
	@AfterReturning(returning = "o", pointcut = "serviceAspect()")
	public void methodAfterReturing(Object o) {
		// log.info("--------------返回内容----------------");
		// log.info("Response内容:" + gson.toJson(o));
		// log.info("--------------返回内容----------------");
		JSONObject respJSONObject = new JSONObject();
		JSONObject jsonObject = new JSONObject();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
		jsonObject.put("response_time", df.format(new Date()));
		jsonObject.put("response_content", JSONObject.toJSONString(o));
		respJSONObject.put("response", jsonObject);
		kafkaSender.send(respJSONObject);

	}
	// 多个项目 每个项目对应不同的主题 不同的主题对应不同的Logstash
	// 请求与响应的日志 是如何区分呢？ {"request":{}} 请求日志 {"response":{}} 错误 {"error":{}}
	// 直接查询error
}
