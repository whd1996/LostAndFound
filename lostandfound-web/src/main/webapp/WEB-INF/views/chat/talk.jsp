<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getServerName() + ":"
			+ request.getServerPort() + path + "/";
	String basePath2 = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
"http://www.w3.org/TR/html4/strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<script type="text/javascript" src="<%=basePath2%>static/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="<%=basePath2%>static/js/json2.js"></script>
<script type="text/javascript" src="<%=basePath2%>static/js/sockjs.min.js"></script>
<script type="text/javascript" src="<%=basePath2%>static/js/jquery.cookie.js"></script>
<style>
textarea {
	height: 300px;
	width: 100%;
	resize: none;
	outline: none;
}

input[type=button] {
	float: right;
	margin: 5px;
	width: 50px;
	height: 35px;
	border: none;
	color: white;
	font-weight: bold;
	outline: none;
}

.clear {
	background: red;
}

.send {
	background: green;
}

.clear:active {
	background: yellow;
}

.send:active {
	background: yellow;
}

.msg {
	width: 100%;
	height: 25px;
	outline: none;
}

#content {
	border: 1px solid gray;
	width: 100%;
	height: 400px;
	overflow-y: scroll;
}

.from {
	background-color: green;
	width: 80%;
	border-radius: 10px;
	height: 30px;
	line-height: 30px;
	margin: 5px;
	float: left;
	color: white;
	padding: 5px;
	font-size: 22px;
}

.to {
	background-color: gray;
	width: 80%;
	border-radius: 10px;
	height: 30px;
	line-height: 30px;
	margin: 5px;
	float: right;
	color: white;
	padding: 5px;
	font-size: 22px;
}

.name {
	color: gray;
	font-size: 12px;
}

.tmsg_text {
	color: white;
	background-color: rgb(47, 47, 47);
	font-size: 18px;
	border-radius: 5px;
	padding: 2px;
}

.fmsg_text {
	color: white;
	background-color: rgb(66, 138, 140);
	font-size: 18px;
	border-radius: 5px;
	padding: 2px;
}

.sfmsg_text {
	color: white;
	background-color: rgb(148, 16, 16);
	font-size: 18px;
	border-radius: 5px;
	padding: 2px;
}

.tmsg {
	clear: both;
	float: right;
	width: 80%;
	text-align: right;
}

.fmsg {
	clear: both;
	float: left;
	width: 80%;
}
</style>
<script>
		var path = '<%=basePath%>';
		var uid=${user eq null ? -1 : user.id};
		//alert(uid);
		if(uid == -1){
			location.href="<%=basePath2%>";
		}
		var from=uid;
		var fromName='${user.userName}';
		var to = uid == 1 ? 2:1;

		var websocket;
		if ('WebSocket' in window) {
			websocket = new WebSocket("ws://" + path + "/ws?uid="+uid);
		} else if ('MozWebSocket' in window) {
			websocket = new MozWebSocket("ws://" + path + "/ws"+uid);
		} else {
			websocket = new SockJS("http://" + path + "/ws/sockjs"+uid);
		}
		websocket.onopen = function(event) {
			console.log("WebSocket:已连接");
			console.log(event);
		};
		websocket.onmessage = function(event) {
			var data=JSON.parse(event.data);
			console.log("WebSocket:收到一条消息",data);
			var textCss = data.from == -1 ? "sfmsg_text" : "fmsg_text";
			$("#content").append("<div class='fmsg'><label class='name'>"+data.fromName+"&nbsp;"+data.date+"</label><div class='"+textCss+"'>"+data.text+"</div></div>");
			scrollToBottom();
			
			//把聊天记录保存到本地cookie
			common.saveCookie("${user.userName}", $("#content").html(), 7);
		};
		websocket.onerror = function(event) {
			console.log("WebSocket:发生错误 ");
			console.log(event);
		};
		websocket.onclose = function(event) {
			console.log("WebSocket:已关闭");
			console.log(event);
		}
		
		function sendMsg(){
				var v = $("#msg").val();
				if(v == ""){
					return;
				}else{
					var data={};
					data["from"]=from;
					data["fromName"]=fromName;
					data["to"]=to;
					data["text"]=v;
					websocket.send(JSON.stringify(data));
					$("#content").append("<div class='tmsg'><label class='name'>我&nbsp;"+new Date().Format("yyyy-MM-dd hh:mm:ss")+"</label><div class='tmsg_text'>"+data.text+"</div></div>");
					scrollToBottom();
					$("#msg").val("");
				}
				
				//把聊天记录保存到本地cookie
				common.saveCookie("${user.userName}", $("#content").html(), 7);
			}
			
			function scrollToBottom(){
				var div = document.getElementById('content');
				div.scrollTop = div.scrollHeight;
			}
			
			Date.prototype.Format = function (fmt) { //author: meizz 
			    var o = {
			        "M+": this.getMonth() + 1, //月份 
			        "d+": this.getDate(), //日 
			        "h+": this.getHours(), //小时 
			        "m+": this.getMinutes(), //分 
			        "s+": this.getSeconds(), //秒 
			        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
			        "S": this.getMilliseconds() //毫秒 
			    };
			    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
			    for (var k in o)
			    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
			    return fmt;
			}
			
		//支持Enter发送
		document.onkeydown = function send(e){
			if(!e) e = window.event;
			if((e.keyCode || e.which) == 13){ // e.keyCode IE e.which Firefox
				sendMsg();				
			}
		}
		
		// 清除
		function clearAll(){
			$("#content").empty();
		}
						
		$(function (){
			var cookieData = common.getCookie("${user.userName}");
			console.log("cookieData: " +cookieData);
			if(cookieData != null && cookieData != ""){
				$("#content").html(cookieData);
			} else {
				$("#content").html("");
			}
			
			//common.delCookie("${user.userName}")
		});
		
	</script>
</head>
<body>
	欢迎：${sessionScope.user.userName}
	<div id="content"></div>
	<input type="text" placeholder="请输入要发送的信息" id="msg" class="msg">
	<input type="button" value="发送" class="send" onclick="sendMsg();" >
	<input type="button" value="清空" class="clear" onclick="clearAll();">
	
	
	<script type="text/javascript">
	
	var common = {};
	common.saveCookie = function(cookieKey, cookieValue, expiresNum) {

        var options = {
            'path': '/',
            'domain': '', //common.saveCookie
            'secure': false,//关闭https传输cookie
            'raw': true,//关闭cookie的自动编码功能
            'expires': expiresNum || 30 //cookie的过期时间，如没有传值默认30天过期
        };

        $.cookie(cookieKey, cookieValue, options);
        
    }

    common.getCookie = function(cookieKey) {
        return $.cookie(cookieKey);
    }

    common.getToken = function() {
        return $.cookie('token');
    }

    common.delCookie = function(cookieKey) {
        $.cookie(cookieKey, '', {
            'path': '/',
            'expires': -1
        });
    }
	
	
	</script>
	
</body>
</html>
