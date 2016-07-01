package com.zzc.configuration.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;

import com.zzc.commons.dao.AbstractBaseDao;
import com.zzc.configuration.entity.Config;

@Repository
public class ConfigDaoImpl extends AbstractBaseDao<Config> implements ConfigDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<Config> getConfigByCategory(String category) {
		Session session = getSessionFactory().getCurrentSession();
		Query q = session.createQuery("from Config where category = :category");
		q.setString("category", category);
		return q.list();
	}
	
	@Override
	public Config getValueByCategory(String category, String ckey) {
		Session session = getSessionFactory().getCurrentSession();
		Query q = session.createQuery("from Config where category = :category and ckey = :ckey");
		q.setString("category", category);
		q.setString("ckey", ckey);
		return (Config) q.uniqueResult();
	}

}
