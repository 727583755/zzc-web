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
		<title>新闻列表</title>
		<#include "inc-header-resource.ftl">
			<#include "macro.ftl">
				<#include "inc-fine-upload.ftl" />
	</head>

	<body>
		<div class="container">
			<div class="row">
				<button type="button" class="btn btn-success" onclick="location='${WEB_ROOT_PATH}/admin/news/add'">新增</button>
				<span id="fine-uploader"></span>
				&nbsp;&nbsp;
				<a href="${WEB_ROOT_PATH}/admin/news/downloadExample">下载导入样例</a>
				<span id="uploadtrip"></span>
			</div>
		</div>

		<div class="container">
			<div class="row">
				<form class="form-inline" action="${WEB_ROOT_PATH}/admin/news" method="post">
					<label class="control-label">标题</label>
					<input type="text" name="search['title']" class="form-control" value="${data.cholder.search['title']}">

					<label class="control-label">内容</label>
					<input type="text" name="search['content']" class="form-control" value="${data.cholder.search['content']}">

					<label class="control-label">修改时间</label>
					<input type="text" name="search['modifyTimeStart']" style="width: 100px;" class="form-control" value="${data.cholder.search['modifyTimeStart']}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})">-
					<input type="text" name="search['modifyTimeEnd']" style="width: 100px;" class="form-control" value="${data.cholder.search['modifyTimeEnd']}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})">

					<label class="control-label">类别</label>
					<input type="text" name="search['category']" style="width: 100px;" class="form-control" value="${data.cholder.search['category']}">

					<button type="submit" class="btn btn-primary">搜索</button>
				</form>
			</div>
		</div>

		<br/>

		<div class="container">
			<div class="row">
				<table class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<th>标题</th>
							<th>内容</th>
							<th>类别 </th>
							<th>新闻时间</th>
							<th>标签</th>
							<th>修改时间</th>
							<th style="width: 130px;">操作</th>
						</tr>
					</thead>
					<tbody>
						<#list data.result as p>
							<tr>
								<td>${p.title}</td>
								<td>${p.content}</td>
								<td>${p.category}</td>
								<td>${(p.newsDate?string("yyyy-MM-dd HH:mm:ss"))?if_exists}</td>
								<td>${p.tag}</td>
								<td>${(p.modifyTime?string("yyyy-MM-dd HH:mm:ss"))?if_exists}</td>
								<td>
									<button type="button" class="btn btn-primary" onclick="location='${WEB_ROOT_PATH}/admin/news/${p.id}?p=${data.pageNum}'">修改</button>
									<button type="button" class="btn btn-danger" onclick="location='${WEB_ROOT_PATH}/admin/news/delete/${p.id}?p=${data.pageNum}'">删除</button>
								</td>
							</tr>
						</#list>
					</tbody>
				</table>
			</div>
			<@pager url="${WEB_ROOT_PATH}/admin/news" data=data/>

		</div>
	</body>

	<script type="text/template" id="template">
		<div class="qq-uploader-selector" qq-drop-area-text="Drop files here">
			<div class="qq-total-progress-bar-container-selector qq-total-progress-bar-container">
				<div role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" class="qq-total-progress-bar-selector qq-progress-bar qq-total-progress-bar"></div>
			</div>
			<div class="qq-upload-drop-area-selector qq-upload-drop-area" qq-hide-dropzone>
				<span class="qq-upload-drop-area-text-selector"></span>
			</div>
			<div class="qq-upload-button-selector qq-upload-button">
				<div>导入数据</div>
			</div>
			<ul class="qq-upload-list-selector" aria-live="polite" aria-relevant="additions removals">
				<li>
					<img class="qq-thumbnail-selector" qq-max-size="100" qq-server-scale>
				</li>
			</ul>
		</div>
	</script>

	<script>
		var uploader = new qq.FineUploader({
			element: document.getElementById('fine-uploader'),
			template: "template",
			request: {
				endpoint: '${WEB_ROOT_PATH}/admin/news/importExcel'
			},
			multiple: false,
			validation: {
				allowedExtensions: ['xls', 'xlsx']
			},
			callbacks: {
				onUpload: function(id, name) {
					$("#uploadtrip").text("后台正在处理...");
				},
				onComplete: function(id, fileName, data) {
					$("#uploadtrip").text("后台处理完成。");
					alert(data.desc);
					setTimeout(function(){$("#uploadtrip").text("");}, 5000);
				}
			}
		});
	</script>

</html>