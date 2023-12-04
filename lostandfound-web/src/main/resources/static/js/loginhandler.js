/**
 * 
 */
jQuery(document).ready(function() {
	// 移动设备登录
	jQuery("#MloginForm").submit(function(e) {
		e.preventDefault();
		
		if (Mlogs("click")) {
			var url = $("#MloginForm").attr("action");			
			$("#MloginSub").attr("disabled", true);
			var Mimgcode = $("#Mimgcode");
			
			jQuery.ajax({
				type : 'post', // 提交方式 get/post
				async : true,
				url : url, // 需要提交的 url
				data : $("#MloginForm").serialize(),
				success : function(data) { // data 保存提交后返回的数据，一般为 json
					$("#MloginSub").attr("disabled", false);
					
					if (data.mesg == "codeErr") {
						alert("验证码错误!");
						Mimgcode.click();
						$("#Mcard_code").val("");
						$("#Mcard_code").focus();
						return Mlogs("click");
					} else if (data.mesg == "error") {
						alert("用户名或密码错误!");
						Mimgcode.click();
						$("#Mcard_code").val("");
						$("#Mcard_pass").val("");
						$("#Mcard_pass").focus();
						return Mlogs("click");
					} else if (data.mesg == "lock") {
						alert("你的账号被冻结!");
						Mimgcode.click();
						$("#Mcard_code").val("");
						return Mlogs("click");
					} else if (data.mesg == "success") {
						alert("ok!");
						url = $("#srcUrl").val();
						window.location.href = url; //当前页面打开URL页面

					}
				},
				error : function(result) {
					$("#MloginSub").attr("disabled", false);
					alert("网络异常!");
				},
			 dataType: "json"
			});
		}
	});

	// 网页登录
	jQuery("#loginForm").submit(function(e) {
		e.preventDefault();

		if (logs("click")) {
			var url = $("#loginForm").attr("action");
			$("#loginSub").attr("disabled", true);
			var imgcode = $("#imgcode");
			jQuery.post(url, $("#loginForm").serialize(), function(data) {
				$("#loginSub").attr("disabled", false);
				
				if (data.mesg == "codeNull") {
					alert("验证码不能为空!");
					return logs("click");
				} else if (data.mesg == "codeErr") {
					alert("验证码错误!");
					imgcode.click();
					$("#Lcard_code").val("");
					$("#Lcard_code").focus();
					return logs("click");
				} else if (data.mesg == "error") {
					alert("用户名或密码错误!");
					imgcode.click();
					$("#Lcard_code").val("");
					$("#Lcard_pass").val("");
					$("#Lcard_pass").focus();
					return logs("click");
				} else if (data.mesg == "lock") {
					alert("你的账号被冻结!");
					imgcode.click();
					$("#Lcard_code").val("");
					return logs("click");
				} else if (data.mesg == "success") {
					alert("ok!");
					url = $("#srcUrl").val();
					window.location.href = url; //当前页面打开URL页面

					return false;
				}
			}, "json");
		}
	});	
	
});
