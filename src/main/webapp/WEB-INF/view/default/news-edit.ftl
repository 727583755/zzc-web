<!doctype html>
<html>

	<head>
		<meta charset="utf-8" />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
		<meta name="apple-touch-fullscreen" content="no" />
		<meta content="telephone=no" name="format-detection" />
		<meta name="apple-mobile-web-app-capable" content="no" />
		<title>新闻</title>
		<#include "inc-header-resource.ftl">
	</head>

	<body>
		<div class="container">
			<div class="row">
				<form action="${WEB_ROOT_PATH}/admin/news/save" method="post" class="form-inline" onsubmit="return check()">
					<input type="hidden" name="p" value="${p}">
					<input type="hidden" name="id" value="${data.id}">
					<input type="hidden" name="category" value="推荐">
					<input type="hidden" name="modifyTime" value="${data.modifyTime}">
					<label class="control-label">标题</label>
					<input type="text" name="title" class="form-control" value="${data.title}">
					<br/>
					<br/>

					<label class="control-label">内容</label>
					<textarea name="content" class="form-control" cols="100" rows="4">${data.content}</textarea>
					<br/>
					<br/>

					<#--
					<label class="control-label">类别</label>
					<select name="category" id="category" class="form-control">
						<option value="" <#if data.category==''>selected</#if>>请选择</option>
						<#list newsTypeArr as p>
							<option value="${p}" <#if data.category=='${p}'>selected</#if>>${p}</option>
						</#list>
					</select>
					<br/>
					<br/>-->

					<label class="control-label">新闻时间</label>
					<input type="text" name="newsDate" class="form-control" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value='${(data.newsDate?string("yyyy-MM-dd HH:mm:ss"))?if_exists}'>
					<br/>
					<br/>

					<label class="control-label">标签</label>
					<textarea name="tag" class="form-control" cols="100" rows="4">${data.tag}</textarea>
					<br/>
					<span class="text-danger">多个标签用分号";"分开</span>
					<br/>

					<button type="submit" id="submitbtn" class="btn btn-primary btn-md">提交保存</button>
					<br/>
				</form>
				<br/>
				<br/>
				<br/>
				<br/>
				<br/>
				<br/>
			</div>

		</div>

	</body>
	<script>
		function check() {
			var category = $("#category").val();
			if (category == "") {
				alert("请选择类型！")
				return false;
			}
			return true;
		}
	</script>

</html>