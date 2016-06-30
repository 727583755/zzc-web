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
		<title>故事专辑</title>
		<#include "inc-header-resource.ftl">
		<#include "macro.ftl">
	</head>

	<body>
		    <#--<div class="container">
				<div class="row">
					<button type="button" class="btn btn-success" onclick="location='${WEB_ROOT_PATH}/admin/storyalbum/add'">新增</button>
				</div>
			</div>-->

			<div class="container">
				<div class="row">
					<form class="form-inline" action="${WEB_ROOT_PATH}/admin/storyalbum" method="post" id="myForm">
						<label class="control-label">ID</label>
						<input type="text" name="search['id']" class="form-control" value="${data.cholder.search['id']}" style="width:60px;" >
					
						<label class="control-label">标题</label>
						<input type="text" name="search['title']" class="form-control" value="${data.cholder.search['title']}">
						
						<label class="control-label">标签</label>
						<input type="text" name="search['tag']" class="form-control" value="${data.cholder.search['tag']}" id="tag">
						<button type="button" class="btn btn-default btn-group-sm" onclick="selectTag()" >选择</button>

						<label class="control-label">是否上架</label>
						<select name="search['enabled']" class="form-control">
							<option value="" <#if data.cholder.search[ 'enabled']==''>selected</#if>>不限</option>
							<option value="1" <#if data.cholder.search[ 'enabled']=='1'>selected</#if>>上架</option>
							<option value="0" <#if data.cholder.search[ 'enabled']=='0'>selected</#if>>下架</option>
						</select>
						
						<label class="control-label">热度排序</label>
						<select name="search['hotSort']" class="form-control">
							<option value="" <#if data.cholder.search[ 'hotSort']==''>selected</#if>>不限</option>
							<option value="DESC" <#if data.cholder.search[ 'hotSort']=='DESC'>selected</#if>>从高到低</option>
							<option value="ASC" <#if data.cholder.search[ 'hotSort']=='ASC'>selected</#if>>从低到高</option>
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
								<th>ID</th>
								<th>标题</th>
								<th>封面 </th>
								<th>作者</th>
								<th>专辑信息</th>
								<th>专辑标签</th>
								<th>分类</th>
								<th>集数 </th>
								<th>修改时间</th>
								<th>上架</th>
								<th>热度</th>
								<th style="width: 250px;">操作</th>
							</tr>
						</thead>
						<tbody>
							<#list data.result as p>
								<tr>
									<td>${p.id}</td>
									<td>
										<#if p.title?length lt 10 >
											<a href="#" data-toggle="tooltip" title="${p.title}">${p.title}</a>
										<#else>
											<a href="#" data-toggle="tooltip" title="${p.title}">${p.title[0..9]}...</a>
										</#if>
									</td>
									<td><img src="${p.coverUrl}" width="80px" height="80px"></img></td>
									<td>${p.announcerName}</td>
									<td>
										<#if p.albumInfo?length lt 20 >
											<a href="#" data-toggle="tooltip" title="${p.albumInfo}">${p.albumInfo}</a>
										<#else>
											<a href="#" data-toggle="tooltip" title="${p.albumInfo}">${p.albumInfo[0..19]}...</a>
										</#if>
									</td>
									<td>${p.albumTags}</td>
									<td>${p.category}</td>
									<td>${p.storyCount}</td>
									<td>${p.modifyTime}</td>
									<td id="enabled_${p.id}">${p.enabled}</td>
									<td>${p.hot}</td>
									<td>
										<a target="_blank" href="${WEB_ROOT_PATH}/admin/storyalbum/${p.id}?p=${data.pageNum}" ><button type="button" class="btn btn-primary" >修改</button></a>
										<button type="button" class="btn <#if p.enabled == 0>btn-success<#else>btn-warning</#if>" onclick="changeStatus(${p.id}, this)" ><#if p.enabled == 0>上架<#else>下架</#if></button>
										<button type="button" class="btn btn-primary" onclick="collapse('#detail_${p.id}', ${p.id})" >展开</button>
									</td>
								</tr>
								<tr id="detail_${p.id}" class="collapse">
									<td colspan="15">
										 <table class="table table-striped table-bordered table-hover">
								            <thead>
								                <tr>
								                	<th>id</th>
								                	<th>标题</th>
								                	<th>文件路径</th>
								                	<th>大小（B）</th>
								                	<th>时长</th>
								                	<th>播放次数</th>
								                	<th>作者</th>
								                	<th>第几集</th>
								                	<#--<th>操作</th>-->
								                </tr>
								            </thead>
								            <tbody id="info_${p.id}">
																				                
								            </tbody>
								        </table>
									</td>
								</tr>
							</#list>
						</tbody>
					</table>
				</div>
				<@pager url="${WEB_ROOT_PATH}/admin/storyalbum" data=data/>
				
				<!-- 模态框（Modal） -->
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				   <div class="modal-dialog">
				      <div class="modal-content">
				         <div class="modal-header">
				            <button type="button" class="close" 
				               data-dismiss="modal" aria-hidden="true">
				                  &times;
				            </button>
				            <h4 class="modal-title">
				            	快捷输入标签
				            </h4>
				         </div>
				         <div class="modal-body" style="height: 350px;overflow:auto;" id="myContent">
				         	<ul>
								<div class="checkbox">
									<label><input type="checkbox" value="儿童" />儿童</label>
								</div>
								<div class="checkbox"><label><li style="list-style-type: none">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" value="胎教母婴" />胎教母婴</li></label></div>
								<div class="checkbox"><label><li style="list-style-type: none">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" value="睡前故事" />睡前故事</li></label></div>
								<div class="checkbox"><label><li style="list-style-type: none">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" value="童话故事" />童话故事</li></label></div>
								<div class="checkbox"><label><li style="list-style-type: none">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" value="儿童读物" />儿童读物</li></label></div>
								<div class="checkbox"><label><li style="list-style-type: none">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" value="绘本故事" />绘本故事</li></label></div>
								<div class="checkbox"><label><li style="list-style-type: none">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" value="影视动漫" />影视动漫</li></label></div>
								<div class="checkbox"><label><li style="list-style-type: none">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" value="儿童教育" />儿童教育</li></label></div>
								<div class="checkbox"><label><li style="list-style-type: none">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" value="儿童学习" />儿童学习</li></label></div>
								<div class="checkbox"><label><li style="list-style-type: none">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" value="儿童科普" />儿童科普</li></label></div>
								
								<div class="checkbox">
									<label><input type="checkbox" value="相声小品评书" />相声小品评书</label>
								</div>
								<div class="checkbox"><label><li style="list-style-type: none">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" value="相声" />相声</li></label></div>
								<div class="checkbox"><label><li style="list-style-type: none">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" value="小品" />小品</li></label></div>
								<div class="checkbox"><label><li style="list-style-type: none">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" value="评书" />评书</li></label></div>
								
								<div class="checkbox">
									<label><input type="checkbox" value="脱口秀" />脱口秀</label>
								</div>
								<div class="checkbox"><label><li style="list-style-type: none">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" value="大咖说" />大咖说</li></label></div>
								<div class="checkbox"><label><li style="list-style-type: none">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" value="我的世界观" />我的世界观</li></label></div>
								
								<div class="checkbox">
									<label><input type="checkbox" value="有声书" />有声书</label>
								</div>
								<div class="checkbox"><label><li style="list-style-type: none">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" value="历史军事" />历史军事</li></label></div>
								<div class="checkbox"><label><li style="list-style-type: none">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" value="浪漫言情" />浪漫言情</li></label></div>
								<div class="checkbox"><label><li style="list-style-type: none">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" value="恐怖悬疑" />恐怖悬疑</li></label></div>
								<div class="checkbox"><label><li style="list-style-type: none">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" value="探案推理" />探案推理</li></label></div>
								<div class="checkbox"><label><li style="list-style-type: none">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" value="玄幻奇幻" />玄幻奇幻</li></label></div>
								<div class="checkbox"><label><li style="list-style-type: none">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" value="文学名著" />文学名著</li></label></div>
								<div class="checkbox"><label><li style="list-style-type: none">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" value="武侠仙侠" />武侠仙侠</li></label></div>
								<div class="checkbox"><label><li style="list-style-type: none">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" value="官场商战" />官场商战</li></label></div>
							</ul>
				         </div>
				         <div class="modal-footer">
				            <button type="button" class="btn btn-warning" id="submitbtn">
				               确认
				            </button>
				         </div>
				      </div><!-- /.modal-content -->
				</div><!-- /.modal -->
			
			</div>
	</body>

	<script>
	function collapse(who, storyAlbumId) {
		$(who).collapse('toggle');
		var tboty = $("#info_" + storyAlbumId);
		$.ajax({
        	url: "${WEB_ROOT_PATH}/admin/storyalbum/getStoryByStoryAlbumId",
            dataType : "json",
            type: "post",
            data: {
                storyAlbumId: storyAlbumId
			},
            success: function(data) {
            	tboty.empty();
                for(var i=0; i<data.length; i = i+1){
                	var d = data[i];
                	var tr = "<tr>";
                	tr += "<td>" + d.id + "</td>";
                	tr += "<td>" + (d.title==null?"":d.title) + "</td>";
                	
                	if (d.filePath.indexOf("http://") == -1) {
                		tr += '<td>' + '<a href="javascript:void(0)" onclick="listenIt(\'${baseUrl}' + d.filePath + '\', this)">${baseUrl}' + (d.filePath==null?"":d.filePath) + '</td>';               	
                	} else {
                		tr += '<td>' + '<a href="javascript:void(0)" onclick="listenIt(\'' + d.filePath + '\', this)">' + (d.filePath==null?"":d.filePath) + '</td>';               	
                	}
                	
                	tr += "<td>" + (d.fileSize==null?"":d.fileSize) + "</td>";
                	tr += "<td>" + (d.duration==null?"":d.duration) + "</td>";
                	tr += "<td>" + (d.playCount==null?"":d.playCount) + "</td>";
                	tr += "<td>" + (d.announcerName==null?"":d.announcerName) + "</td>";
                	tr += "<td>" + (d.orderNum==null?"":d.orderNum) + "</td>";
                	//tr += '<td><button type="button" class="btn btn-primary" onclick="redirect(' + d.id + ')">修改</button></td>';
                	tr += "</tr>";
                	tboty.append(tr);
                }
            }
         });
	}
	
	function redirect(id) {
		window.open('${WEB_ROOT_PATH}/admin/storytitle/story/query/' + id + '?p=${data.pageNum}', '_blank');
	}
	
	function listenIt(url, who) {
		var audio = '<audio controls>'
		audio += '<source src="' + url + '" type="audio/mpeg">您的浏览器不支持 audio 元素。';
		audio += '<source src="' + url + '" type="audio/ogg">您的浏览器不支持 audio 元素。';
		audio += '</audio>';
		$(who).parent().children().remove("audio");
		$(who).parent().append(audio);
	}
	
	function deleteStoryTitle(id) {
		var password = window.prompt("输入删除密码：")
		if (password != "" && password != null) {
			window.location="${WEB_ROOT_PATH}/admin/storyalbum/delete/" + id + "?p=${data.pageNum}&password=" + password;
		}
	}
	
	function changeStatus(id, who) {
		var enabled = $("#enabled_" + id).text();
		if (enabled == 0) {
			enabled = 1;
			$("#enabled_" + id).text(enabled);
			$(who).addClass("btn-warning");
			$(who).text("下架");
		} else if (enabled == 1) {
			enabled = 0;
			$("#enabled_" + id).text(enabled);
			$(who).removeClass("btn-warning");
			$(who).addClass("btn-success");
			$(who).text("上架");
		}
		
		$.ajax({
        	url: "${WEB_ROOT_PATH}/admin/storyalbum/changeStatus",
            dataType : "json",
            type: "post",
            data: {
                id: id,
                enabled:enabled
			},
            success: function(data) {
            	
            }
         });
	}
	
	function selectTag() {
		$('#myModal').modal('show');
		checkTag();
		$("#submitbtn").bind("click", function() {
			var tagStr = "";
			$("#myContent input:checked").each(function(i){
			   tagStr += $(this).val() + ";";
			});
			$("#tag").val(tagStr);
			$('#myModal').modal('hide');
			$("#myForm").submit();
		})
	}
	
	function checkTag() {
		var tagStr = $("#tag").val();
		var arr = tagStr.split(";")
		$("#myContent input").each(function(i) {
			if (tagStr.indexOf($(this).val()) != -1) {
				$(this).attr("checked", true);
			}
		});
	}
	
	function exportExcel() {
		if (window.confirm("确定导出到Excel吗？")) {
			var form = $("#myForm");
			var action = form.attr("action") + "/exportExcel";
			window.location=action + '?' + form.serialize();
		}
	}
	
	</script>

</html>