package com.zzc.configuration.service;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zzc.configuration.dao.ConfigDao;
import com.zzc.configuration.entity.Config;

@Service
public class SystemConfigServiceImpl implements SystemConfigService {

	private Map<String, Object> configs = new HashMap<String, Object>();
	@Autowired
	private ConfigDao configDao;
	private static String SYSTEM_CATEGORY = "system";
	private static Log log = LogFactory.getLog(SystemConfigServiceImpl.class);

	@SuppressWarnings("unchecked")
	@Override
	public <T> T getConfig(String ckey, Class<T> t) {
		if (configs.containsKey(ckey))
			return (T) configs.get(ckey);
		Config conf = configDao.getValueByCategory(SYSTEM_CATEGORY, ckey);
		if (conf == null) {
			log.error("Unknown system config key: " + ckey);
			return null;
		}
		if (t == String.class) {
			configs.put(ckey, conf.getCvalue());
		} else if (t == Integer.class) {
			configs.put(ckey, Integer.valueOf(conf.getCvalue()));
		} else if (t == Boolean.class) {
			configs.put(ckey, conf.getCvalue().equalsIgnoreCase("true") ? true : false);
		} else {
			log.error("Unknown system config type: " + t.getSimpleName() + ", for key: " + ckey);
			return null;
		}
		return (T) configs.get(ckey);
	}

	@Override
	public void updateConfig(String ckey) {
		configs.remove(ckey);
	}

	@Override
	public void refreshAll() {
		configs.clear();
	}

}
