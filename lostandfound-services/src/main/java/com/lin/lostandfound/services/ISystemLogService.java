package com.lin.lostandfound.services;

import com.lin.lostandfound.entities.domain.SystemLog;

import java.util.Map;

public interface ISystemLogService {
	// 添加
	public boolean add(SystemLog systemLog);
	
	// 批量删除
	public boolean remove(String logId);
	
	// 统计所有（分页）
	public long queryAllCount(String key);
	
	// 查询所有
	public Map<String, Object> queryAll(String key, Integer pageIndex, Integer pageSize, String sortField, String sortOrder);
	
}
