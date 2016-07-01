package com.zzc.configuration.service;

import com.zzc.commons.cache.LocalCacheService;

public class AuthcodeService {

	public static boolean checkAuthcode(String identifier, String code) {
		String cachecode = LocalCacheService.getCache(identifier);
		if (cachecode != null && cachecode.equals(code))
			return true;
		return false;
	}

	/**
	 * 保存验证码到缓存
	 * @param identifier   
	 * @param code  验证码
	 */
	public static void setAuthcode(String identifier, String code) {
		LocalCacheService.setCache(identifier, code, 180);
	}
	
	/**
	 * 保存验证码到缓存
	 * @param identifier
	 * @param code
	 * @param seconds 单位秒
	 */
	public static void setAuthcode(String identifier, String code, int seconds) {
        LocalCacheService.setCache(identifier, code, seconds);
    }
	
}
