<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>菜单列表</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<%@include file="../common/base-css-js.jsp"%>
    <style type="text/css">
    html, body{
        margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
    }    
    </style>
</head>
<body>
	<h1>菜单列表</h1>
	
	<!--撑满页面-->
   	<div class="mini-fit">
	<div id="treegrid1" class="mini-treegrid" url="${path}/admin/load-menuItem.html" showTreeIcon="true" style="width:100%;height:100%;" 
    treeColumn="taskname" idField="menuId" parentField="parentId" resultAsTree="false" allowResize="true" expandOnLoad="true">
	    <div property="columns">
	        <div type="indexcolumn"></div>
	        <div name="taskname" field="menuItemName" headerAlign="center">菜单名称</div>
	        <div field="menuItemUrl" headerAlign="center">菜单地址</div>
	        <div field="menuItemDes" headerAlign="center">菜单描述</div>
	        <div field="sort" width="20" headerAlign="center" align="center">菜单排序</div>
	        <div header="操作" width="60" headerAlign="center">
                <div property="columns">
                	<div name="action" width="60" headerAlign="center">菜单状态</div>
                </div>
            </div>                   
	    </div>
	</div>
	</div>
	
	
	<script type="text/javascript">
	mini.parse();
	
	var grid = mini.get("treegrid1");
	
	grid.on("drawcell", function (e) {
        var record = e.record,
        column = e.column,
        field = e.field,
        value = e.value;
        
      	//action列，超连接操作按钮
        if (column.name == "action") {
            e.cellStyle = "text-align:center";
            if(record.status == 1) {
            	e.cellHtml = '<b style="color: gray;">启用</b>';
            } else {
            	e.cellHtml = '<b style="color: gray;">停用</b>';	
            }
        }
    });	
	
	</script>
	
	
</body>
</html>