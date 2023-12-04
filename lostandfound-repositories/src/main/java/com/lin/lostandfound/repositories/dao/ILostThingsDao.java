package com.lin.lostandfound.repositories.dao;

import com.lin.lostandfound.entities.domain.LostThings;

import java.util.List;

/**
 * 
 * @author Administrator
 *
 */
public interface ILostThingsDao {
	
	// 保存
	public boolean save(LostThings lostThings);

	// 批量更新状态
	public boolean updateStatus(long[] lostsId, int status);

	// 批量更新状态
	public boolean updateStatus(long lostsId, int status);
	
	// 删除
	public boolean delete(long[] lostsId);

	// 查询所有统计数量
	public long findAllCount(String key);

	// 查询所有
	public List<LostThings> findAll(String key, Integer pageIndex,
                                    Integer pageSize, String sortField, String sortOrder);

	// 查询所有（分页）boolean desc（排序）
	public List<LostThings> findAll(Integer currentPage, Integer pageSize,
                                    boolean desc);

	// 根据id查询
	public LostThings findById(long id);

	// 根据用户id查询所有
	public List<LostThings> findAllByUid(long uid);

	// 根据类型查询数量
	public long findByType(String type);

	// 根据用户id查询统计所有（分页）
	public long findAllByUidCount(long uid);

	// 根据用户id查询所有（分页）
	public List<LostThings> findAllByUid(long uid, Integer currentPage,
                                         Integer pageSize, boolean desc);

	// 根据关键字查询所有
	public List<LostThings> findAllByKeywords(String keywords);

	// 根据关键字查询统计数量（分页）
	public long findAllByKeywordsCount(String keywords);

	// 根据关键字查询所有（分页）
	public List<LostThings> findAllByKeywords(String keywords,
                                              Integer currentPage, Integer pageSize, boolean desc);

	// 根据类型查询所有（分页）
	public List<LostThings> findAllByThingsType(String type,
                                                Integer currentPage, Integer pageSize, boolean desc);

	// 查询已找到
	public long findByFoundCount();

	// 查询已成功贴的信息
	public List<LostThings> findThingsBySuccess(int index);

	//查询一条记录（上一条、下一条）
	public LostThings findOneRecord(long id, boolean isNext);

}
