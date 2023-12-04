package com.lin.lostandfound.services.impl;

import com.lin.lostandfound.repositories.dao.INoticeDao;
import com.lin.lostandfound.entities.domain.Notice;
import com.lin.lostandfound.services.INoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("noticeService")
public class NoticeServiceImpl implements INoticeService {
	
	@Autowired
	@Qualifier("noticeDao")
	private INoticeDao noticeDao;

	@Override
	public boolean add(Notice notice) {
		
		return noticeDao.save(notice);
	}

	@Transactional
	@Override
	public boolean modifyStatus(Integer id, int status) {
		
		return noticeDao.updateStatus(id, status);
	}

	@Override
	public boolean remove(Integer id) {
		
		return noticeDao.delete(id);
	}
	
	// 查询最新一条
	@Override
	public Notice queryNewNotice() {
		
		return noticeDao.findNewNotice();
	}

	@Override
	public long queryAllCount(String key) {
		
		return noticeDao.findAllCount(key);
	}

	@Override
	public Map<String, Object> queryAll(String key, Integer pageIndex, Integer pageSize, String sortField, String sortOrder) {
		List<Notice> noticeList = noticeDao.findAll(key, pageIndex, pageSize, sortField, sortOrder);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("data", noticeList);
		resultMap.put("total", noticeDao.findAllCount(key));
		
		return resultMap;
	}

	@Override
	public Notice queryById(int id) {
		
		return noticeDao.findById(id);
	}

}
