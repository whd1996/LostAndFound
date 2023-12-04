package com.lin.lostandfound.web.controller;

import com.lin.lostandfound.common.annotation.SystemControllerLog;
import com.lin.lostandfound.common.annotation.Token;
import com.lin.lostandfound.common.constants.Constants;
import com.lin.lostandfound.entities.domain.PickThings;
import com.lin.lostandfound.services.IPickThingsService;
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
@RequestMapping(value = "/find")
public class PickThingsController extends BaseController {

	@Autowired
	@Qualifier("pickThingsService")
	private IPickThingsService pickThingsService;

	// 根据id查询pickThings
	@RequestMapping(value = { "/find-details.do/{pid}", "/find-details.html/{pid}" })
	public String pickThingsDetails(@PathVariable String pid, Model model) {
		System.out.println("find-details..." + pid);
		long id = 0;
		PickThings pickThings = null;
		try {
			id = Long.parseLong(pid);
			pickThings = pickThingsService.queryById(id);
			// 如果没查到就查它的上一条记录
			if(pickThings == null)
				pickThings = pickThingsService.queryOneRecord(id, true);
			
		} catch (NumberFormatException e) {
			e.printStackTrace();
			// 如果id格式化出错就查最后一条（最新）
			for(PickThings pt : pickThingsService.queryAll(1, 1, true))
				pickThings = pt;
			
		}
		model.addAttribute("pickThings", pickThings);

		return "things/find-details";
	}

	// 查询所有pickThings（AllList）
	@RequestMapping(value = { "/find-list.do", "/find-list.html", "/find-list" })
	public String pickThingsAllList(Model model, Map<String, Object> map) {
		System.out.println("find-list...AllList");

		int currentPage = 1;
		int pSize = Constants.PAGE_SIZE_15;

		List<PickThings> pickThingsList = pickThingsService.queryAllByThingsType(null, currentPage, pSize, true);
		long totalCount = pickThingsService.queryByType(null);
		super.initPage(map, currentPage, pSize, (int) totalCount);
		super.initResult(model, "pickThingsList", pickThingsList, map);

		return "find-list";
	}

	// 根据type查询pickThingsList
	@RequestMapping(value = { "/find-list.do/{pageNo}/{pageSize}/{type}", "/find-list.html/{pageNo}/{pageSize}/{type}" })
	public String pickThingsList(@PathVariable String pageNo, @PathVariable String pageSize, @PathVariable String type,
			Map<String, Object> map, Model model) {
		System.out.println("find-list.html...All" + pageNo + pageSize + type);

		int currentPage = 1;
		int pSize = Constants.PAGE_SIZE_15;

		try {
			currentPage = Integer.parseInt(pageNo);
			pSize = Integer.parseInt(pageSize);
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}

		List<PickThings> pickThingsList = pickThingsService.queryAllByThingsType(type, currentPage, pSize, true);
		long totalCount = pickThingsService.queryByType(type);
		super.initPage(map, currentPage, pSize, (int) totalCount);
		super.initResult(model, "pickThingsList", pickThingsList, map);

		return "find-list";
	}

	// 获取捡到东西发帖页面
	@SystemControllerLog(description = "获取发招领贴页面")
	@Token(save=true)
	@RequestMapping(value = { "/find-publish.html" }, method = RequestMethod.GET)
	public String publishPickThingsView() {
		System.out.println("find-publish...GET");

		return "user/find-publish";
	}

	// 捡到东西发帖
	@SystemControllerLog(description = "发招领贴")
	@Token(remove=true)
	@RequestMapping(value = { "/find-publish.html" }, method = RequestMethod.POST)
	public String publishPickThings(PickThings pickThings, @RequestParam(value = "Img", required = false) MultipartFile multipartFile,
			HttpServletRequest request) {
		pickThings.setPublishTime(new Date());
		pickThings.setStatus(Constants.THINGS_STATE_REVIEWED);//发布待审核
		System.out.println("find-publish..." + pickThings);
		// 通过上下文取获取我们的虚拟路径的实际地址
		String basePath = super.getUploadBasePath(request) + "\\find";
		basePath = MakeFolderUtil.makeDir(basePath, new Date(), pickThings.getUserName());
		System.out.println("basePath: " +basePath);

		String fileName = "";
		if (multipartFile.getOriginalFilename() != null
				&& !"".equals(multipartFile.getOriginalFilename()))
			fileName = super.upload(multipartFile, request, basePath);

		if (fileName == null) {
			request.setAttribute("pickThings", pickThings);
			request.setAttribute("upErr", "图片上传失败!");
			
			return "user/find-publish";
		}

		if(!"".equals(fileName)){
			String savePath = basePath.substring(basePath.indexOf("static"));
			savePath = savePath + "/" + fileName;
			pickThings.setThingsImg(savePath);
		}

		if (!pickThingsService.add(pickThings)) {
			request.setAttribute("pickThings", pickThings);
			request.setAttribute("saveErr", "发帖失败!");
			
			return "user/find-publish";
		}

		return "user/user-center";
	}

	// 快速下一贴
	@SystemControllerLog(description = "快速查看招领信息下一贴")
	@RequestMapping(value = { "/find-details.html/next/{id}" }, method = RequestMethod.POST)
	public @ResponseBody List<PickThings> next(@PathVariable String id, Model model) {
		System.out.println("next.html..." +id);
		PickThings pickThings = pickThingsService.queryOneRecord(Long.parseLong(id), true);
		List<PickThings> list = new ArrayList<PickThings>();
		list.add(pickThings);
		
		return list;
	}

	// 快速上一贴
	@SystemControllerLog(description = "快速查看招领信息上一贴")
	@RequestMapping(value = { "/find-details.html/previous/{id}"}, method = RequestMethod.POST)
	public @ResponseBody List<PickThings> previous(@PathVariable String id, Model model){
		System.out.println("previous.html..." +id);
		PickThings pickThings = pickThingsService.queryOneRecord(Long.parseLong(id), false);
		List<PickThings> list = new ArrayList<PickThings>();
		list.add(pickThings);
		
		return list;
	}

}
