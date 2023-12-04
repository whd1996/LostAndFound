package com.lin.lostandfound.repositories.dao;

import com.lin.lostandfound.entities.domain.SystemLog;

import java.util.List;

public interface ISystemLogDao {
	
	// 保存
	public boolean svae(SystemLog systemLog);
	
	// 批量删除
	public boolean delete(long[] logsId);
	
	// 统计所有（分页）
	public long findAllCount(String key);
	
	// 查询所有
	public List<SystemLog> findAll(String key, Integer pageIndex,
                                   Integer pageSize, String sortField, String sortOrder);

}
