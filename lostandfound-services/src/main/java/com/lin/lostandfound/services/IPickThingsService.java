package com.lin.lostandfound.services;

import com.lin.lostandfound.entities.domain.PickThings;

import java.util.List;
import java.util.Map;

public interface IPickThingsService {

	// 添加
	public boolean add(PickThings pickThings);

	// 批量修改状态
	public boolean modifyStatus(String pickId, int status);
	
	// 修改状态
	public boolean modifyStatus(long pickId, int status);

	// 删除
	public boolean remove(String pickId);
	
	// 查询所有统计数量
	public long queryAllCount(String key);

	// 查询所有
	public Map<String, Object> queryAll(String key, Integer pageIndex,
                                        Integer pageSize, String sortField, String sortOrder);

	// 查询所有（分页）
	public List<PickThings> queryAll(Integer currentPage, Integer pageSize,
                                     boolean desc);

	// 根据id查询
	public PickThings queryById(long id);

	// 根据用户id查询所有
	public List<PickThings> queryAllByUid(long uid);

	// 根据类型查询数量
	public long queryByType(String type);

	// 根据用户id查询统计所有（分页）
	public long queryAllByUidCount(long uid);

	// 根据用户id查询所有（分页）
	public List<PickThings> queryAllByUid(long uid, Integer currentPage,
                                          Integer pageSize, boolean desc);

	// 根据关键字查询所有
	public List<PickThings> queryAllByKeywords(String keywords);

	// 根据关键字查询统计数量（分页）
	public long queryAllByKeywordsCount(String keywords);

	// 根据关键字查询所有（分页）
	public List<PickThings> queryAllByKeywords(String keywords,
                                               Integer currentPage, Integer pageSize, boolean desc);

	// 根据类型查询所有（分页）
	public List<PickThings> queryAllByThingsType(String type,
                                                 Integer currentPage, Integer pageSize, boolean desc);

	// 查询已归还
	public long queryByReturnedCount();

	// 查询已成功贴的信息
	public List<PickThings> queryThingsBySuccess(int index);
	
	//查询一条记录（上一条、下一条）
	public PickThings queryOneRecord(long id, boolean isNext);
}
