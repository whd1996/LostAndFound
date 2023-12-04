<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../common/global.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title> ${webSiteTitle} 招领贴详情页面 </title>   
	<%@include file="../common/base-meta.jsp"%>
	<meta name="viewport" content="width=device-width, initial-scale=0.5, minimum-scale=0.5, maximum-scale=0.5, user-scalable=no">
	<%@include file="../common/base-css-js.jsp"%>

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
			#details  {
				width:90%;
				margin: 50px auto; 
			}	
			hr { /*container 与 footer 间*/
			    margin-top : 2%;    
			} 
		}
		
		/* min-width兼容移动设备 */
		@media screen and (min-width: 960px) { 		
			#details {
				max-width:75%;
				margin: 20px auto; 
			}		
		}
   </style>
   <body style="background: rgb(255, 255, 255); overflow-x: hidden;border:1px solid white;"> 
                                              <!--封装容器开始-->
   <div id="pagewrapper" style="margin:0 auto;height:auto;overflow:visible;min-height:600px;*height:800px;border: 1px solid white;">
                             <!--------------页眉开始------------------>	 
    <div class="container-fluid" style="width:100%;margin:0 auto;padding:0;">
	<!-- header start-->
	<div id="find-details-header" style="margin:0 auto;">
	<%@include file="../common/header.jsp"%>
	</div> 
	<!-- header end-->
	
	<!-- 导航条 start -->
	<%@include file="../common/navigator.jsp"%>
    <script>
    activeNav("find-details");
    </script>
	<!-- 导航条 end -->
	</div>
	                         <!--------------页眉结束------------------>				  
		
	                         <!-------------主体部分开始--------------->
     <div id="details" class="container-fluid" style="min-height:420px;border: 1px solid red;"> 
	     <p style="font-size:14px;color:black;">
	     	现在的位置 <a href="${path}/index.html" target="_self" style="color:#666;">主页</a>-&gt;招领贴详情页面 
		 </p>
		 
	<button id="prev" style="width:80px;height:30px;font-size:16px; position:relative; top:120px; left: -20px;" class="btn btn-mini btn-danger">上一贴</button>	 
	<button id="next" style="width:80px;height:30px;font-size:16px; float: right;position:relative; top:120px; right: -20px;" class="btn btn-mini btn-danger">下一贴</button>
	
	<script type="text/javascript">
		jQuery("#next").click(function (){
			$("#next").attr("disable", true);
			var id = ${pickThings.id};
			var url = "${path}/find/find-details.html/next/"+id;
			jQuery.post(url, function(data) {
				if (data[0] != null) {
					var newId = data[0].id;
					var locationurl = location.href.substring(0,location.href.lastIndexOf("/") + 1);
					location.href = locationurl + newId;
				}else{
					alert("已经是最后一贴了");
					$("#next").css("display","none");
					return false;
				}
			});
			$("#next").attr("disable", false);
		});	
		
		jQuery("#prev").click(function () {
			$("#prev").attr("disable", true);
			var id = ${pickThings.id};
			var url = "${path}/find/find-details.html/previous/"+id;
			jQuery.post(url, function(data) {
				if (data[0] != null) {
					var newId = data[0].id;
					var locationurl = location.href.substring(0,location.href.lastIndexOf("/") + 1);
					location.href = locationurl + newId;
				}else{
					alert("已经是第一贴了");
					$("#prev").css("visibility","hidden");
					return false;
				}
			});
			$("#prev").attr("disable", false);
		});
	
		function parseValue(value){
			var v;
			if(value == "card")
				v = "卡类证件";
			else if(value == "book")
				v = "书籍资料";
			else if(value == "clo")
				v = "衣物服饰";
			else if(value == "veh")
				v = "交通工具";
			else if(value == "per_eff")
				v = "随身物件";
			else if(value == "elec")
				v = "电子数码";
			else if(value == "other")
				v = "其他宝贝";
			else
				v = "";
			
			return v;			
		}
		
	</script>

	<hr style="width: 80%; margin:15px auto;">
	 
  <!-- Button to trigger modal -->
 
  <!-- Modal Srtart-->
  <div id="telInfo" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" width="300">
    <div class="modal-header">
       <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
       <h4 id="myModalLabel" style="text-align: center;">
       	<i class="icon-heart"></i> ${webSiteTitle} <i class="icon-heart"></i>
       </h4>
       <c:if test="${user.id eq pickThings.uid}">
    		<div style="font-size:12px;color: blue;text-align: center;line-height:15px;">此贴为自己发布的招领贴</div>
    	</c:if>
    </div>
    <div class="modal-body" id="user-info"></div>
    <div class="modal-footer">
       <button id="close" class="btn" data-dismiss="modal" aria-hidden="true" style="font-size:20px;">关闭</button>
       <c:choose>
       <c:when test="${(user.id ne pickThings.uid) and (pickThings.status != 1)}">
       	<button class="btn btn-primary" onclick="confirm('${path}/user/find-change.do','${pickThings.id}');">确定认领</button>
       </c:when>
       <c:when test="${(user.id eq pickThings.uid) and (pickThings.status != 1)}">
       	<button class="btn btn-primary" onclick="confirm('${path}/user/find-change.do','${pickThings.id}');">确定已归还</button>
       </c:when>
       </c:choose>
    </div>
  </div>
  <!-- Modal End-->
	 
 <table id="thingsinfo" style="width: 80%;margin: 0px auto;border: 1px solid red;">
	 <c:choose>
	 <c:when test="${!empty pickThings}">
	  <tbody>
	  <tr> <td>物品名称 : ${pickThings.thingsName}</td> </tr>
	  <tr> <td id="date">捡到时间 : ${pickThings.pickTime}</td> </tr>
	  <tr> <td id="place">捡到地点 : ${pickThings.pickPlace}</td> </tr>
	  <tr>	 
	   <td>所属类型 : <script>document.write(parseValue("${pickThings.thingsType}"));</script></td>
	   <c:if test="${pickThings.thingsType eq 'card' and !empty pickThings.thingsNo}">
	   <tr> <td>卡号 : ${pickThings.thingsNo}（安全起见，只为您显示后三位!）</td> </tr>
	   </c:if>
	  </tr>
	  <tr> <td>相关描述 : ${pickThings.thingsDes} </td> </tr>
	  <c:if test="${!empty pickThings.storagePlace}">
	  <tr> <td>暂存地点 : ${pickThings.storagePlace} &nbsp;&nbsp;联系电话: ${pickThings.telPhone}</td> </tr>
	  </c:if>
	  <tr> <td><input type="button" class="btn-success" id="showTel" name="showTel" value="查看发帖人及其联系方式"> </tr>
	  <c:if test="${!empty pickThings.thingsImg}">
	  <tr>  
	  	<td>物品图片: <img src="${path}/${pickThings.thingsImg}" alt="物品图片" width="150" height="150" oncontextmenu="return false;" ondragstart="return false;" style="width:150px;height:150px;" > </td> 
	  </tr>	   	  
	  </c:if>
	 </tbody>
	 </c:when>
	 <c:otherwise>
	 <tbody>
   	 <tr>
	   <td colspan="3" style="color: red;text-align: center;" > 
	   	<div style="width:200px;margin:150px auto;">暂无该记录!</div>
	   </td>
     </tr>
	 </tbody>	
	 </c:otherwise>
	 </c:choose>
  </table>
	
