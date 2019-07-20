package com.mayikt.member.service.impl;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSONObject;
import com.mayikt.base.BaseApiService;
import com.mayikt.base.BaseResponse;
import com.mayikt.constants.Constants;
import com.mayikt.core.bean.MeiteBeanUtils;
import com.mayikt.core.utils.MD5Util;
import com.mayikt.member.MemberRegisterService;
import com.mayikt.member.feign.VerificaCodeServiceFeign;
import com.mayikt.member.input.dto.UserInpDTO;
import com.mayikt.member.mapper.UserMapper;
import com.mayikt.member.mapper.entity.UserDo;

@RestController
public class MemberRegisterServiceImpl extends BaseApiService<JSONObject> implements MemberRegisterService {
	@Autowired
	private UserMapper userMapper;
	@Autowired
	private VerificaCodeServiceFeign verificaCodeServiceFeign;

	@Transactional
	public BaseResponse<JSONObject> register(@RequestBody UserInpDTO userInpDTO, String registCode) {
		// 1.参数验证
		// String userName = userInpDTO.getUserName();
		// if (StringUtils.isEmpty(userName)) {
		// return setResultError("用户名称不能为空!");
		// }
		String mobile = userInpDTO.getMobile();
		if (StringUtils.isEmpty(mobile)) {
			return setResultError("手机号码不能为空!");
		}
		String password = userInpDTO.getPassword();
		if (StringUtils.isEmpty(password)) {
			return setResultError("密码不能为空!");
		}
		// // 2.验证码注册码是否正确 暂时省略 会员调用微信接口实现注册码验证
		BaseResponse<JSONObject> verificaWeixinCode = verificaCodeServiceFeign.verificaWeixinCode(mobile, registCode);
		if (!verificaWeixinCode.getCode().equals(Constants.HTTP_RES_CODE_200)) {
			return setResultError(verificaWeixinCode.getMsg());
		}
		// 3.对用户的密码进行加密 // MD5 可以解密 暴力破解
		String newPassword = MD5Util.MD5(password);
		userInpDTO.setPassword(newPassword);
		// 4.调用数据库插入数据 将请求的dto参数转换DO
		UserDo userDo = MeiteBeanUtils.dtoToDo(userInpDTO, UserDo.class);
		return userMapper.register(userDo) > 0 ? setResultSuccess("注册成功") : setResultError("注册失败!");
	}
	// dto 和do 可能 实体类不同，但是部分参数可能相同

}
