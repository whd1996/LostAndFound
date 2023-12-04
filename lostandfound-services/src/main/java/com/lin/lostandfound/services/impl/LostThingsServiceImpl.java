package com.lin.lostandfound.services.impl;

import com.lin.lostandfound.common.annotation.SystemServiceLog;
import com.lin.lostandfound.repositories.dao.ILostThingsDao;
import com.lin.lostandfound.entities.domain.LostThings;
import com.lin.lostandfound.services.ILostThingsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("lostThingsService")
public class LostThingsServiceImpl implements ILostThingsService {
	@Autowired
	@Qualifier("lostThingsDao")
	private ILostThingsDao lostThingsDao;

	// 添加
	@SystemServiceLog(description = "添加寻物贴")
	@Override
	public boolean add(LostThings lostThings) {
		return lostThingsDao.save(lostThings);
	}

	// 批量修改状态
	@Override
	public boolean modifyStatus(String lostId, int status) {
		String[] id = lostId.split(",");

		long[] lostsId = new long[id.length];
		for (int i = 0; i < id.length; i++) {
			lostsId[i] = Long.parseLong(id[i]);
		}
		return lostThingsDao.updateStatus(lostsId, status);
	}
	
	// 修改状态
	@Transactional
	@Override
	public boolean modifyStatus(long lostId, int status) {
		return lostThingsDao.updateStatus(lostId, status);
	}

	// 批量删除
	@SystemServiceLog(description = "批量删除寻物贴")
	@Override
	public boolean remove(String lostId) {
		String[] id = lostId.split(",");
		
		long[] lostsId = new long[id.length];
		for(int i = 0 ;i < id.length; i++){
			lostsId[i] = Long.parseLong(id[i]);
		}
		return lostThingsDao.delete(lostsId);
	}

	// 查询所有统计数量
	@Override
	public long queryAllCount(String key) {
		return lostThingsDao.findAllCount(key);
	}
	
	// 查询所有
	@Override
	public Map<String, Object> queryAll(String key, Integer pageIndex,
			Integer pageSize, String sortField, String sortOrder) {
		List<LostThings> lostThingsList = lostThingsDao.findAll(key, pageIndex, pageSize, sortField, sortOrder);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("data", lostThingsList);
		resultMap.put("total", lostThingsDao.findAllCount(key));
		
		return resultMap;
	}

	// 查询所有（分页）
	@Override
	public List<LostThings> queryAll(Integer currentPage, Integer pageSize,
			boolean desc) {
		return lostThingsDao.findAll(currentPage, pageSize, desc);
	}

	// 根据id查询
	@Override
	public LostThings queryById(long id) {
		return lostThingsDao.findById(id);
	}

	// 根据用户id查询所有
	@Override
	public List<LostThings> queryAllByUid(long uid) {
		return null;
	}

	// 根据类型查询数量
	@Override
	public long queryByType(String type) {
		return lostThingsDao.findByType(type);
	}
	
	// 根据用户id查询统计所有（分页）
	@Override
	public long queryAllByUidCount(long uid) {
		return lostThingsDao.findAllByUidCount(uid);
	}

	// 根据用户id查询所有（分页）
	@Override
	public List<LostThings> queryAllByUid(long uid, Integer currentPage,
			Integer pageSize, boolean desc) {
		return lostThingsDao.findAllByUid(uid, currentPage, pageSize, desc);
	}

	// 根据关键字查询所有
	@Override
	public List<LostThings> queryAllByKeywords(String keywords) {
		return null;
	}
	
	// 根据关键字查询统计数量（分页）
	@Override
	public long queryAllByKeywordsCount(String keywords){
		return lostThingsDao.findAllByKeywordsCount(keywords);
	}

	// 根据关键字查询所有（分页）
	@Override
	public List<LostThings> queryAllByKeywords(String keywords,
			Integer currentPage, Integer pageSize, boolean desc) {
		return lostThingsDao.findAllByKeywords(keywords, currentPage, pageSize,
				desc);
	}

	// 根据类型查询所有（分页）
	@Override
	public List<LostThings> queryAllByThingsType(String type,
			Integer currentPage, Integer pageSize, boolean desc) {
		return lostThingsDao.findAllByThingsType(type, currentPage, pageSize,
				desc);
	}

	// 查询已找到
	@Override
	public long queryByFoundCount() {
		return lostThingsDao.findByFoundCount();
	}
	
	// 查询已成功贴的信息
	@Override
	public List<LostThings> queryThingsBySuccess(int index) {
		return lostThingsDao.findThingsBySuccess(index);
	}
	
	//查询一条记录（上一条、下一条）
	@Override
	public LostThings queryOneRecord(long id, boolean isNext) {
		return lostThingsDao.findOneRecord(id, isNext);
	}

}
