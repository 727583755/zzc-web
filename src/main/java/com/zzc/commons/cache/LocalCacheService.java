package com.zzc.commons.cache;

import java.util.HashMap;
import java.util.Map;

public class LocalCacheService {

	private static Map<String, String> cache = new HashMap<String, String>();

	public static String getCache(String key) {
		String ss = cache.get(key);
		if (ss != null) {
			if (ss.startsWith("0|"))
				return ss.substring(2);
			if (System.currentTimeMillis() <= Long.valueOf(ss.substring(0, 13)))
				return ss.substring(14);
			else
				cache.remove(key);
		}
		return null;
	}

	/**
	 * @param key
	 * @param value
	 * @param seconds 有效期，秒为单位
	 */
	public static void setCache(String key, String value, Integer seconds) {
		Long valid = System.currentTimeMillis() + seconds * 1000;
		cache.put(key, valid.toString().concat("|").concat(value));
	}
}
