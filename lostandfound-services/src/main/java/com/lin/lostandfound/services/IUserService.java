package com.lin.lostandfound.services;

import com.lin.lostandfound.entities.domain.LoginLog;
import com.lin.lostandfound.entities.domain.User;

import java.util.List;
import java.util.Map;

public interface IUserService {
	// 添加用户
	public boolean addUser(User user);

	// 批量添加用户
	public boolean addUser(List<User> usersList);

	// 修改
	public boolean modify(User user);
	
	// 批量修改
	public boolean modify(List<User> usersList);

	// 删除
	public boolean remove(long userId);

	// 批量删除
	public boolean remove(String userId);

	// 设置（撤销）管理员
	public boolean adminSetOrCancel(long userId, int state);
	
	// 批量锁定（解锁）用户
	public boolean lockOrUnlock(String userId, int state);
		
	// 锁定用户
	public boolean lock(long id, int state);
	
	// 批量锁定用户
	public boolean lock(String userId, int state);

	// 解锁用户
	public boolean unlock(long id, int state);
	
	// 批量解锁用户
	public boolean unlock(String userId, int state);

	// 登录
	public User login(String userName, String password, int authority);

	// 根据用户ID查询用户
	public User queryUserById(long id);

	// 根据关键字查询所有用户
	public List<User> queryAllByKeywords(String keywords,
                                         Integer currentPage, Integer pageSize);
	
	// 查询所有统计数量
	public long queryAllCount(String key);

	// 查询所有用户
	public Map<String, Object> queryAll(String key, Integer pageIndex, Integer pageSize, String sortField, String sortOrder);

	// 查询所有用户 （分页）
	public List<User> queryAll(Integer currentPage, Integer pageSize);
	
	// 保存登录日志信息
	public boolean addLoginlog(LoginLog loginLog);
	
	// 查询所有统计数量
	public long queryAllLoginlogCount(String key);
	
	// 查询所有登录日志信息
	public Map<String, Object> queryAllLoginlog(String key, Integer pageIndex, Integer pageSize, String sortField, String sortOrder);

	// 根据用户id查询统计所有（分页）
	public long queryLoginlogByUidCount(long uid);
		
	// 根据uid查询登录日志信息
	public List<LoginLog> queryLoginlogByUid(long uid, Integer pageIndex, Integer pageSize);
	
	// 批量删除登录日志信息
	public boolean removeLoginlog(String logId);
}
