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
		<title>设备升级</title>
		<#include "inc-header-resource.ftl" />
		<#include "inc-fine-upload.ftl" />
	</head>

	<body>
		<div class="container">
			<div class="row">
				<form action="${WEB_ROOT_PATH}/admin/upgrade/save" method="post" class="form-inline">
					<input type="hidden" name="hasCurrent" value="${data.hasCurrent}">
					<input type="hidden" name="type" value="${data.type}">
					<label class="control-label">软件名称&nbsp;&nbsp;&nbsp;</label>
					<input type="text" name="softName" class="form-control" readonly="readonly" value="${data.softName}">
					<br/>
					<br/>

					<label class="control-label">版　　本&nbsp;&nbsp;&nbsp;</label>
					<input type="text" name="version" class="form-control" value="${data.version}">
					<br/>
					<br/>

					<label class="control-label">版本编号&nbsp;&nbsp;&nbsp;</label>
					<input type="number" name="versionCode" class="form-control" value="${data.versionCode}">
					<label class="control-label text-muted">&nbsp;&nbsp;&nbsp;依据版本编号进行升级,只能是数字</label>
					<br/>
					<br/>

					<label class="control-label">更新日期&nbsp;&nbsp;&nbsp;</label>
					<input type="text" name="updateTime" class="form-control" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value='${(data.updateTime?string("yyyy-MM-dd HH:mm:ss"))?if_exists}'>
					<br/>
					<br/>
					
					<label class="control-label">下载地址&nbsp;&nbsp;&nbsp;</label>
					<input type="text" id="downloadURL" name="downloadURL" class="form-control" readonly="readonly" value="${data.downloadURL}" style="width: 500px;">
					<br/>
					<br/>
					
					<label class="control-label">大小（B）&nbsp;&nbsp;&nbsp;</label>
					<input type="text" id="size" name="size" class="form-control" readonly="readonly" value="${data.size}">
					<br/>
					<br/>
					
					<label class="control-label">上传软件&nbsp;&nbsp;&nbsp;</label>
					<div id="fine-uploader"></div>
					<br/>
					<br/>

					<label class="control-label">升级描述&nbsp;&nbsp;&nbsp;</label>
					<textarea name="displayMessage" class="form-control" cols="100" rows="4">${data.displayMessage}</textarea>
					<br/>
					<br/>

					<br/>
					<br/>

					<button type="submit" id="submitbtn" class="btn btn-primary btn-md">确认升级</button>
					<br/>
				</form>
				<br/>
				<br/>
				<br/>
				<br/>
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
        var restrictedUploader = new qq.FineUploader({
            element: document.getElementById("fine-uploader"),
            request: {
                endpoint: '${WEB_ROOT_PATH}/admin/fileUpload/commonFile?softName=${data.softName}'
            },
            thumbnails: {
                placeholders: {
                    waitingPath: '${WEB_ROOT_PATH}/static/fine-uploader-5.3.2/fine-uploader/placeholders/waiting-generic.png',
                    notAvailablePath: '${WEB_ROOT_PATH}/static/fine-uploader-5.3.2/fine-uploader/placeholders/not_available-generic.png'
                }
            },
            multiple: false,
            validation: {
                allowedExtensions: ['apk', 'ipk']
            },
            callbacks: {
                onUpload: function(id, name) {
                    $("#submitbtn").attr("disabled", true);
                },
                onComplete: function(id, fileName, data) {
                    if (data.status == 100) {
                        $("#downloadURL").val(data.filePath);
                        $("#size").val(data.size);
                    } else {
                        alert("上传失败！");
                    }
                    $("#submitbtn").attr("disabled", false);
                }
            }
        });
	</script>

</html>