package com.zzc.commons.utility;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.HttpEntity;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpRequestBase;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.entity.ByteArrayEntity;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.http.HttpMethod;

import com.zzc.commons.KeyValuePair;

/**
 * 发送http请求辅助类（目测支持几乎所有请求的发送）
 * @author zk
 * @date 2015年7月28日 下午5:10:31
 */
public class HttpUtils {
	public static final String JSON_CONTENT_TYPE = "application/json;charset=utf-8";

	@SuppressWarnings("unused")
	private static Log log = LogFactory.getLog(HttpUtils.class);

	public static String urlEncode(String origin) {
		return urlEncode(origin, "UTF-8");
	}

	public static String urlEncode(String origin, String charset) {
		try {
			if (StringUtils.isBlankOrEmpty(charset))
				charset = "UTF-8";
			return URLEncoder.encode(origin, charset);
		} catch (UnsupportedEncodingException e) {
		}
		return null;
	}

	public static String urlDecode(String encoded) {
		return urlDecode(encoded, "UTF-8");
	}

	public static String urlDecode(String encoded, String charset) {
		try {
			if (StringUtils.isBlankOrEmpty(charset))
				charset = "UTF-8";
			return URLDecoder.decode(encoded, charset);
		} catch (UnsupportedEncodingException e) {
		}
		return null;
	}
	
