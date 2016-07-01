package com.zzc.commons.cache;

import java.util.HashMap;
import java.util.Map;

public class LocalCacheManager {

	private static Map<String, Map<String, Object>> localCache = new HashMap<String, Map<String, Object>>();

	public static Object getCache(String group, String key) {
		return localCache.get(group).get(key);
	}

	public static void putCache(String group, String key, Object value) {
		localCache.get(group).put(key, value);
	}

	public static void clearCache(String group) {
		localCache.get(group).clear();
	}
}
