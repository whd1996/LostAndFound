<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="common/global.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title> ${webSiteTitle} 平台指南页面 </title>   
	<%@include file="common/base-meta.jsp"%>
	<meta name="viewport" content="width=device-width, initial-scale=0.5, maximum-scale=1.0, user-scalable=no">
	<%@include file="common/base-css-js.jsp"%>

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
				margin: 50px auto; 
			}
			#user-hlep  {
				width:90%;
			}
			.p_info {
				width:98%;
			}		
			hr { /*container 与 footer 间*/
			    margin-top : 2%;    
			} 
		}
		
		/* min-width兼容移动设备 */
		@media screen and (min-width: 960px) { 		
			#user-hlep {
				max-width:75%;
			}
			#container{
				margin: 0 auto; 
			}
			.p_info {
				width:75%;
			}			
		}
   </style>
  <body style="background: rgb(255, 255, 255); overflow-x: hidden;border: 1px solid white;"> 
                                              <!--封装容器开始-->
   <div id="pagewrapper" style="margin:0 auto;height:auto;overflow:visible;min-height:800px;*height:800px;border: 1px solid white;">
                             <!--------------页眉开始------------------>	 
    <div class="container-fluid" style="width:100%;margin:0 auto;padding:0;">
	<!-- header start-->
	<div id="user-help-header" style="margin-top: 0px;">
	<%@include file="common/header.jsp"%>
	</div> 
	<!-- header end-->
	
	<!-- 导航条 start -->
	<%@include file="common/navigator.jsp"%>
    <script>
    activeNav("user-help");
    </script>
	<!-- 导航条 end -->
	</div>
	                         <!--------------页眉结束------------------>				  
	                         <!-------------主体部分开始--------------->
	 <div id="container" style="max-width:100%;min-height:1000px;">
	 	<p class="p_info" style="margin:0 auto;height:15px;font-size:14px;color:black;">
	     	<span style="float:left;">现在的位置 <a href="${path}/index.html" target="_self" style="color:#666;">主页</a>-&gt;平台使用指南页面 </span>
		</p>
     	<hr style="margin-top:0">
     <div id="user-hlep" class="container-fluid" style="margin:0 auto;min-height:800px;border: 1px solid red;"> 
		 <p style="font-family:微软雅黑;line-height:1.5em">
			<strong style="font-family:Arial; font-weight:bold; font-size:16px;">${webSiteTitle} 使用规范如下：</strong>
		　　　<br><br>一、如果您在校园内拾得他人遗失的物品，可登录失物招领平台，自行发布失物招领信息，寻找失主，也可以送交到失物招领点，填写《失物领取（交公）记录》，做好登记，工作人员会保管相关物品并将信息在失物招领平台发布。
		　　　<br>二、如果您有遗失物品在查找无果后，可自行登录失物招领信息平台查看有无您正寻找的物品招领信息，并按信息提示寻找失物。如果没有，可以自行发布寻物信息。
		　　　<br><br>三、遗失物品领取时，凭学生证、身份证、借阅证等有效证件。代他人领取的，还须出示失主的委托书、失主身份证件。领取失物时，需填写《失物领取（交公）记录》。
		　　　<br><br>四、校园失物招领平台面向全校师生进行开放，根据全校师生的学号或工号实名注册、登录，让公益以最广、最快的形式进行传播。
		　　　<br><br><b style="color:blue;">拾金不昧是中华民族的传统美德，希望广大师生充分利用这个平台，发扬拾金不昧的优秀品质，自助助人。也希望通过我们的努力，能够切实加强师生管理自身财产安全的意识，营造良好的学习与生活环境，构建和谐、温馨校园。</b>
		 </p>
		 
		<div id="myCarousel" class="carousel slide">
			<!-- 轮播（Carousel）指标 -->
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
			</ol>   
			<!-- 轮播（Carousel）项目 -->
			<div class="carousel-inner">
				<div class="active item">
					<img src="${path}/static/images/systemhelp/sys-help.png" style="width:100%;max-width:960px;height:800px;" oncontextmenu="return false;" ondragstart="return false;">
				</div>
			    <div class="item">
			    	<img src="${path}/static/images/systemhelp/help.gif" style="width:100%;max-width:960px;height:800px;" oncontextmenu="return false;" ondragstart="return false;">
			    </div>
			    <div class="item">
			    	<img src="${path}/static/images/systemhelp/login-help.png" style="width:100%;max-width:960px;height:800px;" oncontextmenu="return false;" ondragstart="return false;">
			    </div>
			</div>
			<!-- 轮播（Carousel）导航 -->
			<a class="carousel-control left" href="#myCarousel" data-slide="prev" style="width:30px;">&lsaquo;</a>
			<a class="carousel-control right" href="#myCarousel" data-slide="next" style="width:30px;">&rsaquo;</a>
		</div> 
		 
	</div> 
	                        <!-------------主体部分结束--------------->
     <hr>
     <!-- go to top start-->
	<div id="go-top" class="sr_hidden pull-right" style="display:none;position:fixed;bottom:150px;right:5px;z-index:99;">
		<a id="goTop" href="${path}/user-help.html#logo">
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
   </div>
                                         <!--封装容器结束-->
   	<script> 
	//********************页尾功能js*********************//
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