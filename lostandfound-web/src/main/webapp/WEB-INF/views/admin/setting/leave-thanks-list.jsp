<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>留言感谢列表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<%@include file="../common/base-css-js.jsp"%>
    <style type="text/css">
    html, body{
        margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
    }    
    </style>
</head>
<body>
    <h1>留言感谢列表信息</h1> 
    <div style="width:100%;">
        <div class="mini-toolbar" style="border-bottom:0;padding:0px;">
            <table style="width:100%;">
                <tr>
                    <td style="width:100%;">
                        <a class="mini-button" iconCls="icon-remove" onclick="remove();">删除</a>
                        <a class="mini-button" iconCls="icon-download" onclick="exportExcel();" style="margin-left:45px;">导出Excel</a>       
                    </td>
                    <td style="white-space:nowrap;">
                        <input id="key" class="mini-textbox" emptyText="请输入标题/感谢人" style="width:150px;" onenter="onKeyEnter"/>   
                        <a class="mini-button" iconCls="icon-search" plain="true" onclick="search()">查询</a>
                    </td>
            	    </tr>	
            </table>           
        </div>
    </div>
   <!--撑满页面-->
   <div class="mini-fit" >
    <div id="datagrid1" class="mini-datagrid" style="width:100%;height:100%;" allowResize="true"
        url="${path}/admin/leave-thanks-list.html" idField="id" multiSelect="true">
        <div property="columns">
            <div type="indexcolumn"></div>
            <div type="checkcolumn" width="20"></div>
            <div field="title" width="100" headerAlign="center" align="center">标题</div>
            <div field="substance" width="300" headerAlign="center" align="center">感谢内容</div>       
            <div field="userName" width="50" headerAlign="center" align="center" allowSort="true">感谢人</div>    
            <div field="leaveTime" width="80" headerAlign="center" align="center" dateFormat="yyyy-MM-dd HH:mm:ss" allowSort="true">操作时间</div>
        </div>
    </div>
    </div>
    
    <iframe id="exportIFrame" style="display:none;"></iframe>
    
    <!--导出Excel相关HTML-->
     <form id="excelForm"  action="${path}/admin/thanks-toExcel.html" method="post" target="excelIFrame">
        <input type="hidden" name="columns" id="excelData" />
    </form>
    <iframe id="excelIFrame" name="excelIFrame" style="display:none;"></iframe>
    

    <script type="text/javascript">
        mini.parse();

        var grid = mini.get("datagrid1");
        grid.load();
        grid.sortBy("id", "asc");
        
        grid.on("rowdblclick", function(e) {
        	var record = e.record,
 	        column = e.column,
 	        field = e.field,
 	        value = e.value;
        	
        	var url = "${path}/admin/thanks-view.html";
        	var title = "查看留言感谢信息";
        	// showView(url, title, record.id);
        });
        
        // 删除
        function remove() {
            
            var rows = grid.getSelecteds();
            if (rows.length > 0) {
            	mini.confirm("确定删除选中的"+rows.length+"条记录？", "消息", function(action) {
                if (action == "ok") {
                    var ids = [];
                    for (var i = 0, l = rows.length; i < l; i++) {
                        var r = rows[i];
                        ids.push(r.id);
                    }
                    var id = ids.join(',');
                    grid.loading("操作中，请稍后......");
                    $.ajax({
                        url: "${path}/admin/remove-thanks.html",
                        type: 'post',
                        data: {ids : id},
                        success: function (text) {
                        	grid.unmask();
                        	var o = mini.decode(text);
                        	mini.alert(o.mesg, "消息", function(e) {
                        		grid.reload();
                        	});
                        },
                        error: function () {
                        	grid.unmask();
                        	mini.alert("删除失败!", "消息", function(e) {
                        		grid.reload();
                        	});
                        }
                    });
                }
              });
            } else {
                mini.alert("请选中一条记录", "消息");
            }
        }
        
        // 查询
        function search() {
            var key = mini.get("key").getValue();
            grid.load({ key: key });
        }
        
        // Enter键查询
        function onKeyEnter(e) {
            search();
        }
        
     // 导出excel
     function exportExcel() {
         var columns = grid.getBottomColumns();
         
         function getColumns(columns) {
             columns = columns.clone();
             for (var i = columns.length - 1; i >= 0; i--) {
                 var column = columns[i];
                 if (!column.field) {
                     columns.removeAt(i);
                 } else {
                     var c = { header: column.header, field: column.field };
                     columns[i] = c;
                 }
             }
             return columns;
         }
         
         var columns = getColumns(columns);
         var json = mini.encode(columns);
         document.getElementById("excelData").value = json;
         var excelForm = document.getElementById("excelForm");
         excelForm.submit();            
     }

    </script>
    
</body>
</html>