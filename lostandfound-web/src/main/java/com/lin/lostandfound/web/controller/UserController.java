package com.lin.lostandfound.web.controller;

import com.lin.lostandfound.common.annotation.SystemControllerLog;
import com.lin.lostandfound.common.constants.Constants;
import com.lin.lostandfound.entities.domain.*;
import com.lin.lostandfound.services.IExpressThanksService;
import com.lin.lostandfound.services.ILostThingsService;
import com.lin.lostandfound.services.IPickThingsService;
import com.lin.lostandfound.services.IUserService;
import com.lin.lostandfound.common.utils.JSONUtil;
import com.lin.lostandfound.common.utils.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/user")
public class UserController extends BaseController{

	@Autowired
	@Qualifier("userService")
	private IUserService userService;
	
	@Autowired
	@Qualifier("pickThingsService")
	private IPickThingsService pickThingsService;
	
	@Autowired
	@Qualifier("lostThingsService")
	private ILostThingsService lostThingsService;
	
	@Autowired
	@Qualifier("expressThanksService")
	private IExpressThanksService expressThanksService;

	// 用户中心
	@SystemControllerLog(description = "进入用户中心")
	@RequestMapping(value = { "/user-center.html" })
	public String userCenter(Model model) {

		return "user/user-center";
	}
	
	// 获取默认视图
	@RequestMapping(value = { "/default.html" })
	public String defaultView() {

		return "user/default";
	}
	
	// 获取用户信息视图
	@RequestMapping(value = { "/user-info.do" }, method =RequestMethod.POST)
	public String userInfoView() {

		return "user/user-info";
	}
	
	// 查询用户信息
	@RequestMapping(value = { "/user-query.do" }, method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public @ResponseBody String queryUserInfo(long userId) {
		User user = userService.queryUserById(userId);
		
		return JSONUtil.encode(user);
	}	
	
	// 修改用户信息（保存）
	@SystemControllerLog(description = "保存（修改）个人信息")
	@RequestMapping(value = { "/user-save.do" }, method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> saveUserInfo(User user) {
		logger.info(user);
		Map<String, Object> map = new HashMap<String, Object>();
		if(userService.modify(user))
			map.put("msg", "success");
		else
			map.put("msg", "error");
		
		return map;
	}
	
	// 获取修改密码视图
	@RequestMapping(value = { "/user-password.do" }, method = RequestMethod.POST)
	public String userPasswordView() {

		return "user/user-password";
	}
		
	// 修改密码
	@SystemControllerLog(description = "修改密码")
	@RequestMapping(value = { "/update-password.do" }, method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateUserPassword(User user,String newPassword) {
		logger.info(user);
		Map<String, Object> map = new HashMap<String, Object>();
		if(user.getId() == null) {
			if (userService.login(user.getUserName(), MD5Util.string2MD5(user.getPassword()), user.getState()) != null)
				map.put("msg", "success");
			else
				map.put("msg", "error");
		} else {
			user.setPassword(MD5Util.string2MD5(newPassword));
			if (userService.modify(user))
				map.put("msg", "success");
			else
				map.put("msg", "error");
		}
		
		return map;
	}
	
	// 获取招领贴列表视图
	@RequestMapping(value = { "/find-info.do" }, method = RequestMethod.POST)
	public String findInfoView() {

		return "user/find-info";
	}
	
	// 招领贴列表
	@RequestMapping(value = { "/find-info.html" }, method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public @ResponseBody String findInfoList(int page, int rows, HttpSession session) {
		logger.info("page: " + page + " " + "rows: " + rows);
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		User user = (User) session.getAttribute(Constants.USER);
		List<PickThings> pickThingsList = pickThingsService.queryAllByUid(user.getId(), page, rows, true);

		jsonMap.put("total", pickThingsService.queryAllByUidCount(user.getId()));
		jsonMap.put("rows", pickThingsList);

		return JSONUtil.encode(jsonMap);
	}
	
	// 批量删除招领贴信息
	@SystemControllerLog(description = "批量删除招领贴信息")
	@RequestMapping(value = { "/find-remove.do" }, method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> removeFindInfoList(String ids) {
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		if(pickThingsService.modifyStatus(ids, Constants.THINGS_STATE_DELETE))
			jsonMap.put("success", true);
		else
			jsonMap.put("success", false);
			
		return jsonMap;
	}
	
	// 修改招领贴信息状态
	@RequestMapping(value = { "/find-change.do" }, method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> changeFindInfo(long id) {
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		if (pickThingsService.modifyStatus(id, Constants.THINGS_STATE_SUCCESS))
			jsonMap.put("success", true);
		else
			jsonMap.put("success", false);

		return jsonMap;
	}
		
	// 获取寻物贴列表视图
	@RequestMapping(value = { "/lost-info.do" }, method = RequestMethod.POST)
	public String lostInfoView() {

		return "user/lost-info";
	}
	
	// 寻物贴列表
	@RequestMapping(value = { "/lost-info.html" }, method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public @ResponseBody String lostInfoList(int page, int rows, HttpSession session) {
		logger.info("page: " + page + " " + "rows: " + rows);
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		User user = (User) session.getAttribute(Constants.USER);
		List<LostThings> lostThingsList = lostThingsService.queryAllByUid(user.getId(), page, rows, true);

		jsonMap.put("total", lostThingsService.queryAllByUidCount(user.getId()));
		jsonMap.put("rows", lostThingsList);
		
		return JSONUtil.encode(jsonMap);
	}
	
	// 批量删除寻物贴信息
	@SystemControllerLog(description = "批量删除寻物贴信息")
	@RequestMapping(value = { "/lost-remove.do" }, method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> removeLostInfoList(String ids) {
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		if (lostThingsService.modifyStatus(ids, Constants.THINGS_STATE_DELETE))
			jsonMap.put("success", true);
		else
			jsonMap.put("success", false);

		return jsonMap;
	}
	
	// 修改寻物贴信息状态
	@RequestMapping(value = { "/lost-change.do" }, method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> changeLostInfo(long id) {
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		if (lostThingsService.modifyStatus(id, Constants.THINGS_STATE_SUCCESS))
			jsonMap.put("success", true);
		else
			jsonMap.put("success", false);

		return jsonMap;
	}

	// 获取用户登录日志信息视图
	@RequestMapping(value = { "/user-log.do" }, method = RequestMethod.POST)
	public String userLogView() {

		return "user/user-log";
	}

	// 用户登录日志信息列表
	@RequestMapping(value = { "/user-log.html" }, method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public @ResponseBody String userLogList(int page, int rows, HttpSession session) {
		logger.info("page: " + page + " " + "rows: " + rows);
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		User user = (User) session.getAttribute(Constants.USER);
		List<LoginLog> loginLogList = userService.queryLoginlogByUid(user.getId(), page, rows);

		jsonMap.put("total", userService.queryLoginlogByUidCount(user.getId()));
		jsonMap.put("rows", loginLogList);
		
		return JSONUtil.encode(jsonMap);
	}
	
	
	// 保存感谢信息
	@SystemControllerLog(description = "保存感谢信息")
	@RequestMapping(value = { "/save-thanks.do" }, method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> saveThanks(ExpressThanks expressThanks, String anonymous) {
		logger.info("save-thanks.do...POST: " + expressThanks + " " +anonymous);
		if(anonymous != null)
			expressThanks.setUserName("匿名");
		
		expressThanks.setStatus(1);
		expressThanks.setLeaveTime(new Date());
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		if(expressThanksService.add(expressThanks))
			jsonMap.put("mesg", "success");
		else
			jsonMap.put("mesg", "error");
		
		return jsonMap;
	}
}
