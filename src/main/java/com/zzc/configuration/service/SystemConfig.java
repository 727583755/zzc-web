package com.zzc.configuration.service;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SystemConfig implements InitializingBean {

	public static final String FIX_DATA_VERSION = "fix_data_version";

	@Autowired
	private SystemConfigService systemConfigService;
	private static SystemConfigService systemConfig;

	@Override
	public void afterPropertiesSet() throws Exception {
		systemConfig = systemConfigService;
	}

	public static <T> T getConfig(String ckey, Class<T> t) {
		return systemConfig.getConfig(ckey, t);
	}

	public static Integer getConfigInt(String ckey) {
		return systemConfig.getConfig(ckey, Integer.class);
	}

	public static String getConfigStr(String ckey) {
		return systemConfig.getConfig(ckey, String.class);
	}

	public static Boolean getConfigBool(String ckey) {
		return systemConfig.getConfig(ckey, Boolean.class);
	}

	public static void updateConfig(String ckey) {
		systemConfig.updateConfig(ckey);
	}

	public static void refreshAll() {
		systemConfig.refreshAll();
	}

}
