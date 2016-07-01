package com.zzc.commons.utility;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import com.zzc.commons.KeyValuePair;

public class JSONArrayHelper {

	/**
	 * 将String的List转为JSONArray字符串
	 * 
	 * @param ss
	 * @return
	 */
	public static String stringsToString(List<String> ss) {
		if (ss == null || ss.size() <= 0)
			return "[]";
		JSONArray ja = new JSONArray();
		for (String s : ss)
			ja.put(s);
		return ja.toString();
	}

	/**
	 * 将JSONArray字符串转为String的List
	 * 
	 * @param s
	 * @return
	 */
	public static List<String> stringToStrings(String s) {
		if (StringUtils.isBlankOrEmpty(s))
			return null;
		JSONArray ja = new JSONArray(s);
		List<String> ss = new ArrayList<String>();
		for (int i = 0; i < ja.length(); i++)
			ss.add(ja.getString(i));
		return ss;
	}

	/**
	 * 将JSONArray字符串转为String的Array
	 * 
	 * @param s
	 * @param emptyIsNull 结果为空则返回null
	 * @return
	 */
	public static String[] stringToStringsArray(String s, boolean emptyIsNull) {
		if (StringUtils.isBlankOrEmpty(s))
			return null;
		JSONArray ja = new JSONArray(s);
		if (emptyIsNull && ja.length() == 0)
			return null;
		String[] ss = new String[ja.length()];
		for (int i = 0; i < ja.length(); i++)
			ss[i] = ja.getString(i);
		return ss;
	}
	
	public static String[] stringToStringsArray(String s) {
		return stringToStringsArray(s, false);
	}

	/**
	 * 将KeyValuePair转为JSONObject
	 * 
	 * @param kvp
	 * @return
	 */
	public static JSONObject toJSONObject(KeyValuePair kvp) {
		if (kvp == null || StringUtils.isBlankOrEmpty(kvp.getKey()))
			return null;
		JSONObject jo = new JSONObject();
		jo.put(kvp.getKey(), kvp.getValue() == null ? "" : kvp.getValue());
		return jo;
	}

	/**
	 * 将JSONObject转为KeyValuePair
	 * 
	 * @param jo
	 * @return
	 */
	public static KeyValuePair fromJSONObject(JSONObject jo) {
		if (jo == null || jo.keySet().size() != 1)
			return null;
		KeyValuePair kvp = new KeyValuePair();
		kvp.setKey((String) jo.keySet().toArray()[0]);
		kvp.setValue(jo.getString(kvp.getKey()));
		return kvp;
	}

	/**
	 * 将KeyValuePair的List转为JSONArray字符串
	 * 
	 * @param kvps
	 * @return
	 */
	public static String keyValuesToString(List<KeyValuePair> kvps) {
		if (kvps == null || kvps.size() <= 0)
			return "[]";
		JSONArray ja = new JSONArray();
		for (KeyValuePair kvp : kvps)
			ja.put(toJSONObject(kvp));
		return ja.toString();
	}

	/**
	 * 将JSONArray字符串转为KeyValuePair的List
	 * 
	 * @param s
	 * @return
	 */
	public static List<KeyValuePair> stringToKeyValues(String s) {
		if (StringUtils.isBlankOrEmpty(s))
			return null;
		JSONArray ja = new JSONArray(s);
		List<KeyValuePair> kvps = new ArrayList<KeyValuePair>();
		for (int i = 0; i < ja.length(); i++)
			kvps.add(fromJSONObject(ja.getJSONObject(i)));
		return kvps;
	}

}
