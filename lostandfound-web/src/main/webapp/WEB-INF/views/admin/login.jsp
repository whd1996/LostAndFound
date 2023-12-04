<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>${webSiteTitle} 后台登录</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<link rel="shortcut icon" href="${path}/static/images/favicon.ico" type="image/x-icon">
	<link rel="apple-touch-icon" href="${path}/static/images/applogo.png">
	<%@include file="common/base-css-js.jsp"%>
    <link rel="stylesheet" href="${path}/static/admin/css/supersized.css" type="text/css" />
    
    <style type="text/css">
	    body {
	        width:100%;height:100%;margin:0;overflow:hidden;
	    }
    </style>
    
    <script type="text/javascript">
	  var system = {};
	  var p = navigator.platform;
	  var u = navigator.userAgent;
	
	  system.win = p.indexOf("Win") == 0;
	  system.mac = p.indexOf("Mac") == 0;
	  system.x11 = (p == "X11") || (p.indexOf("Linux") == 0);
	  if (!(system.win || system.mac || system.xll)) {//如果是非PC
		  
	      window.location.href = "${path}/error/refuse-error.html";
	  }
</script>
    
</head>
<body >   
<div id="loginWindow" class="mini-window" title="管理员登录" style="width:320px;height:200px;" 
   showModal="true" showCloseButton="false">

    <div id="loginForm" style="padding:15px;padding-top:10px;">
        <table >
            <tr>
                <td style="width:60px;text-align: right;"><label for="userName$text">帐号：</label></td>
                <td>
                    <input id="userName" name="userName" onvalidation="onUserNameValidation" class="mini-textbox" required="true" style="width:150px;"/>
                </td>    
            </tr>
            <tr>
                <td style="width:60px;text-align: right;"><label for="password$text">密码：</label></td>
                <td>
                    <input id="password" name="password" onvalidation="onPasswordValidation" class="mini-password" requiredErrorText="密码不能为空" required="true" style="width:150px;"/>
                </td>
            </tr> 
            <tr>
                <td style="width:60px;text-align: right;"><label for="code$text">验证码：</label></td>
                <td>
                    <input id="code" name="code" onvalidation="onCodeValidation" class="mini-textbox" requiredErrorText="验证码不能为空" required="true" style="width:80px;margin-top:-20px;"/>
                    <img src="${path}/code.do" id="imgcode" onclick="changeCode(this);" alt="看不清，单击更换" style="width:80px;height:30px;cursor:pointer;">
                </td>    
            </tr>           
            <tr>
                <td></td>
                <td style="padding-top:5px;">
                    <a id="login" onclick="onLoginClick" class="mini-button" style="width:50px;">登录</a>&nbsp;&nbsp;
                    <a onclick="onResetClick" class="mini-button" style="width:50px;">重置</a>
                </td>
            </tr>
        </table>
    </div>

</div>
    
    <script type="text/javascript">
        mini.parse();
        
        // 全局enter键登录控制
		var loginenabled = true; 
        
        var loginWindow = mini.get("loginWindow");
        loginWindow.show();

        function onLoginClick(e) {
            var form = new mini.Form("#loginWindow");

            form.validate();
            if (form.isValid() == false) 
            	return;

            loginenabled = false;
            loginWindow.hide();
            var msid = mini.loading("正在登录，请稍后...", "正在验证");
            setTimeout(function () {
            	
            	//提交表单数据
                var data = form.getData();
                $.ajax({
                    url: "${path}/admin/login.html",
                    type: "post",
                    data: data,
                    success: function (data) {
                        if (data.mesg == "codeErr") {
                        	mini.hideMessageBox(msid);
                        	mini.alert("验证码错误!", "消息", function(e) {
                        		setTrue();
                        		loginWindow.show();
        						$("#imgcode").click();
        						mini.get("code").setValue("");
        						mini.get("code").focus();
                        	});
    						
    					} else if (data.mesg == "success") {
    						mini.alert("ok!","消息", function(e) {
    							mini.loading("正在加载数据，请稍后...", "正在加载");
        						setTimeout(function () {
        							window.location = "${path}/admin/index.html";
        						},1500);  
    						});

    					} else if (data.mesg == "error") {
    						mini.hideMessageBox(msid);
    						mini.alert("用户名或密码错误!", "消息", function(e) {
    							setTrue();
    							loginWindow.show();
        						$("#imgcode").click();
        						mini.get("password").setValue("");
        						mini.get("code").setValue("");
        						mini.get("password").focus();
    						});
    						
    					} else if (data.mesg == "lock") {
    						mini.hideMessageBox(msid);
    						mini.alert("你的账号被冻结!", "消息", function(e) {
    							setTrue();
    							loginWindow.show();
    						});
    					} 
                    },
                    error: function(e) {	
                   		mini.alert("网络异常或系统错误!", "消息", function(e) {
                   			setTrue();
                   			loginWindow.show();
                   		});
                    },
                    dataType: "json"
                });	
            	
            }, 1000);         	
            
        }
      
        function onResetClick(e) {
            var form = new mini.Form("#loginWindow");
            form.clear();
        }
        
        /////////////////////////////////////
        function isEmail(s) {
            if (s.search(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/) != -1 || s.length < 12)
                return true;
            else
                return false;
        }
        
        // 账号
        function onUserNameValidation(e) {
            if (e.isValid) {
                if (isEmail(e.value) == false) {
                    e.errorText = "必须输入邮件地址";
                    e.isValid = false;
                }
            }
        }
        
        // 密码
        function onPasswordValidation(e) {
            if (e.isValid) {
                if (e.value.length < 5) {
                    e.errorText = "密码不能少于5个字符";
                    e.isValid = false;
                }
            }
        }
        
        // 验证码
        function onCodeValidation(e) {
            if (e.isValid) {
                if (e.value.length != 4) {
                    e.errorText = "验证码4位";
                    e.isValid = false;
                }
            }
        }
        
	     //更换验证码	
    	function changeCode(_this) {
    		_this.src = "${path}/code.do?t=" + new Date().getTime();
    	}
	    
    	//支持Enter键登录
		document.onkeydown = function(e){
    		
			if(!e) e = window.event;
			if((e.keyCode || e.which) == 13 && loginenabled){
				onLoginClick(e);				
			}
		}
    	
    	function setTrue() {
    		loginenabled = true;
    	}
    	
	 	var PATH = "${path}";    
    </script>
    <script src="${path}/static/admin/js/supersized.3.2.7.min.js"></script>
	<script src="${path}/static/admin/js/supersized-init.js"></script>

</body>
</html>