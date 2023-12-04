<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>数据库操作</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<%@include file="../common/base-css-js.jsp"%>
    <style type="text/css">
    html, body{
        margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
    }    
    </style>
</head>
<body>
	<h1>数据库备份操作</h1>
	
	<div id="data" style="width:100%;height:100%;">
		<div style="width:150px;height:30px;text-align:center;margin: 50px auto;">
		<a href="${path}/admin/database-backup.html" class="mini-button" iconCls="icon-save">数据库备份</a>
		</div>
	</div>
	
	
	<script type="text/javascript">
        mini.parse();
        
    </script>
	
</body>
</html>