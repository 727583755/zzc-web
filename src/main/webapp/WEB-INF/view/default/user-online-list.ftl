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
		<title>用户在线图</title>
		<#include "inc-header-resource.ftl">
		<#include "macro.ftl">
		<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=BW4foyZ5IFK74zPQs1EQZKdx"></script>
	</head>

	<body>
		<div class="container">
			<div class="row text-center">
				<div class="col-md-12 text-center">
					<span>当前在线：<span class="text-info" style="font-size:20px;" id="onlineCnt"></span>个。 共：<span class="text-info" style="font-size:20px;" id="allCnt"></span>个。&nbsp;&nbsp;</span>
					<span id="secondText" style="font-size:20px;" class="text-danger" ></span>秒后刷新
					<button class="btn btn-success" onclick="refresh()" id="refreshBtn">立即刷新</button>
				</div>
			</div>
		</div>
		
		<div class="container">
			<div class="row">
				<div id="allmap" style="width: 100%; height: 700px;"></div>
			</div>
		</div>
		<br/>
		<br/>
		
		<div class="container">
			<div class="row">
				<table class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<th>省份</th>
							<th>城市</th>
							<th>在线数/总数 </th>
						</tr>
					</thead>
					<tbody>
						<#list data as p>
							<tr>
								<td>${p[0]}</td>
								<td>${p[1]}</td>
								<td>${p[2]?default(0)}/${p[3]}</td>
							</tr>
						</#list>
					</tbody>
				</table>
			</div>
		<div>
	</body>


	<script type="text/javascript">
		var map = new BMap.Map("allmap");    // 创建Map实例
		map.centerAndZoom(new BMap.Point(106.010291,35.651727), 5);
		map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
		
		refresh();
		
		function refresh() {
			refreshCnt();
			
			$("#refreshBtn").html("正在刷新中...");
			$('#secondText').text("");
			$("#refreshBtn").attr("disabled", false);
			$.ajax({
				url: "${WEB_ROOT_PATH}/rest/robotonline/getAllRobot",
				dataType: "json",
				success: function(data) {
					$("#refreshBtn").html("立即刷新");
					timerRefresh()
					if (data.errCode == 100) {
						removeOverlay();
						var d = data.datas;
						var markers = new Array();
						for (var i=0; i<d.length; i++) {
							var point  = new BMap.Point(d[i].lng, d[i].lat);
							var myIcon = new Object();
							if (d[i].hasOnline == true) {
								myIcon = new BMap.Icon("../static/images/online.png", new BMap.Size(15,15))
							} else {
								myIcon = new BMap.Icon("../static/images/offline.png", new BMap.Size(15,15))
							}
							
							var marker = new BMap.Marker(point,{icon:myIcon}); 
							
							markers.push(marker);
						}
						addOverlay(markers);
					}
				}
			});
		}
		
		function refreshCnt() {
			$.ajax({
				url: "${WEB_ROOT_PATH}/rest/robotonline/getRobotCnt",
				dataType: "json",
				success: function(data) {
					if (data.errCode == 100) {
						$("#onlineCnt").text(data.onlineCnt);
						$("#allCnt").text(data.allCnt);
					}
				}
			});
		}
		
		//添加覆盖物
		function addOverlay(markers){
			for (var i=0; i<markers.length; i++) {
				map.addOverlay(markers[i]); 
			}
		}
		
		//清除覆盖物
		function removeOverlay() {
			map.clearOverlays();         
		} 
		
		var timers = new Array();
		function timerRefresh() {
			for (var i=0; i<timers.length; i++) {
				clearTimeout(timers[i]);
			}
			
			var seconds = 180;
			for (var i=seconds; i>=0; i--) {
				var timerId = setTimeout("$('#secondText').text('" + i + "')",1000*(seconds-i+1))
				if (i == 0) {
					timerId = setTimeout("refresh()",1000*(seconds-i+1))
				}
				timers.push(timerId);
			}
		}
	</script>
	
</html>