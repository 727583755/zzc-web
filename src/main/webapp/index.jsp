<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<style>
html,body{margin:0;padding:0;width:100%;height:100%;}
body{background: #000;font-size:18px;font-family: "微软雅黑";color:#333;line-height:160%;text-align:center;}
h1{text-shadow: 0 0 10px #82cef3,
                   0 0 20px #82cef3;
}
form input{
     width:200px;
     height:25px;
     border-radius:5px;
	background: #111;
	border: 1px solid #000;
	padding: 5px;
	color: #444;
	font-size: 16px;
  }
form input:focus{
	color: #FFF;
	box-shadow:0 0 10px #82cef3,
     0 0 20px #82cef3;
}
form input[type="submit"]{
  margin-right:30px;
  width:100px;
  height:30px;
}
div{margin:0 auto;}
.login{
  width:50%;
  height:50%;
  margin-top:80px;
  padding:20px;
  background-color:#204077;
  color:white;
  border-radius:10px;
  box-shadow: 0 0 20px 8px #fff
}
.login div{
   padding-bottom:10px;
   width:300px;
}
.btn{
   text-align:right;
}
.submit {
	background-color: #1B3160;
	background: -webkit-gradient(linear, left top, left bottom, from(#1B3160), to(#82cef3));
	background: -webkit-linear-gradient(top, #1B3160, #82cef3);
	background: -moz-linear-gradient(top, #1B3160, #82cef3);
	background: -ms-linear-gradient(top, #1B3160, #82cef3);
	background: -o-linear-gradient(top, #1B3160, #82cef3);
	background: linear-gradient(top, #1B3160, #82cef3);
	border: 1px solid #82cef3;
	border-bottom: 1px solid #82cef3;
	border-radius: 3px;
	-webkit-border-radius: 3px;
	-moz-border-radius: 3px;
	-ms-border-radius: 3px;
	-o-border-radius: 3px;
	box-shadow: inset 0 1px 0 0 #204077;
	-webkit-box-shadow: 0 1px 0 0 #204077 inset ;
	-moz-box-shadow: 0 1px 0 0 #204077 inset;
	-ms-box-shadow: 0 1px 0 0 #204077 inset;
	-o-box-shadow: 0 1px 0 0 #204077 inset;
	color: white;
	font-weight: bold;
	padding: 6px 20px;
	text-align: center;
	text-shadow: 0 -1px 0 #204077;
}
.submit:hover {
	opacity:.85;
	cursor: pointer; 
}
.submit:active {
	border: 1px solid #20911e;
	box-shadow: 0 0 10px 5px #356b0b inset; 
	-webkit-box-shadow:0 0 10px 5px #356b0b inset ;
	-moz-box-shadow: 0 0 10px 5px #356b0b inset;
	-ms-box-shadow: 0 0 10px 5px #356b0b inset;
	-o-box-shadow: 0 0 10px 5px #356b0b inset;
	
}
</style>
<script>
	if (top.location != self.location) {
		top.location = self.location;
	}
	window.onload=function(){window.document.getElementById("username").focus();}
	
	function cleartrip() {
		document.getElementById("trip").innerHTML = "";
	}
	
</script>
</head>
<body>
	<div>
		<div>
			<h1 style="color: white; padding-top: 45px;">小小白后台管理系统</h1>
		</div>
		<form method="post" action="<%=request.getContextPath()%>/login">
			<div class="login">
				<div>
					<h1>用户登录</h1>
				</div>
				<div>
					<label for="username">用户名</label><input id="username"
						placeholder="username" type="text" name="username">
				</div>
				<div>
					<label for="password">密　码</label><input id="password"
						placeholder="password" type="password" name="password" onfocus="cleartrip()">
				</div>
				<span style="color:red;" id="trip">
					<%
						if(request.getParameter("trip") != null) {
					%>
						<%=request.getParameter("trip")%>
					<%
						}
					%>
				</span>
				<div class="btn">
					<input class="submit" type="submit" value="登录" />
				</div>
			</div>
		</form>
	</div>
</body>
</html>