package com.lin.lostandfound.repositories.dao.impl;

import com.lin.lostandfound.common.utils.StringUtil;
import com.lin.lostandfound.entities.domain.PickThings;
import com.lin.lostandfound.repositories.dao.IPickThingsDao;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("pickThingsDao")
public class PickThingsDaoImpl extends BaseDao implements IPickThingsDao {

	// 保存
	@Override
	public boolean save(PickThings pickThings) {
		Session session = super.getSession();
		try {
			session.save(pickThings);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// 批量更新状态
	@Override
	public boolean updateStatus(long[] picksId, int status) {
		Session session = super.getSession();
		String hql = "update PickThings pick set pick.status = :status where pick.id = :pid";
		Query query = session.createQuery(hql);
		// 批量更新数据
		try {
			for (int i = 0; i < picksId.length; i++) {
				long pid = picksId[i];
				query.setParameter("status", status);
				query.setParameter("pid", pid);
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
	public boolean updateStatus(long pickId, int status) {
		Session session = super.getSession();
		String hql = "update PickThings pick set pick.status = :status where pick.id = :pickId";
		Query query = session.createQuery(hql);
		query.setParameter("status", status);
		query.setParameter("pickId", pickId);
		int count = query.executeUpdate();
		if(count > 0)
			return true;
		else
			return false;
	}

	// 删除
	@Override
	public boolean delete(long[] picksId) {
		Session session = super.getSession();
		String hql = "delete from PickThings pick where pick.id = :pid";
		Query query = session.createQuery(hql);
		// 批量删除数据
		try {
			for (int i = 0; i < picksId.length; i++) {
				long pid = picksId[i];
				query.setParameter("pid", pid);
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

	// 查询所有统计数量（后台admin）
	@Override
	public long findAllCount(String key) {
		Session session = super.getSession();
		String hql = "select count(*) from PickThings pick ";
		if (key != null && key != "")
			hql += "where pick.thingsName like '%" + key
					+ "%' or pick.thingsType like '%" + key + "%' or pick.userName like '%" + key + "%'";

		Query query = session.createQuery(hql);
		
		return (long) query.uniqueResult();
	}

	// 查询所有（后台admin）
	@SuppressWarnings("unchecked")
	@Override
	public List<PickThings> findAll(String key, Integer pageIndex,
			Integer pageSize, String sortField, String sortOrder) {
		Session session = super.getSession();
		String hql = "from PickThings pick ";
		if (key != null && key != "")
			hql += "where pick.thingsName like '%" + key
					+ "%' or pick.thingsType like '%" + key + "%' or pick.userName like '%" + key + "%'";

		if (StringUtil.isNullOrEmpty(sortField) == false) {
			if ("desc".equals(sortOrder) == false) {
				sortOrder = "asc";
			}
			hql += " order by " + sortField + " " + sortOrder;
		} else {
			hql += " order by pick.publishTime desc";
		}

		Query query = session.createQuery(hql);
		query.setFirstResult(pageIndex * pageSize).setMaxResults(pageSize);
		return query.list();
	}

	// 查询所有（分页）
	@SuppressWarnings("unchecked")
	@Override
	public List<PickThings> findAll(Integer currentPage, Integer pageSize,
			boolean desc) {
		Session session = super.getSession();
		String hql = "from PickThings pick where pick.status != 2 ";
		// 降序
		if (desc)
			hql += "order by pick.id desc";

		Query query = session.createQuery(hql);
		query.setFirstResult((currentPage - 1) * pageSize).setMaxResults(
				pageSize);

		return query.list();
	}

	// 根据id查询
	@Override
	public PickThings findById(long id) {
		Session session = super.getSession();
		String hql = "from PickThings pick where pick.id = :id";
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		
		return (PickThings) query.uniqueResult();
	}

	// 根据用户id查询所有
	@Override
	public List<PickThings> findAllByUid(long uid) {
		return null;
	}

	// 根据类型查询数量
	@Override
	public long findByType(String type) {
		Session session = super.getSession();
		String hql = "select count(*) from PickThings pick where pick.status != 2 ";
		boolean falg = false;
		// 降序
		if (type != null && !"".equals(type.trim())
				&& !"all".equals(type.trim())) {
			falg = true;
			hql += "and pick.thingsType = :type";
		}

		Query query = session.createQuery(hql);
		if (falg)
			query.setParameter("type", type);

		return (long) query.uniqueResult();
	}
	
	// 根据用户id查询统计所有（分页）
	@Override
	public long findAllByUidCount(long uid) {
		Session session = super.getSession();
		String hql = "select count(*) from PickThings pick where pick.uid = :uid and pick.status != 2 ";
		Query query = session.createQuery(hql);
		query.setParameter("uid", uid);
		
		return (long) query.uniqueResult();
	}

	// 根据用户id查询所有（分页）
	@SuppressWarnings("unchecked")
	@Override
	public List<PickThings> findAllByUid(long uid, Integer currentPage,
			Integer pageSize, boolean desc) {
		Session session = super.getSession();
		String hql = "from PickThings pick where pick.uid = :uid and pick.status != 2 ";
		// 降序
		if (desc)
			hql += "order by pick.id desc";

		Query query = session.createQuery(hql);
		query.setParameter("uid", uid);
		query.setFirstResult((currentPage - 1) * pageSize).setMaxResults(
				pageSize);

		return query.list();
	}

	// 根据关键字查询所有
	@Override
	public List<PickThings> findAllByKeywords(String keywords) {
		return null;
	}
	
	// 根据关键字查询统计数量（分页）
	@Override
	public long findAllByKeywordsCount(String keywords) {
		Session session = super.getSession();
		String hql = "select count(*) from PickThings pick where pick.status != 2 ";
		if (keywords != null && keywords.length() > 0)
			hql += "and pick.thingsName like '%" + keywords + "%' ";
		
		Query query = session.createQuery(hql);

		return (long) query.uniqueResult();
	}

	// 根据关键字查询所有（分页）
	@SuppressWarnings("unchecked")
	@Override
	public List<PickThings> findAllByKeywords(String keywords,
			Integer currentPage, Integer pageSize, boolean desc) {
		Session session = super.getSession();
		StringBuffer hql = new StringBuffer(
				"from PickThings pick where pick.status != 2 ");
		if (keywords != null && !keywords.isEmpty()){
			hql.append("and pick.thingsName like '%").append(keywords).append("%' ");
			hql.append("or  pick.publishTime like '%").append(keywords).append("%' ");
			hql.append("or  pick.pickTime like '%").append(keywords).append("%' ");
		}
		// 降序
		if (desc)
			hql.append("order by pick.id desc");

		Query query = session.createQuery(hql.toString());
		query.setFirstResult((currentPage - 1) * pageSize).setMaxResults(
				pageSize);

		return query.list();
	}

	// 根据类型查询所有（分页）
	@SuppressWarnings("unchecked")
	@Override
	public List<PickThings> findAllByThingsType(String type,
			Integer currentPage, Integer pageSize, boolean desc) {
		Session session = super.getSession();
		StringBuffer hql = new StringBuffer(
				"from PickThings pick where pick.status != 2 ");
		boolean flag = false;
		if (type != null && !"".equals(type.trim())
				&& !"all".equals(type.trim())) {
			flag = true;
			hql.append("and pick.thingsType = :type ");
		}

		// 降序
		if (desc)
			hql.append("order by pick.id desc");

		Query query = session.createQuery(hql.toString());
		if (flag)
			query.setParameter("type", type);

		query.setFirstResult((currentPage - 1) * pageSize).setMaxResults(
				pageSize);

		return query.list();
	}

	// 查询已经归还
	@Override
	public long findByReturnedCount() {
		Session session = this.getSession();
		String hql = "select count(*) from PickThings pick where pick.status = 1 ";
		Query query = session.createQuery(hql);
		return (long) query.uniqueResult();
	}

	// 查询已成功贴的信息
	@SuppressWarnings("unchecked")
	@Override
	public List<PickThings> findThingsBySuccess(int index) {
		Session session = this.getSession();
		String hql = "from PickThings pick where pick.status = 1 order by pick.id desc ";
		Query query = session.createQuery(hql);
		return query.setFirstResult(0).setMaxResults(index).list();
	}

	//查询一条记录（上一条、下一条）
	@Override
	public PickThings findOneRecord(long id, boolean isNext) {
		Session session = this.getSession();
		// 选择下一行（上一贴）
		String hql = "from PickThings pick where pick.status !=2 and pick.status !=3 and pick.id > :id  order by pick.id asc";
		if(isNext)
			// 选择上一行（下一贴）
			hql = "from PickThings pick where pick.status !=2 and pick.status !=3 and pick.id < :id  order by pick.id desc";

		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		query.setMaxResults(1);
		
		return (PickThings) query.uniqueResult();
	}

}
