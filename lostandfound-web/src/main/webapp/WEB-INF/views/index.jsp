<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="common/global.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>${webSiteTitle}</title>
	<%@include file="common/base-meta.jsp"%>
	<meta name="viewport" content="width=device-width, initial-scale=0.8, minimum-scale=0.8, maximum-scale=1.0, user-scalable=no">
	<%@include file="common/base-css-js.jsp"%>
</head>
<!-- rgb(238, 238, 238) -->
<body style="background: rgb(255, 255, 255); overflow-x: hidden; -webkit-user-select: none;">
	
	<!-- header start -->
	<div id="index-header" style="width:100%;margin:0 auto;">
	<%@include file="common/header.jsp"%>
	</div> 
	<!-- header end -->
	
	<!-- nav start -->
	<nav>
	<div id="navbardiv" class="navbar" style="box-shadow: 1px 1px 7px #999;width:100%;overflow:hidden;z-index:99;">
		<div class="navbar-inner" style="width:100%;max-width: 1680px; margin: 0px auto;padding:0;">
			<ul class="nav" style="height:25px; width: 78%; float: none; margin: 0 auto;">
				<li id="index" class="active">
					<a href="${path}/index.html"> <i class="icon-home"></i> 首页  </a>
				</li>
				<li>
					<a href="${path}/find/find-list.html" title="招领信息汇总"><i class="icon-picture"></i> 招领信息  </a>
				</li>
				<li>
					<a href="${path}/lost/lost-list.html" title="寻物信息汇总"><i class="icon-zoom-in"></i> 寻物信息  </a>
						</li>
				<li>
					<a href="${path}/leave-thanks.html" title="留言感谢墙"><i class="icon-star-empty"></i> 留言感谢墙  </a>
				</li>
				<li>
					<a href="${path}/user-help.html" title="平台使用指南"><i class="icon-hand-right"></i> 平台指南  </a>
				</li>
			</ul>
			<!-- 默认放右，用户习惯点击左边 有新的效果 -->
			<a id="infoStream" title="改变信息流布局" class="sr_only"
				style="float: right; margin-top: -10px; *display: none; text-decoration: none;">改变信息流布局</a>
			<div id="layout"
				style="box-shadow: 0 15px 10px -10px rgba(0, 0, 0, 0.5), 0 1px 4px rgba(0, 0, 0, 0.3), 0 0 40px rgba(0, 0, 0, 0.1) inset; padding: 0 5px; display: none; float: right; margin-top: -10px; margin-right: 20px; cursor: pointer">
				<a title="竖排布局，大道至简"><i id="two" class="icon-align-justify"></i></a>
				<a title="多栏布局，经典明了"><i id="one" class="icon-th-large"></i></a>
			</div>
		</div>
	</div>
	</nav>
	<!-- /.nav end -->

	<div class="gap50"></div>

	<!-- main start -->
	<div id="main" class="container960 child_join" style="_width: 960px;">
		<!-- main left start -->
		<section class="left area area_block border1"> 
		<!-- 帖子 start -->
		<div class="news area area_area_inline">

			<div class="tabbable">
				<ul class="nav nav-tabs" style="font-weight:bold;font-family:微软雅黑;font-size:16px;background:white;">
                    <li class="active">
                        <a id="shia" onclick="this.style.backgroundColor='whiteSmoke';xuna.style.backgroundColor='white';" 
                        onmouseover="this.style.backgroundColor='whiteSmoke';xuna.style.backgroundColor='white';" 
                        style="background:whiteSmoke;" href="${path}/index.html#find" data-toggle="tab">
                        <i class="icon-picture"></i> 
                        <h2 style="font-size:16px;display:inline;line-height:16px;">最新招领信息</h2>
                        </a>
                    </li>
                    <li>
                        <a id="xuna" onclick="this.style.backgroundColor='whiteSmoke';shia.style.backgroundColor='white';" 
                        onmouseover="this.style.backgroundColor='whiteSmoke';shia.style.backgroundColor='white';" 
                        href="${path}/index.html#lost" data-toggle="tab"><i class="icon-zoom-in"></i>
                        <h2 style="font-size:16px;display:inline;line-height:16px;">最新寻物信息</h2>
                        </a>
                    </li>
                </ul>

				<div class="tab-content" style="font-size: 14px; text-align: left; overflow: hidden;">
					<div class="tab-pane active" id="find">
						<ul id="shiinfo" style="list-style: none; height: auto; text-align: left;">

							<c:forEach items="${newPickList}" var="pickList">
								<c:if test="${pickList.status ==1 || pickList.status ==0}">
							<li class="clearfix">
								<a href="${path}/find/find-details.html/${pickList.id}">
								<i class="icon-volume-up"></i>
								<font color="#ee5f5b">${pickList.thingsName}</font>被捡到了!快来领取啊！
									<c:if test="${pickList.status == 1}">
									<p style="display: inline; color: red; font-weight: bold; font-size: 14px; font-style: italic; border-radius: 5px;">
										成功贴
									</p>
									</c:if>
								</a>
								<p class="area area_inline time" style="text-align: right; float: right; *margin-top: -33px;">
									<fmt:formatDate value="${pickList.publishTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</p>
							</li>
								</c:if>
							</c:forEach>

							<li style="border: none;">
								<a href="${path}/find/find-list.html"
								style="float: right; min-width: 40px; color: green; margin: 5px;"
								title="更多招领信息">
								更多...
								</a>
							</li>
								
						</ul>
					</div>

					<div class="tab-pane" id="lost">
						<ul id="xuninfo" style="list-style: none;">

							<c:forEach items="${newLostList}" var="lostList">
								<c:if test="${lostList.status ==1 || lostList.status ==0}">
							<li class="clearfix">
								<a href="${path}/lost/lost-details.html/${lostList.id}"> 
								<i class="icon-volume-up"></i>
								<font color="#ee5f5b">${lostList.thingsName}</font>丢啦!大家有看到的吗?
								<c:if test="${lostList.status == 1}">
									<p style="display: inline; color: red; font-weight: bold; font-size: 14px; font-style: italic; border-radius: 5px;">
										成功贴
									</p>
								</c:if>
								</a>
								<p class="area area_inline" style="text-align: right; float: right; *margin-top: -35px;">
									<fmt:formatDate value="${lostList.publishTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</p>
							</li>
								</c:if>
							</c:forEach>

							<li style="border: none;">
								<a href="${path}/lost/lost-list.html" style="float: right; min-width: 40px; color: green; margin: 5px;"
								title="更多寻物信息">
								更多...
								</a>
							</li>

						</ul>
					</div>
				</div>
			</div>
		</div>
		<!-- /.帖子 end --> 
		</section>
		<!-- /.main left end -->

		<!-- main right start -->
		<aside class="right area area_block"> <!-- 发帖 start -->
		<div class="up area area_block border1">
			<h2 class="text-center" style="font-size: 16px; font-weight: bold; line-height: 19px;">${webSiteTitle} 公告栏</h2>

			<pre title="${notices.title}" style="margin-top: -5px; height: 150px; padding: -15px; text-align: left;">${notices.substance}</pre>

			<div class="shi area area_block" style="*width: 45%; float: left;">
				<!--兼容ie7-->
				<div class="gap10"></div>
				<a href="javascript:void(0);" id="findLogin" target="_self"
					style="width: 45%; cursor: default;"
					class="btn btn-danger center" title="捡到东西猛戳我">捡到东西了</a>
				<div class="gap10"></div>
			</div>

			<div class="xun area area_block">
				<div class="gap10"></div>
				<a href="javascript:void(0);" id="lostLogin" target="_self"
					style="width: 45%; cursor: default;" 
					class="btn btn-danger center" title="丢了东西猛戳我">丢失东西了</a>
				<div class="gap10"></div>
			</div>

		</div>
		<!-- /.发帖 end -->

		<div class="gap"></div>
		<!-- 成功案例 start -->
		<div class="gap10"></div>
		<div class="bottom area area_block">
			<h2 class="text-center" style="margin: 0 0 20px 0;">
				<p class="btn btn-danger btn-block" style="margin: 0 auto;">♥成功案例展示区♥</p>
			</h2>
			<p style="height: 5px; margin-top: -15px;">不断更新中...</p>
			<table class="table table-hover table-condensed" style="font-size: 12px;">
				
				<tbody>
					<!--寻物3条-->
					<c:forEach var="succLost" items="${successLost}">
					<tr>
						<td style="text-align:center;"><b style="color:red;">♥${succLost.thingsName}♥</b>&nbsp;在招领平台<b style="color:green;"> 找到啦！</b></td>
					</tr>
					</c:forEach>
					
					<!--拾物3条-->
					<c:forEach var="succPick" items="${successPick}">
					<tr>
						<td style="text-align:center;"><b style="color:red;">♥${succPick.thingsName}♥</b>&nbsp;被成功<b style="color:green;"> 还给失主啦！</b></td>
					</tr>
					</c:forEach>
										
					<tr>
						<td style="background: #eed; font-family: 微软雅黑;">
							该平台使用至今，累计归还拾物<font style="color: red; font-weight: bold;"> ${pickCount} </font>
							件,为大家寻找到失物<font style="color: red; font-weight: bold;"> ${lostCount} </font>件,
							平台需要大家的支持并竭诚为大家服务!
						</td>
					</tr>

				</tbody>
				
			</table>

			<p class="text-center">
				<a href="${path}/leave-thanks.html"
					target="_blank"> 平台<font style="color: red; font-weight: bold;">
					留言感谢墙</font>已启动!欢迎使用哦.....~
				</a>
			</p>
		</div>
		<!-- /.成功案例 end --> </aside>
		<!-- /.main right end -->

	</div>
	<!-- /.main end -->

	<hr class="hr">
	
	<!-- go to top -->
	<div id="go-top" class="sr_hidden pull-right" style="display:none;position:fixed;bottom:150px;right:5px;z-index:99;">
		<a id="goTop" href="${path}/index.html#logo">
			<img src="${path}/static/images/goTop.gif" oncontextmenu="return false;" ondargstart="return false;" height="42" width="40" alt="回顶部" >
		</a>
	</div> 
	<!-- /.go to top end --> 

	<!-- footer start -->
	<footer class="container100" style="padding:0px;">
		<div style="width:98%;margin:10px auto;text-align: center;"> 
	     	<!--页脚相关信息-->
	     	<%@include file="common/footer.jsp"%>
	     	<!--网站相关说明及信息-->
		</div>
	</footer>
	<!-- /.footer end -->
	
	<script> 
	
		$('.nav-tabs a').mouseover(function(e) { 
			  e.preventDefault();
			  $(this).tab('show');
		});		
		
		//控制 点哪登陆 登录后就去哪
		 $("document").ready(function(){
			 
			 $("#findLogin").click(function(event){
			    	$("#srcUrl").val("${path}/find/find-publish.html");	
			    	if(isLogin){
			    		window.location.href = $("#srcUrl").val();
			    		return;
			    	}
			    	
			    	//小屏幕未登录不可发帖
					if(isSmallScreen())
			    		mobileLoginFocus(event);
					else 
		                loginFocus(event);
			  });
			  
			  $("#lostLogin").click(function(event){
			    	$("#srcUrl").val("${path}/lost/lost-publish.html");	
			    	if(isLogin){
			    		window.location.href = $("#srcUrl").val();
			    		return;
			    	}
			    	
			    	//小屏幕未登录不可发帖
					if(isSmallScreen())
			    		mobileLoginFocus(event);
					else 
		                loginFocus(event);
				});
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