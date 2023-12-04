<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>用户面板</title>
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
            <legend >用户基本信息</legend>
            <div style="padding:5px;">
        	<table style="table-layout:fixed;">
                <tr>
                    <td class="text-rigth" style="width:70px;">帐&nbsp;&nbsp;号：</td>
                    <td style="width:150px;"> 
                    	<input name="id" class="mini-hidden" />
                    	<input name="password" class="mini-hidden" />
                    	<input name="nickName" class="mini-hidden" />
                    	<input name="createTime" class="mini-hidden" />
                    	<input name="isNew" class="mini-hidden" value="0"/>
                    	<input name="lastLoginTime" class="mini-hidden" />
                        <input id="userName" name="userName" class="mini-textbox" required="true"  emptyText="请输入帐号"/>
                    </td>
                    <td class="text-rigth" style="width:70px;">年&nbsp;&nbsp;级：</td>
                    <td style="width:150px;">    
                        <select name="grade" id="grade" class="mini-combobox" style="width:80px;" required="true" emptyText="请选择年级">
			                               
			            </select> 
                    </td>
                </tr>
                <tr>
                    <td class="text-rigth">姓&nbsp;&nbsp;名：</td>
                    <td>    
                        <input name="name" class="mini-textbox" required="true" emptyText="请输入姓名"/>
                    </td>
                    <td class="text-rigth">联系电话：</td>
                    <td>    
                        <input name="telPhone" class="mini-textbox" vtype="int" required="true" emptyText="请输入联系电话"/>
                    </td>
                </tr>
                <tr>
                    <td class="text-rigth">邮&nbsp;&nbsp;箱：</td>
                    <td > 
	                    <input name="email" id="email" class="mini-textbox" emptyText="请输入邮箱"/>
                    </td>
                    <td class="text-rigth">Q&nbsp;&nbsp;Q：</td>
                    <td >   
                        <input name="qq" class="mini-textbox" emptyText="请输入QQ"/>
                    </td>
                </tr>
                <tr>
                    <td class="text-rigth">状&nbsp;&nbsp;态：</td>
                    <td > 
	                    <select name="state" id="state" class="mini-combobox" style="width:80px;" required="true" >
			                <option value="1">正常</option>
			                <option value="2" >管理员</option>
			                <option value="0">冻结</option>                
			            </select>   
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
	 	// 解析年级
	    function parseGrade(value) {
	    	value = value - 4;
	    	var gradeArr = [];
	    	for(var i = 0; i < 5; i++){
	    		gradeArr.push(value);
	    		value ++;
	    	}
	    	
	    	gradeArr.push("QJNU");
	    	
	    	//根据id查找对象，  
	        var obj = document.getElementById("grade");  
	        console.log(gradeArr);
	        //添加一个选项  
	        //obj.add(new Option("文本","值"));    //这个只能在IE中有效  
	        for(var v = 0; v < gradeArr.length; v++)
	        	obj.options.add(new Option(gradeArr[v], gradeArr[v])); //这个兼容IE与firefox 
	    }
    	
	    parseGrade('${thisYear}');
    
        mini.parse();

        var form = new mini.Form("form1");

        function saveData() {
            var o = form.getData();            
			
            form.validate();
            if (form.isValid() == false) 
            	return;

            var json = mini.encode([o]);
            // alert(json);
            $.ajax({
                url: "${path}/admin/save-user.do",
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
                	} else if(data.mesg == "upsucc"){
                		mini.alert("修改成功!", "消息", function(e) {
                			closeWindow("save");
                		});
                	} else if(data.mesg == "uperr") {
                		mini.alert("修改失败!", function(e) {
                			closeWindow("save");
                		});
                	}
                },
                error: function (data) {
                    mini.alert("网络出错!", "消息");
                }
            });
        }

        ////////////////////
        //标准方法接口定义
        function setData(data) {
            if (data.action == "edit") {
                //跨页面传递的数据对象，克隆后才可以安全使用
                data = mini.clone(data);
                $.ajax({
                    url: "${path}/admin/query-user.html",
                    type: 'post',
                    cache: false,
                    data : {userId : data.id},
                    success: function (text) {
                    	mini.get("userName").setEnabled(false);
                        var o = mini.decode(text);
                        o.createTime = mini.formatDate(o.createTime, "yyyy-MM-dd");
                        o.lastLoginTime = mini.formatDate(o.lastLoginTime, "yyyy-MM-dd HH:mm:ss");
                        form.setData(o);
                        form.setChanged(false);
                    }
                });
            }
        }

        function GetData() {
            var o = form.getData();
            return o;
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
