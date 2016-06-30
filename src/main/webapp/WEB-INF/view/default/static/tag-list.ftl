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
		<title>标签列表</title>
		<#include "inc-header-resource.ftl">
			<#include "macro.ftl">
	</head>

	<body>
		<div class="container">
			<div class="row">
				<button type="button" class="btn btn-success" onclick="location='${WEB_ROOT_PATH}/admin/tag/add'">新增</button>
			</div>
		</div>

		<div class="container">
			<div class="row">
				<form class="form-inline" action="${WEB_ROOT_PATH}/admin/tag" method="post">
					<label class="control-label">标签名字</label>
					<input type="text" name="search['name']" class="form-control" value="${data.cholder.search['name']}">

					<label class="control-label">标签类型</label>
					<select name="search['type']" class="form-control">
						<option value="" <#if data.cholder.search[ 'type']==''>selected</#if>>不限</option>
						<#list typeList as p>
							<option value="${p}" <#if data.cholder.search[ 'type']=='${p}'>selected</#if>>${p}</option>
						</#list>
					</select>

					<label class="control-label">同步标志</label>
					<select name="search['flag']" class="form-control">
						<option value="" <#if data.cholder.search[ 'flag']==''>selected</#if>>不限</option>
						<option value="0" <#if data.cholder.search[ 'flag']=='0'>selected</#if>>已同步</option>
						<option value="1" <#if data.cholder.search[ 'flag']=='1'>selected</#if>>未同步</option>
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
							<th>id</th>
							<th>标签名字</th>
							<th>标签类型</th>
							<th>标签同步标志</th>
							<th>修改时间</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<#list data.result as p>
							<tr>
								<td>${p.id}</td>
								<td>${p.name}</td>
								<td>${p.type}</td>
								<td>${p.flag}</td>
								<td>${(p.modifyTime?string("yyyy-MM-dd HH:mm:ss"))?if_exists}</td>
								<td>
									<button type="button" class="btn btn-primary" onclick="location='${WEB_ROOT_PATH}/admin/tag/${p.id}?p=${data.pageNum}'">修改</button>
									<button type="button" class="btn btn-danger" onclick="deleteById(${p.id}, this)" >删除</button>
								</td>
							</tr>
						</#list>
					</tbody>
				</table>
			</div>
			<@pager url="${WEB_ROOT_PATH}/admin/tag" data=data/>

		</div>
	</body>

	<script>
		function deleteById(id, who) {
			$.ajax({
				url: "${WEB_ROOT_PATH}/admin/tag/delete/" + id,
				dataType: "json",
				success: function(data) {
					$(who).parentsUntil("tr").parent().remove();
				}
			});
		}
	</script>

</html>