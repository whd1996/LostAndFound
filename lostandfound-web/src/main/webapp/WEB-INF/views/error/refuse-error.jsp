<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>${webSiteTitle} Refuse</title>
	<meta name="viewport" content="width=device-width, initial-scale=0.6, maximum-scale=1.0, user-scalable=no"/>
	<link rel="shortcut icon" href="${path}/static/images/favicon.ico" type="image/x-icon">
	<link rel="apple-touch-icon" href="${path}/static/images/applogo.png">
    <link rel="stylesheet" href="${path}/static/css/bootstrap.min.css" media="screen">
    
    <style type="text/css">
    /* min-width & max-width 兼容移动设备 */
	@media screen and (min-width: 220px) and (max-width: 960px) { 
		.img_error{
			width:99.5%;
			height:95%;
		}
	}
    
    </style>
</head>

<body style="background: rgb(255, 255, 255);">
	
	<div style="width:90%;text-align:center;margin:20px auto;">
		<img src="${path}/static/images/refuse.png" class="img_error" oncontextmenu="return false;" ondragstart="return false;"/>
		<div style="margin:10px auto;font-size: 24px;color: red;">移动设备不能访问该页面，请用PC端访问...</div>
		<div style="margin:20px auto;"><a href="javascript:history.back();" class="btn btn-success but-mini" style="width:80px;font-size:24px;">返回</a></div>
	</div>
	
</body>

</html>