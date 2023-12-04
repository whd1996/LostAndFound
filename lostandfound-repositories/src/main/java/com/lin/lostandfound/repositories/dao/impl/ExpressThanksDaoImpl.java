package com.lin.lostandfound.repositories.dao.impl;

import com.lin.lostandfound.common.utils.StringUtil;
import com.lin.lostandfound.entities.domain.ExpressThanks;
import com.lin.lostandfound.repositories.dao.IExpressThanksDao;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("expressThanksDao")
public class ExpressThanksDaoImpl extends BaseDao implements IExpressThanksDao {

	// 保存
	@Override
	public boolean save(ExpressThanks expressThanks) {
		Session session = super.getSession();
		try {
			session.save(expressThanks);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// 批量更新状态
	@Override
	public boolean updateStatus(long[] thanksId, int status) {
		Session session = super.getSession();
		String hql = "update ExpressThanks thanks set thanks.status = :status where thanks.id = :tid";
		Query query = session.createQuery(hql);
		// 批量更新数据
		try {
			for (int i = 0; i < thanksId.length; i++) {
				long tid = thanksId[i];
				query.setParameter("status", status);
				query.setParameter("tid", tid);
				query.executeUpdate();
				if (i % 20 == 0) { // 每20条刷新并更新
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

	// 更新状态
	@Override
	public boolean updateStatus(long thanksId, int status) {
		Session session = super.getSession();
		String hql = "update ExpressThanks thanks set thanks.status = :status where thanks.id = :thanksId";
		Query query = session.createQuery(hql);
		query.setParameter("status", status);
		query.setParameter("thanksId", thanksId);
		int count = query.executeUpdate();
		if(count > 0)
			return true;
		else
			return false;
	}

	// 删除
	@Override
	public boolean delete(long[] thanksId) {
		Session session = super.getSession();
		String hql = "delete from ExpressThanks thanks where thanks.id = :tid";
		Query query = session.createQuery(hql);
		// 批量删除数据
		try {
			for (int i = 0; i < thanksId.length; i++) {
				long tid = thanksId[i];
				query.setParameter("tid", tid);
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

	// 查询所有统计数量
	@Override
	public long findAllCount(String key) {
		Session session = super.getSession();
		String hql = "select count(*) from ExpressThanks thanks ";
		if (key != null && key != "")
			hql += "where thanks.title like '%" + key + "%' or thanks.userName like '%" + key + "%'";

		Query query = session.createQuery(hql);
		
		return (long) query.uniqueResult();
	}

	// 查询所有
	@SuppressWarnings("unchecked")
	@Override
	public List<ExpressThanks> findAll(String key, Integer pageIndex,
			Integer pageSize, String sortField, String sortOrder) {
		Session session = super.getSession();
		String hql = "from ExpressThanks thanks ";
		if (key != null && key != "")
			hql += "where thanks.title like '%" + key + "%'  or thanks.userName like '%" + key + "%'";

		if (StringUtil.isNullOrEmpty(sortField) == false) {
			if ("desc".equals(sortOrder) == false) {
				sortOrder = "asc";
			}
			hql += " order by " + sortField + " " + sortOrder;
		} else {
			hql += " order by thanks.leaveTime desc";
		}

		Query query = session.createQuery(hql);
		query.setFirstResult(pageIndex * pageSize).setMaxResults(pageSize);
		return query.list();
	}

	// 根据id查询
	@Override
	public ExpressThanks findById(long id) {
		Session session = super.getSession();
		String hql = "from ExpressThanks thanks where thanks.id = :id";
		Query query = session.createQuery(hql);
		query.setParameter("id", id);

		return (ExpressThanks) query.uniqueResult();
	}

}
