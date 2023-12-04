<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="common/global.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title> ${webSiteTitle} 搜索结果页面 </title>
	<%@include file="common/base-meta.jsp"%>
	<meta name="viewport" content="width=device-width, initial-scale=0.5, maximum-scale=1.0, user-scalable=no"/>
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
	   
   a {
       color: #666;
   }
	
	td {
	    width: 160px; /*不规定宽度，浏览器计算时会有空余，颜色表现不正常*/
	}
	
	.div-tabs {
		margin-left: 0;
		margin-bottom: 20px;
		list-style: none;
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
	}
	
	/* min-width兼容移动设备 */
	@media screen and (min-width: 960px) { 		
		#container {
			margin: 5px auto;
			max-width:75%;
		}		
	}
	
 </style>  

<body style="background: rgb(255, 255, 255); overflow-x: hidden;height:auto;border:1px solid white;"> 
                                              <!--封装容器开始-->
   <div id="pagewrapper" style="margin:0 auto;overflow:visible;height:auto;border: 1px solid white;">
                             <!--------------页眉开始------------------>									 
    <div class="container-fluid" style="width:100%;margin:0 auto;padding:0;">
	<!-- header start-->
	<div id="search-list-header" style="margin-top: 0px;">
	<%@include file="common/header.jsp"%>
	</div>
	<!-- header end-->	
	
	<!-- 导航条 start -->
	<%@include file="common/navigator.jsp"%>
    <script>
    activeNav("search-list");
    
    function parseValue(value){
		var v;
		if(value == "card")
			v = "卡类证件";
		else if(value == "book")
			v = "书籍资料";
		else if(value == "clo")
			v = "衣物服饰";
		else if(value == "per_eff")
			v = "随身物件";
		else if(value == "elec")
			v = "电子数码";
		else if(value == "veh")
			v = "交通工具";
		else if(value == "other")
			v = "其他宝贝";
		else
			v = "";
		
		return v;			
	}
    </script>
	<!-- 导航条 end -->
	</div>      
	                         <!--------------页眉结束------------------>				  
	                         <!-------------主体部分开始--------------->
	<div id="container" class="container-fluid" style="height:auto;">
		<p style="font-size:14px;color:black;">
		现在的位置 <a href="${path}/index.html" target="_self" style="color:#666;">主页</a>-&gt;	搜索结果页面 
		</p>
    <hr style="margin-top:-10px;">
    
    <div style="display:none;">
    <select name="page"	id="page" style="width:80px;" >			
			<option value="find">find</option>
			<option value="lost">lost</option>
	</select>
	</div>
	
	<div class="listthings" style="width:100%;padding:0px;margin:-5px auto;*margin-top:-15px;height:auto;min-height:180px;border-bottom:1px solid #aaa;">
		<!--帖子汇总-->
		<div class="tabbable">
        
        <ul class="nav nav-tabs">
        <!--选项卡-->     
          	<li class="active" id="find-li">
          	<a href="${path}/search-list.html#find" onclick="subValue(this)" data-toggle="tab" style="color:black;">招领信息</a>
          	</li>
			<li id="lost-li">
			<a href="${path}/search-list.html#lost" onclick="subValue(this)" data-toggle="tab" style="color:black;">寻物信息</a>
			</li>
        </ul>
        
		<div class="tab-content" style="width:100%;min-height:180px;height:auto;overflow:hidden;font-size:12px;">
		<!--选项卡对应内容-->
    	<div class="tab-pane active" id="find" style="width:100%;">
    	<!--默认显示失物页面-->
     	<table style="border:1px solid #aaa;" class="table table-striped table-hover">
     	<!--表格形式展示-->
	 	<thead>
		  	<tr>
		   	<th>物品类型</th> <th>物品名称</th> <th>捡到地点</th> <th>发布时间</th> <th>好童鞋的心声</th> <th>详情</th>
		  	</tr>
		  	</thead>
			<c:choose>
			  <c:when test="${empty searchPickThingsList}">
			  <tbody>
			  <tr height="160">
			  	<td colspan="6" style="color: red;text-align: center;">
			  		<div style="width:200px;margin:50px auto;">暂无记录!</div>
			  	</td>
			  </tr>
			  </tbody>	
			  </c:when>
			  <c:otherwise>
			  <tbody>
			  <c:forEach items="${searchPickThingsList}" var="pickList" varStatus="vs">
				<tr
					<c:if test="${vs.index mod 2 == 0 }">style="background: white;"</c:if>>
					<td style="width:80px;"><script>document.write(parseValue("${pickList.thingsType}"));</script></td>
					<td class="limit">${pickList.thingsName}</td>
					<td class="limit">${pickList.pickPlace}</td>
					<td style="width:90px;"><fmt:formatDate value="${pickList.publishTime}" pattern="yyyy-MM-dd"/></td>
					<c:choose>
					<c:when test="${pickList.thingsType eq 'card' and !empty pickList.thingsNo}">
					<td class="limit">尾号<b style="color:red;">${pickList.thingsNo}</b>的卡的失主在哪里</td>
					</c:when>
					<c:otherwise>
					<td class="limit"><b style="color:red;">${pickList.thingsName}</b>的失主在哪里</td>
					</c:otherwise>
					</c:choose>
					<td>
					<a href="${path}/find/find-details.html/${pickList.id}"
						title="失主在哪:${pickList.thingsName}">查看详情
						<c:if test="${pickList.status == 1}">
							<i style="display: inline; color: red; font-weight: bold;">成功贴</i>
						</c:if>
					</a>
					</td>
				</tr>
			</c:forEach>
			</tbody>
			</c:otherwise>
		</c:choose>
		 </table>
		 <div style="width:98%;height:50px;padding-bottom:10px;text-align:center;margin:0 auto;">		
			<!-- url 是提供url地址的-->
			<page:createPager totalCount="${picktotalCount}" pageSize="${pickpageSize}"
			totalPage="${picktotalPage}" currentPage="${pickpageNum}" url="${path}/search-list.html?keywords=${keywords}" valueId="page">
			</page:createPager>
	  	 </div>
     	</div>
     
	     <div class="tab-pane" id="lost" style="width:100%;">
	     <!--寻物页面-->
	     <table style="border:1px solid #aaa;" class="table table-striped table-hover">
	     <!--表格形式展示-->
		  <thead>
		  <tr>
		   <th>物品类型</th> <th>物品名称</th> <th>丢失地点</th> <th>发布时间</th> <th>焦急的呼声</th> <th>详情</th>
		  </tr>
		  </thead>
		  <c:choose>
		  <c:when test="${empty searchLostThingsList}">
		  <tbody>
		  <tr height="160" >
		  	<td colspan="6" style="color: red;text-align: center;">
		  		<div style="width:200px;margin:50px auto;">暂无记录!</div>
		  	</td>
		  </tr>
		  </tbody>	
		  </c:when>
		  <c:otherwise>
		  <tbody>	  
		  <c:forEach items="${searchLostThingsList}" var="lostList" varStatus="vs">
			<tr
				<c:if test="${vs.index mod 2 == 0 }">style="background: white;"</c:if>>
				<td style="width:80px;"><script>document.write(parseValue("${lostList.thingsType}"));</script></td>
				<td class="limit">${lostList.thingsName}</td>
				<td class="limit">${lostList.lostPlace}</td>
				<td style="width:90px;"><fmt:formatDate value="${lostList.publishTime}" pattern="yyyy-MM-dd"/></td>
				<c:choose>
				<c:when test="${lostList.thingsType eq 'card' and !empty lostList.thingsNo}">
				<td class="limit">尾号<b style="color:red;">${lostList.thingsNo}</b>的卡谁捡到了</td>
				</c:when>
				<c:otherwise>
				<td class="limit"><b style="color:red;">${lostList.thingsName}</b>谁捡到了</td>
				</c:otherwise>
				</c:choose>
				<td>
				<a href="${path}/lost/lost-details.html/${lostList.id}"
					title="失主在哪:${lostList.thingsName}">查看详情 
					<c:if test="${lostList.status == 1}">
						<i style="display: inline; color: red; font-weight: bold;">成功贴</i>
					</c:if>
				</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
		</c:otherwise>
		</c:choose>
		 </table>
		 <div id="pager" style="width:98%;height:50px;text-align:center;padding-bottom:10px;margin:0 auto;">		
			<!-- url 是提供url地址的-->
			<page:createPager totalCount="${losttotalCount}" pageSize="${lostpageSize}"
			totalPage="${losttotalPage}" currentPage="${lostpageNum}" url="${path}/search-list.html?keywords=${keywords}" valueId="page" >
			</page:createPager>
	  	</div>
	     </div>
    </div>
   	</div> 
  	<!-- /tabbable -->
	</div>
    </div>
    	<hr>
	                       <!-------------主体部分结束--------------->
                           <!----------------页脚开始---------------->	
	<div id="footer"  class="container-fluid footer" style="max-width:100%;height:80px;">
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
	
	$(function (){
		function activeTable() {
			var pageName = "${pageName}";
			var obj = document.getElementById(pageName);
			var find_li = $("#find-li");
			var lost_li = $("#lost-li");
			var find = document.getElementById("find");
			var lost = document.getElementById("lost");
			
			// alert(obj +" " +find);
			if(obj == find){
				lost_li.removeClass("active");
				find_li.addClass("active");
				$("#lost").removeClass("active");
				$("#find").addClass("active");
			}
			
			if(obj == lost){
				find_li.removeClass("active");
				lost_li.addClass("active");
				$("#find").removeClass("active");
				$("#lost").addClass("active");
			}
		}
		
		activeTable();
	});
	
	function subValue(_this){
		var value = _this.href.substring(_this.href.lastIndexOf("#") + 1);
		var obj = document.getElementById("page");
		selectedOption(obj,value);
	}
	
	// 选中select的option
	function selectedOption(obj,value) {
		for(var i = 0;i < obj.options.length; i++){
			if(value == obj.options[i].value){
				obj.options[i].selected = true;
				break;
			}
		}
	}
	
</script>

</body>
</html>