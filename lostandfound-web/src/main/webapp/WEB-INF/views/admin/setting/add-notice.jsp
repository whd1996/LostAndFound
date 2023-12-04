<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>公告面板</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="../common/base-css-js.jsp"%>

    <style type="text/css">
    html, body {
        font-size:14px;
        padding:0;
        margin:0;
        border:0;
        height:100%;
        overflow:hidden;
    }
    .text-rigth{text-align:right;}
    </style>
</head>
<body>    
     
    <form id="form1" method="post">
        <fieldset style="border:solid 1px #aaa;padding:3px;">
            <legend >公告基本信息</legend>
            <div style="padding:5px;">
        	<table style="table-layout:fixed;">
                <tr>
                    <td class="text-rigth" style="width:70px;">标&nbsp;&nbsp;题：</td>
                    <td style="width:300px;"> 
                        <input id="title" name="title" class="mini-textbox" width="300" required="true"  emptyText="请输入公告标题"/>
                    </td>
                </tr>
                <tr>
                    <td class="text-rigth">内&nbsp;&nbsp;容：</td>
                    <td  style="width:400px;">    
                        <input name="substance" class="mini-textArea" width="400" required="true" emptyText="请输入公告内容"/>
                    </td>
                </tr>
            </table>
            </div>
        </fieldset>
        <div style="text-align:center;padding:10px;margin-top:25px;">               
            <a class="mini-button" onclick="onOk" style="width:60px;margin-right:20px;">确定</a>       
            <a class="mini-button" onclick="onCancel" style="width:60px;">取消</a>       
        </div>        
    </form>
    <script type="text/javascript">
    
        mini.parse();

        var form = new mini.Form("form1");

        function saveData() {
            var o = form.getData();            
			
            form.validate();
            if (form.isValid() == false) 
            	return;

            $.ajax({
                url: "${path}/admin/save-notice.do",
				type: 'post',
                data : o,
                cache: false,
                success: function (text) {
                	var data = mini.decode(text);
                	if(data.mesg == "addsucc") {
                		mini.alert("添加成功!", "消息", function(e) {
                			closeWindow("save");
                    	});
                	} else if(data.mesg == "adderr") {
                		mini.alert("添加失败!", "消息");
                	}
                },
                error: function (data) {
                    mini.alert("网络出错!", "消息");
                }
            });
        }

        function closeWindow(action) {            
            if (action == "close" && form.isChanged()) {
                if (confirm("数据被修改了，是否先保存？")) {
                    return false;
                }
            }
            
            if (window.CloseOwnerWindow) 
            	return window.CloseOwnerWindow(action);
            else 
            	window.close();            
        }
        
        function onOk(e) {
            saveData();
        }
        
        function onCancel(e) {
            closeWindow("cancel");
        }
        
    </script>
</body>
</html>
