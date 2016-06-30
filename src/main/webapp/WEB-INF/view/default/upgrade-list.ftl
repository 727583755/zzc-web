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
		<title>升级列表</title>
		<#include "inc-header-resource.ftl">
		<#include "macro.ftl">
	</head>

	<body>
		<div class="container">
			<div class="row">
				<label class="control-label">类别</label>
				<select name="type" class="form-control" onchange="sendRequest(this.value)">
					<option value="0" <#if type=='' || type == 0>selected</#if>>小小白机器人</option>
					<option value="1" <#if type==1 >selected</#if>>安卓手机APK</option>
					<option value="2" <#if type==2 >selected</#if>>IOS手机</option>
				</select>
			</div>
		</div>
		<br/>
		
		<div class="container">
			<div class="row">
				<table class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<th>操作</th>
							<th>名字</th>
							<th>版本</th>
							<th>版本编号 </th>
							<th>更新时间</th>
							<th>下载地址</th>
							<th>升级描述</th>
							<th>大小（B）</th>
							<th>修改时间 </th>
						</tr>
					</thead>
					<tbody>
						<#list data.result as p>
							<tr>
								<td>
									<button type="button" class="btn btn-primary" onclick="location='${WEB_ROOT_PATH}/admin/upgrade/${p.id}?p=${data.pageNum}'">升级</button>
								</td>
								<td>${p.softName}</td>
								<td>${p.version}</td>
								<td>${p.versionCode}</td>
								<td>${(p.updateTime?string("yyyy-MM-dd HH:mm:ss"))?if_exists}</td>
								<td>${p.downloadURL}</td>
								<td>${p.displayMessage}</td>
								<td>${p.size}</td>
								<td>${(p.modifyTime?string("yyyy-MM-dd HH:mm:ss"))?if_exists}</td>
							</tr>
						</#list>
					</tbody>
				</table>
			</div>
			
		</div>
	</body>
	<script>
		function sendRequest(type) {
			window.location='${WEB_ROOT_PATH}/admin/upgrade?type=' + type;
		}
		
	</script>

</html>