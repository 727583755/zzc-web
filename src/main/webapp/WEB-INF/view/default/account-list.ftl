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
		<title>用户帐户</title>
		<#include "inc-header-resource.ftl">
		<#include "macro.ftl">
	</head>

	<body>
		<div class="container">
			<div class="row">
			</div>
		</div>

		<div class="container">
			<div class="row">
				<form class="form-inline" action="${WEB_ROOT_PATH}/admin/account" method="post">
					<label class="control-label">用户名</label>
					<input type="text" name="search['username']" class="form-control" value="${data.cholder.search['username']}">
					
					<label class="control-label">昵称</label>
					<input type="text" name="search['nickname']" class="form-control" value="${data.cholder.search['nickname']}">
					
					<label class="control-label">姓别</label>
					<select name="search['sex']" class="form-control">
						<option value="" <#if data.cholder.search[ 'sex']==''>selected</#if>>不限</option>
						<option value="1" <#if data.cholder.search[ 'sex']=='1'>selected</#if>>男</option>
						<option value="0" <#if data.cholder.search[ 'sex']=='0'>selected</#if>>女</option>
					</select>

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
							<th>昵称</th>
							<th>邮箱</th>
							<th>性别 </th>
							<th>生日</th>
							<th>地址</th>
							<th>爱好</th>
							<th>注册时间</th>
							<th>最后活跃时间</th>
							<th style="width: 200px;">操作</th>
						</tr>
					</thead>
					<tbody>
						<#list data.result as p>
							<tr>
								<td>${p.username}</td>
								<td>${p.nickname}</td>
								<td>${p.email}</td>
								<td>
								<#if p.sex == '0'>
								女
								<#else>
								男
								</#if>
								</td>
								<td>${p.birthday}</td>
								<td>${p.address}</td>
								<td>${p.hobby}</td>
								<td>${p.registerTime}</td>
								<td>${p.lastActiveTime}</td>
								<td>
									<button type="button" class="btn btn-danger" onclick="location='${WEB_ROOT_PATH}/admin/account/delete/${p.id}?p=${data.pageNum}'">删除</button>
								</td>
							</tr>
						</#list>
					</tbody>
				</table>
			</div>
			<@pager url="${WEB_ROOT_PATH}/admin/account" data=data/>

		</div>
	</body>

	<script>
		function reomveBind(id) {
			var password = window.prompt("请输入解除绑定密码：");
			if (password == "" || password == null) {
				alert("密码不能为空")
				return;
			}
			$.ajax({
				url: "${WEB_ROOT_PATH}/admin/account/reomveBind",
				dataType: "json",
				data: {
					id: id,
					password:password
				},
				success: function(data) {
					if (data.status == 100) {
						alert("解绑成功！")
					} else {
						alert(data.desc);
					}
				}
			});
		}
		
		function lookupBind(id) {
			$.ajax({
				url: "${WEB_ROOT_PATH}/admin/account/lookupBind",
				dataType: "json",
				data: {
					id: id
				},
				success: function(data) {
					if (data.status == 100) {
						alert("该用户已经绑定机器人，机器人MAC地址为：" + data.mac);
					} else {
						alert(data.desc);
					}
				}
			});
		}
		
	</script>

</html>