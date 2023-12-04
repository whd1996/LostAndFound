<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../common/global.jsp"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html5/loose.dtd">
<html>
<head>
	<title> ${webSiteTitle} 发招领贴页面 </title> 
	<%@include file="../common/base-meta.jsp"%>
	<meta name="viewport" content="width=device-width, initial-scale=0.5 maximum-scale=1.0 user-scalable=no"/>
	<%@include file="../common/base-css-js.jsp"%>
	<link rel="stylesheet" href="${path}/static/css/publish-find-lost.css">
	<script type="text/javascript" src="${path}/static/js/publish-find-lost.js"></script> 
	<script type="text/javascript" src="${path}/static/js/datepicker/WdatePicker.js"></script> 
	<style type="text/css">
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
				
	</style>

	<script type="text/javascript">
	
	showError("${upErr}", "${savaErr}");
	
	function checkValidForm(form){
		
		if(form.thingsName.value.trim() == ""){
			//alert("名称要填一下嘛!");
			form.thingsName.focus();
			valid(form.thingsName, "物品名称");
			return false;
		}
		
		if(form.pickTime.value.trim() == ""){
			//alert("时间要选一下嘛!");
			form.pickTime.focus();
			valid(form.pickTime, "捡到时间");
			return false;
		}
		
		if(form.pickPlace.value.trim() == ""){
			//alert("在哪捡到要填一下嘛!");
			form.pickPlace.focus();
			valid(form.pickPlace, "捡到地点");
			return false;
		}
		
		if(form.thingsType.value.trim() == "all"){
			//alert("类型要选一下嘛!");
			form.thingsType.focus();
			valid(form.thingsType, "物品类型");
			return false;
		} 
		
		if(form.storagePlace.value.trim() != ""){
			if(form.telPhone.value == ""){
				//alert("电话不能空哦!");
				form.telPhone.focus();
				valid(form.telPhone, "电话");
				return false;
			}
		} 
		
		return true;
	}
	
	
	</script>
</head>

