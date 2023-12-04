<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../common/global.jsp"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title> ${webSiteTitle} 用户中心 </title>   
	<%@include file="../common/base-meta.jsp"%>
	<meta name="viewport" content="width=device-width, initial-scale=0.5, minimum-scale=0.5, maximum-scale=0.7">
	<%@include file="../common/base-css-js.jsp"%>
	<!-- easyui-css -->
	<link rel="stylesheet" type="text/css" href="${path}/static/easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="${path}/static/easyui/themes/icon.css">
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
				margin: 50px auto; 
			}
			.easyui-layout{
				width:100%;
			}	
			.p_info {
				width:99.5%;
			}
		}
		
		/* min-width兼容移动设备 */
		@media screen and (min-width: 960px) { 		
			#details {
				margin: 20px auto; 
			}
			.easyui-layout{
				width:80%;
			}
			.p_info {
				width:78%;
			}		
		}
   </style>
<body style="background: rgb(255, 255, 255); overflow-x: hidden;"> 
                                              <!--封装容器开始-->
   <div id="pagewrapper" style="margin:0 auto;height:auto;overflow:visible;min-height:800px;*height:800px;">
                             <!--------------页眉开始------------------>	 
    <div class="container-fluid" style="width:100%;margin:0 auto;padding:0;">
	<!-- header start-->
	<div id="user-center-header" style="margin-top: 0px;">
	<%@include file="../common/header.jsp" %>
	</div> 
	<!-- header end-->
	
	<!-- 导航条 start -->
	<%@include file="../common/navigator.jsp"%>
    <script>
    activeNav("user-center");
    </script>
	<!-- 导航条 end -->
	</div>
	                         <!--------------页眉结束------------------>				  
	                         <!-------------主体部分开始--------------->
     <div id="details" class="container-fluid" style="max-width:100%;height:auto;border: 1px solid red;"> 
		<p class="p_info" style="margin:0 auto;height:15px;font-size:14px;color:black;">
	     	<span style="float:left;">现在的位置 <a href="${path}/index.html" target="_self" style="color:#666;">主页</a>-&gt;用户中心页面 </span>
		</p>
		 
	 	<div id="myLayOut" class="easyui-layout" style="height:400px;margin:0 auto;"> 
		<div data-options="region:'west',split:true,collapsible:true,minWidth:150,maxWidth:180" title="菜单导航" style="width:100px;">
		
			<div class="easyui-accordion" data-options="fit:true,border:false">
             <div id="p_info" title="个人信息" data-options="iconCls:'icon-user'">
                 <ul class="tree easyui-tree" data-options="animate:true,lines:true" style="padding: 10px;">
                      <li data-options="iconCls:'icon-save'">
                          <a href="${path}/user/user-info.do" onclick="load(this, '个人信息');return false;" oncontextmenu="return false;" ondragstart="return false;">完善修改个人资料</a>
                      </li>
                      <li data-options="iconCls:'icon-edit'">
                          <a href="${path}/user/user-password.do" target="mainFrame" onclick="load(this, '个人信息');return false;" oncontextmenu="return false;" ondragstart="return false;">修改密码</a>
                      </li>
                 </ul>
             </div>
             <div id="fl_info" title="帖子信息" data-options="iconCls:'icon-zoom-in'">
                 <ul class="tree easyui-tree" data-options="animate:true,lines:true" style="padding: 10px;">
                     <li data-options="iconCls:'icon-search'">
                         <a href="${path}/user/find-info.do" target="mainFrame" onclick="load(this, '帖子信息');return false;" oncontextmenu="return false;" ondragstart="return false;">查看招领贴列表</a>
                     </li>
                     <li data-options="iconCls:'icon-search'">
                         <a href="${path}/user/lost-info.do" target="mainFrame" onclick="load(this, '帖子信息');return false;" oncontextmenu="return false;" ondragstart="return false;">查看寻物贴列表</a>
                     </li>
                 </ul>
             </div>
             <div id="s_info" title="系统设置" data-options="iconCls:'icon-cog'">
                  <ul class="tree easyui-tree" data-options="animate:true,lines:true" style="padding: 10px;">
                     <li data-options="iconCls:'icon-edit'">
                         <a href="${path}/user/user-password.do" target="mainFrame" onclick="load(this, '系统设置');return false;" oncontextmenu="return false;" ondragstart="return false;">修改登录密码</a>
                     </li>
                     <li data-options="iconCls:'icon-search'">
                             <a href="${path}/user/user-log.do" target="mainFrame" onclick="load(this, '系统设置');return false;" oncontextmenu="return false;" ondragstart="return false;">查看登录日志列表</a>
                     </li>
                 </ul>
             </div>
         </div>
         
		</div>
        <div id="center" title="个人中心" data-options="region:'center'">
        	<iframe id="mainFrame" name="mainFrame" src="${path}/user/default.html" frameborder="0" width="100%" height="100%" >
            </iframe>
		</div>
		</div> 
		<script type="text/javascript">
		function setTitle(text){
			text = " >>>> " +text;
			$("#myLayOut").layout('panel','center').panel('setTitle','<a href="${path}/user/default.html" target="mainFrame">个人中心</a>' +text);
		}
		
		function load(_this, text){
			setTitle(text);
			loadIframe(_this.href);
		}
		
		// 加载Iframe页面
		function loadIframe(url){
			var html;
	    	$.post(url,
	    			function(data){
	    				html = data;
	    				// 先清除一下内容
	    				window.frames.mainFrame.document.body.innerHTML = "";
      					window.frames.mainFrame.document.write(html);
      					// 写完关闭
      					window.frames.mainFrame.document.close();
	    			},
	    			function(data){
	    				html = '<div style="width:150px;margin:150px auto;height:25px;color:red;">加载失败...</div>';
	    				window.frames.mainFrame.document.body.innerHTML = html;
	    			},
	    			"html"
	    		);
		}
		</script>
	</div> 	 
	                        <!-------------主体部分结束--------------->
     <hr>				
                            <!----------------页脚开始---------------->	
    <div class="container-fluid footer" style="max-width:100%;height:80px;">
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
	</script>

</body>
</html>