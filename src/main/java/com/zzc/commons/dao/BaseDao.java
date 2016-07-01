package com.zzc.commons.dao;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;


/**
 * DAO根接口
 * 
 * @param <T>
 */
public interface BaseDao<T> {

	T getById(Serializable k);

	Serializable save(T t);

	void save(List<T> list);

	void saveOrUpdate(T t);

	void saveOrUpdate(List<T> list);

	void delete(T t);
	
	void delete(List<T> list);

	void deleteById(Integer id);

	void update(T t);

	List<T> getAllList();

	int getAllCount();

	List<T> getMostRecentByPage(Integer pageNum);

	List<T> getMostRecentByPage(Integer pageNum, Integer pageSize);

	PageHolder<T> findByPage(Integer pageNum);

	PageHolder<T> findByPage(Integer pageNum, Integer pageSize);

	PageHolder<T> findByPage(Integer pageNum, Collection<Criterion> criterions, ConditionHolder cholder);

	PageHolder<T> findByPage(Integer pageNum, Integer pageSize, Collection<Criterion> criterions,
							 ConditionHolder cholder, Order... orders);

}
