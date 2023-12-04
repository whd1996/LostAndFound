package com.lin.lostandfound.repositories.dao;

import com.lin.lostandfound.entities.domain.Notice;

import java.util.List;

public interface INoticeDao {
	
	// 保存
	public boolean save(Notice notice);

	// 修改状态
	public boolean updateStatus(Integer id, int status);

	// 删除
	public boolean delete(Integer id);
	
	// 查询最新一条
	public Notice findNewNotice();
	
	// 查询所有统计
	public long findAllCount(String key);

	// 查询所有
	public List<Notice> findAll(String key, Integer pageIndex,
                                Integer pageSize, String sortField, String sortOrder);

	// 根据id查询所有
	public Notice findById(int id);

}
