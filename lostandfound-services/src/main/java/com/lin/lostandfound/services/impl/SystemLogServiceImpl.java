package com.lin.lostandfound.services.impl;

import com.lin.lostandfound.repositories.dao.ISystemLogDao;
import com.lin.lostandfound.entities.domain.SystemLog;
import com.lin.lostandfound.services.ISystemLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("systemLogService")
public class SystemLogServiceImpl implements ISystemLogService {
	@Autowired
	@Qualifier("systemLogDao")
	private ISystemLogDao systemLogDao;

	// 添加
	@Override
	public boolean add(SystemLog systemLog) {
		
		return systemLogDao.svae(systemLog);
	}
	
	// 批量删除
	@Override
	public boolean remove(String logId) {
		String[] id = logId.split(",");
		
		long[] lid = new long[id.length];
		for(int i = 0 ;i < id.length; i++){
			lid[i] = Long.parseLong(id[i]);
		}
		
		return systemLogDao.delete(lid);
	}
	
	// 统计所有（分页）
	@Override
	public long queryAllCount(String key) {
		
		return systemLogDao.findAllCount(key);
	}
	
	// 查询所有
	@Override
	public Map<String, Object> queryAll(String key, Integer pageIndex, Integer pageSize, String sortField, String sortOrder) {
		List<SystemLog> systemLogList = systemLogDao.findAll(key, pageIndex, pageSize, sortField, sortOrder);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("data", systemLogList);
		resultMap.put("total", systemLogDao.findAllCount(key));
		
		return resultMap;
	}

}
