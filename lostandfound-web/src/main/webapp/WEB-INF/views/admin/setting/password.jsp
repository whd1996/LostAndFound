<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>修改密码</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<%@include file="../common/base-css-js.jsp"%>
	
	<style>
		.text-align-right{text-align:right;}
	</style>
</head>
<body>
	<div style="padding:10px 20px 20px 20px;margin:50px auto;">
	    <form id="admin-password" method="post">
	    	<table cellpadding="2" style="margin:0 auto;">
	    		<tr>
	    			<td class="text-align-right">账号:</td>
	    			<td>
	    			<input name="id" class="mini-hidden">
	    			<input name="userName" class="mini-hidden">
	    			<input name="name" class="mini-hidden">
	    			<input name="grade" class="mini-hidden">
	    			<input name="nickName" class="mini-hidden">
	    			${admin.userName}
	    		</tr>
	    		<tr>
	    			<td class="text-align-right">原密码:</td>
	    			<td><input class="mini-password" name="password" id="password" required="true" width="120" style="width:120px;"/></td>
	    		</tr>
	    		<tr>
	    			<td class="text-align-right">新密码:</td>
	    			<td><input class="mini-password" name="newPassword" id="newPassword" required="true" width="120" style="width:120px;"/></td>
	    		</tr>
	    		<tr>
	    			<td class="text-align-right">确认密码:</td>
	    			<td><input class="mini-password" name="rePassword" id="rePassword" required="true" width="120" style="width:120px;"/></td>
	    		</tr>
	    		<tr>
	    			<td>
	    			<input name="telPhone" class="mini-hidden"/>
	    			<input name="email" class="mini-hidden"/>
	    			<input name="qq" class="mini-hidden"/>
	    			<input name="state" class="mini-hidden"/>
	    			<input name="createTime" class="mini-hidden"/>
	    			<input name="isNew" class="mini-hidden"/>
	    			<input name="lastLoginTime" class="mini-hidden"/>
	    			</td>
	    		</tr>
	    	</table>
	    </form>
	    <div style="text-align:center;padding:10px">
	    	<a class="mini-button" onclick="submitForm();">修改</a>
	    </div>
	 </div>
	 
	 <script>
	 	mini.parse();

     	var form = new mini.Form("admin-password");
	 
		$(function (){
			setAdminForm();
		});
	
		function setAdminForm(){
			$.ajax({
                url: "${path}/admin/query-user.html",
                type: 'post',
                cache: false,
                data : {userId: "${admin.id}"},
                success: function (data) {
                	var admin = mini.decode(data);
					admin.password = null;
					admin.createTime = mini.formatDate(admin.createTime, "yyyy-MM-dd");
                    admin.lastLoginTime = mini.formatDate(admin.lastLoginTime, "yyyy-MM-dd HH:mm:ss");
					form.setData(admin);
                },
                error: function (data) {
                	mini.alert("网络出错!", "消息");
                }
            });
		}
	
		function submitForm(){
			var url = '${path}/admin/password.html';
			var admin = {"userName": "${admin.userName}", "password":mini.get("password").getValue(), "state": "${admin.state}"};            
            
			form.validate();
            if (form.isValid() == false) 
            	return;
           
            if(checkPass(mini.get("newPassword").getValue(), mini.get("rePassword").getValue())){
            	if(checkPassword(url, admin)){
        			admin = form.getData();
        			savePassword(url, admin);
        		}
            }
		}
		
		function savePassword(url , admin) {
			$.ajax({
				url : url,
				type: 'post',
                data : admin,
                cache: false,
                success: function (text) {
                	var data = mini.decode(text);
                	if(data.msg == "success") {
        				mini.alert("密码修改成功!", '消息', function(e) {
        					mini.get("password").setValue("");
                        	mini.get("newPassword").setValue("");
                        	mini.get("rePassword").setValue("");
        				});
                    } else if(data.msg == "error")
        				mini.alert("密码修改失败!", '消息', function(e) {
        					mini.get("password").setValue("");
                        	mini.get("newPassword").setValue("");
                        	mini.get("rePassword").setValue("");
        				});
                },
                error: function (data) {
                    mini.alert("网络出错!", "消息");
                }
			});
		}
		
		// 校验两次密码是否一致
		function checkPass(first, second){
			if(first != second) {
				mini.alert("两次密码不一致!", "消息", function(e) {
					mini.get("rePassword").setValue("");
				});
				return false;
			}else {
				if((first.length < 8) || (first.length > 16)){
					mini.alert("密码长度8-16位!", "消息");
					return false;
				}
				return true;
			}
		}
		
		
		//校验密码
		function checkPassword(url, admin){
			var flag = false;
        	$.ajax({  
                url : url,  
                async : false, // 开启同步  
                type : "post", 
                data: admin,
                dataType : "json",  
                success : function(data) {
                	var mesg = mini.decode(data);
            		if(mesg.msg == "success")
            			flag = true;
            		else if(mesg.msg == "error") {
            			mini.alert("原密码不正确!", "消息", function(e) {
            				mini.get("password").setValue("");
                        	mini.get("newPassword").setValue("");
                        	mini.get("rePassword").setValue("");
            			});
            		}
            	},
                error : function(data) {
                	mini.alert("网路异常!", "消息");
            	}
            }); 
        	
        	return flag;
		}
		
	</script>
	 
</body>
</html>