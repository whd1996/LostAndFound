package com.lin.lostandfound.repositories.dao.impl;

import com.lin.lostandfound.repositories.dao.INoticeDao;
import com.lin.lostandfound.entities.domain.Notice;
import com.lin.lostandfound.common.utils.StringUtil;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("noticeDao")
public class NoticeDaoImpl extends BaseDao implements INoticeDao {

	@Override
	public boolean save(Notice notice) {
		Session session = super.getSession();
		try {
			session.save(notice);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public boolean updateStatus(Integer id, int status) {
		return false;
	}

	@Override
	public boolean delete(Integer id) {
		Session session = super.getSession();
		String hql = "delete from Notice notice where notice.id =:id";
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		int v = query.executeUpdate();
		if(v > 0)
			return true;
		else
			return false;
	}
	
	// 查询最新一条
	@Override
	public Notice findNewNotice() {
		Session session = super.getSession();
		String hql = "from Notice notice order by notice.publishTime desc";
		Query query = session.createQuery(hql);
		query.setFirstResult(0).setMaxResults(1);

		return (Notice) query.uniqueResult();
	}
	
	@Override
	public long findAllCount(String key) {
		Session session = super.getSession();
		String hql = "select count(*) from Notice notice ";
		if (key != null && key != "")
			hql += "where notice.title like '%" +key+ "%'";

		Query query = session.createQuery(hql);

		return (long) query.uniqueResult();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Notice> findAll(String key, Integer pageIndex,
			Integer pageSize, String sortField, String sortOrder) {
		Session session = super.getSession();
		String hql = "from Notice notice ";
		if (key != null && key != "")
			hql += "where notice.title like '%" +key+ "%'";

		if (StringUtil.isNullOrEmpty(sortField) == false) {
			if ("desc".equals(sortOrder) == false) {
				sortOrder = "asc";
			}
			hql += " order by " + sortField + " " + sortOrder;
		} else {
			hql += " order by notice.publishTime desc";
		}

		Query query = session.createQuery(hql);
		query.setFirstResult(pageIndex * pageSize).setMaxResults(pageSize);
		
		return query.list();
	}

	@Override
	public Notice findById(int id) {
		Session session = super.getSession();
		String hql = "from Notice notice where notice.id =: id";
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		
		return (Notice) query.uniqueResult();
	}

}
