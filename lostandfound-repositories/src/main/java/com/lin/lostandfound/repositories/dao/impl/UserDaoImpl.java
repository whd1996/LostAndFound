package com.lin.lostandfound.repositories.dao.impl;

import com.lin.lostandfound.common.utils.StringUtil;
import com.lin.lostandfound.entities.domain.LoginLog;
import com.lin.lostandfound.entities.domain.User;
import com.lin.lostandfound.repositories.dao.IUserDao;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository("userDao")
public class UserDaoImpl extends BaseDao implements IUserDao {
	
	@Override
	public boolean save(User user) {
		Session session = super.getSession();
		try {
			session.save(user);
			System.out.println("add");
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public boolean save(List<User> usersList) {
		Session session = super.getSession();
		// 批量插入数据
		try {
			for (int i = 0; i < usersList.size(); i++) {
				User user = usersList.get(i);
				session.save(user);
				if (i % 30 == 0) { // 每30条刷新并写入数据库
					session.flush();
					session.clear();
				}
			}
			session.flush();
			return true;
		} catch (HibernateException e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public boolean update(User user) {
		Session session = super.getSession();
		try {
			session.update(user);
			session.flush();
			return true;
		} catch (HibernateException e) {
			e.printStackTrace();
			return false;
		}
	}
	
	@Override
	public boolean update(List<User> usersList) {
		Session session = super.getSession();
		// 批量修改数据
		try {
			for (int i = 0; i < usersList.size(); i++) {
				User user = usersList.get(i);
				session.update(user);
				if (i % 20 == 0) { // 每20条刷新并更新数据库
					session.flush();
					session.clear();
				}
			}
			session.flush();
			return true;
		} catch (HibernateException e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public boolean delete(long userId) {
		Session session = super.getSession();
		String hql = "delete from User u where u.id = :uid";
		Query query = session.createQuery(hql);
		query.setParameter("uid", userId);
		int v = query.executeUpdate();
		if(v > 0)
			return true;
		else
			return false;
	}

	@Override
	public boolean delete(long[] usersId) {
		Session session = super.getSession();
		String hql = "delete from User u where u.id = :uid";
		Query query = session.createQuery(hql);
		// 批量删除数据
		try {
			for (int i = 0; i < usersId.length; i++) {
				Long uid = usersId[i];
				query.setParameter("uid", uid);
				query.executeUpdate();
				if (i % 20 == 0) { // 每20条刷新并删除
					session.flush();
					session.clear();
				}
			}
			session.flush();
			return true;
		} catch (HibernateException e) {
			e.printStackTrace();
			return false;
		}
	}
	
	// 设置（撤销）管理员
	@Override
	public boolean adminSetOrCancel(long usersId, int state) {
		Session session = super.getSession();
		String hql = "update User u set u.state =:state where u.id = :uid";
		Query query = session.createQuery(hql);
		query.setParameter("state", state);
		query.setParameter("uid", usersId);
		int count = query.executeUpdate();
		if(count > 0)
			return true;
		else
			return false;
	}
	
	// 批量锁定（解锁）用户
	@Override
	public boolean lockOrUnlock(long[] usersId, int state) {
		Session session = super.getSession();
		String hql = "update User u set u.state =:state where u.id = :uid";
		Query query = session.createQuery(hql);
		// 批量处理数据
		try {
			for (int i = 0; i < usersId.length; i++) {
				Long uid = usersId[i];
				query.setParameter("state", state);
				query.setParameter("uid", uid);
				query.executeUpdate();
				if (i % 20 == 0) { // 每20条刷新
					session.flush();
					session.clear();
				}
			}
			session.flush();
			return true;
		} catch (HibernateException e) {
			e.printStackTrace();
			return false;
		}
	}

	// 锁定用户
	@Override
	public boolean lock(long id, int state) {
		Session session = super.getSession();
		String hql = "update User u set u.state =:state where u.id = :uid";
		Query query = session.createQuery(hql);
		query.setParameter("state", state);
		query.setParameter("uid", id);
		int count = query.executeUpdate();
		if(count > 0)
			return true;
		else
			return false;
		
	}
	
	// 批量锁定用户
	@Override
	public boolean lock(long[] usersId, int state) {
		Session session = super.getSession();
		String hql = "update User u set u.state =:state where u.id = :uid";
		Query query = session.createQuery(hql);
		// 批量处理数据
		try {
			for (int i = 0; i < usersId.length; i++) {
				Long uid = usersId[i];
				query.setParameter("state", state);
				query.setParameter("uid", uid);
				query.executeUpdate();
				if (i % 20 == 0) { // 每20条刷新
					session.flush();
					session.clear();
				}
			}
			session.flush();
			return true;
		} catch (HibernateException e) {
			e.printStackTrace();
			return false;
		}
	}

	// 解锁用户
	@Override
	public boolean unlock(long id, int state) {
		Session session = super.getSession();
		String hql = "update User u set u.state =:state where u.id = :uid";
		Query query = session.createQuery(hql);
		query.setParameter("state", state);
		query.setParameter("uid", id);
		int count = query.executeUpdate();
		if(count > 0)
			return true;
		else
			return false;
		
	}
	
	// 批量解锁用户
	@Override
	public boolean unlock(long[] usersId, int state) {
		Session session = super.getSession();
		String hql = "update User u set u.state =:state where u.id = :uid";
		Query query = session.createQuery(hql);
		// 批量处理数据
		try {
			for (int i = 0; i < usersId.length; i++) {
				Long uid = usersId[i];
				query.setParameter("state", state);
				query.setParameter("uid", uid);
				query.executeUpdate();
				if (i % 20 == 0) { // 每20条刷新并删除
					session.flush();
					session.clear();
				}
			}
			session.flush();
			return true;
		} catch (HibernateException e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public User findUserByUserNameAndPassword(String userName, String password, int authority) {
		String hql = "from User u where u.userName = :userName and u.password = :password and u.state >= :authority";

		Query query = super.getSession().createQuery(hql);
		query.setParameter("userName", userName);
		query.setParameter("password", password);
		query.setParameter("authority", authority);

		return (User) query.uniqueResult();
	}

	@Override
	public User findUserById(long id) {
		Session session = super.getSession();
		String hql = "from User u where u.id = :uid";

		Query query = session.createQuery(hql);
		query.setParameter("uid", id);
		return (User) query.uniqueResult();
	}

	// 根据关键字查询所有用户（分页）
	@SuppressWarnings("unchecked")
	public List<User> findAllByKeywords(String keywords, Integer currentPage,
			Integer pageSize) {

		String hql = "from User u";
		if (keywords != null && keywords.length() > 0) {
			hql += "where u.userName like '%" + keywords + "%'";
		}

		Query query = super.getSession().createQuery(hql);
		// setFirstResult 设置第一条显示的位置，setMaxResults ，设置这一次显示多少条
		return query.setFirstResult((currentPage - 1) * pageSize)
				.setMaxResults(pageSize).list();
	}
	
	// 统计所有（分页）
	@Override
	public long findAllCount(String key) {
		Session session =super.getSession();
		String hql = "select count(*) from User u where u.state != 3 ";
		if (key != null && key != "")
			hql += "and (u.userName like '%" + key + "%' or u.grade like '%" + key + "%' or u.name like '%" + key + "%')";

		Query query = session.createQuery(hql);
		
		return (long) query.uniqueResult();
	}

	// 查询所有用户（分页）
	@SuppressWarnings("unchecked")
	@Override
	public List<User> findAll(String key, Integer pageIndex,
			Integer pageSize, String sortField, String sortOrder) {
		Session session = super.getSession();

		String hql = "from User u where u.state != 3 ";
		if (key != null && key != "")
			hql += "and (u.userName like '%" + key + "%' or u.grade like '%" + key + "%' or u.name like '%" + key + "%')";

		if (StringUtil.isNullOrEmpty(sortField) == false) {
			if ("desc".equals(sortOrder) == false) {
				sortOrder = "asc";
			}
			hql += " order by " + sortField + " " + sortOrder;
		} else {
			hql += " order by u.createTime desc";
		}

		Query query = session.createQuery(hql);
		query.setFirstResult(pageIndex * pageSize).setMaxResults(pageSize);

		return query.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<User> findAll(Integer currentPage, Integer pageSize) {
		String hql = "from User u";

		Query query = super.getSession().createQuery(hql);
		// setFirstResult 设置第一条显示的位置，setMaxResults ，设置这一次显示多少条
		return query.setFirstResult((currentPage - 1) * pageSize).setMaxResults(pageSize).list();
	}
	
	// 保存登录日志信息
	@Override
	public boolean saveLoginlog(LoginLog loginLog) {
		Session session = super.getSession();
		try {
			session.save(loginLog);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	// 查询所有登录日志信息
	@Override
	public long findAllLoginlogCount(String key) {
		Session session = super.getSession();
		String hql = "select count(*) from LoginLog log ";
		
		if (key != null && key != "")
			hql += " where log.userName like '%" + key + "%'";

		Query query = session.createQuery(hql);
		
		return (long) query.uniqueResult();
	}
	
	// 查询所有登录日志信息
	@SuppressWarnings("unchecked")
	@Override
	public List<LoginLog> findAllLoginlog(String key, Integer pageIndex,
			Integer pageSize, String sortField, String sortOrder) {
		Session session = super.getSession();
		String hql = "from LoginLog log ";
		
		if (key != null && key != "")
			hql += " where log.userName like '%" + key + "%'";

		if (StringUtil.isNullOrEmpty(sortField) == false) {
			if ("desc".equals(sortOrder) == false) {
				sortOrder = "asc";
			}
			hql += " order by " + sortField + " " + sortOrder;
		} else {
			hql += " order by log.loginTime desc";
		}
		Query query = session.createQuery(hql);
		query.setFirstResult(pageIndex * pageSize).setMaxResults(pageSize);
		
		return query.list();
	}
	
	// 根据用户id查询统计所有（分页）
	@Override
	public long findLoginlogByUidCount(long uid) {
		Session session = super.getSession();
		String hql = "select count(*) from LoginLog log where log.uid = :uid";
		Query query =session.createQuery(hql);
		query.setParameter("uid", uid);
		
		return (long) query.uniqueResult();
	}
	
	// 根据uid查询登录日志信息（分页）
	@SuppressWarnings("unchecked")
	@Override
	public List<LoginLog> findLoginlogByUid(long uid, Integer pageIndex, Integer pageSize) {
		Session session = super.getSession();
		String hql = "from LoginLog log where log.uid = :uid";
		Query query =session.createQuery(hql);
		query.setParameter("uid", uid);
		
		return query.setFirstResult((pageIndex - 1) * pageSize).setMaxResults(pageSize).list();
	}
	
	// 批量删除登录日志信息
	@Override
	public boolean deleteLoginlog(long[] logsId) {
		Session session = super.getSession();
		String hql = "delete from LoginLog log where log.id = :lid";
		Query query = session.createQuery(hql);
		// 批量删除数据
		try {
			for (int i = 0; i < logsId.length; i++) {
				Long lid = logsId[i];
				query.setParameter("lid", lid);
				query.executeUpdate();
				if (i % 20 == 0) { // 每20条刷新并删除
					session.flush();
					session.clear();
				}
			}
			return true;
		} catch (HibernateException e) {
			e.printStackTrace();
			return false;
		}
	}

}
