package com.zzc.commons.utility;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.util.Random;

public class CaptchaUtils {
	private static Logger log = Logger.getLogger(CaptchaUtils.class);
	private static final String SMS_ADDR = "http://api.sms.cn/mt/";
	private static final String USER_ID = "wangzhix110";
	private static final String PWD = "50c35341e56df0bb932fbd69b77d1132";
	private static final String ENCODING = "utf8";
	private static final int DEFAULT_CAPTCHA_LENGTH = 6;

	private static String getRadomNumber(int count) {
		StringBuilder sb = new StringBuilder();
		Random random = new Random();
		for (int i = 0; i < count; i++) {
			sb.append(random.nextInt(10));
		}

		return sb.toString();
	}

	public static String getRandomCaptcha() {
		return getRadomNumber(DEFAULT_CAPTCHA_LENGTH);
	}

	public static void sendSMS(String captcha, String phone) throws Exception {
		StringBuilder sb = new StringBuilder();
		sb.append(SMS_ADDR);
		sb.append("?uid=");
		sb.append(USER_ID);
		sb.append("&pwd=");
		sb.append(PWD);
		sb.append("&mobile=");
		sb.append(phone);
		sb.append("&encode=");
		sb.append(ENCODING);
		sb.append("&content=");

		StringBuilder content = new StringBuilder("欢迎使用狗尾草智能机器人，您的验证码为");
		content.append(captcha);
		content.append("，验证码5分钟之后失效，请及时验证。【狗尾草智能科技】");
		String encodeContent = URLEncoder.encode(content.toString(), "UTF-8");
		sb.append(encodeContent);


		log.info("Send Captcha:" + sb.toString());
		//创建默认的httpClient实例
		CloseableHttpClient httpClient = HttpClients.createDefault();
		try {
			HttpGet get = new HttpGet(sb.toString());
			get.addHeader("Content-Type", "application/x-www-form-urlencoded");
			CloseableHttpResponse httpResponse  = httpClient.execute(get);
			try{
				//response实体
				HttpEntity entity = httpResponse.getEntity();
				if (null != entity) {
					log.debug("响应内容:" + EntityUtils.toString(entity, Charset.forName("UTF-8")));
				}
			} finally {
				httpResponse.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (httpClient != null){
					httpClient.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}
