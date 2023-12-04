package com.lin.lostandfound.services;

import com.lin.lostandfound.entities.domain.LostThings;

import java.util.List;
import java.util.Map;

public interface ILostThingsService {
	// 添加
	public boolean add(LostThings lostThings);

	// 批量修改状态
	public boolean modifyStatus(String lostId, int status);
	
	// 修改状态
	public boolean modifyStatus(long lostId, int status);

	// 删除
	public boolean remove(String lostId);
	
	// 查询所有统计数量
	public long queryAllCount(String key);

	// 查询所有
	public Map<String, Object> queryAll(String key, Integer pageIndex, Integer pageSize,
                                        String sortField, String sortOrder);

	// 查询所有（分页）
	public List<LostThings> queryAll(Integer currentPage, Integer pageSize,
                                     boolean desc);

	// 根据id查询
	public LostThings queryById(long id);

	// 根据用户id查询所有
	public List<LostThings> queryAllByUid(long uid);

	// 根据类型查询数量
	public long queryByType(String type);

	// 根据用户id查询统计所有（分页）
	public long queryAllByUidCount(long uid);

	// 根据用户id查询所有（分页）
	public List<LostThings> queryAllByUid(long uid, Integer currentPage,
                                          Integer pageSize, boolean desc);

	// 根据关键字查询所有
	public List<LostThings> queryAllByKeywords(String keywords);

	// 根据关键字查询统计数量（分页）
	public long queryAllByKeywordsCount(String keywords);

	// 根据关键字查询所有（分页）
	public List<LostThings> queryAllByKeywords(String keywords,
                                               Integer currentPage, Integer pageSize, boolean desc);

	// 根据类型查询所有（分页）
	public List<LostThings> queryAllByThingsType(String type,
                                                 Integer currentPage, Integer pageSize, boolean desc);

	// 查询已找到
	public long queryByFoundCount();

	// 查询已成功贴的信息
	public List<LostThings> queryThingsBySuccess(int index);

	//查询一条记录（上一条、下一条）
	public LostThings queryOneRecord(long id, boolean isNext);

}
