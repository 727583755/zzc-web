package com.zzc.commons.dao;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.Collection;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;


/**
 * DAO根接口的默认抽象实现
 * 
 * @param <T>
 */
@SuppressWarnings("unchecked")
@Transactional
public abstract class AbstractBaseDao<T> implements BaseDao<T> {

	private Class<T> entityClass;
	private static int DEFAULT_PAGE_SIZE = 10;
	private static int BATCH_SAVE_FLUSH_INTERVAL = 100;
	private static int BATCH_DELTE_FLUSH_INTERVAL = 100;

	@Autowired
	private SessionFactory sessionFactory;

	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	public AbstractBaseDao() {
		Type genType = getClass().getGenericSuperclass();
		Type[] params = ((ParameterizedType) genType).getActualTypeArguments();
		entityClass = (Class<T>) params[0];
	}

	@Override
	public T getById(Serializable k) {
		Session session = sessionFactory.getCurrentSession();
		return (T) session.get(entityClass, k);
	}

	@Override
	public Serializable save(T t) {
		Session session = sessionFactory.getCurrentSession();
		return session.save(t);
	}

	@Override
	public void saveOrUpdate(T t) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(t);
	}

	@Override
	public void delete(T t) {
		Session session = sessionFactory.getCurrentSession();
		session.delete(t);
	}

	@Override
	public void update(T t) {
		Session session = sessionFactory.getCurrentSession();
		session.update(t);
	}

	@Override
	public List<T> getAllList() {
		Session session = sessionFactory.getCurrentSession();
		Query q = session.createQuery("from " + entityClass.getSimpleName());
		return q.list();
	}

	@Override
	public int getAllCount() {
		Session session = sessionFactory.getCurrentSession();
		Query q = session.createQuery("select count(*) from " + entityClass.getSimpleName());
		return Integer.parseInt(q.uniqueResult().toString());
	}

	@Override
	public List<T> getMostRecentByPage(Integer pageIndex) {
		return getMostRecentByPage(pageIndex, null);
	}

	@Override
	public List<T> getMostRecentByPage(Integer pageIndex, Integer pageSize) {
		return (List<T>) findByPage(pageIndex, pageSize, null, null, Order.desc("id")).getResult();
	}

	@Override
	public PageHolder<T> findByPage(Integer pageIndex) {
		return findByPage(pageIndex, null, null, null);
	}

	@Override
	public PageHolder<T> findByPage(Integer pageIndex, Integer pageSize) {
		return findByPage(pageIndex, pageSize, null, null);
	}

	@Override
	public PageHolder<T> findByPage(Integer pageIndex, Collection<Criterion> criterions, ConditionHolder cholder) {
		return findByPage(pageIndex, null, criterions, cholder);
	}

	@SuppressWarnings("finally")
	@Override
	public PageHolder<T> findByPage(Integer pageIndex, Integer pageSize, Collection<Criterion> criterions,
			ConditionHolder cholder, Order... orders) {
		if (pageIndex == null || pageIndex < 1)
			pageIndex = 1;
		if (pageSize == null || pageSize < 1)
			pageSize = DEFAULT_PAGE_SIZE;
		PageHolder<T> holder = null;
		try {
			Criteria criteria = sessionFactory.getCurrentSession().createCriteria(entityClass);
			if (criterions != null) {
				for (Criterion criterion : criterions) {
					if (criterion != null) {
						criteria.add(criterion);
					}
				}
			}

			int totalCount = Integer.parseInt(criteria.setProjection(Projections.rowCount()).uniqueResult().toString());
			criteria.setProjection(null);

			if (orders != null && orders.length > 0) {
				for (int i = 0; i < orders.length; i++) {
					if (orders[i] == null) {
						continue;
					}
					criteria.addOrder(orders[i]);
				}
			} else {
				criteria.addOrder(Order.asc("id"));
			}

			criteria.setFirstResult((pageIndex - 1) * pageSize);
			criteria.setMaxResults(pageSize);
			List<T> result = criteria.list();

			int maxPageNum = totalCount / pageSize + 1;
			if (totalCount != 0 && totalCount % pageSize == 0)
				maxPageNum--;
			int pageNum = pageIndex > maxPageNum ? maxPageNum : pageIndex;
			boolean hasPrevious = pageNum > 1;
			boolean hasNext = pageNum < maxPageNum;
			holder = new PageHolder<T>(pageNum, maxPageNum, pageSize, totalCount, hasPrevious, hasNext, cholder, result);
		} catch (RuntimeException ex) {
			ex.printStackTrace();
		} finally {
			return holder;
		}
	}

	@Override
	public void save(List<T> list) {
		if (list == null || list.size() == 0)
			return;
		Session session = sessionFactory.getCurrentSession();
		for (int i = 0; i < list.size(); i++) {
			T t = list.get(i);
			session.save(t);
			if ((i + 1) % BATCH_SAVE_FLUSH_INTERVAL == 0) {
				session.flush();
				session.clear();
			}
		}
	}

	@Override
	public void saveOrUpdate(List<T> list) {
		if (list == null || list.size() == 0)
			return;
		Session session = sessionFactory.getCurrentSession();
		for (int i = 0; i < list.size(); i++) {
			T t = list.get(i);
			session.saveOrUpdate(t);
			if ((i + 1) % BATCH_SAVE_FLUSH_INTERVAL == 0) {
				session.flush();
				session.clear();
			}
		}
	}

	@Override
	public void deleteById(Integer id) {
		T t = getById(id);
		if (t != null) {
			delete(t);
		}
	}
	
	@Override
	public void delete(List<T> list) {
		if (list == null || list.size() == 0) {
			return;
		}
		Session session = sessionFactory.getCurrentSession();
		for (int i = 0; i < list.size(); i++) {
			T t = list.get(i);
			session.delete(t);
			if ((i + 1) % BATCH_DELTE_FLUSH_INTERVAL == 0) {
				session.flush();
				session.clear();
			}
		}
	}

}
