<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>用户列表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="../common/base-css-js.jsp"%>
    <script src="${path}/static/admin/js/user-things.js" type="text/javascript"></script>
    <style type="text/css">
    html, body{
        margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
    }
    </style>
</head>
<body>
    <h1>用户列表信息</h1>
    <div style="width:100%;">
        <div class="mini-toolbar" style="border-bottom:0;padding:0px;">
            <table style="width:100%;">
                <tr>
                    <td style="width:100%;">
                        <a class="mini-button" iconCls="icon-add" onclick="add();">增加</a>
                        <a class="mini-button" iconCls="icon-edit" onclick="edit();">编辑</a>
                        <c:if test="${admin.state == 3}">
                        	<a class="mini-button" iconCls="icon-remove" onclick="remove();">删除</a>
                        </c:if>
                        <a class="mini-button" iconCls="icon-lock" onclick="lock();">冻结</a>
                        <a class="mini-button" iconCls="icon-unlock" onclick="unlock();">解冻</a>
                        <c:if test="${admin.state == 3}">
                        	<a class="mini-button" iconCls="icon-user" onclick="resetPassword();">重置密码</a>
                        </c:if>
                        <a class="mini-button" iconCls="icon-download" onclick="exportExcel();" style="margin-left:45px;">导出Excel</a>      
                    </td>
                    <td style="white-space:nowrap;">
                        <input id="key" class="mini-textbox" emptyText="账号/年级/姓名" style="width:150px;" onenter="onKeyEnter"/>   
                        <a class="mini-button" iconCls="icon-search" plain="true" onclick="search()">查询</a>
                    </td>
            	    </tr>
            </table>
        </div>
    </div>
   <!--撑满页面-->
   <div class="mini-fit">
    <div id="datagrid1" class="mini-datagrid" style="width:100%;height:100%;" allowResize="true"
        url="${path}/admin/user-list.html" idField="id" multiSelect="true" >
        <div property="columns">
            <div type="indexcolumn"></div>
            <div type="checkcolumn"></div>
            <div field="userName" width="100" headerAlign="center" align="center" allowSort="true">用户账号</div>
            <div field="grade" width="40" headerAlign="center" align="center" allowSort="true">年级</div>
            <div field="name" width="60" headerAlign="center" align="center" allowSort="true">姓名</div>
            <div field="createTime" width="80" headerAlign="center" align="center" dateFormat="yyyy-MM-dd" allowSort="true">创建日期</div>    
            <div field="qq" width="80" headerAlign="center" align="center">QQ</div>
            <div field="email" width="100" headerAlign="center" align="center">邮箱</div>
            <div field="telPhone" width="80" headerAlign="center" align="center">联系电话</div>
            <div field="state" width="50" headerAlign="center" align="center" renderer="onStateRenderer">状态</div>
            <div header="操作" width="80" headerAlign="center">
                <div property="columns">
                	<div name="action" width="80" headerAlign="center">管理员设置</div>
                </div>
            </div>
        </div>
    </div>
  </div>
    
    <iframe id="exportIFrame" style="display:none;"></iframe>
    
    <!--导出Excel相关HTML-->
     <form id="excelForm"  action="${path}/admin/user-toExcel.html" method="post" target="excelIFrame">
        <input type="hidden" name="columns" id="excelData" />
    </form>
    <iframe id="excelIFrame" name="excelIFrame" style="display:none;"></iframe>
    

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
                var state = ${admin.state};
                if(record.state == 2) {
                	if(state == 3)
                		e.cellHtml = '<a href="javascript:setAdmin(\'' + record.id + '\', 1)">撤销管理员</a>';
                	else
                		e.cellHtml = '<b style="color: gray;">撤销管理员</b>';
                } else {
                	if(state == 3)
                		e.cellHtml = '<a href="javascript:setAdmin(\'' + record.id + '\', 2)">设为管理员</a>';
                	else
                		e.cellHtml = '<b style="color: gray;">设为管理员</b>';	
                }
            }
        });
        
     	// 添加
        function add() {
            
            mini.open({
                url: "${path}/admin/save-user.html",
                title: "新增用户", width: 600, height: 280, allowResize: false,
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
        
        // 编辑
        function edit() {
         
            var row = grid.getSelected();
            if (row) {
                mini.open({
                    url: "${path}/admin/save-user.html",
                    title: "编辑用户信息", width: 600, height: 280, allowResize: false,
                    onload: function () {
                        var iframe = this.getIFrameEl();
                        var data = { action: "edit", id: row.id };
                        iframe.contentWindow.setData(data);
                        
                    },
                    ondestroy: function (action) {
                        grid.reload();
                    }
                });
         	   } else {
                mini.alert("请选中一条记录", "消息");
            }
            
        }
        
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
                        url: "${path}/admin/remove-/user/.html",
                        type: 'post',
                        data: {ids : id},
                        success: function (text) {
                        	grid.unmask();
                        	var o = mini.decode(text);
                        	mini.alert(o.mesg, "消息", function(e) {
                        		// 有bug
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
        
     	// 冻结
        function lock() {
            
            var rows = grid.getSelecteds();
            if (rows.length > 0) {
            	mini.confirm("确定冻结选中的"+rows.length+"条记录？", "消息", function(action) {
                if (action == "ok") {
                    var ids = [];
                    for (var i = 0, l = rows.length; i < l; i++) {
                        var r = rows[i];
                        if(r.state == 0)
                        	continue;
                        ids.push(r.id);
                    }
                    var id = ids.join(',');
                    if(id) {
                    	grid.loading("操作中，请稍后......");
                        $.ajax({
                            url: "${path}/admin/lock-user.html",
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
                            	mini.alert("冻结失败!", "消息", function(e) {
                            		grid.reload();
                            	});
                            }
                        });
                    }
                }
              });
            } else {
                mini.alert("请选中一条记录", "消息");
            }
        }
     	
     	// 解冻
        function unlock() {
            
            var rows = grid.getSelecteds();
            if (rows.length > 0) {
            	mini.confirm("确定解冻选中的"+rows.length+"条记录？", "消息", function(action) {
                if (action == "ok") {
                    var ids = [];
                    for (var i = 0, l = rows.length; i < l; i++) {
                        var r = rows[i];
                        if(r.state != 0)
                        	continue;
                        ids.push(r.id);
                    }
                    var id = ids.join(',');
                    if(id) {
                    	grid.loading("操作中，请稍后......");
                        $.ajax({
                            url: "${path}/admin/unlock-user.html",
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
                            	mini.alert("解冻失败!", "消息", function(e) {
                            		grid.reload();
                            	});
                            }
                        });
                    }
                }
              });
            } else {
                mini.alert("请选中一条记录", "消息");
	        }
	     }
	     	
	     // 重置密码
	     function resetPassword() {
	    	var rows = grid.getSelecteds();
	           if (rows.length > 0) {
	        	   mini.confirm("确定重置密码选中的"+rows.length+"条记录？", "消息", function(action) {
	               if (action == "ok") {
	                   var user = [];
	                   for (var i = 0, l = rows.length; i < l; i++) {
	                       user.push(rows[i].id);
	                   }
	                   
	                   var users = user.join(",");
	                   console.info(users);
	                   grid.loading("操作中，请稍后......");
                       $.ajax({
                           url: "${path}/admin/reset-password.html",
                           type: 'post',
                           data: {usersId : users},
                           success: function  (text) {
                        		grid.unmask();
	                           	var o = mini.decode(text);
	                           	mini.alert(o.mesg, "消息", function(e) {
	                           		grid.reload();
	                           	});
                           },
                           error: function () {
                        	    grid.unmask();
	                           	mini.alert("重置密码失败!", "消息", function(e) {
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
     	
     	// 设为（撤销）管理员
     	function setAdmin(id, state) {
     		grid.loading("操作中，请稍后......");
            $.ajax({
                url: "${path}/admin/admin-user.html",
                type: 'post',
                data: {userId : id, state : state},
                success: function (text) {
                	grid.unmask();
                	var o = mini.decode(text);
                	mini.alert(o.mesg, "消息", function(e) {
                		grid.reload();
                	});
                },
                error: function () {
                	grid.unmask();
                	mini.alert("设置失败!", "消息", function(e) {
                		grid.reload();
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
        
        function onStateRenderer(e) {
            if (e.value == 0)
            	return "已冻结";
            else if(e.value == 1)
            	return "正常";
            else if(e.value == 2)
            	return "管理员";
            else if(e.value == 3)
            	return "超级管理员";
        }
        
    </script>
    
</body>
</html>