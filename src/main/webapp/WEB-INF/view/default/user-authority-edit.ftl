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
		<title>权限设置</title>
		<#include "inc-header-resource.ftl">
	</head>

	<body>
		<div class="container">
			<div class="row">
				<form role="form-inline">
					<label class="control-label">用户</label>
					<input type="text" value="${data.username}" class="form-control" readonly="readonly"/>
					<br />
					<label class="control-label">用户权限</label>
					<div id="authorityNum"></div>
				</form>
			</div>
			<button class="btn btn-group-lg btn-primary" onclick="saveAuthority(${data.id})" >确认权限，并保存</button>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
		</div>

	</body>
	<script>
		$(function(){
			var tree = ${authorityTree};
			var htmlStr = "";
			for (var i=0; i<tree.length; i++) {
				var obj = tree[i];
				var subStr = "<ul>"
				if (obj.hasRight) {
					subStr += '<div class="checkbox"><label><input type="checkbox" checked value="' + obj.authorityNum + '" />' + obj.name + '</label></div>';
				} else {
					subStr += '<div class="checkbox"><label><input type="checkbox" value="' + obj.authorityNum + '" />' + obj.name + '</label></div>';
				}
				
				for (var j=0; j<obj.items.length; j++) {
					if (obj.items[j].hasRight) {
						subStr += '<div class="checkbox"><label><li style="list-style-type: none">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" checked value="' + obj.items[j].authorityNum + '" />' + obj.items[j].name + '（' + obj.items[j].url + '）</li></label></div>';
					} else {
						subStr += '<div class="checkbox"><label><li style="list-style-type: none">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" value="' + obj.items[j].authorityNum + '" />' + obj.items[j].name + '（' + obj.items[j].url + '）</li></label></div>';
					}
				}
				subStr += "</ul>";
				htmlStr += subStr;
			}
			$("#authorityNum").append(htmlStr);
		})
		
		function saveAuthority(id) {
			var authoritys = "";
			$("input:checked").each(function(){
				authoritys += $(this).val() + ",";
			});
			
			window.location="${WEB_ROOT_PATH}/admin/user/authority/save/" + id + "?authoritys=" + authoritys;
		}
	</script>

</html>