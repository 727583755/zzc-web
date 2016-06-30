//package com.zzc.controller;
//
//import com.gowild.cm.dao.NewsDao;
//import com.gowild.cm.entity.News;
//import com.gowild.cm.es.EsConstant;
//import com.gowild.cm.service.NewsService;
//import com.gowild.commons.dao.ConditionHolder;
//import com.gowild.commons.dao.PageHolder;
//import com.gowild.commons.utility.ExcelUtils;
//import com.gowild.commons.utility.RegexUtils;
//import com.gowild.commons.utility.StringUtils;
//import com.gowild.commons.utility.TimeUtils;
//import org.apache.commons.io.FileUtils;
//import org.elasticsearch.client.Client;
//import org.hibernate.criterion.Criterion;
//import org.hibernate.criterion.MatchMode;
//import org.hibernate.criterion.Order;
//import org.hibernate.criterion.Restrictions;
//import org.json.JSONObject;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.HttpHeaders;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.MediaType;
//import org.springframework.http.ResponseEntity;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.multipart.MultipartFile;
//
//import java.io.File;
//import java.io.IOException;
//import java.util.ArrayList;
//import java.util.Calendar;
//import java.util.Date;
//import java.util.List;
//import java.util.regex.Matcher;
//
///**
// * @author Zheng.Ke
// */
//@Controller
//@RequestMapping(value = "/admin/news")
//public class NewsController {
//	String[] newsTypeArr = {"民生", "餐饮", "医疗", "房产", "科技", "教育", "经济", "娱乐", "交�??", "体育", "推荐"};
//
//	@Autowired
//	private NewsDao newsDao;
//	@Autowired
//	private NewsService newsService;
//	@Autowired
//	private Client client;
//
//	@RequestMapping
//	public String list(ConditionHolder search, Model model, Integer p) {
//		PageHolder<News> data = null;
//		List<Criterion> criterions = new ArrayList<Criterion>();
//		String title = search.getSearch().get("title");
//		String content = search.getSearch().get("content");
//		String category = search.getSearch().get("category");
//		String modifyTimeStart = search.getSearch().get("modifyTimeStart");
//		String modifyTimeEnd = search.getSearch().get("modifyTimeEnd");
//
//		if (StringUtils.isNotBlank(title)) {
//			criterions.add(Restrictions.ilike("title", title, MatchMode.ANYWHERE));
//		}
//		if (StringUtils.isNotBlank(content)) {
//			criterions.add(Restrictions.ilike("content", content, MatchMode.ANYWHERE));
//		}
//		if (StringUtils.isNotBlank(category)) {
//			criterions.add(Restrictions.ilike("category", category, MatchMode.ANYWHERE));
//		}
//		if (StringUtils.isNotBlank(modifyTimeStart)) {
//			criterions.add(Restrictions.ge("modifyTime", TimeUtils.engStringToDate(modifyTimeStart, "yyyy-MM-dd")));
//		}
//		if (StringUtils.isNotBlank(modifyTimeEnd)) {
//			criterions.add(Restrictions.le("modifyTime", TimeUtils.engStringToDate(modifyTimeEnd + " 23:59:59", "yyyy-MM-dd HH:mm:ss")));
//		}
//		Calendar c = Calendar.getInstance();
//		c.add(Calendar.DAY_OF_MONTH, -7);
//		criterions.add(Restrictions.ge("modifyTime", c.getTime()));
//
//		data = newsDao.findByPage(p, null, criterions, search, Order.desc("newsDate"));
//
//		model.addAttribute("data", data);
//		return "news-list";
//	}
//
//	@RequestMapping(value = "/save")
//	public String save(News news, Integer p) {
//		if (news != null) {
//			news.setModifyTime(new Date());
//			newsService.saveOrUpdateNews(news);
//		}
//		return "redirect:/admin/news?p=" + (p==null?"":p);
//	}
//
//	@RequestMapping(value = "/{id}")
//	public String query(@PathVariable int id, Model model, Integer p) {
//		News news = newsDao.getById(id);
//		model.addAttribute("data", news);
//		model.addAttribute("p", p);
//		model.addAttribute("newsTypeArr", newsTypeArr);
//		client.prepareGet(EsConstant.INDEX_NEWS, EsConstant.TYPE_NEWS, id + "").execute().actionGet();
//		return "news-edit";
//	}
//
//	@RequestMapping(value = "/delete/{id}")
//	public String delete(@PathVariable int id, Model model, Integer p) {
//		newsDao.deleteById(id);
//		client.prepareDelete(EsConstant.INDEX_NEWS, EsConstant.TYPE_NEWS, id+"").get();
//		return "redirect:/admin/news?p=" + (p==null?"":p);
//	}
//
//	@RequestMapping(value = "/add")
//	public String add(Model model) {
//		model.addAttribute("newsTypeArr", newsTypeArr);
//		return "news-edit";
//	}
//
//	@RequestMapping(value = "/importExcel")
//	@ResponseBody
//	public String importExcel(@RequestParam("qqfile") MultipartFile file) {
//		JSONObject jo = new JSONObject();
//		try {
//			List<String[]> datas = ExcelUtils.readToList(file.getInputStream(), file.getOriginalFilename());
//			boolean isRightExcel = checkExcel(datas);
//			if (!isRightExcel) {
//				jo.put("status", 200);
//				jo.put("desc", "表头格式不对，请下载正确Excel�?");
//				return jo.toString();
//			}
//			List<News> successlist = new ArrayList<News>();
//			List<String> errlist = new ArrayList<String>();
//			for (int i=1; i<datas.size(); i++) {
//				String[] arr = datas.get(i);
//				News news = transform(arr);
//				if (news != null) {
//					newsService.saveOrUpdateNews(news);
//					successlist.add(news);
//				} else {
//					errlist.add(String.valueOf(i));
//				}
//			}
//			String successMsg = "上传成功�?" + successlist.size() + "条\n";
//			String errMsg = "上传失败�?" + errlist.size() + "�?";
//			if (errlist.size() > 0) {
//				errMsg += ",分别在第" + errlist + "行\n";
//			}
//
//			jo.put("status", 100);
//			jo.put("desc", successMsg + errMsg);
//		} catch (Exception e) {
//			jo.put("status", 300);
//			jo.put("desc", "服务器出错！" + e.getMessage());
//			e.printStackTrace();
//		}
//		return jo.toString();
//	}
//
//	private boolean checkExcel(List<String[]> datas) {
//		if (datas == null || datas.size() <= 0) {
//			return false;
//		}
//		String[] arr = datas.get(0);
//		String[] titles = {"标题", "新闻内容", "新闻时间"};
//		if (arr.length < 3) {
//			return false;
//		}
//		for (int i=0; i<titles.length; i++) {
//			if (!titles[i].equals(StringUtils.trim(arr[i]))) {
//				return false;
//			}
//		}
//		return true;
//	}
//
//	private News transform(String[] arr) {
//		String title = arr[0];
//		String content = arr[1];
//		String category = "推荐";
//		String newsDateStr = arr[2];
//		String tag = arr[3];
//
//		if (StringUtils.isBlankOrEmpty(title)) {
//			return null;
//		}
//		Matcher m = RegexUtils.doMatcher(newsDateStr + "", "\\d{4}/\\d{1,2}/\\d{1,2}");//2015/3/12
//		News news = new News();
//		if (m.find()) {
//			news.setNewsDate(TimeUtils.engStringToDate(newsDateStr, "yyyy/MM/dd"));
//		}
//		m = RegexUtils.doMatcher(newsDateStr + "", "[a-zA-Z]{3} [a-zA-Z]{3} \\d{2} \\d{2}:\\d{2}:\\d{2} [a-zA-Z]{3} \\d{4}");//Tue Nov 03 00:00:00 CST 2015
//		if (m.find()) {
//			news.setNewsDate(TimeUtils.engStringToDate(newsDateStr, "EEE MMM dd HH:mm:ss z yyyy"));
//		}
//		if (news.getNewsDate() == null) {
//			news.setNewsDate(new Date());
//		}
//
//		news.setTitle(title);
//		news.setContent(content);
//		news.setCategory(category);
//		news.setTag(tag);
//		news.setModifyTime(new Date());
//
//		return news;
//	}
//
//	@RequestMapping(value = "/downloadExample")
//	public ResponseEntity<byte[]> downloadExample() throws IOException {
//		String filePath = this.getClass().getClassLoader().getResource("").getPath() + "files/template/NewsTemplate.xlsx";
//		File file = new File(filePath);
//		HttpHeaders headers = new HttpHeaders();
//		headers.setContentDispositionFormData("attachment", file.getName());
//		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
//		return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.CREATED);
//	}
//
//}
