
// 起始页（全局变量）
var globalpageIndex = 0;
// 每次加载的条数
var globalpageSize = 10;
// 数量
var total = 0;

var arr = ['a','b','c','d','e'];



function thanksList(url, pageIndex, pageSize) {
	var html;
	jQuery.ajax({
		type : 'post', // 提交方式post
		async : true,
		url : url, // 需要提交的 url
		data : {pageIndex : pageIndex, pageSize : pageSize},
		success : function(data) { // data 保存提交后返回的数据，一般为 json
			if(data.total > 0) {
				for(var i = 0; i < data.data.length; i++) {
					// 生成0-4的随机数
					var random = parseInt(Math.random()*5);
					html = '<div class="thanks '+arr[random]+'">'
		 				+'<div class="title"><span>标题：</span><span>'+data.data[i].title+'</span></div>'
		 				+'<div class="substance"><span>内容：</span><span>'+data.data[i].substance+'</span></div>'
		 				+'<div class="userName"><span>感谢人：</span><span>'+data.data[i].userName+'</span></div>'
			 			+'<div class="leaveTime"><span>感谢时间：</span><span>'+data.data[i].leaveTime.replace("T", " ")+'</span><span class="num">'+data.data[i].id+'楼</span></div>'
			 			+'</div>';
			 			
					$("#thanks").append(html);
					total ++;
				}
				
				if(data.total <= pageSize || total >= data.total) {
					html = '<span style="color: gray;">没有更多感谢数据了...</span>';
					$("#thanks-more").html(html);
				} else {
					globalpageIndex ++;
					html = '<a href="javascript:void(0);" class="btn btn-mini btn-success"'
					+'onclick="thanksList(thanksListUrl, '+globalpageIndex+', '+globalpageSize+');" style="font-size:18px;">加载更多留言感谢数据...</a>';
					$("#thanks-more").html(html);
				}
			} else {
				html = '<div class="thanks" style="text-align:center;height:50px;"><span style="color: red;">暂无感谢信息...</span></div>';
				$("#thanks").append(html);
			}
		},
		error : function(result) {
			html = '<div class="thanks" style="text-align:center;height:50px;"><span style="color: red;">加载失败刷新重试...</span></div>';
			$("#thanks").append(html);
		},
	 dataType: "json"
	});
}

function checkThanks(obj1, obj2) {
		if($.trim(obj1.val()) == ""){
			obj1.focus();
			return false;
		}
		
		if($.trim(obj2.val()) == ""){
			obj2.focus();
			return false;
		}
		
		return true;
	}
	

function saveThanks(url, data) {
	jQuery.ajax({
		type : 'post', // 提交方式 get/post
		async : true,
		url : url, // 需要提交的 url
		data : data,
		success : function(data) { // data 保存提交后返回的数据，一般为 json
			var html;
			if(data.mesg == "error") {
				alert("感谢失败!")
			} else {
				jQuery("#thanks-info")[0].reset();
				closeThanksView();
				$("#thanks").html("");
				globalpageIndex = 0;
				total = 0;
				thanksList(thanksListUrl, globalpageIndex, globalpageSize);
			}
		},
		error : function(result) {
			alert("网络异常!");
		},
		dataType: "json"
	});
}
	
function thanksView(event) {
	if(isLogin) {
		$( '<div id="windowShadow"></div>' ).css( {
			width : $(document).width(),
 			height : $(document).height(),
 			position : 'absolute',
 			top : 0,
 			left : 0,
 			zIndex : 998,
 			opacity : 0.3,
 			filter : 'Alpha(Opacity = 30)',
 			backgroundColor : '#000000'
		} ).appendTo('body');
		
		var obj = $('#send-form');
		obj.css( {
			left : ($(window).width() - obj.width() ) / 2,
			top : $(document).scrollTop() + ($(window).height() - obj.height()) / 2
		} ).fadeIn();
	} else {
		// 小屏幕未登录
		if(isSmallScreen()) {
			mobileLoginFocus(event);
		} else {
			loginFocus(event);
		}
	}
}
	
function closeThanksView() {
	$('#send-form').fadeOut('slow', function () {
		$('#windowShadow').remove();
	});
}



function valueListenerLimiter(_this, length) {
	$("#font-num").show();
	$(_this).bind('input porpertychange',function(e){
		var value = _this.value;
		var len = value.length;
		if((length - len) >= 0)
			$("#font-num").html("您还能输入<b style='color:red;'>" +(length - len)+ "</b>个字符");
		if(len > length) 
			_this.value = value.substring(0, length);
		
	});
}
	
function labelHidden(_this) {
	$("#font-num").hide();
}


function myBrowser(){
    var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串
    var isOpera = userAgent.indexOf("Opera") > -1; //判断是否Opera浏览器
    var isIE = userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera; //判断是否IE浏览器
    var isFF = userAgent.indexOf("Firefox") > -1; //判断是否Firefox浏览器
    var isSafari = userAgent.indexOf("Safari") > -1; //判断是否Safari浏览器
    if (isIE) {
        var IE5 = IE55 = IE6 = IE7 = IE8 = false;
        var reIE = new RegExp("MSIE (\\d+\\.\\d+);");
        reIE.test(userAgent);
        var fIEVersion = parseFloat(RegExp["$1"]);
        IE55 = fIEVersion == 5.5;
        IE6 = fIEVersion == 6.0;
        IE7 = fIEVersion == 7.0;
        IE8 = fIEVersion == 8.0;
        if (IE55) {
            return "IE55";
        }
        if (IE6) {
            return "IE6";
        }
        if (IE7) {
            return "IE7";
        }
        if (IE8) {
            return "IE8";
        }
    }//isIE end
    if (isFF) {
        return "FF";
    }
    if (isOpera) {
        return "Opera";
    }
}

function myBrowserType(){
    var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串
    var isOpera = userAgent.indexOf("Opera") > -1;
    if (isOpera) {
        return "Opera"
    }; //判断是否Opera浏览器
    if (userAgent.indexOf("Firefox") > -1) {
        return "FF";
    } //判断是否Firefox浏览器
    if (userAgent.indexOf("Chrome") > -1){
  return "Chrome";
 }
    if (userAgent.indexOf("Safari") > -1) {
        return "Safari";
    } //判断是否Safari浏览器
    if (userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera) {
        return "IE";
    }; //判断是否IE浏览器
}