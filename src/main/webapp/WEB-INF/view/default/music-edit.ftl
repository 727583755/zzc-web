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
		<title>音乐信息</title>
		<#include "inc-header-resource.ftl">
		<#include "inc-fine-upload.ftl" />
	</head>

	<body>
		<div class="container">
			<div class="row">
				<form action="${WEB_ROOT_PATH}/admin/music/save" method="post" class="form-inline">
					<input type="hidden" name="p" value="${p}">
					<input type="hidden" name="id" value="${data.id}">
					<input type="hidden" name="lrcPath" value="${data.lrcPath}">
					<input type="hidden" name="modifyTime" value="${data.modifyTime}">

                    <label class="control-label">类别选择：</label><br/>
					<#list typeMap?keys as key>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<label class="control-label">${key}</label>
						<#list typeMap[key] as type>
							<div class="checkbox">
								<label>
									<input type="checkbox" name="type" value="${type}" <#if data != null><#if data.typeList?seq_contains("${type}") >checked</#if></#if> >&nbsp;${type}&nbsp;&nbsp;
								</label>
							</div>
						</#list>
						<br/>
					</#list>
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
                    <label class="control-label">上传音乐文件</label>
					<#if data.id == null>
                        <div id="fileUpload"></div>
					</#if>
                    <br/>
                    <br/>
                    <label class="control-label">歌名</label>
                    <input type="text" name="title" id="title" class="form-control" value="${data.title}">
                    <span class="text-danger">不能为空</span>
                    <br/>
                    <br/>
                    <label class="control-label">专辑名</label>
                    <input type="text" name="albumTitle" id="albumTitle" class="form-control" value="${data.albumTitle}">
                    <br/>
                    <br/>
                    <label class="control-label">专辑ID</label>
                    <input type="text" name="albumId" id="albumTitle" class="form-control" value="${data.albumId}" readonly="readonly">
                    <br/>
                    <br/>
                    <label class="control-label">歌手</label>
                    <input type="text" name="announcerName" id="announcerName" class="form-control" value="${data.announcerName}" >
                    <br/>
                    <br/>
					<label class="control-label">比特率</label>
					<input type="text" name="bitrate" id="bitrate" class="form-control" value="${data.bitrate}" readonly="readonly">
					<br/>
					<br/>
					<label class="control-label">文件路径</label>
					<input type="text" name="filePath" id="filePath" class="form-control" value="${data.filePath}" readonly="readonly" style="width: 500px">
					<br/>
					<br/>
					<label class="control-label">文件大小</label>
					<input type="text" name="size" id="size" class="form-control" value="${data.size}" readonly="readonly" >
					<br/>
					<br/>
					<label class="control-label">时长</label>
					<input type="text" name="duration" id="duration" class="form-control" value="${data.duration}" readonly="readonly">
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
        var uploader = new qq.FineUploader({
            element: document.getElementById('fileUpload'),
            request: {
                endpoint: '${WEB_ROOT_PATH}/admin/fileUpload/musicFile'
            },
            multiple: false,
            callbacks: {
                onUpload: function (id, name) {
                    $("#submitbtn").attr("disabled", true);
                },
                onComplete: function(id, fileName, data) {
                    if (data.status == 100) {
                        $("#filePath").val(data.filePath);
                        $("#size").val(data.size);
                        $("#title").val(data.info.title);
                        $("#albumTitle").val(data.info.album);
                        $("#announcerName").val(data.info.artist);
                        $("#duration").val(data.info.duration);
                        $("#bitrate").val(data.info.bitrate);
                    } else {
                        alert("上传失败！");
                    }
                    $("#submitbtn").attr("disabled", false);
                }
            }
        });
	</script>
	
</html>