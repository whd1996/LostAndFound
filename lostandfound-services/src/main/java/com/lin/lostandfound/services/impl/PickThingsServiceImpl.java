package com.lin.lostandfound.services.impl;

import com.lin.lostandfound.common.annotation.SystemServiceLog;
import com.lin.lostandfound.repositories.dao.IPickThingsDao;
import com.lin.lostandfound.entities.domain.PickThings;
import com.lin.lostandfound.services.IPickThingsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("pickThingsService")
public class PickThingsServiceImpl implements IPickThingsService {
	@Autowired
	@Qualifier("pickThingsDao")
	private IPickThingsDao pickThingsDao;

	// 添加
	@SystemServiceLog(description = "添加招领贴")
	@Override
	public boolean add(PickThings pickThings) {
		return pickThingsDao.save(pickThings);
	}

	// 批量修改状态
	@Transactional
	@Override
	public boolean modifyStatus(String pickId, int status) {
		String[] id = pickId.split(",");
		
		long[] picksId = new long[id.length];
		for(int i = 0 ;i < id.length; i++){
			picksId[i] = Long.parseLong(id[i]);
		}
		return pickThingsDao.updateStatus(picksId, status);
	}
	
	// 修改状态
	@Transactional
	@Override
	public boolean modifyStatus(long pickId, int status) {
		return pickThingsDao.updateStatus(pickId, status);
	}

	// 批量删除
	@SystemServiceLog(description = "批量删除招领贴")
	@Override
	public boolean remove(String pickId) {
		String[] id = pickId.split(",");
			
		long[] picksId = new long[id.length];
		for(int i = 0 ;i < id.length; i++){
			picksId[i] = Long.parseLong(id[i]);
		}
		return pickThingsDao.delete(picksId);
	}
	
	// 查询所有统计数量
	@Override
	public long queryAllCount(String key) {
		return pickThingsDao.findAllCount(key);
	}

	// 查询所有
	@Override
	public Map<String, Object> queryAll(String key, Integer pageIndex,
			Integer pageSize, String sortField, String sortOrder) {
		List<PickThings> pickThingsList = pickThingsDao.findAll(key, pageIndex, pageSize, sortField, sortOrder);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("data", pickThingsList);
		resultMap.put("total", pickThingsDao.findAllCount(key));
		
		return resultMap;
	}

	// 查询所有（分页）
	@Override
	public List<PickThings> queryAll(Integer currentPage, Integer pageSize,
			boolean desc) {
		return pickThingsDao.findAll(currentPage, pageSize, desc);
	}

	// 根据id查询
	@Override
	public PickThings queryById(long id) {
		return pickThingsDao.findById(id);
	}

	// 根据用户id查询所有
	@Override
	public List<PickThings> queryAllByUid(long uid) {
		return pickThingsDao.findAllByUid(uid);
	}

	// 根据类型查询数量
	@Override
	public long queryByType(String type) {
		return pickThingsDao.findByType(type);
	}
	
	// 根据用户id查询统计所有（分页）
	@Override
	public long queryAllByUidCount(long uid) {
		return pickThingsDao.findAllByUidCount(uid);
	}

	// 根据用户id查询所有（分页）
	@Override
	public List<PickThings> queryAllByUid(long uid, Integer currentPage,
			Integer pageSize, boolean desc) {
		return pickThingsDao.findAllByUid(uid, currentPage, pageSize, desc);
	}

	// 根据关键字查询所有
	@Override
	public List<PickThings> queryAllByKeywords(String keywords) {
		return pickThingsDao.findAllByKeywords(keywords);
	}
	
	// 根据关键字查询统计数量（分页）
	@Override
	public long queryAllByKeywordsCount(String keywords){
		return pickThingsDao.findAllByKeywordsCount(keywords);
	}

	// 根据关键字查询所有（分页）
	@Override
	public List<PickThings> queryAllByKeywords(String keywords,
			Integer currentPage, Integer pageSize, boolean desc) {
		return pickThingsDao.findAllByKeywords(keywords, currentPage, pageSize,
				desc);
	}

	// 根据类型查询所有（分页）
	@Override
	public List<PickThings> queryAllByThingsType(String type,
			Integer currentPage, Integer pageSize, boolean desc) {
		return pickThingsDao.findAllByThingsType(type, currentPage, pageSize,
				desc);
	}

	// 查询已归还
	@Override
	public long queryByReturnedCount() {
		return pickThingsDao.findByReturnedCount();
	}

	@Override
	public List<PickThings> queryThingsBySuccess(int index) {
		return pickThingsDao.findThingsBySuccess(index);
	}

	//查询一条记录（上一条、下一条）
	@Override
	public PickThings queryOneRecord(long id, boolean isNext) {
		return pickThingsDao.findOneRecord(id, isNext);
	}
}
