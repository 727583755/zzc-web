package com.zzc.controller;

import com.zzc.commons.dao.ConditionHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class CodeIndexController {

	@RequestMapping
	public String indexCode(ConditionHolder search, Model model, Integer p) {
		return "code_index";
	}
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
//		return "news-edit";
//	}
//
//	@RequestMapping(value = "/delete/{id}")
//	public String delete(@PathVariable int id, Model model, Integer p) {
//		newsDao.deleteById(id);
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
	
}
