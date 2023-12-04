package com.lin.lostandfound.web.controller;

import com.lin.lostandfound.common.constants.Constants;
import com.lin.lostandfound.common.tag.PagerTag;
import com.lin.lostandfound.common.utils.DateUtil;
import jxl.common.Logger;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

public abstract class BaseController {
	
	protected static Logger logger = Logger.getLogger(BaseController.class);
	protected static Log log = LogFactory.getLog(BaseController.class);
	
	// 初始化分页相关信息
	protected void initPage(Map<String, Object> map, Integer pageNum,
			Integer pageSize, Integer totalCount) {
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
		map.put("startIndex", PagerTag.getStartIndex(pageNum, pageSize));
		map.put("pageNum", pageNum);
		map.put("totalPage", totalPage);
		map.put("pageSize", pageSize);
		map.put("totalCount", totalCount);
	}

	// 将相关数据放入model
	protected void initResult(Model model, String listKey, List<?> list,
			Map<String, Object> map) {
		model.addAttribute(listKey, list);
		Iterator<Entry<String, Object>> it = map.entrySet().iterator();
		while (it.hasNext()) {
			Entry<String, Object> m = (Entry<String, Object>) it.next();
			model.addAttribute(m.getKey().toString(), m.getValue());
		}
	}
	
	// 上传
	protected String upload(MultipartFile multipartFile, HttpServletRequest request,String  basePath) {
		// 取文件的类型，后缀名
		String fileType = multipartFile.getOriginalFilename().substring(
				multipartFile.getOriginalFilename().lastIndexOf("."));
		
		// 我们构建一个随机文件名称， 2016-15-310834.jpg
		String fileName = DateUtil.format(new Date(), "yyyyMMddHHmmssS") + fileType;
		//System.out.println("fileName: " +fileName);
		// Java IO的内容
		File targetFile = new File(basePath, fileName);

		// 保存
		try {
			// 转移到 targetFile
			(multipartFile).transferTo(targetFile);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
		return fileName;
	}
	
	// 获取上传根路径
	protected String getUploadBasePath(HttpServletRequest request) {

		 return Thread.currentThread().getContextClassLoader().getResource("").getPath() + Constants.BASE_UPLOAD_PATH;
	}
}
