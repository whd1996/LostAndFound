package com.lin.lostandfound.repositories.dao;

import com.lin.lostandfound.entities.domain.ExpressThanks;

import java.util.List;

public interface IExpressThanksDao {

	// 保存
	public boolean save(ExpressThanks expressThanks);

	// 批量更新状态
	public boolean updateStatus(long[] thanksId, int status);

	// 更新状态
	public boolean updateStatus(long thanksId, int status);

	// 删除
	public boolean delete(long[] thanksId);

	// 查询所有统计数量
	public long findAllCount(String key);

	// 查询所有
	public List<ExpressThanks> findAll(String key, Integer pageIndex,
                                       Integer pageSize, String sortField, String sortOrder);

	// 根据id查询
	public ExpressThanks findById(long id);

}
