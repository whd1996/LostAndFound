package com.lin.lostandfound.web.controller;

import com.lin.lostandfound.common.annotation.SystemControllerLog;
import com.lin.lostandfound.common.annotation.Token;
import com.lin.lostandfound.common.constants.Constants;
import com.lin.lostandfound.entities.domain.LostThings;
import com.lin.lostandfound.services.ILostThingsService;
import com.lin.lostandfound.common.utils.MakeFolderUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/lost")
public class LostThingsController extends BaseController {
	
	@Autowired
	@Qualifier("lostThingsService")
	private ILostThingsService lostThingsService;

	// 根据id查询lostThings
	@RequestMapping(value = { "/lost-details.do/{pid}", "/lost-details.html/{pid}" })
	public String lostThingsDetails(@PathVariable String pid, Model model) {
		System.out.println("lost-details..." + pid);
		
		long id = 0;
		LostThings lostThings = null;
		try {
			id = Long.parseLong(pid);
			lostThings = lostThingsService.queryById(id);
			// 如果没查到就查它的上一条记录
			if(lostThings == null)
				lostThings = lostThingsService.queryOneRecord(id, true);
			
		} catch (NumberFormatException e) {
			e.printStackTrace();
			// 如果id格式化出错就查最后一条（最新）
			for(LostThings lt : lostThingsService.queryAll(1, 1, true))
				lostThings = lt;
			
		}
		model.addAttribute("lostThings", lostThings);

		return "things/lost-details";
	}

	// 查询所有lostThings（AllList）
	@RequestMapping(value = { "/lost-list.do", "/lost-list.html", "/lost-list" })
	public String lostThingsAllList(Model model, Map<String, Object> map) {
		System.out.println("lost-list...AllList");

		int currentPage = 1;
		int pSize = Constants.PAGE_SIZE_15;

		List<LostThings> lostThingsList = lostThingsService.queryAllByKeywords(null, currentPage, pSize, true);
		long totalCount = lostThingsService.queryByType(null);
		super.initPage(map, currentPage, pSize, (int) totalCount);
		super.initResult(model, "lostThingsList", lostThingsList, map);

		return "lost-list";
	}

	// 根据type查询lostThingsList
	@RequestMapping(value = { "/lost-list.do/{pageNo}/{pageSize}/{type}", "/lost-list.html/{pageNo}/{pageSize}/{type}" })
	public String lostThingsList(@PathVariable String pageNo, @PathVariable String pageSize, @PathVariable String type,
			Map<String, Object> map, Model model) {
		System.out.println("lost-list.html...All" + pageNo + pageSize + type);

		int currentPage = 1;
		int pSize = Constants.PAGE_SIZE_15;

		try {
			currentPage = Integer.parseInt(pageNo);
			pSize = Integer.parseInt(pageSize);
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}

		List<LostThings> lostThingsList = lostThingsService.queryAllByThingsType(type, currentPage, pSize, true);
		long totalCount = lostThingsService.queryByType(type);
		super.initPage(map, currentPage, pSize, (int) totalCount);
		super.initResult(model, "lostThingsList", lostThingsList, map);

		return "lost-list";
	}

	// 获取丢失东西发帖页面
	@SystemControllerLog(description = "获取发寻物贴页面")
	@Token(save=true)
	@RequestMapping(value = { "/lost-publish.html" }, method = RequestMethod.GET)
	public String publishLostThingsView() {
		System.out.println("lost-publish.html...GET");

		return "user/lost-publish";
	}

	// 丢失东西发帖
	@SystemControllerLog(description = "发寻物贴")
	@Token(remove=true)
	@RequestMapping(value = { "/lost-publish.html" }, method = RequestMethod.POST)
	public String publishPickThings(LostThings lostThings, @RequestParam(value = "Img", required = false) MultipartFile multipartFile,
			HttpServletRequest request) {
		lostThings.setPublishTime(new Date());
		lostThings.setStatus(Constants.THINGS_STATE_REVIEWED);
		System.out.println("lost-publish.html..." + lostThings);
		// 通过上下文取获取我们的虚拟路径的实际地址
		String basePath = super.getUploadBasePath(request) + "\\lost";
		basePath = MakeFolderUtil.makeDir(basePath, new Date(), lostThings.getUserName());
		
		String fileName = "";
		if (multipartFile.getOriginalFilename() != null
				&& !"".equals(multipartFile.getOriginalFilename()))
			fileName = super.upload(multipartFile, request, basePath);

		if (fileName == null) {
			request.setAttribute("lostThings", lostThings);
			request.setAttribute("upErr", "图片上传失败!");

			return "user/lost-publish";
		}

		if(!"".equals(fileName)) {
			String savePath = basePath.substring(basePath.indexOf("static"));
			savePath = savePath + "\\" + fileName;
			lostThings.setThingsImg(savePath);
		}

		if (!lostThingsService.add(lostThings)) {
			request.setAttribute("lostThings", lostThings);
			request.setAttribute("saveErr", "发帖失败!");

			return "user/lost-publish";
		}

		return "user/user-center";
	}
	
	// 快速下一贴
	@SystemControllerLog(description = "快速查看寻物信息下一贴")
	@RequestMapping(value = { "/lost-details.html/next/{id}" }, method = RequestMethod.POST)
	public @ResponseBody List<LostThings> next(@PathVariable String id, Model model) {
		System.out.println("next.html..." +id);
		LostThings lostThings = lostThingsService.queryOneRecord(Long.parseLong(id), true);
		List<LostThings> list = new ArrayList<LostThings>();
		list.add(lostThings);
		
		return list;
	}

	// 快速上一贴
	@SystemControllerLog(description = "快速查看寻物信息上一贴")
	@RequestMapping(value = { "/lost-details.html/previous/{id}" }, method = RequestMethod.POST)
	public @ResponseBody List<LostThings> previous(@PathVariable String id, Model model){
		System.out.println("previous.html..." +id);
		LostThings lostThings = lostThingsService.queryOneRecord(Long.parseLong(id), false);
		List<LostThings> list = new ArrayList<LostThings>();
		list.add(lostThings);
		
		return list;
	}
	
}
