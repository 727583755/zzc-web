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
		<title>歌手</title>
		<#include "inc-header-resource.ftl">
		<#include "inc-fine-upload.ftl" />
	</head>

	<body>
		<div class="container">
			<div class="row">
				<form action="${WEB_ROOT_PATH}/admin/musicannouncer/save" method="post" class="form-inline">
					<input type="hidden" name="p" value="${p}">
					<input type="hidden" name="id" value="${data.id}">
					<input type="hidden" name="combination" value="${data.combination}">
					<input type="hidden" name="announcerId" value="${data.announcerId}">
					<input type="hidden" name="conditionIndex" value="${data.conditionIndex}">
					<input type="hidden" name="modifyTime" value="${data.modifyTime}">
					
					<label class="control-label">姓名</label>
					<input type="text" name="name" class="form-control" value="${data.name}">
					<span class="text-danger">不能为空</span>
					<br/>
					<br/>
					<label class="control-label">热度</label>
					<input type="text" name="hot" class="form-control" value="${data.hot}">
					<br/>
					<br/>
					<label class="control-label">歌的数量</label>
					<input type="text" name="songNum" class="form-control" value="${data.songNum}">
					<br/>
					<br/>
					<label class="control-label">性别</label>
					<input type="text" name="sex" class="form-control" value="${data.sex}">
					<br/>
					<br/>
					<label class="control-label">星座</label>
					<input type="text" name="star" class="form-control" value="${data.star}">
					<br/>
					<br/>
					<label class="control-label">专辑数</label>
					<input type="text" name="albumNum" class="form-control" value="${data.albumNum}">
					<br/>
					<br/>
					<label class="control-label">国籍</label>
					<input type="text" name="nationality" class="form-control" value="${data.nationality}">
					<br/>
					<br/>
					<label class="control-label">类型</label>
					<input type="text" name="classify" class="form-control" value="${data.classify}">
					<br/>
					<br/>
					<label class="control-label">图象地址</label>
					<input type="text" name="photoUrl" id="imageUrl" class="form-control" value="${data.photoUrl}" readonly="readonly" style="width: 600px">
                    <div id="fileUpload"></div>
					<br/>
					<br/>
					<label class="control-label">简介</label>
					<textarea class="form-control" rows="3" cols="100" name="introduction">${data.introduction}</textarea>
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
                endpoint: '${WEB_ROOT_PATH}/admin/fileUpload/imageFile'
            },
            validation: {
                allowedExtensions:[ 'bmp','jpg','gif','png']
            },
            multiple: false,
            callbacks: {
                onUpload: function (id, name) {
                    $("#submitbtn").attr("disabled", true);
                },
                onComplete: function(id, fileName, data) {
                    if (data.status == 100) {
                        $("#imageUrl").val(data.filePath);
                    } else {
                        alert("上传失败！");
                    }
                    $("#submitbtn").attr("disabled", false);
                }
            }
        });
	</script>
	
</html>