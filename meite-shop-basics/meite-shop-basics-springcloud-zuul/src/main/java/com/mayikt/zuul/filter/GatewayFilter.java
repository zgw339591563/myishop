package com.mayikt.zuul.filter;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import com.mayikt.zuul.handler.GatewayHandler;
import com.mayikt.zuul.handler.ResponsibilityClient;
import com.mayikt.zuul.mapper.BlacklistMapper;
import com.netflix.zuul.ZuulFilter;
import com.netflix.zuul.context.RequestContext;
import com.netflix.zuul.exception.ZuulException;
import lombok.extern.slf4j.Slf4j;
import com.mayikt.zuul.build.GatewayDirector;

/**
 * 使用网关拦截客户端所有的请求
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
public class GatewayFilter extends ZuulFilter {
	@Autowired
	private BlacklistMapper blacklistMapper;
	@Autowired
	private ResponsibilityClient responsibilityClient;
	@Autowired
	private GatewayDirector gatewayDirector;

	/**
	 * 请求之前拦截处理业务逻辑 建议将限制黑名单存放到redis或者携程的阿波罗
	 */
	@Override
	public Object run() throws ZuulException {
		RequestContext ctx = RequestContext.getCurrentContext();
		// 1.获取请求对象
		HttpServletRequest request = ctx.getRequest();
		HttpServletResponse response = ctx.getResponse();
		//基于责任链模式实现网关权限控制
		GatewayHandler handler = responsibilityClient.getHandler();
		handler.service(ctx, request, response);
		//基于建造者模式实现网关权限控制---和责任链模式2选一
//		gatewayDirector.direcot(ctx,getIpAddr( request),response,request);
		return null;
	}
	// public/api/api-pay/cratePayToken?payAmount=300222&orderId=2019010203501502&userId=644064

	/**
	 * 过滤参数
	 */
	private Map<String, List<String>> filterParameters(HttpServletRequest request, RequestContext ctx) {
		Map<String, List<String>> requestQueryParams = ctx.getRequestQueryParams();
		if (requestQueryParams == null) {
			requestQueryParams = new HashMap<>();
		}
		Enumeration em = request.getParameterNames();
		while (em.hasMoreElements()) {
			String name = (String) em.nextElement();
			String value = request.getParameter(name);
			ArrayList<String> arrayList = new ArrayList<>();
			// 将参数转化为html参数 防止xss攻击
			arrayList.add(StringEscapeUtils.escapeHtml(value));
			requestQueryParams.put(name, arrayList);
		}
		return requestQueryParams;
	}

	@Override
	public boolean shouldFilter() {

		return true;
	}

	@Override
	public int filterOrder() {

		return 0;
	}

	/**
	 * 在请求之前实现拦截
	 */
	public String filterType() {

		return "pre";
	}



	// ip地址存在一个问题
	private void resultError(RequestContext ctx, String errorMsg) {
		ctx.setResponseStatusCode(401);
		// 网关响应为false 不会转发服务
		ctx.setSendZuulResponse(false);
		ctx.setResponseBody(errorMsg);
	}
	// MD5 单向加密 不可逆 加盐
	// 客户端调用接口 add?userName=yushengjun&zhangsan=644 MD5
	// userName=yushengjun&zhangsan=644 ==签名=msfgfjsjsxjss
	// userName=yushengjun&zhangsan=644 名=msfgfjsjsxjss
	// msfgfjsjsxjss=msfgfjsjsxjss

	// 签名的目的是 为了防止数据被篡改 数据还是明文数据
	// 加密 RSA


	/**
	 * 获取Ip地址
	 *
	 * @param request
	 * @return
	 */
	public String getIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("X-Forwarded-For");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}
}
