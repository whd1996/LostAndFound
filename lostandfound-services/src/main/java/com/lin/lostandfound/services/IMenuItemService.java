package com.lin.lostandfound.services;

import com.lin.lostandfound.entities.domain.MenuItem;

import java.util.List;

public interface IMenuItemService {
	
	// 添加
	public boolean add(MenuItem menuItem);

	// 修改状态
	public boolean modifyStatus(Integer id, int status);
	
	// 修改权限
	public boolean modifyAuthority(Integer id, int authority);

	// 删除
	public boolean remove(Integer id);
	
	// 根据主键id查询
	public MenuItem queryById(Integer id);
	
	// 根据菜单id查询
	public MenuItem queryByMenuId(String menuId);
	
	// 根据父菜单id查询
	public List<MenuItem> queryAllByParentId(String parentId);

	// 查询所有
	public List<MenuItem> queryAll();
	
	// 根据权限查询所有
	public List<MenuItem> queryAll(int authority);



}
