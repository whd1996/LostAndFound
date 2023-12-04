<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="common/global.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>${webSiteTitle} 留言感谢墙</title>
	<%@include file="common/base-meta.jsp"%>
	<meta name="viewport" content="width=device-width, initial-scale=0.5, maximum-scale=1.0, user-scalable=no"/>
	<%@include file="common/base-css-js.jsp"%>
	<link rel="stylesheet" href="${path}/static/css/leave-thanks.css">
	<link rel="stylesheet" href="${path}/static/css/chat/chat.css">
	<script type="text/javascript" src="${path}/static/js/leave-thanks.js"></script>

  <style>
     /* Let's get this party started */
	::-webkit-scrollbar {
	    width: 12px;
	}
	 
	/* Track */
	::-webkit-scrollbar-track {
	    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3); 
	    -webkit-border-radius: 10px;
	    border-radius: 10px;
	}
	 
	/* Handle */
	::-webkit-scrollbar-thumb {
	    -webkit-border-radius: 10px;
	    border-radius: 10px;
	    background: #99CCFF; 
	    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.5); 
	}
	::-webkit-scrollbar-thumb:window-inactive {
		background: rgba(255,0,0,0.4); 
	}
	
	.clear {
		clear:both; height: 0; line-height: 0; font-size: 0
	}
	
  
	/* min-width & max-width 兼容移动设备 */
	@media screen and (min-width: 220px) and (max-width: 960px) { 
		#navbardiv {
	 		position: fixed;
			right: 0;
			left: 0;
			z-index: 1030;
			margin-bottom: 0;
			top: 0px;
		} 
		#container{
			position:relative;
			top:50px;
		}
		#leave-thanks-list{
			width:95%;
		}
		.p_info {
			width:98%;
		}
		.thanks{
			width:41%;
		}
	}
		
	/* min-width兼容移动设备 */
	@media screen and (min-width: 960px) { 		
		#leave-thanks-list {
			max-width:75%;
		}
		.p_info {
			width:80%;
		}		
	}
		
  </style>    
  </head>
  
  <body style="background: rgb(255, 255, 255); overflow-x: hidden; -webkit-user-select: none; min-height: 1150px;border: 1px solid white;"> 
   <div id="pagewrapper" style="margin:0 auto;height:auto;overflow:visible;min-height:800px;*height:1000px;border: 1px solid white;">
                             <!--------------页眉开始------------------>	 
    <div class="container-fluid" style="width:100%;margin:0 auto;padding:0;">
	<!-- header start-->
	<div id="leave-thanks-header" style="width:100%;margin:0 auto;">
	<%@include file="common/header.jsp"%>
	</div>
	<!-- header end-->	
		
	<!-- 导航条 start -->
	<%@include file="common/navigator.jsp"%>
    <script>
    	activeNav("leave-thanks");
    </script>
	<!-- 导航条 end -->
	</div>
	                         <!--------------页眉结束------------------>				  
	                         <!-------------主体部分开始--------------->
	<div id="container" style="max-width:100%;min-height:800px;">
		<p class="p_info" style="margin:0 auto;height:15px;font-size:14px;color:black;">
	     	<span style="float:left;">现在的位置 <a href="${path}/index.html" target="_self" style="color:#666;">主页</a>-&gt;留言感谢墙</span>
	     	<span style="float:right;"><a id="show_online" href="javascript:void(0);" class="btn btn-mini btn-danger"><b style="font-size:16px;">在线交流</b></a></span> 
		</p>
     <hr style="margin-top:0">
	 <div id="leave-thanks-list" style="margin:0 auto;height:auto;min-height:800px;border-bottom:1px solid #aaa;border:1px solid green;">
	 	
	 	<!-- 显示框 （移动端）-->
	 	<div id="mobilechatwindow" style="width:100%;height:480px;overflow:hidden;display:none;border:1px solid pink;position: relative;top:0px;">
	 	<div class="window_title" style="">${webSiteTitle} 在线交流</div>
	 	<div class="chat_icon_minchat_ns" title="关闭" onclick="close_window_mini();"></div>
	 	<div class="mini_header_bg_div" style="background-size:contain;background: url(&quot;${path}/static/images/onlinechat/header_bg_1280.png?119&quot;) no-repeat;"></div>
	 		<iframe id="mobile_chat_dailog" name="mobile_chat_dailog" frameborder="0" width="100%" height="100%"></iframe>
	 	</div>
	 		
	 	<!-- 弹出框 （PC端）-->	
		<div id="chatwindow" class="chatwindow">
			<div id="window_title" class="window_title" style="">${webSiteTitle} 在线交流</div>
			<div id="min_to_normal" class="chat_icon_min" title="缩小" mini_narrow="缩小" mini_recover="还原" max_min="max" 
				onclick="max_min_window_mini(this);">
			</div>
			<div id="max_to_normal" class="chat_icon_maxto" title="切换到最大窗口" mini_narrow="切换到最大窗口" mini_recover="切换到正常窗口" max_min="min" 
				onclick="max_from_window_mini(this);">
			</div>
			<div class="chat_icon_minchat_ns" title="关闭" style="" onclick="close_window_mini();"></div>
			<div id="mini_header_bg_div" class="mini_header_bg_div"></div>
			<div id="iframe_window_mini_div" style="width:100%;height:100%;">
				<iframe id="chat_dailog" name="chat_dailog" frameborder="0" width="100%" height="100%"></iframe>
			</div>
		</div>
		
		<!-- 留言感谢部分 -->
		<div style="width:100%;min-height:800px;margin-top:5px;" >
			<div id="leave-thanks">
				
				<div class="clear"></div>
		 		<div id="main" style="width: 100%;text-align:center;">
		 		<a href="javascript:void(0);"id="want-to-thanks" class="btn btn-mini btn-success" title="我要感谢"
						style="width:130px;margin: 20px auto;">
						<b style="font-size:20px;height:30px;line-height:30px;">我要留言感谢</b>
				</a>
				
		 		<div id="thanks" style="margin:0px;width:100%;min-height:800px;float: left;border:1px solid green;">
		 		
		 		</div>
		 		<div class="clear"></div>
		 		<div id="thanks-more" style="margin:15px auto;"></div>
		 		
		 		</div>
		 		
		 		<div id="send-form">
					<p class="title">
						<span>写下你的感谢语</span>
						<a href="javascript:void(0);" id="close" onclick="closeThanksView();"></a>
					</p>
					<form id="thanks-info" name='thanks-info'>
						<p>
							<label for="title">标题：</label>
							<input type="hidden" name="userName" value="${user.userName}"/>
							<input type="text" name="title" id="title" maxlength="15" style="width:220px;"/>
							<span style="color: red;">*必填</span>
						</p>
						<p>
							<label for="substance">想说的话：<span id='font-num' style="color: blue;"></span></label>
							<textarea name="substance" id='substance' onfocus="valueListenerLimiter(this, 50);" onblur="labelHidden(this);"></textarea>
							<span style="color: red;">*必填</span>
						</p>
						<p>
							<label for="anonymous">匿名：<input type="checkbox" name="anonymous" id="anonymous" value="anonymous"/></label>
						</p>
						<p style="text-align:center;">
						<input type="submit" name="saveThanks" id="saveThanks" value="感谢"
									class="btn btn-success btn-mini" style="width:50px;height: 30px;font-size:20px; *background: #f2000d;">
						</p>
					</form>
				</div>
		 		<div class="clear"></div>
		 		
			</div>
	 		
	 	</div>
		
	 </div>
    </div>
	                        <!-------------主体部分结束--------------->
	<!-- go to top start-->
	<div id="go-top" class="sr_hidden pull-right" style="display:none;position:fixed;bottom:150px;right:5px;z-index:99;">
		<a id="goTop" href="${path}/leave-thanks.html#logo">
			<img src="${path}/static/images/goTop.gif" oncontextmenu="return false;" ondargstart="return false;" height="42" width="46" alt="回顶部" >
		</a>
	</div> 
	<!-- /.go to top end --> 
	                        
                            <!----------------页脚开始---------------->	
	<div class="container-fluid footer" style="max-width:100%;height:120px;">
	   <div style="width:100%;margin:10px auto;text-align: center;"> 
	     <!--页脚相关信息-->
			<%@include file="common/footer.jsp" %>
	     <!--网站相关说明及信息-->
		</div>
   	</div>
	                        <!----------------页脚结束---------------->
   </div>
                                         <!--封装容器结束-->
                                         
                                         
      <script>
	    
	    var thanksListUrl = "${path}/thanks.do";
	    var saveThanksUrl = "${path}/user/save-thanks.do";
	    
	    var $Lin = function(id) {return document.getElementById(id) ? document.getElementById(id) : null};
	    var onlineClick = true;
	    var Left = 0;
	    var Top = 0;
	    
		var max_to_normal = $Lin("max_to_normal");
		var min_to_normal = $Lin("min_to_normal");
	    
	    
		 // 关闭悬浮框 
		function close_window_mini(){
			var close_html = '<div style="width:180px;margin:200px auto;height:25px;">您已断开服务器连接...</div>';
			
			if(isSmallScreen()) {
				window.frames.mobile_chat_dailog.document.body.innerHTML = close_html;
				
				// 手动调用iframe下的webSocketClose函数关闭
				window.frames.mobile_chat_dailog.webSocketClose();
				// 隐藏div
				$("#mobilechatwindow").hide(1500);
			} else {
				window.frames.chat_dailog.document.body.innerHTML = close_html;
				
				// 手动调用iframe下的webSocketClose函数关闭
				window.frames.chat_dailog.webSocketClose();
				$("#chatwindow").hide(1500);
			}
			
			// 修改online按钮单击有效
			onlineClick = true;
		}
	
		//	mini悬浮对话窗口 正常与最大切换
		function max_from_window_mini(t) {
			$("#iframe_window_mini_div").is(":hidden");
			$Lin("iframe_window_mini_div").style.display = "block";
			$Lin("min_to_normal").style.backgroundImage = 'url("${path}/static/images/onlinechat/min.png")';
			$Lin("min_to_normal").setAttribute('max_min','max');
			$Lin("min_to_normal").title = $Lin("min_to_normal").getAttribute('mini_narrow');
			
			if (t.getAttribute('max_min') == 'max') {
				$Lin("chatwindow").style.width = "600px";
				$Lin("chatwindow").style.height = "480px";
				$Lin("window_title").style.width = "330px";
				t.style.backgroundImage = 'url("${path}/static/images/onlinechat/maxto.gif")';				
				t.setAttribute('max_min','min');
				t.title = t.getAttribute('mini_narrow');
	            $Lin("mini_header_bg_div").style.backgroundImage = 'url("${path}/static/images/onlinechat/header_bg_600.png?113")';
	            $(window.frames.chat_dailog.document.getElementById("left_msg")).css("height", "310px");
			} else {	
				$Lin("chatwindow").style.width = "1000px";
				$Lin("chatwindow").style.height = "600px";
				$Lin("window_title").style.width = "730px";
				t.style.backgroundImage = 'url("${path}/static/images/onlinechat/max.png")';
				t.setAttribute('max_min','max');
				t.title = t.getAttribute('mini_recover');
	           $Lin("mini_header_bg_div").style.backgroundImage = 'url("${path}/static/images/onlinechat/header_bg_1000.png?115")';
	           
	           $(window.frames.chat_dailog.document.getElementById("left_msg")).css("height", "430px");
	    	}
			
			 setDivCenter("#chatwindow");
		}
	    
		// mini悬浮对话窗口 缩小与正常切换
	    function max_min_window_mini(t) {
	    	$Lin("max_to_normal").style.backgroundImage = 'url("${path}/static/images/onlinechat/maxto.gif")';				
	    	$Lin("max_to_normal").setAttribute('max_min','min');
	    	$Lin("max_to_normal").title = $Lin("max_to_normal").getAttribute('mini_narrow');
			
			if (t.getAttribute('max_min') == 'max') {
				$Lin("chatwindow").style.width = "403px";
				$Lin("chatwindow").style.height = "36px";
				$Lin("window_title").style.width = "330px";
				$Lin("iframe_window_mini_div").style.display = "none";
				t.style.backgroundImage = 'url("${path}/static/images/onlinechat/max.png")';				
				t.setAttribute('max_min','min');
				t.title = t.getAttribute('mini_recover');
				$Lin("chatwindow").style.left = "";
				$Lin("chatwindow").style.top = "";
	            $Lin("chatwindow").style.right = '0px';
		     	$Lin("chatwindow").style.bottom = '0px';
	            $Lin("mini_header_bg_div").style.backgroundImage = 'url("${path}/static/images/onlinechat/header_bg_403.png?117")';
			} else {	
				$Lin("iframe_window_mini_div").style.display = "block";
				$Lin("chatwindow").style.width = "600px";
				$Lin("chatwindow").style.height = "480px";
				$Lin("window_title").style.width = "330px";
				$Lin("chatwindow").style.left = Left+ "px";
				$Lin("chatwindow").style.top = Top+ "px";
				t.style.backgroundImage = 'url("${path}/static/images/onlinechat/min.png")';
				t.setAttribute('max_min','max');
				t.title = t.getAttribute('mini_narrow');
	           $Lin("mini_header_bg_div").style.backgroundImage = 'url("${path}/static/images/onlinechat/header_bg_600.png?116")';
	           $(window.frames.chat_dailog.document.getElementById("left_msg")).css("height", "310px");
	           setDivCenter("#chatwindow");
	    	}
	    }
	    
	    window.onload = function(){
	    	var div = document.getElementById("chatwindow");
	    	div.onmousedown = function(ev){
				var oevent = ev || event;
				var distanceX = oevent.clientX - div.offsetLeft;
				var distanceY = oevent.clientY - div.offsetTop;
			
				document.onmousemove = function(ev){
					var oevent = ev || event;
					div.style.left = oevent.clientX - distanceX + 'px';
					div.style.top = oevent.clientY - distanceY + 'px';
				}
				
				document.onmouseup = function(){
					document.onmousemove = null;
					document.onmouseup = null;
				}
			}
		}
	    
	    //让指定的DIV始终显示在document正中间   
	    function setDivCenter(divName) {   
	        var top = ($(window).height() - $(divName).height())/2;   
	        var left = ($(window).width() - $(divName).width())/2; 
	        
	        Left = left;
	        Top = top;
	        
	        var scrollTop = $(document).scrollTop();   
	        var scrollLeft = $(document).scrollLeft();   
	        $(divName).css( {'top' : top + scrollTop, left : left + scrollLeft } );  
	    }  
	    
	    // 加载消息框
	    function getMsgDailog(){
	    	var html;
	    	$.post('${path}/message/chat.do',
	    			function(data){
	    				html = data;
	    				// 先清除一下内容
	    				window.frames.chat_dailog.document.body.innerHTML = "";
	    				//console.log(html);
	    				var isIE = myBrowserType() == "IE"; 
	    				if(isSmallScreen()) {
	    					if(isIE){
	        					document.frames.mobile_chat_dailog.document.write(html);
	        					document.frames.mobile_chat_dailog.document.close();
	        				} else {
	        					window.frames.mobile_chat_dailog.document.write(html);
	        					// 写完关闭
	        					window.frames.mobile_chat_dailog.document.close();
	        				}
	    				} else {
	    					if(isIE){
	        					document.frames.chat_dailog.document.write(html);
	        					document.frames.chat_dailog.document.close();
	        				} else {
	        					window.frames.chat_dailog.document.write(html);
	        					// 写完关闭
	        					window.frames.chat_dailog.document.close();
	        				}
	    				}
	    			},
	    			function(data){
	    				html = '<div style="width:150px;margin:200px auto;height:25px;color:red;">连接服务器失败...</div>';
	    				window.frames.chat_dailog.document.body.innerHTML = html;
	    			},
	    			"html"
	    		);
	    }
	    
	    $(function(){
	    	$("#show_online").click(function(event){
	    		if(isLogin) {
	    			if(USER != null && USER != "") {
	    				var conn_html = '<div style="width:180px;margin:180px auto;height:auto;text-align:center;">'
	    				+'<div><img src="${path}/static/images/onlinechat/load.gif" style="width:100px;height:70px;"></div>'
	    				+'<div>您正在连接服务器...</div>'
	    				+'</div>';
	    				
	    				if(isSmallScreen()) {
	    					if(onlineClick) {
	                    		$("#mobilechatwindow").show(500);
	                			onlineClick = $("#mobilechatwindow").is(":hidden");
		    					window.frames.mobile_chat_dailog.document.body.innerHTML = conn_html;
		    					setTimeout('getMsgDailog()', 2000);
	    					} else {
	    						close_window_mini();
	    					}
	    				} else {
	    					
	    					setDivCenter("#chatwindow");
	                		if(onlineClick) {
	                    		$("#chatwindow").show(500);
	                			onlineClick = $("#chatwindow").is(":hidden");
	                			
	                			window.frames.chat_dailog.document.body.innerHTML = conn_html;
	                			setTimeout('getMsgDailog()', 2000);
	                		} 
	    				} 
	    			} else {
	        			alert("您已长时间没有操作，请重新登录...");
	        		}
	    				
	    		} else {
	    			//小屏幕未登录
	    		    if(isSmallScreen()){
	    		    	mobileLoginFocus(event);     
	    		    } else{
	    		    	loginFocus(event);
	    		    }
	    		}
	    	});
	    });

		 		
 		thanksList(thanksListUrl, globalpageIndex, globalpageSize);
 		
 		$("#want-to-thanks").click(function (event) {
 			thanksView(event);
 		});
 		
 		jQuery("#thanks-info").submit(function(e) {
 			e.preventDefault();
 			
 			var data = $("#thanks-info").serialize();
 			
 			if(checkThanks($("#title"), $("#substance"))){
 				saveThanks(saveThanksUrl, data);
 			}
 		});
	
		//当滚动条的位置处于距顶部100像素以下时，跳转链接出现，否则消失
		$(function () {
			$(window).scroll(function () {
				if ($(window).scrollTop() > 100) {
					$("#go-top").fadeIn(100);
				} else {
					$("#go-top").fadeOut(100);
				}
			});
		});
		  
</script>  

</body>
</html>