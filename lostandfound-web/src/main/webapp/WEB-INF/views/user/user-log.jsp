<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${webSiteTitle}</title>
<script type="text/javascript" src="${path}/static/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="${path}/static/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${path}/static/easyui/locale/easyui-lang-zh_CN.js"></script>
<link rel="stylesheet" type="text/css" href="${path}/static/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${path}/static/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="${path}/static/easyui/demo.css">
</head>
<body>
	<table id="dg" title="个人登录日志列表" class="easyui-datagrid" width="100%"  height="100%"
             data-options="url:'${path}/user/user-log.html',method:'post',border:false,resizeHandle:'both',rownumbers:true,fit:true,fitColumns:true,pagination:true,pagePosition:'bottom'">
        <thead>
             <tr>
                 <th data-options="field:'userName',align:'center'" width="80">账号</th>
                 <th data-options="field:'osname',align:'center'" width="80">操作系统</th>
                 <th data-options="field:'browserName',align:'center'" width="80">浏览器</th>
                 <th data-options="field:'loginIp',align:'center'" width="80">登录IP</th>
                 <th data-options="field:'loginTime',align:'center',
                 	formatter : function(value){
                 		if(value) {
                 			value = value.replace('T',' ');
	                        return value;
                        }
                    }" width="100">登录时间</th>
             </tr>
        </thead>
    </table>
</body>
</html>