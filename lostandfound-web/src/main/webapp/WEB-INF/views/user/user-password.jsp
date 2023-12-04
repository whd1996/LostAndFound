<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=0.5">
<title>${webSiteTitle}</title>
<script type="text/javascript" src="${path}/static/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="${path}/static/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${path}/static/easyui/locale/easyui-lang-zh_CN.js"></script>
<link rel="stylesheet" type="text/css" href="${path}/static/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${path}/static/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="${path}/static/easyui/demo.css">
<style>
	.text-align-right{text-align:right;}
	/* min-width & max-width 兼容移动设备 */
	@media screen and (min-width: 220px) and (max-width: 960px) { 
	 	.easyui-panel {
	 		width:98.5%;
		}
	}
	
	/* min-width兼容移动设备 */
	@media screen and (min-width: 960px) { 		
		.easyui-panel {
			width:500px;		
		}
	}
</style>
</head>
<body>
	<div style="width:100%;margin:60px auto;">
	<div class="easyui-panel" title="修改密码" data-options="iconCls:'icon-edit',fit:true">
		<div style="padding:10px 20px 20px 20px;margin:10px auto;">
	    <form id="user-password" method="post">
	    	<table cellpadding="2" style="margin:0 auto;">
	    		<tr>
	    			<td class="text-align-right">账号:</td>
	    			<td>
	    			<input type="hidden" name="id">
	    			<input type="hidden" name="userName">
	    			<input type="hidden" name="name">
	    			<input type="hidden" name="grade">
	    			<input type="hidden" name="nickName">
	    			${user.userName}
	    		</tr>
	    		<tr>
	    			<td class="text-align-right">原密码:</td>
	    			<td><input class="easyui-textbox" type="password" name="password" id="password" data-options="required:true" width="120" style="width:120px;"/></td>
	    		</tr>
	    		<tr>
	    			<td class="text-align-right">新密码:</td>
	    			<td><input class="easyui-textbox" type="password" name="newPassword" id="newPassword" data-options="required:true" width="120" style="width:120px;"/></td>
	    		</tr>
	    		<tr>
	    			<td class="text-align-right">确认密码:</td>
	    			<td><input class="easyui-textbox" type="password" name="rePassword" id="rePassword" data-options="required:true" width="120" style="width:120px;"/></td>
	    		</tr>
	    		<tr>
	    			<td>
	    			<input type="hidden" name="telPhone"/>
	    			<input type="hidden" name="email"/>
	    			<input type="hidden" name="qq"/>
	    			<input type="hidden" name="state"/>
	    			<input type="hidden" name="createTime"/>
	    			<input type="hidden" name="isNew"/>
	    			<input type="hidden" name="lastLoginTime"/>
	    			</td>
	    		</tr>
	    	</table>
	    </form>
	    <div style="text-align:center;padding:10px">
	    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">修改</a>
	    </div>
	    </div>
	</div>
	</div>
	<script>
		$(function (){
			setUserForm();
		});
	
		function setUserForm(){
			$.post("${path}/user/user-query.do",
					{userId: "${user.id}"},
					function(data){
						var user = JSON.parse(data);
						if(user.lastLoginTime)
							user.lastLoginTime = user.lastLoginTime.replace("T", " ");
						user.password = null;
						$("#user-password").form("load", user);
					});
		}
	
		function submitForm(){
			var url = '${path}/user/update-password.do';
			$('#user-password').form('submit',{  
                url: url,  
                onSubmit: function(){  
                        if($("#user-password").form("validate")) {
                        	var user = {"userName": "${user.userName}", "password":$('#password').val(), "state": "${user.state}"};
                        	if(checkPass($("#newPassword").val(), $("#rePassword").val()))
                        		return checkPassword(url, user);
                        	else 
                        		return false;
                        } else  
                            return false;  
                    },  
				//注意ajax的url的后台action方法必须有返回值return "json"，而不是return null,否则下面的回调函数不起作用，sucess方法失效  
                success:function(data){  
                	// 注意这个坑！！！（移动设备返回的内容在{}两边含有div标签）
                	data = data.substring(data.indexOf("{"), data.indexOf("}") + 1);
                    //此处data={"msg":success}实际为字符串，而不是json对象，需要用如下代码处理  
                    data = jQuery.parseJSON(data);
                    if(data.msg == "success") {
        				$.messager.alert('消息',"密码修改成功!");
                    } else if(data.msg == "error")
        				$.messager.alert('消息',"密码修改失败!");
                    
                    $("#password").textbox('setValue',"");
                	$("#newPassword").textbox('setValue',"");
                	$("#rePassword").textbox('setValue',"");
                },
                dataType: "json"
              });
		}
		
		// 校验两次密码是否一致
		function checkPass(first, second){
			if(first != second) {
				$.messager.alert("消息", "两次密码不一致!");
				$("#rePassword").textbox('setValue',"");
				return false;
			}else {
				if((first.length < 8) || (first.length > 16)){
					$.messager.alert("消息", "密码长度8-16位!");
					return false;
				}
				return true;
			}
		}
		
		
		//校验密码
		function checkPassword(url, user){
			var flag = false;
        	$.ajax({  
                url : url,  
                async : false, // 开启同步  
                type : "post", 
                data: user,
                dataType : "json",  
                success : function(data) {
            		if(data.msg == "success")
            			flag = true;
            		else if(data.msg == "error") {
        				$.messager.alert("消息", "原密码不正确!");
        				$("#password").textbox('setValue',"");
                    	$("#newPassword").textbox('setValue',"");
                    	$("#rePassword").textbox('setValue',"");
            		}
            	},
                error : function(data) {
                	$.messager.alert("消息", "网路异常!");
            	}
            }); 
        	
        	return flag;
		}
		
	</script>
</body>
</html>