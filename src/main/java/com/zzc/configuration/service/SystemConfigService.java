package com.zzc.configuration.service;

public interface SystemConfigService {

	public <T> T getConfig(String ckey, Class<T> t);

	public void updateConfig(String ckey);

	public void refreshAll();

}
