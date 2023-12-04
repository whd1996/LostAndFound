package com.lin.lostandfound.repositories.dao.impl;

import com.lin.lostandfound.repositories.dao.IMenuItenDao;
import com.lin.lostandfound.entities.domain.MenuItem;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("menuItemDao")
public class MenuItemDaoImpl extends BaseDao implements IMenuItenDao {

	@Override
	public boolean save(MenuItem menuItem) {
		Session session = super.getSession();
		try {
			session.save(menuItem);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public boolean updateStatus(Integer id, int status) {
		Session session = super.getSession();
		String hql = "update MenuItem menu set menu.status =: status where menu.id =: id";
		Query query = session.createQuery(hql);
		query.setParameter("status", status);
		query.setParameter("id", id);
		
		int count = query.executeUpdate();
		if(count > 0)
			return true;
		else
			return false;
	}
	
	@Override
	public boolean updateAuthority(Integer id, int authority) {
		Session session = super.getSession();
		String hql = "update MenuItem menu set menu.authority =: authority where menu.id =: id";
		Query query = session.createQuery(hql);
		query.setParameter("authority", authority);
		query.setParameter("id", id);
		
		int count = query.executeUpdate();
		if(count > 0)
			return true;
		else
			return false;
	}

	@Override
	public boolean delete(Integer id) {
		return false;
	}
	
	// 根据主键id查询
	@Override
	public MenuItem findById(Integer id) {
		Session session = super.getSession();
		String hql = "from MenuItem menu  where menu.id =: id and menu.status = 1 order by menu.sort";
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		
		return (MenuItem) query.uniqueResult();
	}
	
	// 根据菜单id查询
	@Override
	public MenuItem findByMenuId(String menuId) {
		Session session = super.getSession();
		String hql = "from MenuItem menu  where menuId =: menuId and menu.status = 1 order by menu.sort";
		Query query = session.createQuery(hql);
		query.setParameter("menuId", menuId);
		
		return (MenuItem) query.uniqueResult();
	}
	
	// 根据父菜单id查询
	@SuppressWarnings("unchecked")
	@Override
	public List<MenuItem> findAllByParentId(String parentId) {
		Session session = super.getSession();
		String hql = "from MenuItem menu  where menu.parentId =: parentId and menu.status = 1 order by menu.sort";
		Query query = session.createQuery(hql);
		query.setParameter("parentId", parentId);
		
		return query.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<MenuItem> findAll() {
		Session session = super.getSession();
		String hql = "from MenuItem menu order by menu.sort";
		Query query = session.createQuery(hql);
		
		return query.list();
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<MenuItem> findAll(int authority) {
		Session session = super.getSession();
		//String hql = "select new MenuItem(menuId, menuItemName, menuItemUrl, parentId, status, menuItemDes, authority, sort) from MenuItem menu  where menu.status = 1 and menu.authority <= :authority order by menu.sort";
		String hql = "from MenuItem menu where menu.status = 1 and menu.authority <= :authority order by menu.sort";
		Query query = session.createQuery(hql);
		query.setParameter("authority", authority);
		
		return query.list();
	}
}
