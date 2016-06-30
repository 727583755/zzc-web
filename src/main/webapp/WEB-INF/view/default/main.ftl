<!DOCTYPE HTML>
<html style="width: 100%;height: 100%;">

	<head>
		<title>后台管理系统</title>
		<#assign WEB_ROOT_PATH="${rc.contextPath}">
			<script>
				var webrootpath = "${WEB_ROOT_PATH}"
			</script>
			<#-- 全局webrootpath,供js里面用 -->

				<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
				<link href="${WEB_ROOT_PATH}/static/assets/css/dpl-min.css" rel="stylesheet" type="text/css" />
				<link href="${WEB_ROOT_PATH}/static/assets/css/bui-min.css" rel="stylesheet" type="text/css" />
				<link href="${WEB_ROOT_PATH}/static/assets/css/main-min.css" rel="stylesheet" type="text/css" />
				<script type="text/javascript" src="${WEB_ROOT_PATH}/static/assets/js/jquery-1.8.1.min.js"></script>
				<script type="text/javascript" src="${WEB_ROOT_PATH}/static/assets/js/bui-min.js"></script>
				<script type="text/javascript" src="${WEB_ROOT_PATH}/static/assets/js/common/main-min.js"></script>
				<script type="text/javascript" src="${WEB_ROOT_PATH}/static/assets/js/config-min.js"></script>

				<link rel="stylesheet" type="text/css" href="${WEB_ROOT_PATH}/static/bui/Css/bootstrap.css" />
				<link rel="stylesheet" type="text/css" href="${WEB_ROOT_PATH}/static/bui/Css/bootstrap-responsive.css" />
				<link rel="stylesheet" type="text/css" href="${WEB_ROOT_PATH}/static/bui/Css/style.css" />
				<script type="text/javascript" src="${WEB_ROOT_PATH}/static/bui/Js/ckform.js"></script>
				<script type="text/javascript" src="${WEB_ROOT_PATH}/static/bui/Js/common.js"></script>

				<script>
					BUI.use('common/main', function() {
						var config = [{
							id: '1',
							menu: ${nodeTree}
							}];
						new PageUtil.MainPage({
							modulesConfig: config
						});
					});
				</script>
	</head>

	<body style="height: 100%;">

		<div class="header">
			<div class="dl-title">
				<!--<img src="${WEB_ROOT_PATH}/static/images/gowild_logo.png">-->
			</div>
			<div class="dl-log">欢迎您，<span class="dl-log-user"></span><a href="${WEB_ROOT_PATH}/admin/logout" title="退出系统" class="dl-log-quit">[退出]</a>
			</div>
		</div>

		<div class="content">
			<div class="dl-main-nav" style="display: none;">
				<div class="dl-inform">
					<div class="dl-inform-title"><s class="dl-inform-icon dl-up"></s></div>
				</div>
				<ul id="J_Nav" class="nav-list ks-clear">
					<li class="nav-item dl-selected">
						<div class="nav-item-inner nav-home">管理系统</div>
					</li>
				</ul>
			</div>
			<ul id="J_NavContent" class="dl-tab-conten" style="margin: 0 0;">
			</ul>
		</div>
	</body>

</html>