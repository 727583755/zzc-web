package com.zzc.commons.dao;

import java.util.LinkedHashMap;
import java.util.Map;

public class ConditionHolder {

	private Map<String, String> search = new LinkedHashMap<String, String>();

	public Map<String, String> getSearch() {
		return search;
	}

	public void setSearch(Map<String, String> search) {
		this.search = search;
	}

}
