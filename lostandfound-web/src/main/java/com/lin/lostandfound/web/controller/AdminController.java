package com.lin.lostandfound.web.controller;

import com.lin.lostandfound.common.constants.Constants;
import com.lin.lostandfound.entities.domain.*;
import com.lin.lostandfound.services.*;
import com.lin.lostandfound.common.utils.*;
import com.lin.lostandfound.common.utils.MysqlDumpUtils.BackupInfo;
import org.apache.commons.io.IOUtils;
import org.apache.poi.POIXMLDocument;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.*;
import java.util.concurrent.ExecutionException;

@Controller
@RequestMapping(value = "/admin")
public class AdminController extends BaseController {
	
	@Autowired
	@Qualifier("userService")
	private IUserService userService;

	@Autowired
	@Qualifier("menuItemService")
	private IMenuItemService menuItemService;

	@Autowired
	@Qualifier("pickThingsService")
	private IPickThingsService pickThingsService;

	@Autowired
	@Qualifier("lostThingsService")
	private ILostThingsService lostThingsService;
	
	@Autowired
	@Qualifier("noticeService")
	private INoticeService noticeService;
	
	@Autowired
	@Qualifier("systemLogService")
	private ISystemLogService systemLogService;
	
	@Autowired
	@Qualifier("expressThanksService")
	private IExpressThanksService expressThanksService;
	

	@RequestMapping(value = { "/", "/index.do", "/index.html", "/index" }, method = RequestMethod.GET)
	public String index() {
		System.out.println("adminIndex...");
		
		return "admin/index";
	}

	@RequestMapping(value = { "/default.html" })
	public String defaultView() {

		return "admin/default";
	}

	@RequestMapping(value = { "/datagrid.html" })
	public String datagridView() {

		return "admin/datagrid";
	}

	// 加载菜单项
	@RequestMapping(value = { "/menuItem.html" }, produces = "text/html;charset=UTF-8")
	public @ResponseBody String menuItem(HttpSession session) throws IOException {
		User admin = (User) session.getAttribute(Constants.ADMIN);
		// 根据权限（管理员级别）加载菜单
		List<MenuItem> jsonMenuList = menuItemService.queryAll(admin.getState());
		
		//System.out.println(JSONUtil.encode(jsonMenuList));
		return JSONUtil.encode(jsonMenuList);
	}
	
	// 加载全部菜单项
	@RequestMapping(value = { "/load-menuItem.html" }, produces = "text/html;charset=UTF-8")
	public @ResponseBody String loadMenuItem(HttpSession session) throws IOException {
		List<MenuItem> jsonMenuList = menuItemService.queryAll();
		
		return JSONUtil.encode(jsonMenuList);
	}
	