<script>  
		
   $("#showTel").click(function(event){
		 // 未登录控制
		 if(!isLogin){
			// 小屏幕未登录
			if(isSmallScreen()) {
				mobileLoginFocus(event);
			} else {
				loginFocus(event);
			}
		 } else {
			 event.preventDefault();// 如果<a>定义了 target="_blank" 需要这句来阻止打开新页面   
			 var url = "${path}/user/user-query.do";
			 var userId = "${pickThings.uid}";
			 showInfo(url, userId);
		 }
	});
	
    // 显示发帖人信息
	function showInfo(url, userId){
		 var table = '<table style="width: 80%;margin: 0px auto;">'
			  + '<tbody><tr><td>账号 : <span id="userName"></span></td><td>姓名 : <span id="name"></span></td></tr>'
			  + '<tr><td>联系电话 : <span id="telPhone"></span></td><td>QQ : <span id="qq"></span></td></tr>'
			  + '<tr><td>邮箱 : <span id="email"></span></td><td></td></tr>'
		  	  + '</tbody></table>';
	 	 $("#user-info").html(table);
	 	 
		 $('#telInfo').modal({
	            backdrop: 'static', keyboard: false
	     });
		 
		 userInfo(url, userId);
	}
	
	// 发帖人信息
	function userInfo(url, userId) {
		$.post(url, {userId: userId}, function(data,status){
			 //alert(data.userName +" "+status);
			 if(status == "success") {
				 $("#userName").html(data.userName);
				 $("#name").html(data.name);
				 $("#telPhone").html(data.telPhone);
				 $("#qq").html(data.qq);
				 $("#email").html(data.email);
			 } else {
				 $("#user-info").html('<span style="color:red;">获取发帖人信息失败，请刷新重新获取...</span>');
			 }
		 }, "json");
	}
	 
	 
	function confirm(url, id) {
		 //alert(url + id);
		 $.post(url, {id: id}, function(data){
			 $("#close").click();
			 window.location.reload(true);
		 }, "json");
	 }
	
	function showMsg(){
		 $("#user-info").html('<span style="color: red;">您确定相关物品完成了妥善的交接？感谢您所做的一切!</sapn>');
         $('#telInfo').modal({
       	  backdrop: 'static', keyboard: false
         });
	}
	
	</script>
	
	<c:if test="${!empty user}">
	<div style="margin-right:100px;">
	    <c:choose>
		<c:when test="${(pickThings.uid == user.id) and (pickThings.status != 1)}">
			<a href="javascript:void(0);" onclick="showMsg();" class="btn-success pull-right" >失主已找到</a>
		</c:when>
		<c:when test="${pickThings.status == 1}">
			<a href="javascript:void(0);" class="btn-success pull-right" style="cursor:default;">此贴已成功</a>
		</c:when>
		<c:when test="${(pickThings.uid != user.id) and (pickThings.status != 1)}">
			<a href="javascript:void(0);" onclick="showMsg();" class="btn-success pull-right">宝贝已找到</a>
		</c:when>
		</c:choose>
	</div>
	</c:if>
 
	</div> 
	                        <!-------------主体部分结束--------------->
     <hr>				
                            <!----------------页脚开始---------------->	
     <div class="container-fluid footer" style="max-width:100%;height:100px;">
	   <div style="width:100%;margin:10px auto;text-align: center;"> 
	     <!--页脚相关信息-->
			<%@include file="../common/footer.jsp" %>
	     <!--网站相关说明及信息-->
		</div>
   	</div>
                            <!----------------页脚结束---------------->
   </div>
                                         <!--封装容器结束-->
   <script> 
	//********************页尾功能js*********************//
	
	jQuery(function () {
		
		// 登录框改变
		$("#myModalLogin .modal-header p").html('登录后，可查看<font color="red">联系方式</font>等信息');
		
		$('html, body').animate({  
               scrollTop: $("#details").offset().top
           }, 1500); 
		
	});	
	
</script>
</body>
</html>