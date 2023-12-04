<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="common/global.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title> ${webSiteTitle} 招领信息页面 </title>
	<%@include file="common/base-meta.jsp"%>
	<meta name="viewport" content="width=device-width, initial-scale=0.5, minimum-scale=0.5, maximum-scale=0.5, user-scalable=no">
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
		
  </style>    
  </head>
  
  <body style="background: rgb(255, 255, 255); overflow-x: hidden;height:auto;border:1px solid white;"> 
   <div id="pagewrapper" style="width:100%;margin:0 auto;overflow:visible;">
                             <!--------------页眉开始------------------>	 
    <div class="container-fluid" style="width:100%;margin:0 auto;padding:0;">
	<div style="min-width:100%;max-width:1440px;margin:0 auto;">
		<!-- header start-->
		<div id="find-list-header" style="margin-top: 0px;">
		<%@include file="common/header.jsp"%>
		</div>
		<!-- header end-->	
	
	<!-- 导航条 start -->
	<%@include file="common/navigator.jsp"%>
    <script>
    activeNav("find-list");
    </script>
	<!-- 导航条 end -->
	</div>
	</div>
	                         <!--------------页眉结束------------------>				  
		
	                         <!-------------主体部分开始--------------->
							 
	<div id="container" class="container-fluid" style="max-width:100%;border:1px solid red;">
	<div style="width:100%;height:30px;">
	<span style="width:38%;float:left;padding-left:10%;font-size:14px;color:black;">
		<span>现在的位置 <a href="${path}/index.html" target="_self" style="color:#666;">主页</a>-&gt; 招领信息页面</span>
	</span>
	<span style="width:38%;float:right;text-align:right;padding-right:10%;">
		<select name="type"	id="types" style="width:160px;">			
			<option value="${path}/find/find-list.html/1/${pageSize}/all">--请选择物件类型--</option>
			<option value="${path}/find/find-list.html/1/${pageSize}/card">卡类证件</option>
			<option value="${path}/find/find-list.html/1/${pageSize}/book">书籍资料</option>
			<option value="${path}/find/find-list.html/1/${pageSize}/clo">衣物服饰</option>
			<option value="${path}/find/find-list.html/1/${pageSize}/per_eff">随身物件</option>
			<option value="${path}/find/find-list.html/1/${pageSize}/elec">电子数码</option>
			<option value="${path}/find/find-list.html/1/${pageSize}/veh">交通工具</option>
			<option value="${path}/find/find-list.html/1/${pageSize}/other">其他宝贝</option>
		</select>
	</span>
	<script>
		//按类搜索
		$("#types").change(function(){
		   location.href=this.options[this.selectedIndex].value;
		});	

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
	</div>
     
     <hr style="margin-top:0">
	 <div class="listthings" style="margin:-5px auto;*margin-top:-15px;height:auto;min-height:180px;border-bottom:1px solid #aaa;">
	 <!--招领信息内容展示容器-->
	 <table style="border:1px solid #aaa;" class="table table-striped table-hover">
	 <!--表格形式展示-->
	 <thead>
	  <tr>
	   <th>物品类型</th> <th>物品名称</th> <th>捡到地点</th> <th>发布时间</th> <th>好童鞋的心声</th> <th>详情</th>
	  </tr>
	  </thead>
	  <c:choose>
	  <c:when test="${empty pickThingsList}">
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
	  <c:forEach items="${pickThingsList}" var="pickList" varStatus="vs">
		<tr
				<c:if test="${pickList.status ==0}">
			<c:if test="${vs.index mod 2 == 0 }">style="background: white;"</c:if>>
			<td style="width:80px;"><script>document.write(parseValue("${pickList.thingsType}"));</script></td>
			<td class="limit">${pickList.thingsName}</td>
			<td class="limit">${pickList.pickPlace}</td>
			<td style="width:90px;"><fmt:formatDate value="${pickList.publishTime}" pattern="yyyy-MM-dd"/></td>
			<c:choose>
			<c:when test="${(pickList.thingsType eq 'card') and (!empty pickList.thingsNo)}">
			<td class="limit">尾号<b style="color:red;"> ${pickList.thingsNo} </b>的卡的失主在哪里呢</td>
			</c:when>
			<c:otherwise>
			<td class="limit"><b style="color:red;"> ${pickList.thingsName} </b>的失主在哪里呢</td>
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
				</c:if>
	</c:forEach>
	</tbody>
	</c:otherwise>
	</c:choose>
	</table>
	</div>
	  <script type="text/javascript">
 		var url = location.href; //把当前页面的地址赋给变量 url
  		var type = url.substring(url.lastIndexOf("/"));//取 url 最一个/分隔符的值"/type" 即当前type值 用于保存条件状态
    	//alert(type);
		for(var i = 0; i < document.getElementById('types').options.length; i++) {			
			var typevalue = document.getElementById('types').options[i].value;
    		if(typevalue.substring(typevalue.lastIndexOf("/")) == type) { 
    			document.getElementById('types').options[i].selected = true; 
    			break;
    		}
		}
 	  </script>
	<div style="width:100%;height:50px;text-align:center;margin:0 auto;padding-bottom:10px;">		
		<!-- url 是提供url地址的-->
		<page:createPager totalCount="${totalCount}" pageSize="${pageSize}"
		totalPage="${totalPage}" currentPage="${pageNum}" url="${path}/find/find-list.html" valueId="types"></page:createPager>
	</div>
    </div>
	                        <!-------------主体部分结束--------------->
							  
                            <!----------------页脚开始---------------->	
	 <div class="container-fluid footer" style="max-width:100%;height:120px;">
		   <div style="width:100%;margin:10px auto;text-align: center;"> 
		     <!--页脚相关信息-->
		     <%@include file="common/footer.jsp"%>
		     <!--网站相关说明及信息-->
		   </div>
   	 </div>
	                        <!----------------页脚结束---------------->
   </div>
                                         <!--封装容器结束-->
<script>	
	
</script>  
</body>
</html>