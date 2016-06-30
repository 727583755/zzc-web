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
		<title>用户列表</title>
		<#include "inc-header-resource.ftl">
		<#include "macro.ftl">
	</head>

	<body>
		<div class="container">
			<div class="row">
				<button type="button" class="btn btn-success" onclick="location='${WEB_ROOT_PATH}/admin/user/add'">新增</button>
			</div>
		</div>

		<div class="container">
			<div class="row">
				<form class="form-inline" action="${WEB_ROOT_PATH}/admin/user" method="post">
					<label class="control-label">用户名</label>
					<input type="text" name="search['username']" class="form-control" value="${data.cholder.search['username']}">

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
							<th>用户名</th>
							<th>权限码值</th>
							<th>备注</th>
							<th>注册时间</th>
							<th style="width: 260px;">操作</th>
						</tr>
					</thead>
					<tbody>
						<#list data.result as p>
							<tr>
								<td>${p.username}</td>
								<td>${p.authority}</td>
								<td>${p.remark}</td>
								<td>${(p.registerTime?string("yyyy-MM-dd HH:mm:ss"))?if_exists}</td>
 								<td>
									<button type="button" class="btn btn-primary" onclick="location='${WEB_ROOT_PATH}/admin/user/authority/${p.id}?p=${data.pageNum}'">权限修改</button>
									<button type="button" class="btn btn-warning" onclick="resetPassword(${p.id})">密码重置</button>
									<button type="button" class="btn btn-danger" onclick="deleteOne(${p.id}, ${data.pageNum})">删除</button>
								</td>
							</tr>
						</#list>
					</tbody>
				</table>
			</div>
			<@pager url="${WEB_ROOT_PATH}/admin/user" data=data/>

		</div>
	</body>

	<script>
		function deleteOne(id, pageNum) {
			if (confirm("确定删除该用户吗？")) {
				window.location='${WEB_ROOT_PATH}/admin/user/delete/' + id + '?p=' + pageNum;
			}
		}
	
		function resetPassword(id) {
			if (confirm("确定把密码重置为123456吗？")) {
				$.ajax({
					url: "${WEB_ROOT_PATH}/admin/user/resetPassword/" + id,
					dataType: "json",
					success: function(data) {
						alert(data.datas);
					}
				});
			}
		}
	</script>

</html>