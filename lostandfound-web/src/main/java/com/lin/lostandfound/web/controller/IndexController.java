package com.lin.lostandfound.web.controller;

import com.lin.lostandfound.common.annotation.SystemControllerLog;
import com.lin.lostandfound.common.constants.Constants;
import com.lin.lostandfound.entities.domain.LostThings;
import com.lin.lostandfound.entities.domain.Notice;
import com.lin.lostandfound.entities.domain.PickThings;
import com.lin.lostandfound.services.IExpressThanksService;
import com.lin.lostandfound.services.ILostThingsService;
import com.lin.lostandfound.services.INoticeService;
import com.lin.lostandfound.services.IPickThingsService;
import com.lin.lostandfound.common.tag.PagerTag;
import com.lin.lostandfound.common.utils.JSONUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

@Controller
public class IndexController extends BaseController {
	
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
	@Qualifier("expressThanksService")
	private IExpressThanksService expressThanksService;

	// 首页
	//此处为记录AOP拦截Controller记录操作  
	@SystemControllerLog(description = "访问主页") 
	@RequestMapping(value = { "/", "/index", "/index.do", "/index.html", "/index.jsp" })
	public String index(Model model) {
		System.out.println("index...");

		List<PickThings> newPickList = pickThingsService.queryAll(1, Constants.PAGE_SIZE_15, true);
		List<LostThings> newLostList = lostThingsService.queryAll(1, Constants.PAGE_SIZE_15, true);
		
		// 已归还数量
		long returnedCount = pickThingsService.queryByReturnedCount();
		// 已找到数量
		long foundCount = lostThingsService.queryByFoundCount();
		
		// 取最新3条
		List<PickThings> successPickList = pickThingsService.queryThingsBySuccess(3);
		List<LostThings> successLostList = lostThingsService.queryThingsBySuccess(3);
		
		// 最新一条公告
		Notice notices = noticeService.queryNewNotice();

		model.addAttribute("newPickList", newPickList);
		model.addAttribute("newLostList", newLostList);
		
		model.addAttribute("pickCount", returnedCount);
		model.addAttribute("lostCount", foundCount);
		
		model.addAttribute("successPick", successPickList);
		model.addAttribute("successLost", successLostList);
		
		model.addAttribute("notices", notices);

		return "index";
	}

	// 搜索List
	//此处为记录AOP拦截Controller记录操作  
	@SystemControllerLog(description = "搜索") 
	@RequestMapping(value = { "/search-list.html" })
	public String searchAll(Map<String, Object> map, Model model,String keywords) {
		System.out.println("search-list..." +keywords);
		
		List<PickThings> searchPickThingsList = pickThingsService.queryAllByKeywords(keywords, 1, Constants.PAGE_SIZE_15, true);
		List<LostThings> searchLostThingsList = lostThingsService.queryAllByKeywords(keywords, 1, Constants.PAGE_SIZE_15, true);
		int totalPick = (int) pickThingsService.queryAllByKeywordsCount(keywords);
		int totalLost = (int) lostThingsService.queryAllByKeywordsCount(keywords);
		
		model.addAttribute("keywords", keywords);
		this.initPickPage(map, 1, Constants.PAGE_SIZE_15, totalPick);
		this.initLostPage(map, 1, Constants.PAGE_SIZE_15, totalLost);
		super.initResult(model, "searchPickThingsList", searchPickThingsList, map);
		super.initResult(model, "searchLostThingsList", searchLostThingsList, map);

		return "search-list";
	}
	
