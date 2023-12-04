package com.lin.lostandfound.web.controller;

import com.lin.lostandfound.common.annotation.DataSource;
import com.lin.lostandfound.common.annotation.SystemControllerLog;
import com.lin.lostandfound.common.constants.Constants;
import com.lin.lostandfound.common.utils.MD5Util;
import com.lin.lostandfound.common.utils.UserAgentParserUtil;
import com.lin.lostandfound.entities.domain.LoginLog;
import com.lin.lostandfound.entities.domain.User;
import com.lin.lostandfound.services.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
public class LoginController extends BaseController {

	@Autowired
	@Qualifier("userService")
	private IUserService userService;

	// 获取登录view
	//此处为记录AOP拦截Controller记录操作  
	@SystemControllerLog(description = "获取登录视图") 
	@RequestMapping(value = { "/login.html", "/login.do", "/login" }, method = RequestMethod.GET)
	public String loginView() {
		logger.info("loginView...");

		return "redirect:index.html";
	}

	// 网页登录（ajax）
	//此处为记录AOP拦截Controller记录操作  
	@SystemControllerLog(description = "网页登录") 
	@DataSource(name = Constants.RemoteDataSource)
	@RequestMapping(value = { "/login.do"}, method = RequestMethod.POST)
	public @ResponseBody Map<String, String> login(User user, String code, HttpSession session, HttpServletRequest request) {
		logger.info("login...");
		Map<String, String> jsonMap = new HashMap<String, String>();
		if (code == null || "".equals(code)) {
			jsonMap.put("mesg", "codeNull");
			return jsonMap;
		}

		if (!code.equalsIgnoreCase((String) session
				.getAttribute(Constants.CODE))) {
			jsonMap.put("mesg", "codeErr");
			return jsonMap;
		}

		// 调用私有的 login 方法
		return login(user, session, request, jsonMap);
	}

	// 移动设备登录（ajax）
	//此处为记录AOP拦截Controller记录操作  
	@SystemControllerLog(description = "移动设备登录") 
	@RequestMapping(value = { "/mobileLogin.do"}, method = RequestMethod.POST)
	public @ResponseBody Map<String, String> mobileLogin(User user, String code, HttpSession session, HttpServletRequest request) {
		logger.info("mobileLogin...");
		Map<String, String> jsonMap = new HashMap<String, String>();
		if (!code.equalsIgnoreCase((String) session.getAttribute(Constants.CODE))) {
			jsonMap.put("mesg", "codeErr");
			return jsonMap;
		}

		// 调用私有的 login 方法
		return login(user, session, request, jsonMap);
	}
	
	// 私有登录方法
	private Map<String, String> login(User user, HttpSession session, HttpServletRequest request, Map<String, String> jsonMap) {
		// 调用service 的 login 方法
		User u = userService.login(user.getUserName(),
				MD5Util.string2MD5(user.getPassword()),
				Constants.USER_STATE_LOCK);
		if (u != null) {
			// 判断用户权限（是否冻结）
			if (u.getState() == Constants.USER_STATE_LOCK) {
				jsonMap.put("mesg", "lock");
				return jsonMap;
			}

			logger.info("user...login...success");

			// 写入登录日志信息
			String agent = request.getHeader("User-Agent");
			String osname = UserAgentParserUtil.getOS(agent);
			String browserName = UserAgentParserUtil.getBrowser(agent);
			String loginIp = UserAgentParserUtil.getRemoteHost(request);

			LoginLog loginLog = new LoginLog(u.getUserName(), osname,
					browserName, loginIp, new Date(), u.getId());
			userService.addLoginlog(loginLog);
			Date date = u.getLastLoginTime();
			u.setLastLoginTime(new Date());
			userService.modify(u);
			// 把密码置空
			u.setPassword(null);
			u.setLastLoginTime(date == null ? new Date() : date);
			session.setAttribute(Constants.USER, u);
			
			jsonMap.put("mesg", "success");
			return jsonMap;
		} else {
			jsonMap.put("mesg", "error");
			return jsonMap;
		}
	}

	// 退出 method = RequestMethod.POST（默认支持get 和 post）
	//此处为记录AOP拦截Controller记录操作  
	@SystemControllerLog(description = "注销") 
	@RequestMapping(value = { "/logout.do", "/logout", "/logout.html"})
	public String logout(HttpSession session) {
		logger.info("user...logout...");
		session.removeAttribute(Constants.USER);

		return "redirect:index.html";
	}

}