	public static String addParamsToUrl(String url, List<KeyValuePair> params, boolean isNeedUrlEncode,
			String urlEncoding) {
		try {
			StringBuilder sb = new StringBuilder();
			sb.append(url.trim());
			if (url.contains("?")) {
				if (sb.charAt(sb.length() - 1) != '?' && sb.charAt(sb.length() - 1) != '&') {
					sb.append('&');
				}
			} else {
				sb.append('?');
			}
			if (params != null && params.size() > 0)
				for (KeyValuePair kvp : params) {
					sb.append(kvp.getKey());
					sb.append('=');
					if (isNeedUrlEncode)
						sb.append(URLEncoder.encode(kvp.getValue(), urlEncoding));
					else
						sb.append(kvp.getValue());
					sb.append('&');
				}
			sb.deleteCharAt(sb.length() - 1);

			return sb.toString();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return null;
	}

	public static String addParamsToContent(List<KeyValuePair> params, boolean isNeedUrlEncode, String urlEncoding)
			throws UnsupportedEncodingException {
		StringBuilder sb = new StringBuilder();
		if (params != null && params.size() > 0)
			for (KeyValuePair kvp : params) {
				sb.append(kvp.getKey());
				sb.append('=');
				if (isNeedUrlEncode)
					sb.append(URLEncoder.encode(kvp.getValue(), urlEncoding));
				else
					sb.append(kvp.getValue());
				sb.append('&');
			}
		if (sb.length() > 0)
			sb.deleteCharAt(sb.length() - 1);

		return sb.toString();
	}
	
	public static String sendWebRequestByGet(String scc, String uri) {
		return sendWebRequestByGet(scc, uri, null);
	}

	public static String sendWebRequestByGet(String scc, String uri, String forceRespEncoding) {
		BasicCookieStore bcs = null;
		if (scc != null) {
			bcs = CookieManager.getCookieStore(scc);
			if (bcs == null) {
				bcs = new BasicCookieStore();
				CookieManager.setCookieStore(scc, bcs);
			}
		}
		return sendWebRequest(uri, HttpMethod.GET, null, null, forceRespEncoding, null, bcs);
	}

	public static String sendWebRequestByPost(String scc, String uri, String contents, String reqEncoding,
			String contentType) {
		BasicCookieStore bcs = null;
		if (scc != null) {
			bcs = CookieManager.getCookieStore(scc);
			if (bcs == null) {
				bcs = new BasicCookieStore();
				CookieManager.setCookieStore(scc, bcs);
			}
		}
		List<KeyValuePair> headers = new ArrayList<KeyValuePair>();
		if (contentType != null)
			headers.add(new KeyValuePair("Content-Type", contentType));
		return sendWebRequest(uri, HttpMethod.POST, headers, contents, reqEncoding, null, null, bcs);
	}

	public static String sendWebRequestByForm(String scc, String uri, Map<String, String> headers,
			Map<String, String> params, String reqEncoding) {
		BasicCookieStore bcs = null;
		if (scc != null) {
			bcs = CookieManager.getCookieStore(scc);
			if (bcs == null) {
				bcs = new BasicCookieStore();
				CookieManager.setCookieStore(scc, bcs);
			}
		}
		List<KeyValuePair> kvpHeaders = new ArrayList<KeyValuePair>();
		if (headers != null)
			for (String key : headers.keySet())
				kvpHeaders.add(new KeyValuePair(key, headers.get(key)));
		if (headers == null || !headers.containsKey("Content-Type"))
			kvpHeaders.add(new KeyValuePair("Content-Type", "application/x-www-form-urlencoded"));
		return sendWebRequest(uri, HttpMethod.POST, kvpHeaders, formToUrlEncodedString(params, reqEncoding),
				reqEncoding, null, null, bcs);
	}

	public static String sendWebRequestByForm(String scc, String uri, List<KeyValuePair> headers,
			List<KeyValuePair> params, String reqEncoding) {
		BasicCookieStore bcs = null;
		if (scc != null) {
			bcs = CookieManager.getCookieStore(scc);
			if (bcs == null) {
				bcs = new BasicCookieStore();
				CookieManager.setCookieStore(scc, bcs);
			}
		}
		boolean hasContentType = false;
		List<KeyValuePair> kvpHeaders = new ArrayList<KeyValuePair>();
		if (headers != null)
			for (KeyValuePair kvp : headers) {
				if (kvp.getKey().equalsIgnoreCase("Content-Type"))
					hasContentType = true;
				kvpHeaders.add(kvp);
			}
		if (!hasContentType)
			kvpHeaders.add(new KeyValuePair("Content-Type", "application/x-www-form-urlencoded"));
		return sendWebRequest(uri, HttpMethod.POST, kvpHeaders, formToUrlEncodedString(params, reqEncoding),
				reqEncoding, null, null, bcs);
	}

	public static String sendWebRequest(String uri, HttpMethod httpMethod, List<KeyValuePair> headers, String contents,
			String reqEncoding, String forceRespEncoding, Integer timeout, BasicCookieStore cookieStore) {
		if (contents == null)
			contents = "";
		if (StringUtils.isBlankOrEmpty(reqEncoding))
			reqEncoding = "UTF-8";
		return sendWebRequest(uri, httpMethod, headers, contents.getBytes(Charset.forName(reqEncoding)),
				forceRespEncoding, timeout, cookieStore);
	}

	public static String sendWebRequest(String uri, HttpMethod httpMethod, List<KeyValuePair> headers, byte[] contents,
			String forceRespEncoding, Integer timeout, BasicCookieStore cookieStore) {
		if (timeout == null || timeout < 1000) {
			timeout = 10000;
		} else if (timeout > 100000) {
			timeout = 100000;
		}
		if (cookieStore == null)
			cookieStore = new BasicCookieStore();

		try {
			RequestConfig defaultRequestConfig = RequestConfig.custom().setSocketTimeout(timeout)
					.setConnectTimeout(timeout).setConnectionRequestTimeout(timeout).build();
			CloseableHttpClient httpclient = null;
			try {
				if (uri.startsWith("https://")) {
					SSLContext ctx = SSLContext.getInstance("SSL");
					ctx.init(null, new TrustManager[] { new X509TrustAnyManager() }, null);
					SSLConnectionSocketFactory ssf = new SSLConnectionSocketFactory(ctx);
					httpclient = HttpClients.custom().setDefaultCookieStore(cookieStore)
							.setDefaultRequestConfig(defaultRequestConfig).setSSLSocketFactory(ssf).build();
				} else {
					httpclient = HttpClients.custom().setDefaultCookieStore(cookieStore)
							.setDefaultRequestConfig(defaultRequestConfig).build();
				}
				CloseableHttpResponse response = null;
				HttpRequestBase request = null;
				if (httpMethod == HttpMethod.GET) {
					request = new HttpGet(uri);
				} else {
					request = new HttpPost(uri);
					ByteArrayEntity byteEntity = new ByteArrayEntity(contents);
					((HttpPost) request).setEntity(byteEntity);
				}
				if (headers != null) {
					for (KeyValuePair kvp : headers)
						request.setHeader(kvp.getKey(), kvp.getValue());
				}
				response = httpclient.execute(request);
				try {
					if (response.getStatusLine().getStatusCode() != 200 && response.getStatusLine().getStatusCode() != 201) {
						if (response.getStatusLine().getStatusCode() == 302)
							return response.getHeaders("Location")[0].getValue();
						return null;
					}
					HttpEntity entity = response.getEntity();
					if (entity != null) {
						if (forceRespEncoding == null)
							return EntityUtils.toString(entity);
						else
							return StringUtils.byteArrayToString(EntityUtils.toByteArray(entity), forceRespEncoding);
					}
				} finally {
					if (response != null)
						response.close();
				}
			} finally {
				if (httpclient != null)
					httpclient.close();
			}
		} catch (Exception e) {
			System.out.println("web request exception: " + uri);
			e.printStackTrace();
		}
		return null;
	}

	public static String formToUrlEncodedString(List<KeyValuePair> params) {
		return formToUrlEncodedString(params, "UTF-8");
	}

	public static String formToUrlEncodedString(List<KeyValuePair> params, String charset) {
		StringBuilder sb = new StringBuilder();
		if (params != null && params.size() > 0)
			for (KeyValuePair kvp : params) {
				sb.append(kvp.getKey());
				sb.append('=');
				sb.append(urlEncode(kvp.getValue(), charset));
				sb.append('&');
			}
		if (sb.length() > 0)
			sb.deleteCharAt(sb.length() - 1);

		return sb.toString();
	}

	public static String formToUrlEncodedString(Map<String, String> params) {
		return formToUrlEncodedString(params, "UTF-8");
	}

	public static String formToUrlEncodedString(Map<String, String> params, String charset) {
		StringBuilder sb = new StringBuilder();
		if (params != null && params.size() > 0)
			for (String key : params.keySet()) {
				sb.append(key);
				sb.append('=');
				sb.append(urlEncode(params.get(key), charset));
				sb.append('&');
			}
		if (sb.length() > 0)
			sb.deleteCharAt(sb.length() - 1);

		return sb.toString();
	}

	public static Map<String, String> urlEncodedStringToForm(String encoded) {
		return urlEncodedStringToForm(encoded, "UTF-8");
	}

	public static Map<String, String> urlEncodedStringToForm(String encoded, String charset) {
		if (StringUtils.isBlankOrEmpty(encoded))
			return null;
		Map<String, String> retval = new HashMap<String, String>();
		String[] params = encoded.split("&");
		for (String param : params) {
			String[] kvp = param.split("=");
			retval.put(kvp[0], kvp.length > 1 ? urlDecode(kvp[1], charset) : "");
		}
		return retval;
	}

}