	// 搜索AllList（分页）
	@RequestMapping(value = { "/search-list.html/{pageNo}/{pageSize}/{page}"})
	public String searchAllList(@PathVariable String pageNo,
			@PathVariable String pageSize, @PathVariable String page, String keywords, Map<String,
			Object> map, Model model) {
		System.out.println("search-list...AllList" +keywords + pageNo + " " + pageSize + " "+ page);
		
		List<PickThings> searchPickThingsList = pickThingsService.queryAllByKeywords(keywords, 1, Constants.PAGE_SIZE_15, true);
		List<LostThings> searchLostThingsList = lostThingsService.queryAllByKeywords(keywords, 1, Constants.PAGE_SIZE_15, true);
		
		int totalPick = (int) pickThingsService.queryAllByKeywordsCount(keywords);
		int totalLost = (int) lostThingsService.queryAllByKeywordsCount(keywords);
		
		int currentPage = 1;
		int pSize = Constants.PAGE_SIZE_15;

		try {
			currentPage = Integer.parseInt(pageNo);
			pSize = Integer.parseInt(pageSize);
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		
		model.addAttribute("keywords", keywords);
		model.addAttribute("pageName", page);
		
		this.initPickPage(map, currentPage, pSize, totalPick);
		this.initLostPage(map, currentPage, pSize, totalLost);
		
		super.initResult(model, "searchPickThingsList", searchPickThingsList, map);
		super.initResult(model, "searchLostThingsList", searchLostThingsList, map);

		return "search-list";
	}
	
	// 初始化分页相关信息
	private void initPickPage(Map<String, Object> map, Integer pageNum, Integer pageSize, Integer totalCount) {
		if (null == pageSize || pageSize.equals("")) {
			pageSize = Constants.PAGE_SIZE_15;
		}
		if (pageSize > 50) {
			pageSize = 50;
		}
		Integer totalPage = (totalCount + pageSize - 1) / pageSize;
		if (null == pageNum) {
			pageNum = 1;
		} else if (pageNum > totalPage) {
			pageNum = totalPage;
		}
		map.put("pickstartIndex", PagerTag.getStartIndex(pageNum, pageSize));
		map.put("pickpageNum", pageNum);
		map.put("picktotalPage", totalPage);
		map.put("pickpageSize", pageSize);
		map.put("picktotalCount", totalCount);
	}
	
	// 初始化分页相关信息
	private void initLostPage(Map<String, Object> map, Integer pageNum, Integer pageSize, Integer totalCount) {
		if (null == pageSize || pageSize.equals("")) {
			pageSize = Constants.PAGE_SIZE_15;
		}
		if (pageSize > 50) {
			pageSize = 50;
		}
		Integer totalPage = (totalCount + pageSize - 1) / pageSize;
		if (null == pageNum) {
			pageNum = 1;
		} else if (pageNum > totalPage) {
			pageNum = totalPage;
		}
		map.put("loststartIndex", PagerTag.getStartIndex(pageNum, pageSize));
		map.put("lostpageNum", pageNum);
		map.put("losttotalPage", totalPage);
		map.put("lostpageSize", pageSize);
		map.put("losttotalCount", totalCount);
	}
	
	// 获取leave-thanks视图
	@RequestMapping(value = {"/leave-thanks.html"}, method = RequestMethod.GET)
	public String thanksView() {
		System.out.println("leave-thanks.html...GET");
		
		return "leave-thanks";
	}
	
	// thanks列表
	@RequestMapping(value = {"/thanks.do"}, method = RequestMethod.POST)
	public @ResponseBody String thanks(Integer pageIndex, Integer pageSize) {
		System.out.println("thanks.do...POST" + pageIndex + " " +pageSize);
		Map<String, Object> jsonMap = expressThanksService.queryAll(null, pageIndex, pageSize, "id", "desc");
		
		return JSONUtil.encode(jsonMap);
	}
	
	// leave列表
	@RequestMapping(value = {"/leave.do"}, method = RequestMethod.POST)
	public @ResponseBody String leave(Integer pageIndex, Integer pageSize) {
		System.out.println("leave.do...POST" + pageIndex + " " +pageSize);
		Map<String, Object> jsonMap = expressThanksService.queryAll(null, pageIndex, pageSize, "id", "desc");
		
		return JSONUtil.encode(jsonMap);
	}
	
	// 获取user-help视图
	@RequestMapping(value = {"/user-help.html"}, method = RequestMethod.GET)
	public String userHelpView() {
		System.out.println("user-help.html...GET");
		
		return "user-help";
	}
	
}
