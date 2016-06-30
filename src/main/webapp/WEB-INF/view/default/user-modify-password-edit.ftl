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
		<title>修改密码</title>
		<#include "inc-header-resource.ftl">
	</head>

	<body>
		<div class="container">
			<div class="row">
				<form action="" method="post" class="form-inline" onsubmit="return check()">
					<label class="control-label">新密码</label>
					<input type="text" name="password" id="password" class="form-control">
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
		function check() {
			$.ajax({
				url: "${WEB_ROOT_PATH}/admin/user/modifypassword/start",
				dataType: "json",
				data: {
					password:$("#password").val()
				},
				success: function(data) {
					alert(data.desc);
				}
			});
			return false;
		}
	</script>

</html>