	// 下载
	@RequestMapping(value = {"/download.html"})
	public String download(String fileName, HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("multipart/form-data");
		response.setHeader("Content-Disposition", "attachment;fileName="+ URLEncoder.encode("用户数据模板", "UTF-8") +fileName.substring(fileName.lastIndexOf(".")));
		InputStream is = null;
		OutputStream os = null;
		try {
			System.out.println("----" +Thread.currentThread().getContextClassLoader()
					.getResource(""));
			String path = Thread.currentThread().getContextClassLoader()
					.getResource("").getPath() + "download";// 这个download目录为啥建立在classes下的

			System.out.println(URLDecoder.decode(path, "UTF-8"));
			path = URLDecoder.decode(path, "UTF-8");
			is = new FileInputStream(new File(path + File.separator + fileName));

			os = response.getOutputStream();
			byte[] b = new byte[2048];
			int length;
			while ((length = is.read(b)) > 0) {
				os.write(b, 0, length);
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			IOUtils.closeQuietly(is);
			IOUtils.closeQuietly(os);
		}
		// 返回值要注意，要不然就出现下面这句错误！
		// java+getOutputStream() has already been called for this response
		return null;
	}
	
	// 获取批量导入用户视图
	@RequestMapping(value = { "/user-import.html" }, method = RequestMethod.GET)
	public String toImportUserView() {

		return "admin/user/user-import";
	}
	
	// 批量导入用户
	@RequestMapping(value = { "/user-import.do" }, method = RequestMethod.POST)
	public @ResponseBody Map<String, String> toImportUser(HttpServletRequest request, HttpServletResponse respons) throws InvalidFormatException {

		Map<String, String> map = new HashMap<String, String>();
		MultipartHttpServletRequest mulRequest = (MultipartHttpServletRequest) request;
		MultipartFile file = mulRequest.getFile("excelFile");
		String filename = file.getOriginalFilename();
		String extension = filename.substring(filename.lastIndexOf("."));
		if(!".xls".equals(extension) && !".xlsx".equals(extension)) {
			map.put("mesg", "请选择excel格式的文件!");
			return map;
		}
		
		// 如果文件名为空则什么都不做
		if (filename != null && !"".equals(filename)) {
			try {
				InputStream in = file.getInputStream();
				Workbook workBook = null;
				if (!in.markSupported()) {
					in = new PushbackInputStream(in, 8);
				}
				// 读写xls和xlsx格式时，HSSFWorkbook针对xls，XSSFWorkbook针对xlsx
				if (POIFSFileSystem.hasPOIFSHeader(in)) {
					workBook = new HSSFWorkbook(in);
				} else if (POIXMLDocument.hasOOXMLHeader(in)) {
					workBook = new XSSFWorkbook(OPCPackage.open(in));
				}
				
				List<User> userList = ExcelImportUtil.exportListFromExcel(workBook);
				userService.addUser(userList);
				//System.out.println("获取到的数据：" + userList.size());
			} catch (IOException e) {
				e.printStackTrace();
				map.put("mesg", "导入数据失败!");
				return map;
			}
		}
		map.put("mesg", "导入数据成功!");
		
		return map;
	}
	
	// 获取用户列表视图
	@RequestMapping(value = { "/user-list.html" }, method = RequestMethod.GET)
	public String toUserListView() {
		
		return "admin/user/user-list";
	}

	// 获取用户列表数据
	@RequestMapping(value = { "/user-list.html" }, method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public @ResponseBody String toUserList(String key, Integer pageIndex,
			Integer pageSize, String sortField, String sortOrder) {
		// 查询条件 key 分页 pageIndex、pageSize 字段排序 sortField、sortOrder
		System.out.println("user-list.html...POST : " + key + "," + pageIndex
				+ "," + pageSize + "," + sortField + "," + sortOrder);

		Map<String, Object> jsonMap = userService.queryAll(key, pageIndex, pageSize, sortField, sortOrder);

		//System.out.println(JSONUtil.encode(jsonMap));
		return JSONUtil.encode(jsonMap);
	}
	
	// 获取保存用户视图
	@RequestMapping(value = { "/save-user.html" }, method = RequestMethod.GET)
	public String saveUserView() {
		System.out.println("save-user.html...GET");
		
		return "admin/user/add-user";
	}

	// 保存用户 （修改用户）
	@RequestMapping(value = { "/save-user.do" }, method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public @ResponseBody String saveUser(User user) {
		System.out.println("save-user.do...POST");
		Map<String, String> map = new HashMap<String, String>();
		if (user.getId() == null) {
			user.setPassword(MD5Util.string2MD5(user.getUserName()));
			user.setCreateTime(new Date());
			user.setIsNew(0);
			if(userService.addUser(user))
				map.put("mesg", "addsucc");
			else
				map.put("mesg", "adderr");
				
		} else {
			if(userService.modify(user))
				map.put("mesg", "upsucc");
			else
				map.put("mesg", "uperr");
		}
			
		return JSONUtil.encode(map);
	}

	// 根据id查询用户信息
	@RequestMapping(value = { "/query-user.html" }, method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public @ResponseBody String queryUser(Long userId) {
		System.out.println("query-user.html...POST" + userId);
		User user = userService.queryUserById(userId);

		return JSONUtil.encode(user);
	}
	
	// 根据id批量设置（撤销）管理员
	@RequestMapping(value = { "/admin-user.html" }, method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public @ResponseBody String setAdmin(long userId, int state) {
		Map<String, String> map = new HashMap<String, String>();
		if(userService.adminSetOrCancel(userId, state))
			map.put("mesg", "设置成功!");
		else 
			map.put("mesg", "设置失败!");
		
		return JSONUtil.encode(map);
	}
	// 根据id批量审核lost found信息
	@RequestMapping(value = { "/update-/{role}/.html" }, method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public @ResponseBody String updateLostFound(@PathVariable String role, String ids) {
		System.out.println("update-user.html...POST" + ids);
		String[] Ids = ids.split(",");
		boolean flag = false;
	    if("find".equalsIgnoreCase(role)) {
			for(int i = 0 ;i < Ids.length; i++){
				flag = pickThingsService.modifyStatus(Ids[i],0);
				if(!flag)
					break;
			}
		} else if("lost".equalsIgnoreCase(role)) {
			for(int i = 0 ;i < Ids.length; i++){
				flag = lostThingsService.modifyStatus(Ids[i],Constants.THINGS_STATE_PUBLISHED);
				if(!flag)
					break;
			}
		}

		Map<String, String> map = new HashMap<String, String>();
		if(flag)
			map.put("mesg", "过审成功!");
		else
			map.put("mesg", "过审失败!");

		return JSONUtil.encode(map);
	}
	// 根据id批量删除（用户删除、物品删除、日志删除）
	@RequestMapping(value = { "/remove-/{role}/.html" }, method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public @ResponseBody String removeUser(@PathVariable String role, String ids) {
		System.out.println("remove-user.html...POST" + ids);
		
		boolean flag = false;
		if("user".equalsIgnoreCase(role)) {
			flag = userService.remove(ids);
		} else if("find".equalsIgnoreCase(role)) {
			flag = pickThingsService.remove(ids);
		} else if("lost".equalsIgnoreCase(role)) {
			flag = lostThingsService.remove(ids);
		} else if("log".equalsIgnoreCase(role)) {
			flag = userService.removeLoginlog(ids);
		} 
		
		Map<String, String> map = new HashMap<String, String>();
		if(flag)
			map.put("mesg", "删除成功!");
		else 
			map.put("mesg", "删除失败!");
		
		return JSONUtil.encode(map);
	}
	
	// 根据id批量冻结用户
	@RequestMapping(value = { "/lock-user.html" }, method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public @ResponseBody String lockUser(String ids) {
		Map<String, String> map = new HashMap<String, String>();
		if(userService.lockOrUnlock(ids, Constants.USER_STATE_LOCK))
			map.put("mesg", "冻结成功!");
		else
			map.put("mesg", "冻结失败!");
		
		return JSONUtil.encode(map);
	}
	
	// 根据id批量解冻用户
	@RequestMapping(value = { "/unlock-user.html" }, method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public @ResponseBody String unlockUser(String ids) {
		Map<String, String> map = new HashMap<String, String>();
		if(userService.unlock(ids, Constants.USER_STATE_NORMAL))
			map.put("mesg", "解冻成功!");
		else
			map.put("mesg", "解冻失败!");
		
		return JSONUtil.encode(map);
	}
	
	// 批量重置密码
	@RequestMapping(value = { "/reset-password.html" }, method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public @ResponseBody String resetPassword(String usersId) {
		Map<String, String> map = new HashMap<String, String>();
		List<User> usersList = new ArrayList<User>();
		User user = null;
		String[] uid = usersId.split(",");
		
		for(int i = 0 ;i < uid.length; i++){
			user = userService.queryUserById(Long.parseLong(uid[i]));
			user.setPassword(MD5Util.string2MD5(user.getUserName()));
			usersList.add(user);
		}
		
		if(userService.modify(usersList))
			map.put("mesg", "重置密码成功!");
		else
			map.put("mesg", "重置密码失败!");
			
		return JSONUtil.encode(map);
	}

	// 导出用户信息到Excel
	@RequestMapping(value = { "/user-toExcel.html" }, method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String toExcel(HttpServletRequest request,
			HttpServletResponse response, String key, String sortField, String sortOrder) {
		System.out.println("user-toExcel.html...POST" + sortField + "," + sortOrder);
		long total = userService.queryAllCount(key);
		Map<String, Object> resultMap = userService.queryAll(key, 0, (int) total, sortField, sortOrder);

		try {
			DataHandlingUtil.excelWrite(request, response, resultMap, "用户数据信息");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return JSONUtil.encode(null);
	}
	
	// 获取用户登录日志列表视图
	@RequestMapping(value = { "/user-log.html" }, method = RequestMethod.GET)
	public String toLogListView() {
		
		return "admin/user/user-log";
	}

	// 获取用户登录日志列表数据
	@RequestMapping(value = { "/user-log.html" }, method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public @ResponseBody String toLogList(String key, Integer pageIndex, Integer pageSize, String sortField, String sortOrder) {
		// 查询条件 key 分页 pageIndex、pageSize 字段排序 sortField、sortOrder
		System.out.println("user-log.html...POST : " + key + "," + pageIndex
				+ "," + pageSize + "," + sortField + "," + sortOrder);

		Map<String, Object> jsonMap = userService.queryAllLoginlog(key, pageIndex, pageSize, sortField, sortOrder);

		return JSONUtil.encode(jsonMap);
	}
	
	// 导出用户登录日志信息到Excel
	@RequestMapping(value = { "/log-toExcel.html" }, method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String toLogExcel(HttpServletRequest request, HttpServletResponse response, String key, String sortField, String sortOrder) {
		System.out.println("log-toExcel.html...POST" + sortField + "," + sortOrder);
		long total = userService.queryAllLoginlogCount(key);
		Map<String, Object> resultMap = userService.queryAllLoginlog(key, 0, (int) total, sortField,sortOrder);
		
		try {
			DataHandlingUtil.excelWrite(request, response, resultMap, "用户登录日志信息");
		} catch (Exception e) {
			e.printStackTrace();
			return JSONUtil.encode("");
		}

		return JSONUtil.encode(null);
	}
	
	// 获取招领信息视图
	@RequestMapping(value = { "/find-view.html" }, method = RequestMethod.GET)
	public String toFindView() {
		System.out.println("find-view.html...GET");
		
		return "admin/things/find-view";
	}
	
	// 根据id查询招领信息
	@RequestMapping(value = { "/find-query.html" }, method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public @ResponseBody String toPickThingsView(long thingsId) {
		System.out.println("find-query.html...POST : " + thingsId);

		PickThings pickThings = pickThingsService.queryById(thingsId);

		return JSONUtil.encode(pickThings);
	}

	// 获取招领列表视图
	@RequestMapping(value = { "/find-list.html" }, method = RequestMethod.GET)
	public String toPickThingsListView() {
		
		return "admin/things/find-list";
	}

	// 获取招领列表数据
	@RequestMapping(value = { "/find-list.html" }, method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public @ResponseBody String toPickThingsList(String key, Integer pageIndex, Integer pageSize, String sortField, String sortOrder) {
		// 查询条件 key 分页 pageIndex、pageSize 字段排序 sortField、sortOrder
		System.out.println("find-list.html...POST : " + key + "," + pageIndex
				+ "," + pageSize + "," + sortField + "," + sortOrder);

		Map<String, Object> jsonMap = pickThingsService.queryAll(key, pageIndex, pageSize, sortField, sortOrder);

		return JSONUtil.encode(jsonMap);
	}
	
	// 导出招领信息到Excel
	@RequestMapping(value = { "/find-toExcel.html" }, method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String toPickExcel(HttpServletRequest request,
			HttpServletResponse response, String key, String sortField,	String sortOrder) {
		System.out.println("find-toExcel.html...POST" + sortField + "," + sortOrder);
		long total = pickThingsService.queryAllCount(key);
		Map<String, Object> resultMap = pickThingsService.queryAll(key, 0, (int) total, sortField, sortOrder);

		try {
			DataHandlingUtil.excelWrite(request, response, resultMap, "招领信息");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return JSONUtil.encode(null);
	}
	
	// 获取招领信息视图
	@RequestMapping(value = { "/lost-view.html" }, method = RequestMethod.GET)
	public String toLostView() {
		System.out.println("lost-view.html...GET");

		return "admin/things/lost-view";
	}
	
	// 根据id查询招领信息
	@RequestMapping(value = { "/lost-query.html" }, method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public @ResponseBody String toLostThingsView(long thingsId) {
		System.out.println("lost-query.html...POST : " + thingsId);

		LostThings lostThings = lostThingsService.queryById(thingsId);

		return JSONUtil.encode(lostThings);
	}

	// 获取寻物列表视图
	@RequestMapping(value = { "/lost-list.html" }, method = RequestMethod.GET)
	public String toLostThingsListView() {
		
		return "admin/things/lost-list";
	}

	// 获取寻物列表数据
	@RequestMapping(value = { "/lost-list.html" }, method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public @ResponseBody String toLostThingsList(String key, Integer pageIndex,
			Integer pageSize, String sortField, String sortOrder) {
		// 查询条件 key 分页 pageIndex、pageSize 字段排序 sortField、sortOrder
		System.out.println("lost-list.html...POST : " + key + "," + pageIndex
				+ "," + pageSize + "," + sortField + "," + sortOrder);

		Map<String, Object> jsonMap = lostThingsService.queryAll(key, pageIndex, pageSize, sortField, sortOrder);

		return JSONUtil.encode(jsonMap);
	}
	
	// 导出寻物信息到Excel
	@RequestMapping(value = { "/lost-toExcel.html" }, method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String toLostExcel(HttpServletRequest request, HttpServletResponse response, String key, String sortField, String sortOrder) {
		System.out.println("lost-toExcel.html...POST" + sortField + "," + sortOrder);
		long total = lostThingsService.queryAllCount(key);
		Map<String, Object> resultMap = lostThingsService.queryAll(key, 0, (int)total, sortField, sortOrder);

		try {
			DataHandlingUtil.excelWrite(request, response, resultMap, "寻物信息");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return JSONUtil.encode(null);
	}
	
	// 获取菜单列表视图
	@RequestMapping(value = { "/menu-list.html" }, method = RequestMethod.GET)
	public String menuListView() {
		System.out.println("menu-list.html...GET");

		return "admin/menu/menu-list";
	}

	// 获取权限列表视图
	@RequestMapping(value = { "/authority-list.html" }, method = RequestMethod.GET)
	public String authorityListView() {
		System.out.println("authority-list.html...GET");

		return "admin/authority/authority-list";
	}
	
	// 获取修改密码视图
	@RequestMapping(value = { "/password.html" }, method = RequestMethod.GET)
	public String passwordView() {
		System.out.println("password.html...GET");

		return "admin/setting/password";
	}
	
	// 修改密码
	@RequestMapping(value = { "/password.html" }, method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public @ResponseBody String savePassword(User user,String newPassword) {
		System.out.println("password.html...POST");
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
		return JSONUtil.encode(map);
	}
	
	// 获取公告视图
	@RequestMapping(value = { "/notice-list.html" }, method = RequestMethod.GET)
	public String noticeView() {
		System.out.println("notice-list.html...GET");

		return "admin/setting/notice-list";
	}
	
	// 公告列表
	@RequestMapping(value = { "/notice-list.html" }, method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public @ResponseBody String toNoticeList(String key, Integer pageIndex, Integer pageSize, String sortField, String sortOrder) {
		// 查询条件 key 分页 pageIndex、pageSize 字段排序 sortField、sortOrder
		System.out.println("notice-list.html...POST : " + key + "," + pageIndex + "," + pageSize + "," + sortField + "," + sortOrder);

		Map<String, Object> jsonMap = noticeService.queryAll(key, pageIndex, pageSize, sortField, sortOrder);

		return JSONUtil.encode(jsonMap);
	}
	
	// 获取添加公告视图
	@RequestMapping(value = { "/save-notice.html" }, method = RequestMethod.GET)
	public String saveNoticeView() {
		System.out.println("save-notice.html...GET");
		
		return "admin/setting/add-notice";
	}

	// 添加公告 
	@RequestMapping(value = { "/save-notice.do" }, method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public @ResponseBody String saveNotice(Notice notice) {
		System.out.println("save-notice.do...POST" + notice);
		Map<String, String> map = new HashMap<String, String>();
		notice.setStatus(1);
		notice.setPublishTime(new Date());
		if(noticeService.add(notice))
			map.put("mesg", "addsucc");
		else
			map.put("mesg", "adderr");
			
		return JSONUtil.encode(map);
	}
	
	// 删除公告 
	@RequestMapping(value = { "/remove-notice.html" }, method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public @ResponseBody String removeNotice(int noticeId) {
		System.out.println("remove-notice.html...POST" + noticeId);
		Map<String, String> map = new HashMap<String, String>();
		if(noticeService.remove(noticeId))
			map.put("mesg", "删除成功！");
		else
			map.put("mesg", "删除失败!");
			
		return JSONUtil.encode(map);
	}
	
	// 获取留言感谢视图
	@RequestMapping(value = { "/leave-thanks-list.html" }, method = RequestMethod.GET)
	public String thanksView() {
		System.out.println("leave-thanks-list.html...GET");

		return "admin/setting/leave-thanks-list";
	}
	
	// 留言感谢列表
	@RequestMapping(value = { "/leave-thanks-list.html" }, method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public @ResponseBody String toLeaveThanksList(String key, Integer pageIndex, Integer pageSize, String sortField, String sortOrder) {
		// 查询条件 key 分页 pageIndex、pageSize 字段排序 sortField、sortOrder
		System.out.println("leave-thanks-list.html...POST : " + key + "," + pageIndex + "," + pageSize + "," + sortField + "," + sortOrder);

		Map<String, Object> jsonMap = expressThanksService.queryAll(key, pageIndex, pageSize, sortField, sortOrder);

		return JSONUtil.encode(jsonMap);
	}
	
	// 根据id批量删除留言感谢信息
	@RequestMapping(value = { "/remove-thanks.html" }, method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public @ResponseBody String removeLeaveThanks(String ids) {
		System.out.println("remove-thanks.html...POST" + ids);
		
		Map<String, String> map = new HashMap<String, String>();
		
		if(expressThanksService.remove(ids))
			map.put("mesg", "删除成功!");
		else 
			map.put("mesg", "删除失败!");
		
		return JSONUtil.encode(map);
	}
	
	// 导出留言感谢信息到Excel
	@RequestMapping(value = { "/thanks-toExcel.html" }, method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String toLeaveThanksExcel(HttpServletRequest request, HttpServletResponse response, String key, String sortField, String sortOrder) {
		System.out.println("thanks-toExcel.html...POST" + sortField + "," + sortOrder);
		long total = expressThanksService.queryAllCount(key);
		Map<String, Object> resultMap = expressThanksService.queryAll(key, 0, (int)total, sortField, sortOrder);

		try {
			DataHandlingUtil.excelWrite(request, response, resultMap, "留言感谢信息");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return JSONUtil.encode(null);
	}
	
	// 获取数据库操作视图
	@RequestMapping(value = { "/database.html" }, method = RequestMethod.GET)
	public String databaseView() {
		System.out.println("database.html...GET");

		return "admin/setting/database";
	}
	
	// 数据库备份操作
	@RequestMapping(value = { "/database-backup.html" })
	public String databaseBackup(String destPath,HttpServletResponse response) {
		System.out.println("database-backup.html...GET" +destPath);
		String username = DataBaseInfoUtils.getDataBaseInfo().get("username");
		String password = DataBaseInfoUtils.getDataBaseInfo().get("password");
		String ip = DataBaseInfoUtils.getDataBaseInfo().get("ip");
		String port = DataBaseInfoUtils.getDataBaseInfo().get("port");
		String databaseName = DataBaseInfoUtils.getDataBaseInfo().get("databaseName");
		
		MysqlDumpUtils.config(username, password, databaseName, ip, port);
		try {
			BackupInfo backupInfo = MysqlDumpUtils.backup(MysqlDumpUtils.getBackupPath()+ "/");
			if(backupInfo.isComplete()) {
				response.setCharacterEncoding("UTF-8");
				response.setContentType("multipart/form-data");
				response.setHeader("Content-Disposition", "attachment;fileName="+ URLEncoder.encode("数据库备份"+backupInfo.getPath().substring(backupInfo.getPath().lastIndexOf("/") + 1, backupInfo.getPath().lastIndexOf(".")), "UTF-8") +backupInfo.getPath().substring(backupInfo.getPath().lastIndexOf(".")));
				InputStream is = null;
				OutputStream os = null;
				try {
					is = new FileInputStream(new File(URLDecoder.decode(backupInfo.getPath(), "UTF-8")));
					os = response.getOutputStream();
					byte[] b = new byte[2048];
					int length;
					while ((length = is.read(b)) > 0) {
						os.write(b, 0, length);
					}
					
				} catch (FileNotFoundException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				} finally {
					IOUtils.closeQuietly(is);
					IOUtils.closeQuietly(os);
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (InterruptedException e) {
			e.printStackTrace();
		} catch (ExecutionException e) {
			e.printStackTrace();
		}

		return null;
	}
	
	// 数据库还原
	@RequestMapping(value = { "/recover.html" }, method = RequestMethod.POST)
	public @ResponseBody String recover() throws IOException {
		String username = DataBaseInfoUtils.getDataBaseInfo().get("username");
		String password = DataBaseInfoUtils.getDataBaseInfo().get("password");
		String ip = DataBaseInfoUtils.getDataBaseInfo().get("ip");
		String port = DataBaseInfoUtils.getDataBaseInfo().get("port");
		String databaseName = DataBaseInfoUtils.getDataBaseInfo().get("databaseName");
		
		MysqlDumpUtils.config(username, password, databaseName, ip, port);
		MysqlDumpUtils.recover(MysqlDumpUtils.getBackupPath() +"/backup/");
		
		return null;
	}
	
	// 获取系统日志视图
	@RequestMapping(value = { "/system-log.html" }, method = RequestMethod.GET)
	public String systemLogView() {
		System.out.println("system-log.html...GET");

		return "admin/setting/system-log";
	}
	
	// 系统日志列表
	@RequestMapping(value = { "/system-log.html" }, method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public @ResponseBody String toSystemLogList(String key, Integer pageIndex, Integer pageSize, String sortField, String sortOrder) {
		// 查询条件 key 分页 pageIndex、pageSize 字段排序 sortField、sortOrder
		System.out.println("system-log.html...POST : " + key + "," + pageIndex + "," + pageSize + "," + sortField + "," + sortOrder);

		Map<String, Object> jsonMap = systemLogService.queryAll(key, pageIndex, pageSize, sortField, sortOrder);

		return JSONUtil.encode(jsonMap);
	}
	
	// 根据id批量删除系统日志
	@RequestMapping(value = { "/remove-systemlog.html" }, method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public @ResponseBody String removeSystemLog(String ids) {
		System.out.println("remove-systemlog.html...POST" + ids);
		
		Map<String, String> map = new HashMap<String, String>();
		
		if(systemLogService.remove(ids))
			map.put("mesg", "删除成功!");
		else 
			map.put("mesg", "删除失败!");
		
		return JSONUtil.encode(map);
	}
	
	// 导出系统日志信息到Excel
	@RequestMapping(value = { "/systemlog-toExcel.html" }, method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String toSystemLogExcel(HttpServletRequest request, HttpServletResponse response, String key, String sortField, String sortOrder) {
		System.out.println("systemlog-toExcel.html...POST" + sortField + "," + sortOrder);
		long total = systemLogService.queryAllCount(key);
		Map<String, Object> resultMap = systemLogService.queryAll(key, 0, (int)total, sortField, sortOrder);

		try {
			DataHandlingUtil.excelWrite(request, response, resultMap, "系统日志信息");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return JSONUtil.encode(null);
	}
	
	// 获取admin登录视图
	@RequestMapping(value = { "/login.do", "/login.html", "/login" }, method = RequestMethod.GET)
	public String login(HttpSession session) {
		System.out.println("adminLogin...GET");
		if(session.getAttribute(Constants.ADMIN) != null)
			return "admin/index";
		
		return "admin/login";
	}

	// admin登录
	@RequestMapping(value = { "/login.do", "login.html" }, method = RequestMethod.POST)
	public @ResponseBody String login(User user, String code, HttpSession session) {
		System.out.println("adminLogin...post" + code);

		Map<String, String> jsonMap = new HashMap<String, String>();
		if (code == null || "".equals(code)) {
			jsonMap.put("mesg", "codeNull");
			return JSONUtil.encode(jsonMap);
		}

		if (!code.equalsIgnoreCase((String)session.getAttribute(Constants.CODE))) {
			jsonMap.put("mesg", "codeErr");
			return JSONUtil.encode(jsonMap);
		}

		// 调用service 的 login 方法
		User u = userService.login(user.getUserName(), MD5Util.string2MD5(user.getPassword()), Constants.USER_STATE_ADMIN);
		if (u != null) {
			// 判断用户权限（是否冻结）
			if(u.getState() == 0) {
				jsonMap.put("mesg", "lock");
				return JSONUtil.encode(jsonMap);
			}
			
			System.out.println("admin...login...success");
			session.setAttribute(Constants.ADMIN, u);
			jsonMap.put("mesg", "success");
			
			return JSONUtil.encode(jsonMap);
		} else {
			jsonMap.put("mesg", "error");
			return JSONUtil.encode(jsonMap);
		}

	}

	// admin注销
	@RequestMapping(value = { "/logout.do", "logout.html" })
	public String logout(HttpSession session) {
		System.out.println("adminLogout...");
		session.removeAttribute(Constants.ADMIN);
		session.invalidate();

		return "redirect:login.html";
	}

}
