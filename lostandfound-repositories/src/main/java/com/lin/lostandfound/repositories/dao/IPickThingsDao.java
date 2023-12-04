package com.lin.lostandfound.repositories.dao;

import com.lin.lostandfound.entities.domain.PickThings;

import java.util.List;

/**
 * @author lgllink
 *
 */

public interface IPickThingsDao {

	// 保存
	public boolean save(PickThings pickThings);

	// 批量更新状态
	public boolean updateStatus(long[] picksId, int status);
	
	// 更新状态
	public boolean updateStatus(long pickId, int status); 

	// 删除
	public boolean delete(long[] picksId);
	
	// 查询所有统计数量
	public long findAllCount(String key);
	
	// 查询所有
	public List<PickThings> findAll(String key, Integer pageIndex,
                                    Integer pageSize, String sortField, String sortOrder);

	// 查询所有（分页）
	public List<PickThings> findAll(Integer currentPage, Integer pageSize,
                                    boolean desc);

	// 根据id查询
	public PickThings findById(long id);

	// 根据用户id查询所有
	public List<PickThings> findAllByUid(long uid);

	// 根据类型查询数量
	public long findByType(String type);

	// 根据用户id查询统计所有（分页）
	public long findAllByUidCount(long uid);

	// 根据用户id查询所有（分页）
	public List<PickThings> findAllByUid(long uid, Integer currentPage,
                                         Integer pageSize, boolean desc);

	// 根据关键字查询所有
	public List<PickThings> findAllByKeywords(String keywords);

	// 根据关键字查询统计数量（分页）
	public long findAllByKeywordsCount(String keywords);

	// 根据关键字查询所有（分页）
	public List<PickThings> findAllByKeywords(String keywords,
                                              Integer currentPage, Integer pageSize, boolean desc);

	// 根据类型查询所有（分页）
	public List<PickThings> findAllByThingsType(String type,
                                                Integer currentPage, Integer pageSize, boolean desc);

	// 查询已经归还
	public long findByReturnedCount();

	// 查询已成功贴的信息
	public List<PickThings> findThingsBySuccess(int index);
	
	//查询一条记录（上一条、下一条）
	public PickThings findOneRecord(long id, boolean isNext);

}
