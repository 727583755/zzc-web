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
		<title>故事专辑信息</title>
		<#include "inc-header-resource.ftl">
		<#include "inc-fine-upload.ftl" />
	</head>

	<body>
		<div class="container">
			<div class="row">
				<form action="${WEB_ROOT_PATH}/admin/storyalbum/save" method="post" class="form-inline">
					<input type="hidden" name="p" value="${p}">
					<input type="hidden" name="id" value="${data.id}">
					<input type="hidden" name="distinguishFlag" value="${data.distinguishFlag}">
					<input type="hidden" name="announcerId" value="${data.announcerId}">
					<input type="hidden" name="conditionIndex" value="${data.conditionIndex}">
					<input type="hidden" name="modifyTime" value="${data.modifyTime}">
					
					<label class="control-label">标题</label>
					<input type="text" name="title" class="form-control" value="${data.title}">
					<span class="text-danger">不能为空</span>
					<br/>
					<br/>
					<label class="control-label">封面图片地址</label>
					<input type="text" name="coverUrl" id="coverUrl" style="width:600px;" class="form-control" value="${data.coverUrl}">
					<br/>
					<br/>
					<label class="control-label">来源</label>
					<input type="text" name="source" class="form-control" value="${data.source}">
					<br/>
					<br/>
					<label class="control-label">作者名</label>
					<input type="text" name="announcerName" class="form-control" value="${data.announcerName}">
					<br/>
					<br/>
					<label class="control-label">专辑信息</label>
					<input type="text" name="albumInfo" class="form-control" value="${data.albumInfo}">
					<br/>
					<br/>
					<label class="control-label">专辑标签</label>
					<input type="text" name="albumTags" class="form-control" value="${data.albumTags}">
					<br/>
					<br/>
					<label class="control-label">分类</label>
					<input type="text" name="category" class="form-control" value="${data.category}">
					<br/>
					<br/>
					<label class="control-label">播放次数</label>
					<input type="text" name="playCount" class="form-control" value="${data.playCount?default(0)}">
					<br/>
					<br/>
					<label class="control-label">故事集数</label>
					<input type="text" name="storyCount" class="form-control" value="${data.storyCount?default(1)}">
					<br/>
					<br/>
					<label class="control-label">热度</label>
					<input type="text" name="hot" class="form-control" value="${data.hot}">
					<br/>
					<br/>
					<label class="control-label">是否上架</label>
					<select name="enabled" class="form-control">
						<option value="1" <#if data.enabled=='1'>selected</#if>>上架</option>
						<option value="0" <#if data.enabled=='0'>selected</#if>>下架</option>
					</select>
					<br/>
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

	</script>
	
</html>