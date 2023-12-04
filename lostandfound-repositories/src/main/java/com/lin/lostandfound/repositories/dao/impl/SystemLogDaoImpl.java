package com.lin.lostandfound.repositories.dao.impl;

import com.lin.lostandfound.repositories.dao.ISystemLogDao;
import com.lin.lostandfound.entities.domain.SystemLog;
import com.lin.lostandfound.common.utils.StringUtil;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("systemLogDao")
public class SystemLogDaoImpl extends BaseDao implements ISystemLogDao {

	// 保存
	@Override
	public boolean svae(SystemLog systemLog) {
		Session session = super.getSession();
		try {
			session.save(systemLog);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	// 批量删除
	@Override
	public boolean delete(long[] logsId) {
		Session session = super.getSession();
		String hql = "delete from SystemLog systemLog where systemLog.id = :lid";
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
			session.flush();
			return true;
		} catch (HibernateException e) {
			e.printStackTrace();
			return false;
		}
	}
	
	// 统计所有（分页）
	@Override
	public long findAllCount(String key) {
		Session session =super.getSession();
		String hql = "select count(*) from SystemLog systemLog where 1 = 1 ";
		if (key != null && key != "")
			hql += "and systemLog.createBy like '%" + key + "%'";

		Query query = session.createQuery(hql);
		
		return (long) query.uniqueResult();
	}
	
	// 查询所有
	@SuppressWarnings("unchecked")
	@Override
	public List<SystemLog> findAll(String key, Integer pageIndex, Integer pageSize, String sortField, String sortOrder) {
		
		Session session = super.getSession();

		String hql = "from SystemLog systemLog where 1 = 1 ";
		if (key != null && key != "")
			hql += "and systemLog.createBy like '%" + key + "%'";

		if (StringUtil.isNullOrEmpty(sortField) == false) {
			if ("desc".equals(sortOrder) == false) {
				sortOrder = "asc";
			}
			hql += " order by " + sortField + " " + sortOrder;
		} else {
			hql += " order by systemLog.createDate desc";
		}

		Query query = session.createQuery(hql);
		query.setFirstResult(pageIndex * pageSize).setMaxResults(pageSize);

		return query.list();
	}
	

}
