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
		<title>技能包列表</title>
		<#include "inc-header-resource.ftl">
		<#include "macro.ftl">
	</head>

	<body>
		<div class="container">
			<div class="row">
				<button type="button" class="btn btn-success" onclick="location='${WEB_ROOT_PATH}/admin/skill/add'">新增</button>
				<#--
				<div id="fine-uploader"><span id="uploadtrip"></span></div>
				-->
			</div>
		</div>

		<div class="container">
			<div class="row">
				<form class="form-inline" action="${WEB_ROOT_PATH}/admin/skill" method="post">
					<label class="control-label">技能名称</label>
					<input type="text" name="search['skillName']" class="form-control" value="${data.cholder.search['skillName']}">

					<label class="control-label">技能状态</label>
                    <select name="search['skillStatus']" class="form-control">
                        <option value="-1" <#if data.cholder.search[ 'skillStatus']==''>selected</#if>>不限</option>
                        <option value="0" <#if data.cholder.search[ 'skillStatus']=='0'>selected</#if>>未启用</option>
                        <option value="1" <#if data.cholder.search[ 'skillStatus']=='1'>selected</#if>>已解锁</option>
                        <option value="2" <#if data.cholder.search[ 'skillStatus']=='2'>selected</#if>>未解锁</option>
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
							<th>技能名称</th>
							<th>技能状态</th>
							<th>耗费金币 </th>
                            <th>未启用图片 </th>
                            <th>未解锁图片 </th>
                            <th>已解锁图片 </th>
							<th style="width: 130px;">操作</th>
						</tr>
					</thead>
					<tbody>
						<#list data.result as p>
							<tr>
								<td>${p.id}</td>
								<td>${p.skillName}</td>
								<td>
									<#if p.skillStatus=='0'>未启用
										<#elseif p.skillStatus=='1'>已解锁
										<#elseif p.skillStatus=='2'>未解锁
									</#if>
								</td>
								<td>${p.costCoin}</td>
                                <td><img src="http://www.gowild.top:1234${p.skillIconUnused}" /> </td>
                                <td><img src="http://www.gowild.top:1234${p.skillIconLocked}" /> </td>
                                <td><img src="http://www.gowild.top:1234${p.skillIconUnlocked}" /> </td>
								<td>
									<button type="button" class="btn btn-primary" onclick="location='${WEB_ROOT_PATH}/admin/skill/${p.id}?p=${data.pageNum}'">修改</button>
									<button type="button" class="btn btn-danger" onclick="location='${WEB_ROOT_PATH}/admin/skill/delete/${p.id}?p=${data.pageNum}'">删除</button>
								</td>
							</tr>
						</#list>
					</tbody>
				</table>
			</div>
			<@pager url="${WEB_ROOT_PATH}/admin/skill" data=data/>

		</div>
	</body>

</html>