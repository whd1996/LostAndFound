<%--标签 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- css样式 -->
<link href="${path}/static/admin/css/demo.css" rel="stylesheet" type="text/css" />

<!-- js -->
<script src="${path}/static/admin/scripts/boot.js" type="text/javascript"></script>


<script type="text/javascript">
	
	//全局的ajax访问，处理ajax清求时sesion超时  
	$.ajaxSetup({  
	    contentType:"application/x-www-form-urlencoded;charset=utf-8",  
	    complete:function(XMLHttpRequest,textStatus){
	        //通过XMLHttpRequest取得响应头，sessionstatus，  
	        var sessionstatus = XMLHttpRequest.getResponseHeader("sessionstatus");   
	        if(sessionstatus == "timeout"){  
	        	//如果超时就处理 ，指定要跳转的页面  
	        	alert("页面过期，请重新登录!"); 
	        	parent.window.location.reload(true);  
	        }  
	    }  
	});
	
</script>

