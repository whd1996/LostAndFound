<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>

	<header class="container100 child_join">
	
	<!-- big box start -->
	<div style="max-width: 1200px; margin: 0 auto;">
	
		<!-- 用于存储跳转的url地址 -->
		<input type="hidden" id="srcUrl" name="srcUrl" value="">
	
		<section class="leftbox area area_block"><!--div不可以？？？--> 
		<a id="logo" class="block" href="javascript:void(0);" oncontextmenu="return false;" ondragstart="return false;" style="cursor:default;">
			<div class="gap30"></div> 
			<img src="${path}/static/images/logo.png" width="450" height="90" alt="logo" oncontextmenu="return false;" ondragstart="return false;" >
		</a> 
		</section>

		<aside class="rightbox area area_block" style="position:relative;top:0px;height:180px;font-size:14px;letter-spacing:0;"><!-- 抵消 child_join 效果 写行内 要不bug... -->
		<div class="sr_hidden" style="width: 100%; height: 150px;">
			<div class="gap5"></div>
			<!-- mobile login -->
			<div id="mobilelog" style="overflow: visible;display: none;">
				<form class="form-horizontal" action="${path}/mobileLogin.do"
					id="MloginForm" name="loginForm" method="post" onsubmit="return Mlogs(&#39;click&#39;)">
					
					<div style="width:220px;margin:0 auto;">
					<input type="text" name="userName" id="Mcard_num"
						style="width: 180px; height: 30%;float:left;" placeholder="学号/工号 " required="required">
						<span id="Mcn" style="width: 10px;"></span>
					</div>
					<div class="gap5"></div>
					<div style="width:220px;margin:0 auto;">
					<input type="password" name="password" id="Mcard_pass"
						style="width: 180px; height: 30%;float:left;" placeholder="密码 " required="required">
						<span id="Mcp" style="width: 10px;"></span>
					</div>
					<div class="gap5"></div>
					<div style="width:220px;margin:0 auto;">
					<input type="text" name="code" id="Mcard_code"
						style="width: 80px; height: 30%;float:left;" placeholder="验证码 " required="required">
					<img id="Mimgcode" onclick="changeCode(this);" alt="看不清，单击更换" style="display:none;width:100px;height:30px;float:left;cursor:pointer;">
					<span id="Mcd" style="width: 10px;"></span>
					</div>	
					<div class="gap5"></div>
					<input type="submit" name="sub" id="MloginSub" value="登录" 
						class="btn btn-danger btn-block" style="width: 60px; *background: #f2000d;">
						
				</form>
			</div>
		</div>
		
		<c:if test="${!empty user}">
		<div class="moblie_show" style="width:100%; height: 60px;margin:0 auto;padding:0px;">
		<div class="gap20"></div>
			<ul class="inline">
				<!-- http://LostAndFound/index.html#myModal -->	
				<li style="margin-right:27px;padding:0px;">
					<a href="${path}/user/user-center.html" role="button"
						class="btn btn-mini btn-success" data-toggle="modal" title="${user.userName}"
						style="padding:0px;_float: right; _margin-top: 20px;" oncontextmenu="return false;" ondragstart="return false;">
						<b style="font-size:20px;height:40px;line-height:40px;">
						${user.userName}
						</b>
					</a>
				</li>
				<li style="margin-right:27px;padding:0px;">
					<a href="${path}/find/find-publish.html" style="padding:0px;_float: right; _margin-top: 20px;" 
						class="btn btn-mini btn-danger" title="捡到东西猛戳我" oncontextmenu="return false;" ondragstart="return false;">
						<b style="font-size:20px;height:40px;line-height:40px;">捡东西了</b>
					</a>
				</li>
				<li style="margin-right:27px;padding:0px;">
					<a href="${path}/lost/lost-publish.html" style="padding:0px;_float: right; _margin-top: 20px;"
						class="btn btn-mini btn-danger" title="丢失东西猛戳我" oncontextmenu="return false;" ondragstart="return false;">
						<b style="font-size:20px;height:40px;line-height:40px;">丢东西了</b>
					</a>
				</li>
				<li style="padding:0px;">
					<a class="btn btn-mini btn-success" onclick="return logout();" href="${path}/logout.do" style="padding:0px;_float: right;" oncontextmenu="return false;" ondragstart="return false;">
						<b style="font-size:20px;height:40px;line-height:40px;">注销</b>
					</a>
				</li>
			</ul>
		</div>
		</c:if>	
		
		<div class="sr_only" style="width: 100%; height: 30%;">
			<div class="gap20"></div>
			<ul class="inline">
				<!-- http://LostAndFound/index.html#myModal -->	
				<c:choose>
				<c:when test="${empty user}">
				<li>
					<a href="${path}/index.html#myModalLogin" id="loginClick" role="button"
						class="btn btn-mini btn-success" data-toggle="modal" title="立即登录"
						style="_float: right; _margin-top: 20px;" oncontextmenu="return false;" ondragstart="return false;">
						<b style="font-size:20px;height:20px;line-height:20px;">立即登录</b>
					</a>
				</li>
				</c:when>			
				<c:otherwise>
				<li>
					<a href="${path}/user/user-center.html" role="button"
						class="btn btn-mini btn-success" data-toggle="modal" title="${user.userName}"
						style="_float: right; _margin-top: 20px;">
						<b style="font-size:20px;height:20px;line-height:20px;">
						${(empty user.nickName) ? user.userName : user.nickName}
						</b>
					</a>
				</li>
				<li>
					<a href="${path}/find/find-publish.html" style="_float: right; _margin-top: 20px;" 
						class="btn btn-mini btn-danger" title="捡到东西猛戳我" oncontextmenu="return false;" ondragstart="return false;">
						<b style="font-size:20px;height:20px;line-height:20px;">捡东西了</b>
					</a>
				</li>
				<li>
					<a href="${path}/lost/lost-publish.html" style="_float: right; _margin-top: 20px;"
						class="btn btn-mini btn-danger" title="丢失东西猛戳我" oncontextmenu="return false;" ondragstart="return false;">
						<b style="font-size:20px;height:20px;line-height:20px;">丢东西了</b>
					</a>
				</li>
				<li>
					<a class="btn btn-mini btn-success" onclick="return logout();"
						href="${path}/logout.do" style="_float: right;" oncontextmenu="return false;" ondragstart="return false;">
						<b style="font-size:20px;height:20px;line-height:20px;">注销</b>
					</a>
				</li>
				</c:otherwise>
				</c:choose>
			</ul>
		</div>

		<!-- Modal start-->
		<div id="myModalLogin" class="modal hide fade"
			style="background: WhiteSmoke; text-align: left; padding: 10px; font-size: 16px;"
			tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 id="myModalLabel"></h4>
				<h5>立即登录</h5>
				<p>寻找宝贝...</p>
			</div>

			<div class="modal-body">
				<form class="form-horizontal" id="loginForm" name="loginForm" 
					action="${path}/login.do" method="post" onsubmit="return logs(&#39;click&#39;)">
					
					<div class="control-group">
						<label class="control-label" for="Lcard_num">账号</label>
						<div class="controls">
							<input type="text" name="userName" id="Lcard_num"
								style="height: 5%; margin-top: 3px; margin-right: 3px;"
								required="required"><span id="Lcn">请输入账号！</span>
							<!-- chrom ie11 input bug 5% height fixed it -->
						</div>
					</div>

					<div class="control-group">
						<label class="control-label" for="Lcard_pass">密码</label>
						<div class="controls">
							<input type="password" name="password" id="Lcard_pass"
								style="height: 5%; margin-top: 3px; margin-right: 3px;"
								required="required"><span id="Lcp">请输入密码！</span>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label" for="Lcard_code">验证码</label>
						<div class="controls">
							<input type="text" name="code" id="Lcard_code"
								style="height: 5%; margin-top: 3px; margin-right: 3px;width:100px;"
								required="required">
								<img id="imgcode" onclick="changeCode(this);" title="看不清，单击更换" alt="看不清，单击更换" style="display:none;width:80px;height:30px;cursor:pointer;">
								<span id="Lcd">请输入验证码！</span>
						</div>
					</div>

					<div class="control-group">
						<div class="controls">
							<input type="submit" name="sub" id="loginSub" value="登录"
								class="btn btn-danger btn-block" style="margin-left: -90px; height: 30px; *background: #f2000d;">
						</div>
					</div>

				</form>
			</div>

			<div class="modal-footer">
				<p class="pull-left">
					<a href="javascript:void(0);" target="_blank" title="${webSiteTitle}找回密码">找回密码</a>
				</p>
				<p class="pull-right">${webSiteTitle}</p>
				<div class="accordion" id="accordion2">
					<div class="accordion-group" style="border: none;">
						<div class="accordion-heading">
							<a class="accordion-toggle" data-toggle="collapse"
								data-parent="#accordion2" href="${path}/index.html#collapseOne">
								<p style="font-size: 12px; margin-top: -3px; *margin-top: -1px; float: left; color: green;">
								|&nbsp;&nbsp;&nbsp;登录帮助
								</p>
							</a>
						</div>
						<div id="collapseOne" class="accordion-body collapse" style="border:none;font-size:12px;width:100%;max-height:80px;">
               				<div class="accordion-inner alert alert-error" style="float:left;text-align:left;height:60px;">
								*账号即为学生的学号，教师的工号。<br> 
								*密码，初始与账号相同，请登录后立即修改并完善个人信息。<br> 
								*忘记密码请联系平台管理员（1254403440）。
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
		<!-- /.Modal end-->

		<div id="searchdiv" style="width: 100%; height: 30px;">
			<!-- 站内搜索 start -->
			<form name="searchForm" action="${path}/search-list.html" method="get"
				class="form-search" onsubmit="return checkpost();">
				<input type="text" id="search" name="keywords" value="${keywords}" list="words" class="input-medium search-query"
					style="width: 200px; font-size: 12px; overflow: hidden; height: 25%;"
					placeholder="搜搜看~双击查看小伙伴们的搜索热词" x-webkit-speech="" x-webkit-grammar="bUIltin:search">
				<datalist id="words">
					<option value="钱包"></option>
					<option value="饭卡"></option>
					<option value="u盘"></option>
					<option value="手机"></option>
					<option value="..."></option>
				</datalist>
				<button type="submit" class="btn btn-danger" title="不搜你不知道，一搜说不定就有">Search</button>
			</form>
			<!-- /.站内搜索 end -->
		</div>
		</aside>
		<!-- /.header rightbox end -->

	</div>
	<!-- /.big box end --> 
	</header>
	
	<script type="text/javascript">
	
		// 移动终端登录获得焦点
		function mobileLoginFocus(event){
			alert("请您先登录啊!");
			scroll(0,0);
			$('#Mcard_num').focus();
            event.preventDefault();// 如果<a>定义了 target="_blank" 需要这句来阻止打开新页面 
		}
		
		// PC端网页登录获得焦点显示
		function loginFocus(event){
			event.preventDefault();// 如果<a>定义了 target="_blank" 需要这句来阻止打开新页面      
            $('#myModalLogin').modal({
              keyboard: true
            });
		}
	
		// 搜索防空
		function checkpost(){
		     if(searchForm.search.value==""){
		      alert("请输入搜索内容！");
		      searchForm.search.focus();
		      return false;
		    }
		}
		 
		//更换验证码	
		function changeCode(_this) {
			_this.src = "${path}/code.do?createTypeFlag=nl&t=" + new Date().getTime();
		}
		
		//注销
		function logout(){
		    return confirm("您确定要注销登录吗?");
		}	
	
	</script>
