package com.lin.lostandfound.repositories.dao;

import com.lin.lostandfound.entities.domain.LoginLog;
import com.lin.lostandfound.entities.domain.User;

import java.util.List;

public interface IUserDao {

	// 保存
	public boolean save(User user);

	// 批量保存
	public boolean save(List<User> usersList);

	// 更新
	public boolean update(User user);
	
	// 批量更新
	public boolean update(List<User> usersList);

	// 删除
	public boolean delete(long userId);

	// 批量删除
	public boolean delete(long[] usersId);
	
	// 设置（撤销）管理员
	public boolean adminSetOrCancel(long usersId, int state);
	
	// 批量锁定（解锁）用户
	public boolean lockOrUnlock(long[] usersId, int state);

	// 锁定用户
	public boolean lock(long id, int state);
	
	// 批量锁定用户
	public boolean lock(long[] usersId, int state);

	// 解锁用户
	public boolean unlock(long id, int state);
	
	// 批量解锁用户
	public boolean unlock(long[] usersId, int state);

	// 根据用户名和密码查询用户
	public User findUserByUserNameAndPassword(String userName, String password, int authority);

	// 根据用户ID查询用户
	public User findUserById(long id);

	// 根据关键字查询所有用户
	public List<User> findAllByKeywords(String keywords, Integer currentPage, Integer pageSize);
	
	// 统计所有（分页）
	public long findAllCount(final String key);
	
	// 查询所有用户（分页）
	public List<User> findAll(String key, Integer pageIndex, Integer pageSize, String sortField, String sortOrder);

	// 查询所有用户 （分页）
	public List<User> findAll(Integer currentPage, Integer pageSize);
	
	// 保存登录日志信息
	public boolean saveLoginlog(LoginLog loginLog);
	
	// 查询所有登录日志信息（统计）
	public long findAllLoginlogCount(String key);
	
	// 查询所有登录日志信息
	public List<LoginLog> findAllLoginlog(String key, Integer pageIndex, Integer pageSize, String sortField, String sortOrder);
	
	// 根据用户id查询统计所有（分页）
	public long findLoginlogByUidCount(long uid);
	
	// 根据uid查询登录日志信息
	public List<LoginLog> findLoginlogByUid(long uid, Integer pageIndex, Integer pageSize);
	
	// 批量删除登录日志信息
	public boolean deleteLoginlog(long[] logsId);
	

}