<body style="background: rgb(255, 255, 255); overflow-x: hidden;"> 
                                              <!--封装容器开始-->
   <div id="pagewrapper" style="margin:0 auto;height:auto;overflow:visible;min-height:800px;*height:800px;border: 1px solid white;">
                             <!--------------页眉开始------------------>	 
    <div class="container-fluid" style="width:100%;margin:0 auto;padding:0;">
	<!-- header start-->
	<div id="find-publish-header" style="margin-top: 0px;">
	<%@include file="../common/header.jsp"%>
	</div>
	<!-- header end-->
	
	<!-- 导航条 start -->
	<%@include file="../common/navigator.jsp"%>
    <script>
    activeNav("find-publish");
    </script>
	<!-- 导航条 end -->
	</div>
	                         <!--------------页眉结束------------------>				  
   	<div id="details" class="container-fluid" style="min-height:550px;border: 1px solid red;"> 
	     <p style="font-size:14px;color:black;">现在的位置 <a href="${path}/index.html" target="_self" style="color:#666;">主页</a>-&gt; 	
			发布招领贴页面 
		 </p>
		 		 	
	<hr style="width: 80%; margin:15px auto;"> 
		
  	<form action="${path}/find/find-publish.html" method="post" enctype="multipart/form-data" onsubmit="return checkValidForm(this)" >
	 <table style="width: 100%;margin: 0px auto;background-color: #f5f5f5;">
	  <tbody>
	  <tr style="height:30px;">
	   <td style="width: 80px;valign: middle;">物品名称 : </td>
	   <td>
	   <input type="hidden" name="token" value="${token}" />
	   <input type="text" name="thingsName" id="thingsName" value="${pickThings.thingsName}" onfocus="valueListenerLimiter(this, 12);" onblur="labelHidden(this);" style="width:180px;margin-top:10px;" maxlength="12">
	   <span style="color:blue;font-size:12px;"></span>
	   </td>
	  </tr>
	  <tr style="height:30px;">
	   <td id="date">捡到时间 : </td>
	   <td id="date">
	   <input class="Wdate" type="text" name="pickTime" value="<fmt:formatDate value="${pickThings.pickTime}" pattern="yyyy-M-d" />" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd', maxDate:'%y-%M-%d'})" placeholder="选择日期" readonly style="width: 120px;margin-top:10px;"/>
	  </td>
	  </tr>
	  <tr>
	   <td id="place">捡到地点 : </td>
	   <td>
	   <input type="text" name="pickPlace" id="pickPlace" value="${pickThings.pickPlace}" onfocus="valueListenerLimiter(this, 15);" onblur="labelHidden(this);" style="width:230px;margin-top:10px;" maxlength="15">
	   <span style="color:blue;font-size:12px;"></span>
	   </td>
	  </tr>
	  <tr>
	   <td>所属类型 : </td>
	   <td>
	    <script>var cardTr = '<td id="card">卡号 : </td><td><input type="text" name="thingsNo" id="thingsNo" value="${pickThings.thingsNo}" onblur="validCardNumFormater(this);" style="width:50px;margin-top:10px;text-align:center;" maxLength="3">（安全起见，只填写后三位!）</td>';</script>
	    <select name="thingsType" id="thingsType" onchange="selectType(this,cardTr)" onblur="labelHidden(this);" class="offset3" style="margin-left: 0px;width:160px;margin-top:10px;">			
			<option value="all">--请选择物件类型--</option>
			<option value="card">卡类证件</option>
			<option value="book">书籍资料</option>
			<option value="clo">衣物服饰</option>
			<option value="per_eff">随身物件</option>
			<option value="elec">电子数码</option>
			<option value="veh">交通工具</option>
			<option value="other">其他宝贝</option>
		</select> 
		<span style="color:blue;font-size:12px;"></span>
		<script>
		   var type = $("#thingsType").children();
		   var tType = "${pickThings.thingsType}";
		   for(var i = 0; i < type.length;i++){
			   if(type[i].value == tType){
				   type[i].selected = true;
				   if(type[i].value == "card"){
					   $("#thingsType").change();
				   }				   
			   }
		   }
	   </script>
	   </td>
	  </tr>
	  <tr>
	   <td>相关描述 : </td>
	   <td>
	   <textarea name="thingsDes" id="thingsDes" rows="3" cols="10" onfocus="valueListenerLimiter(this, 50);" onblur="labelHidden(this);" style="width:300px;max-width:350px;max-height: 80px;margin-top:10px;text-align: left;">${pickThings.thingsDes}</textarea>	   
	   <span style="color:blue;font-size:12px;"></span>
	   </td>
	  </tr>
	  <tr>
	  <td>暂存地点 : </td>
	   <td>
	    <input type="text" name="storagePlace" id="storagePlace" value="${pickThings.storagePlace}" onfocus="valueListenerLimiter(this, 15);" onblur="labelHidden(this);" style="width:230px;margin-top:10px;" maxlength="15">
	    <span style="color:blue;font-size:12px;"></span>
	    <span id="tel" style="margin-left:10px;display:none;">
	    	电话: <input type="text" name="telPhone" id="telPhone" value="" onfocus="showTelFormater(this);" onblur="onBlurValidTel(this);" style="width:100px;margin-top:10px;text-align:center;">
	    	<span style="font-size:12px;"></span>
	    </span>
	   </td> 
	  </tr>
	  <tr>
	   <td>物品图片 : </td>
	   <td>
		   <div class="file" id="selectFile">		   
		    <div class="userdefined-file" >
		    　　<input type="text" name="userdefinedFile" id="userdefinedFile" value="未选择任何图片" >
		    　　<button type="button">上传</button>
		    </div>
		    <input type="file" name="Img" id="file" onchange="upload(this)"  accept="image/gif,image/jpeg,image/png" >
		</div>
		   <span style="font-size:12px;"></span>
	   </td>
	  </tr>
	  <tr style="text-align: center;">
	   <td colspan="2">
	   <input type="hidden" name="userName" value="${user.userName}">
	   <input type="hidden" name="uid" value="${user.id}">
	   <input type="submit" class="btn-success" id="publish" name="publish" value="发帖招领" style="margin-top: 20px;">
	   </td>
	  </tr>	    
	 </tbody>
	 </table>
	</form>
	</div> 
	                        <!-------------主体部分结束--------------->
     <hr>				
                            <!----------------页脚开始---------------->	
     <div id="footer"  class="container-fluid footer" style="max-width:100%;height:80px;">
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
	$(function (){
		$("#storagePlace").blur(function (){
			if($(this).val().trim() != "")
				$("#tel").show();
			else
				$("#tel").hide();
		});
	});
	
	</script>
</body>
</html>