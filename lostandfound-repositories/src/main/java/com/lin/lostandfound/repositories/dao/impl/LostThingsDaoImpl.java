package com.lin.lostandfound.repositories.dao.impl;

import com.lin.lostandfound.repositories.dao.ILostThingsDao;
import com.lin.lostandfound.entities.domain.LostThings;
import com.lin.lostandfound.common.utils.StringUtil;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("lostThingsDao")
public class LostThingsDaoImpl extends BaseDao implements ILostThingsDao {

	// 保存
	@Override
	public boolean save(LostThings lostThings) {
		Session session = super.getSession();
		try {
			session.save(lostThings);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// 批量更新状态
	@Override
	public boolean updateStatus(long[] lostsId, int status) {
		Session session = super.getSession();
		String hql = "update LostThings lost set lost.status = :status where lost.id = :lid";
		Query query = session.createQuery(hql);
		// 批量更新数据
		try {
			for (int i = 0; i < lostsId.length; i++) {
				long lid = lostsId[i];
				query.setParameter("status", status);
				query.setParameter("lid", lid);
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
	public boolean updateStatus(long lostsId, int status) {
		Session session = super.getSession();
		String hql = "update LostThings lost set lost.status = :status where lost.id = :lostsId";
		Query query = session.createQuery(hql);
		query.setParameter("status", status);
		query.setParameter("lostsId", lostsId);
		int count = query.executeUpdate();
		if(count > 0)
			return true;
		else
			return false;
	}

	// 删除
	@Override
	public boolean delete(long[] lostsId) {
		Session session = super.getSession();
		String hql = "delete from LostThings lost where lost.id = :lid";
		Query query = session.createQuery(hql);
		// 批量删除数据
		try {
			for (int i = 0; i < lostsId.length; i++) {
				long lid = lostsId[i];
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
	
	// 查询所有统计数量（后台admin）
	@Override
	public long findAllCount(String key) {
		Session session = super.getSession();
		String hql = "select count(*) from LostThings lost ";
		if (key != null && key != "")
			hql += "where lost.thingsName like '%" + key
					+ "%' or lost.thingsType like '%" + key + "%' or lost.userName like '%" + key + "%'";

		Query query = session.createQuery(hql);
		
		return (long) query.uniqueResult();
	}

	// 查询所有（后台admin）
	@SuppressWarnings("unchecked")
	@Override
	public List<LostThings> findAll(String key, Integer pageIndex, Integer pageSize,
			String sortField, String sortOrder) {
		Session session = super.getSession();
		String hql = "from LostThings lost ";
		if (key != null && key != "")
			hql += "where lost.thingsName like '%" + key
					+ "%' or lost.thingsType like '%" + key + "%' or lost.userName like '%" + key + "%'";

		if (StringUtil.isNullOrEmpty(sortField) == false) {
			if ("desc".equals(sortOrder) == false) {
				sortOrder = "asc";
			}
			hql += " order by " + sortField + " " + sortOrder;
		} else {
			hql += " order by lost.publishTime desc";
		}

		Query query = session.createQuery(hql);
		query.setFirstResult(pageIndex * pageSize).setMaxResults(pageSize);
		return query.list();
	}

	// 查询所有（分页）
	@SuppressWarnings("unchecked")
	@Override
	public List<LostThings> findAll(Integer currentPage, Integer pageSize,
			boolean desc) {
		Session session = super.getSession();
		String hql = "from LostThings lost where lost.status != 2 ";
		// 降序
		if (desc)
			hql += "order by lost.id desc";

		Query query = session.createQuery(hql);
		query.setFirstResult((currentPage - 1) * pageSize).setMaxResults(pageSize);

		return query.list();
	}

	// 根据id查询
	@Override
	public LostThings findById(long id) {
		Session session = super.getSession();
		String hql = "from LostThings lost where lost.id = :id";
		Query query = session.createQuery(hql);
		query.setParameter("id", id);

		return (LostThings) query.uniqueResult();
	}

	// 根据用户id查询所有
	@Override
	public List<LostThings> findAllByUid(long uid) {
		return null;
	}

	// 根据类型查询数量
	@Override
	public long findByType(String type) {
		Session session = super.getSession();
		String hql = "select count(*) from LostThings lost where lost.status != 2 ";
		boolean falg = false;
		// 降序
		if (type != null && !"".equals(type.trim())
				&& !"all".equals(type.trim())) {
			falg = true;
			hql += "and lost.thingsType = :type";
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
		String hql = "select count(*) from LostThings lost where lost.uid = :uid and lost.status != 2 ";
		Query query = session.createQuery(hql);
		query.setParameter("uid", uid);

		return (long) query.uniqueResult();
	}

	// 根据用户id查询所有（分页）
	@SuppressWarnings("unchecked")
	@Override
	public List<LostThings> findAllByUid(long uid, Integer currentPage,
			Integer pageSize, boolean desc) {
		Session session = super.getSession();
		String hql = "from LostThings lost where lost.uid = :uid and lost.status != 2 ";
		// 降序
		if (desc)
			hql += "order by lost.id desc";

		Query query = session.createQuery(hql);
		query.setParameter("uid", uid);
		query.setFirstResult((currentPage - 1) * pageSize).setMaxResults(
				pageSize);

		return query.list();
	}

	// 根据关键字查询所有
	@Override
	public List<LostThings> findAllByKeywords(String keywords) {
		return null;
	}
	
	// 根据关键字查询统计数量（分页）
	@Override
	public long findAllByKeywordsCount(String keywords) {
		Session session = super.getSession();
		String hql = "select count(*) from LostThings lost where lost.status != 2 ";
		if (keywords != null && keywords.length() > 0)
			hql += "and lost.thingsName like '%" + keywords + "%' ";
		
		Query query = session.createQuery(hql);

		return (long) query.uniqueResult();
	}

	// 根据关键字查询所有（分页）
	@SuppressWarnings("unchecked")
	@Override
	public List<LostThings> findAllByKeywords(String keywords,
			Integer currentPage, Integer pageSize, boolean desc) {
		Session session = super.getSession();
		StringBuffer hql = new StringBuffer(
				"from LostThings lost where lost.status != 2 ");
		if (keywords != null && keywords.length() > 0)
			hql.append("and lost.thingsName like '%" + keywords + "%' ");
		// 降序
		if (desc)
			hql.append("order by lost.id desc");

		Query query = session.createQuery(hql.toString());
		query.setFirstResult((currentPage - 1) * pageSize).setMaxResults(
				pageSize);

		return query.list();
	}

	// 根据类型查询所有（分页）
	@SuppressWarnings("unchecked")
	@Override
	public List<LostThings> findAllByThingsType(String type,
			Integer currentPage, Integer pageSize, boolean desc) {
		Session session = super.getSession();
		StringBuffer hql = new StringBuffer(
				"from LostThings lost where lost.status != 2 ");
		boolean flag = false;
		if (type != null && !"all".equals(type.trim())
				&& !"".equals(type.trim())) {
			flag = true;
			hql.append("and lost.thingsType = :type ");
		}
		// 降序
		if (desc)
			hql.append("order by lost.id desc");

		Query query = session.createQuery(hql.toString());
		if (flag)
			query.setParameter("type", type);

		query.setFirstResult((currentPage - 1) * pageSize).setMaxResults(
				pageSize);

		return query.list();
	}

	// 查询已找到
	@Override
	public long findByFoundCount() {
		Session session = super.getSession();
		String hql = "select count(*) from LostThings lost where lost.status = 1 ";
		Query query = session.createQuery(hql);
		return (long) query.uniqueResult();
	}

	// 查询已成功贴的信息
	@SuppressWarnings("unchecked")
	@Override
	public List<LostThings> findThingsBySuccess(int index) {
		Session session = super.getSession();
		String hql = "from LostThings lost where lost.status = 1 order by lost.id desc ";
		Query query = session.createQuery(hql);
		return query.setFirstResult(0).setMaxResults(index).list();
	}
	
	//查询一条记录（上一条、下一条）
	@Override
	public LostThings findOneRecord(long id, boolean isNext) {
		Session session = super.getSession();
		// 选择下一行（上一贴）
		String hql = "from LostThings lost where lost.status !=2 and  lost.status !=3 and lost.id > :id ";
		if(isNext)
			// 选择上一行（下一贴）
			hql = "from LostThings lost where lost.status !=2 and  lost.status !=3  and lost.id < :id  order by lost.id desc";
		
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		query.setMaxResults(1);
		
		return (LostThings) query.uniqueResult();
	}

}
