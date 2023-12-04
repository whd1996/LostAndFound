<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>公告信息列表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<%@include file="../common/base-css-js.jsp"%>
    <style type="text/css">
    html, body{
        margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
    }    
    </style>
</head>
<body>
    <h1>公告列表信息</h1> 
    <div style="width:100%;">
        <div class="mini-toolbar" style="border-bottom:0;padding:0px;">
            <table style="width:100%;">
                <tr>
                    <td style="width:100%;">
                    	<a class="mini-button" iconCls="icon-add" onclick="add();">增加</a>
                    </td>
                    <td style="white-space:nowrap;">
                        <input id="key" class="mini-textbox" emptyText="请输入公告标题" style="width:150px;" onenter="onKeyEnter"/>   
                        <a class="mini-button" iconCls="icon-search" plain="true" onclick="search()">查询</a>
                    </td>
            	    </tr>	
            </table>           
        </div>
    </div>
   <!--撑满页面-->
   <div class="mini-fit" >
    <div id="datagrid1" class="mini-datagrid" style="width:100%;height:100%;" allowResize="true"
        url="${path}/admin/notice-list.html" idField="id" multiSelect="true" >
        <div property="columns">
            <div type="indexcolumn"></div>
            <div type="checkcolumn" width="20"></div>
            <div field="title" width="100" headerAlign="center" align="center">标题</div>
            <div field="substance" width="200" headerAlign="center" align="center">内容</div>       
            <div field="publishTime" width="80" headerAlign="center" align="center" dateFormat="yyyy-MM-dd HH:mm:ss" allowSort="true">发布时间</div>
            <div field="status" width="30" headerAlign="center" align="center" renderer="onStatusRenderer">状态</div>
            <div header="操作" width="40" headerAlign="center">
                <div property="columns">
                	<div name="action" width="80" headerAlign="center">删除</div>
                </div>
            </div>
        </div>
    </div>
    </div>

    <script type="text/javascript">
        mini.parse();

        var grid = mini.get("datagrid1");
        grid.load();
        grid.sortBy("id", "asc");
        
        grid.on("drawcell", function (e) {
            var record = e.record,
	        column = e.column,
	        field = e.field,
	        value = e.value;
            
          	//action列，超连接操作按钮
            if (column.name == "action") {
                e.cellStyle = "text-align:center";
                e.cellHtml = '<a href="javascript:remove(\'' + record.id + '\')">删除</a>';
            }
        });
        
     	// 添加
        function add() {
            
            mini.open({
                url: "${path}/admin/save-notice.html",
                title: "新增公告", width: 600, height: 250, allowResize: false,
                onload: function () {
                    var iframe = this.getIFrameEl();
                    var data = { action: "new"};
                    iframe.contentWindow.setData(data);
                },
                ondestroy: function (action) {

                    grid.reload();
                }
            });
        }
        
        // 删除
        function remove(id) {
            
        	mini.confirm("确定删除选中的记录？", "消息", function(action) {
            if (action == "ok") {
               grid.loading("操作中，请稍后......");
               $.ajax({
                   url: "${path}/admin/remove-notice.html",
                   type: 'post',
                   data: {noticeId : id},
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
        
        function onStatusRenderer(e) {
            if (e.value == 0) 
            	return "不显示";
            else if(e.value == 1)
            	return "已发布";
        }

    </script>
    
</body>
</html>