package com.lin.lostandfound.services.impl;

import com.lin.lostandfound.common.annotation.SystemServiceLog;
import com.lin.lostandfound.entities.domain.ExpressThanks;
import com.lin.lostandfound.repositories.dao.IExpressThanksDao;
import com.lin.lostandfound.repositories.dao.impl.BaseDao;
import com.lin.lostandfound.services.IExpressThanksService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

//@DataSource(name = Constants.RemoteDataSource)
@Service("expressThanksService")
public class ExpressThanksServiceImpl extends BaseDao implements IExpressThanksService {
	
	@Autowired
	@Qualifier("expressThanksDao")
	private IExpressThanksDao expressThanksDao;

	// 添加
	@SystemServiceLog(description = "添加感谢信息")
	@Override
	public boolean add(ExpressThanks expressThanks) {
		
		return expressThanksDao.save(expressThanks);
	}

	// 批量修改状态
	@Transactional
	@Override
	public boolean modifyStatus(String thanksId, int status) {
		String[] id = thanksId.split(",");

		long[] tId = new long[id.length];
		for (int i = 0; i < id.length; i++) {
			tId[i] = Long.parseLong(id[i]);
		}

		return expressThanksDao.updateStatus(tId, status);
	}

	// 修改状态
	@Transactional
	@Override
	public boolean modifyStatus(long thanksId, int status) {
		
		return expressThanksDao.updateStatus(thanksId, status);
	}

	// 删除
	@SystemServiceLog(description = "批量删除感谢信息")
	@Override
	public boolean remove(String thanksId) {
		String[] id = thanksId.split(",");
		
		long[] tId = new long[id.length];
		for(int i = 0 ;i < id.length; i++){
			tId[i] = Long.parseLong(id[i]);
		}
		
		return expressThanksDao.delete(tId);
	}

	// 查询所有统计数量
	@Override
	public long queryAllCount(String key) {
		
		return expressThanksDao.findAllCount(key);
	}

	// 查询所有
	@Override
	public Map<String, Object> queryAll(String key, Integer pageIndex, Integer pageSize, String sortField, String sortOrder) {
		List<ExpressThanks> expressThanksList = expressThanksDao.findAll(key, pageIndex, pageSize, sortField, sortOrder);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("data", expressThanksList);
		resultMap.put("total", expressThanksDao.findAllCount(key));
		
		return resultMap;
	}

	// 根据id查询
	@Override
	public ExpressThanks queryById(long id) {

		return expressThanksDao.findById(id);
	}

}
