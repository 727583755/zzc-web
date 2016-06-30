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
		<title>用户</title>
		<#include "inc-header-resource.ftl">
	</head>

	<body>
		<div class="container">
			<div class="row">
				<form action="${WEB_ROOT_PATH}/admin/user/save" method="post" class="form-inline" onsubmit="return check()">
					<input type="hidden" name="p" value="${p}">
					<input type="hidden" name="id" value="${data.id}">
					<input type="hidden" name="modifyTime" value="${data.modifyTime}">
					<label class="control-label">用户名</label>
					<input type="text" name="username" id="username" class="form-control" value="${data.username}" <#if data.id != null>readonly="readonly"</#if> >
					<br/>
					<br/>
					
					<label class="control-label">密码</label>
					<input type="text" name="password" id="password" class="form-control" value="${data.password}" >
					<br/>
					<br/>
					
					<label class="control-label">备注</label>
					<input type="text" name="remark" class="form-control" value="${data.remark}">
					<br/>
					<br/>
					<label class="control-label text-danger">权限设置：请先新增用户后，再去设置。</label>
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
			var username = $("#username").val();
			var password = $("#password").val();
			if (username == "" || password == "") {
				alert("用户名或密码不能为空");
				return false;
			}
			var flag = true;
			$.ajax({
				url: "${WEB_ROOT_PATH}/admin/user/checkname",
				dataType: "json",
				async: false,
				data: {
					username: username
				},
				success: function(data) {
					if (data.errCode == 200) {
						alert(data.datas);
						flag = false;
					}
				}
			});
			return flag;
		}
	</script>

</html>