package com.lin.lostandfound.services.impl;

import com.lin.lostandfound.common.annotation.DataSource;
import com.lin.lostandfound.common.constants.Constants;
import com.lin.lostandfound.entities.domain.LoginLog;
import com.lin.lostandfound.entities.domain.User;
import com.lin.lostandfound.repositories.dao.IUserDao;
import com.lin.lostandfound.services.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

//@DataSource(name = Constants.RemoteDataSource)
@Service("userService")
public class UserServiceImpl implements IUserService {
	@Autowired
	@Qualifier("userDao")
	private IUserDao userDao;

	@Override
	public boolean addUser(User user) {
		
		return userDao.save(user);
	}

	@Override
	@Transactional
	public boolean addUser(List<User> usersList) {
		
		return userDao.save(usersList);
	}

	@Transactional
	@Override
	public boolean modify(User user) {
		
		return userDao.update(user);
	}

	@Transactional
	@Override
	public boolean modify(List<User> usersList) {
		
		return userDao.update(usersList);
	}

	@Override
	public boolean remove(long userId) {
		
		return userDao.delete(userId);
	}
	
	@Override
	public boolean remove(String userId) {
		String[] id = userId.split(",");
		
		long[] uid = new long[id.length];
		for(int i = 0 ;i < id.length; i++){
			uid[i] = Long.parseLong(id[i]);
		}
		
		return userDao.delete(uid);
	}
	
	// 设置（撤销）管理员
	@Transactional
	@Override
	public boolean adminSetOrCancel(long userId, int state) {
		
		return userDao.adminSetOrCancel(userId, state);
	}
	
	// 批量锁定（解锁）用户
	@Transactional
	@Override
	public boolean lockOrUnlock(String userId, int state) {
		String[] id = userId.split(",");

		long[] uid = new long[id.length];
		for (int i = 0; i < id.length; i++) {
			uid[i] = Long.parseLong(id[i]);
		}

		return userDao.lockOrUnlock(uid, state);
	}

	// 锁定用户
	@Transactional
	@Override
	public boolean lock(long id, int state) {
		
		return userDao.lock(id, state);
	}
	
	// 批量锁定用户
	@Transactional
	@Override
	public boolean lock(String userId, int state) {
		String[] id = userId.split(",");
		
		long[] uid = new long[id.length];
		for(int i = 0 ;i < id.length; i++){
			uid[i] = Long.parseLong(id[i]);
		}
		
		return userDao.lock(uid, state);
	}

	// 解锁用户
	@Transactional
	@Override
	public boolean unlock(long id, int state) {
		
		return userDao.unlock(id, state);
	}
	
	// 批量解锁用户
	@Transactional
	@Override
	public boolean unlock(String userId, int state) {
		String[] id = userId.split(",");
		
		long[] uid = new long[id.length];
		for(int i = 0 ;i < id.length; i++){
			uid[i] = Long.parseLong(id[i]);
		}
		
		return userDao.unlock(uid, state);
	}

	@Override
	public User login(String userName, String password, int authority) {
		
		return userDao.findUserByUserNameAndPassword(userName, password, authority);
	}

	@Override
	public User queryUserById(long id) {
		
		return userDao.findUserById(id);
	}

	// 根据关键字查询所有用户
	@Override
	public List<User> queryAllByKeywords(String keywords, Integer currentPage, Integer pageSize) {
		
		return userDao.findAllByKeywords(keywords, currentPage, pageSize);
	}
	
	// 查询所有统计数量
	@Override
	public long queryAllCount(String key) {
		
		return userDao.findAllCount(key);
	}

	// 查询所有用户
	@Override
	public Map<String, Object> queryAll(String key, Integer pageIndex, Integer pageSize, String sortField, String sortOrder) {
		
		List<User> userList = userDao.findAll(key, pageIndex, pageSize, sortField, sortOrder);

        Map<String, Object> result = new HashMap<String, Object>();
        result.put("data", userList);
        result.put("total",  userDao.findAllCount(key));
		
		return result;
	}

	@Override
	public List<User> queryAll(Integer currentPage, Integer pageSize) {
		
		return userDao.findAll(currentPage, pageSize);
	}
	
	// 保存登录日志信息
	@Override
	public boolean addLoginlog(LoginLog loginLog) {
		
		return userDao.saveLoginlog(loginLog);
	}
	
	// 查询所有统计数量
	public long queryAllLoginlogCount(String key) {
		
		return userDao.findAllLoginlogCount(key);
	}
	
	// 查询所有登录日志信息
	@Override
	public Map<String, Object> queryAllLoginlog(String key, Integer pageIndex, Integer pageSize, String sortField, String sortOrder) {
		
		List<LoginLog> logList = userDao.findAllLoginlog(key, pageIndex, pageSize, sortField, sortOrder);

        Map<String, Object> result = new HashMap<String, Object>();
        result.put("data", logList);
        result.put("total",  userDao.findAllLoginlogCount(key));
		
		return result;
	}
	
	// 根据用户id查询统计所有（分页）
	@Override
	public long queryLoginlogByUidCount(long uid) {
		
		return userDao.findLoginlogByUidCount(uid);
	}
	
	// 根据uid查询登录日志信息
	@Override
	public List<LoginLog> queryLoginlogByUid(long uid, Integer pageIndex, Integer pageSize) {
		
		return userDao.findLoginlogByUid(uid, pageIndex, pageSize);
	}
	
	// 批量删除登录日志信息
	@Override
	public boolean removeLoginlog(String logId) {
		String[] id = logId.split(",");
		
		long[] lid = new long[id.length];
		for(int i = 0 ;i < id.length; i++){
			lid[i] = Long.parseLong(id[i]);
		}
		
		return userDao.deleteLoginlog(lid);
	}

}
