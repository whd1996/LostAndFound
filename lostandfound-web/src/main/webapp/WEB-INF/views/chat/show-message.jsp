<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getServerName() + ":" + request.getServerPort() + path + "/";
	String basePath2 = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>${webSiteTitle} 在线交流页面</title>

	<script type="text/javascript" src="${path}/static/js/jquery-1.10.2.min.js"></script>
	<script type="text/javascript" src="${path}/static/js/chat/json2.js"></script>
	<script type="text/javascript" src="${path}/static/js/chat/sockjs.min.js"></script>
	<script type="text/javascript" src="${path}/static/js/chat/jquery.cookie.js"></script>
	<script type="text/javascript" src="${path}/static/js/chat/lin.marquee.min.js"></script>
	
	<!--[if lte IE 9]>
		<script type="text/javascript" src="${path}/static/js/jquery-1.6.2.min.js"></script>
	<![endif]-->
	
<style>

	* {	margin: 0px;padding: 0px; font-family:"瀹嬩綋"}
	HTML{overflow:hidden}
	img{border:0;}
	
	body{width:100%;height:100%;position:absolute;}
	#table{font-size:12px;margin:0 0;height:100%;width:100%; position:absolute;}
	.top_bg{height:37px;width:100%;}
	.msg_title{wdith:100%; display:block; overflow:hidden; white-space:nowrap; line-height:25px; 
	font-family:"榛戜綋";font-size:14px; font-weight:bold;letter-spacing:2px}
	
	
	#content{
			overflow:hidden;overflow-y:auto;
			scrollbar-face-color: #e6ecf8;
			scrollbar-base-color:#f7f9fc;
			scrollbar-highlight-color: #ffffff;
			scrollbar-shadow-color: #e6ecf8;
			scrollbar-3dlight-color: #ffffff;
			scrollbar-arrow-color: #0f297b;
			scrollbar-track-color: #F7F7F9;
			scrollbar-darkshadow-color: #6d8ec9;
	}
	
	.part_input{margin:5px auto;width:99%;height:60px;padding:0;}
	
	#msg {
			position:absolute;
			height:50px;
			overflow:auto;  
			resize: none;
			word-wrap: break-word; 
			word-break: break-all;float:left;
			padding:3px;scrollbar-face-color: #e6ecf8;
			scrollbar-base-color:#f7f9fc;
			scrollbar-highlight-color: #ffffff;
			scrollbar-shadow-color: #e6ecf8;
			scrollbar-3dlight-color: #ffffff;
			scrollbar-arrow-color: #0f297b;
			scrollbar-track-color: #F7F7F9;
			scrollbar-darkshadow-color: #6d8ec9;
	}
	
	.send_purple{border:0; width:40px; height:37px; float:left;cursor:pointer;}
	.hotkey_purple{border:0; width:15px; height:37px;margin-right:10px;float:left;cursor:pointer;}
	
	.me {
		text-align: right;
		margin-bottom: 20px;
		margin-left: 60px;
		margin-right: 15px;
		overflow: hidden;
	}
	
	.me .chat_word {
		background: #56aee2;
		line-height: 22px;
		max-width:45%;
		margin: 0;
		text-align: left;
		padding: 5px 10px;
		color: #fff;
		border-radius: 5px;
		float: right;
	}
	
	.chat_word img, .all_chat_word img{ vertical-align:middle;}
	
	
	.from {
		text-align: left;
		margin-bottom: 20px;
		margin-left: 15px;
		overflow: hidden;
	}
	
	
	.from .chat_word {
		background: #F1F8F9;
		line-height: 22px;
		max-width:45%;
		margin: 0;
		text-align: left;
		padding: 5px 10px;
		border-radius: 5px;
		float: left;
	}
	
	.all_chat_word {
		background: red;
		line-height: 1.2;
		max-width:45%;
		margin: 0;
		text-align: left;
		padding: 5px 10px;
		border-radius: 5px;
		float: left;
	}
	
	
	.dhk_left_left .q_face{margin-top:-5px;width:600px;height:22px;border: 1px solid red;}
	.dhk_left_left .q_face img{margin:0px 0 0 8px;float:left;}

	.bq:hover{cursor:pointer;}
	.dhk_left_left .bqk{width:365px;height:180px;background:#fff;position:absolute;bottom:100px;left:5px;padding:3px;box-shadow:1px 1px 8px #D0D0D0;display:none;}
	.dhk_left_left .bqk ul li{list-style:none;float:left;margin:2px;cursor:pointer;}
	
	

</style>

</head>

<body oncontextmenu="return false" >
	
	<div class="container" id="table" style="background: rgb(253, 253, 253);border:1px solid red;width: 99.5%; margin:0 auto;height:95%;">
		<div class="top_bg" id="top_bg">
			<div id="msg_title" class="msg_title" style="border:1px solid green;">
				<span style="width:150px;float:left;border:1px solid green;"> 当前在线人数: <b id="num" style="color:red;">0</b> </span>
				<span id="msg_div" style="overflow:hidden;width:400px;float:right;border:1px solid green;">
				<span id="come_out" style="height:25px;line-height:25px;float:right;border:1px solid green;"></span>
				</span>
			</div>
		</div>
		<div class="dhk_left_left" id="dhk_left_left" style="border:1px solid yellow;float:left; margin-left:0;padding-top:0px;width: 100%;height:100%;">
			<!-- right -->
			<div class="left_msg" id="left_msg" style="background: url(&quot;${path}/static/images/onlinechat/chat_message_bg.jpg?129&quot;) no-repeat;border:1px solid blue;padding-top:2px; margin-left:0;width: 100%; height: 310px;">
				<div class="msg_show" id="msg_show" style="height:100%;padding: 0px;">
					<div id="content" style="width: 100%; height: 100%;"></div>
				</div>
			</div>

			<div class="part_input" id="part_input" style="border:1px solid green;">
				<div id="part_input_content" style="width: 100%;height:60px;">
					<div class="inputmsg" style="height:100%; float:left;">
						<!-- onkeypress="return keypress(event);" onkeydown="return keydown(event)" --> 
						<div id="msg" contenteditable="true" style="border: 1px solid red;width:85%;" onkeyup="return keyup(event);" ></div>
					</div>
					<div class="send_msg" style="border: 1px solid red;position:relative;left:5px;top:11px;float:right;">
						<input type="button" class="send_purple" style="background:url(${path}/static/images/onlinechat/green.gif) 0 -24px no-repeat;" value="发送" id="send" title="发送" onclick="sendMsg();" />
						<input type="button" class="hotkey_purple" style="background:url(${path}/static/images/onlinechat/green.gif) -40px -24px no-repeat;" title="设置快捷键" onclick="showpkset();" />
					</div>
				</div>
			</div>
			
			<div class="q_face">
			 	<a class="bq"><img src="${path}/static/images/onlinechat/face/smilea_thumb.gif"  title="选择表情"></a>
			</div>
			<div class="bqk">
				<ul class="uli">
					<li><img src="${path}/static/images/onlinechat/face/smilea_thumb.gif" title="微笑"></li>
					<li><img src="${path}/static/images/onlinechat/face/tootha_thumb.gif" title="呲牙"></li>
					<li><img src="${path}/static/images/onlinechat/face/88_thumb.gif" title="再见"></li>
					<li><img src="${path}/static/images/onlinechat/face/angrya_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/bba_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/boboshengmenqi_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/bofubianlian_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/bs_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/bs2_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/bz_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/cake.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/camera_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/cat_yunqizhong_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/cf_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/chn_buyaoya_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/cj_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/clock_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/come_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/cool_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/crazya_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/cry.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/cza_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/daxiongleibenxiong_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/dizzya_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/fuyun_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/gbzkun_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/gza_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/h_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/hatea_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/hearta_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/heia_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/horse2_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/hsa_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/hufen_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/j_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/k_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/kbsa_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/kl_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/laugh.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/lazu_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/ldln_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/liwu_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/lovea_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/lxhluguo_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/lxhzhuanfa_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/m_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/mb_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/money_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/nm_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/no_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/ok_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/otm_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/panda_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/pig.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/sad_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/sb_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/shamea_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/sk_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/sleepa_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/sleepya_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/sw_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/sweata_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/t_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/tza_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/unheart.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/vw_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/weijin_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/wg_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/wq_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/x_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/ye_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/yhh_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/youqian_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/yw_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/yx_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/z2_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/zhh_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/zy_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/zz2_thumb.gif"></li>
					<li><img src="${path}/static/images/onlinechat/face/mg_thumb.gif"></li>
				</ul>
			 </div>
			
		</div>
		<!-- send tips  -->
	</div>
	
	<script type="text/javascript">
	
	$(".q_face .bq").click(function(){
		$(".bqk").toggle(500);
		
	});

	$(".uli").find("li").click(function(){
		var img=$(this).find("img").clone();
		$("#msg").append(img);
	});
	
	$(".bqk").mouseleave(function(){
		$(".bqk").hide(500);
	});
	
	</script>
	
	
	<script>
		
		var path = location.host + "${path}";
		
		var uid = "${empty user? -1 : user.id}";

		if(uid == -1){
			parent.location.href="<%=basePath2%>";
		}
		
		var from = uid;
		var fromName = '${user.userName}';
		var to = uid == 1 ? 2:1;

		var isConnection = false;
		var websocket;
		
		if ('WebSocket' in window) {
			websocket = new WebSocket("ws://" +path+ "/ws?uid=" +uid);
		} else if ('MozWebSocket' in window) {
			websocket = new MozWebSocket("ws://" +path+ "/ws" +uid);
		} else {
			alert("JsWebSocket");
			websocket = new SockJS(location.protocol+ "//" +path+ "/ws/sockjs");
		}
		
		websocket.onopen = function(event) {
			isConnection = true;
			console.log("WebSocket:已连接");
			console.log(event);
		};
		
		websocket.onmessage = function(event) {
			var data=JSON.parse(event.data);
			console.log("WebSocket:收到一条消息",data);
			if(data.from == -2) {
				var onlineSize = data.onlineSize;
				var msg = data.text;
				
				onMsgBroadcast(onlineSize, msg);
			} else {
				window.parent.sessonStartTime = new Date().getTime();
				var textCss = data.from == -1 ? "all_chat_word" : "chat_word";
				var msgContent = '<div class="from"><p>' +data.fromName+ '&nbsp;' +data.date+ '</p><div class="'+textCss+'">' +data.text+ '</div></div>';
				$("#content").append(msgContent);
				scrollToBottom();
				
				//把聊天记录保存到本地cookie
				common.saveCookie("${user.userName}", $("#content").html(), 7);
			}
		};		
		
		websocket.onerror = function(event) {
			isConnection = false;
			console.log("WebSocket:发生错误 ");
			console.log(event);
			websocket = null;
			var html = '<div style="width:150px;margin:200px auto;height:25px;color:red;">连接服务器失败...</div>';
			document.body.innerHTML = html;
		};
		
		websocket.onclose = function(event) {
			isConnection = false;
			console.log("WebSocket:已关闭");
			console.log(event);
			websocket = null;
		}
		
		
		//手动关闭websocket
		function webSocketClose(){
			//alert("close");
			if(websocket != null)
				websocket.close();
		}
		
		//群聊
		function groupchat(){
			$.ajax({
				url:'${path}/message/groupchat.html',
				type:"post",
				data:{text : $("#msg").html(), id: "${user.id}", userName: "${user.userName}"},
				dataType:"json",
				success:function(data){
					//alert("发送成功");
				}
			});
		}
		
		function sendMsg(){
			if(websocket != null && isConnection) {
				var v = $("#msg").html();
				if(v == ""){
					
					return;
				}else{
					window.parent.sessionStartTime = new Date().getTime();
					var data={};
					data["from"]=from;
					data["fromName"]=fromName;
					data["to"]=to;
					data["text"]=v;
					//websocket.send(JSON.stringify(data));
					groupchat();
					var msgContent = '<div class="me"><p>我&nbsp;' +new Date().Format("yyyy-MM-dd hh:mm:ss")+ '</p><div class="chat_word">' +data.text+ '</div></div>'
					$("#msg").html("");
					$("#content").append(msgContent);
					scrollToBottom();
				}
				
				//把聊天记录保存到本地cookie
				common.saveCookie("${user.userName}", $("#content").html(), 7);
			} else {
				alert("你已掉线，请重新连接...");
			}
				
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
		
		// 接收广播消息
		function onMsgBroadcast(onlineSize, msg) {
			$("#num").html(onlineSize);
			$("#come_out").html(msg);
			Marquee($("#msg_div").html(), false);
		}

		// 群聊接收消息 
		function onMsgChatgroup(onlineSize, msg) {
			$("#num").html(onlineSize);
			$("#come_out").append(msg);
		}
		
		// 消息框头滚动
		function Marquee(text, loop){
			//var come_out = '<span id="come_out" style="height:25px;line-height:25px;float:right;border:1px solid green;">' +text+ '</span>';
			ScrollText($('#msg_div'), 25, 400, text, 'left', 1, 15, loop);//滚动字幕
		} 
		
		function keypress(event) {
			alert($("#msg").html());
		}
		
		function keyup(event) {
			if((event.keyCode || event.which) == 13){ // e.keyCode IE e.which Firefox
				$("#msg").html("");
			}
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
			
			scrollToBottom();
			
			//common.delCookie("${user.userName}")
			
			//$("#iframe_window_mini_div").load("${path}/data/webCompany.html");
		});
		
		
	</script>
	
	
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