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
		<title>标签</title>
		<#include "inc-header-resource.ftl">
	</head>

	<body>
		<div class="container">
			<div class="row">
				<form action="${WEB_ROOT_PATH}/admin/tag/save" method="post" class="form-inline" onsubmit="return check()">
					<input type="hidden" name="p" value="${p}">
					<input type="hidden" name="id" value="${data.id}">
					<input type="hidden" name="modifyTime" value="${data.modifyTime}">
					<label class="control-label">标签名字</label>
					<input type="text" name="name" id="name" class="form-control" value="${data.name}">
					<br/>
					<br/>

					<label class="control-label">标签类型</label>
					<select name="type" class="form-control" id="type">
						<option value="" <#if data.type==''>selected</#if>>请选择</option>
						<#list typeList as p>
							<option value="${p}" <#if data.type=='${p}'>selected</#if>>${p}</option>
						</#list>
					</select>
					<br/>
					<br/>

					<label class="control-label">标签同步标志</label>
					<select name="flag" class="form-control">
						<option value="1" <#if data.flag=='1'>selected</#if>>未同步</option>
						<option value="0" <#if data.flag=='0'>selected</#if>>已同步</option>
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
		function check() {
			var type = $("#type").val();
			var name = $("#name").val();
			if ($.trim(name) == "") {
				alert("标签名不能为空");
				return false;
			}
			if (type == "") {
				alert("请选择类型");
				return false;
			}
			return true;
		}
	</script>

</html>