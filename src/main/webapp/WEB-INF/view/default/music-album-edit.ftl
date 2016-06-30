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
		<title>音乐专辑信息</title>
		<#include "inc-header-resource.ftl">
		<#include "inc-fine-upload.ftl" />
		<#include "inc-autocomplete.ftl">
	</head>

	<body>
		<div class="container">
			<div class="row">
				<form action="${WEB_ROOT_PATH}/admin/musicalbum/save" method="post" class="form-inline">
					<input type="hidden" name="p" value="${p}">
					<input type="hidden" name="id" value="${data.id}">
					<input type="hidden" name="modifyTime" value="${data.modifyTime}">
					<input type="hidden" name="category" value="${data.category}">

					<label class="control-label">专辑名</label>
					<input type="text" name="title" class="form-control" value="${data.title}">
					<span class="text-danger">不能为空</span>
					<br/>
					<br/>
					<label class="control-label">封面图片地址</label>
					<input type="text" name="coverUrl" id="coverUrl" id="coverUrl" style="width:600px;" class="form-control" value="${data.coverUrl}" readonly="readonly">
                    <div id="fileUpload"></div>
					<br/>
					<br/>
					<label class="control-label">作者名</label>
					<input type="text" name="announcerName" id="announcerName" class="form-control" value="${data.announcerName}">
					<br/>
					<br/>
					<label class="control-label">作者ID</label>
					<input type="text" name="announcerId" id="announcerId" class="form-control" value="${data.announcerId}" readonly="readonly">
					<br/>
					<br/>
					<label class="control-label">专辑信息</label>
					<textarea class="form-control" rows="3" cols="100" name="albumInfo">${data.albumInfo}</textarea>
					<br/>
					<br/>
					<label class="control-label">专辑标签</label>
					<input type="text" name="albumTags" class="form-control" value="${data.albumTags}">
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
                        $("#coverUrl").val(data.filePath);
                    } else {
                        alert("上传失败！");
                    }
                    $("#submitbtn").attr("disabled", false);
                }
            }
        });

        $(function(){
            $("#announcerName").autocomplete({
                autoFocus: true,
                select: function(event, ui) {
					$("#announcerId").val(ui.item.announcerId);
				},
                source: function(request, response) {
                    $.ajax({
                        url: webrootpath + "/rest/autocomplete/getSingerByName",
                        dataType : "json",
                        type: "post",
                        data: {
                            name: request.term
                        },
                        success: function(data) {
                            response($.map(data.datas, function(item){
                                return {
                                    label : item.id + "--" + item.name + "--" + item.nationality,
                                    value : item.name,
                                    announcerId : item.id
                                };
                            }));
                        }
                    });
                }
            });
        })
	</script>
	
</html>