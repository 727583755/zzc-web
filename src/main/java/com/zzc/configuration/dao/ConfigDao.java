package com.zzc.configuration.dao;

import java.util.List;

import com.zzc.commons.dao.BaseDao;
import com.zzc.configuration.entity.Config;

public interface ConfigDao extends BaseDao<Config>{

	List<Config> getConfigByCategory(String category);
	
	Config getValueByCategory(String category, String ckey);
	
}
