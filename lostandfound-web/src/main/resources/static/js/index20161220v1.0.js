/*
 *   2017 4 08  
 *   script of the index
 *   last modified 2017 4 07 20:18
 */

// 页面加载时间
var loadDate = new Date();
// 时间间隔15分钟
var subTime = 15*60;

// 网页登录检查
function check(obj, spanobj, info, fun, click) {
	var Lcardcode = document.getElementById("Lcard_code");
	obj.onfocus = function() {
		if(obj == Lcardcode){
			var nowDate = new Date();
			// 从页面加载到现在的时间秒差
			var subDate = (nowDate - loadDate) / 1000;
			var imgcode = document.getElementById("imgcode");
			
			if(imgcode.style.display == "none" || subDate > subTime){
				imgcode.click();
				imgcode.style.display = "inline-block";
				loadDate = nowDate;	
			}
		}
		spanobj.innerHTML = info;
		spanobj.style = "font-size: 16px;color: orange;";
	}
	obj.onblur = function() {
		if (fun(obj.value.trim())) {
			spanobj.style = "font-size: 24px;color: green;";
			spanobj.innerHTML = "√";
		} else {
			spanobj.style = "font-size: 24px;color: red;";
			spanobj.innerHTML = "×";
		}
	}
	if (click == "click")
		obj.onblur();

}

// 移动设备登录检查
function checkMobile(obj, spanobj, info, fun, click) {
	var Mcardcode = document.getElementById("Mcard_code");
	obj.onfocus = function() {
		if(obj == Mcardcode){
			var nowDate = new Date();
			// 从页面加载到现在的时间秒差
			var subDate = (nowDate - loadDate) / 1000;
			var imgcode = document.getElementById("Mimgcode");
			
			if(imgcode.style.display == "none" || subDate > subTime){
				imgcode.click();
				imgcode.style.display = "inline-block";
				loadDate = nowDate;	
			}
		}
	}
	obj.onblur = function() {
		if (fun(obj.value.trim())) {
			spanobj.style = "font-size: 24px;color: green;";
			spanobj.innerHTML = "√";
		} else {
			spanobj.style = "font-size: 24px;color: red;";
			spanobj.innerHTML = "×";
		}
	}
	if (click == "click")
		obj.onblur();
}

function logs(click) {
	var sta = true;
	var Lcardnum = document.getElementById("Lcard_num");
	var Lcardpass = document.getElementById("Lcard_pass");
	var Lcardcode = document.getElementById("Lcard_code");
	var Lcn = document.getElementById("Lcn");
	var Lcp = document.getElementById("Lcp");
	var Lcd = document.getElementById("Lcd");
	check(Lcardnum, Lcn, "账号5-10位哦", function(val) {
		if (val.trim().length >= 5 && val.trim().length <= 10) {
			return true;
		} else {
			sta = false;
			return false;
		}
	}, click);

	check(Lcardpass, Lcp, "初始为5-10位", function(val) {
		if (val.trim().length >= 5 && val.trim().length <= 20) {
			return true;
		} else {
			sta = false;
			return false;
		}
	}, click);

	check(Lcardcode, Lcd, "4位哦", function(val) {
		if (val.trim().length == 4) {
			return true;
		} else {
			sta = false;
			return false;
		}
	}, click);
	return sta;
}


function Mlogs(click) {
	var sta = true;
	var Mcardnum = document.getElementById("Mcard_num");
	var Mcardpass = document.getElementById("Mcard_pass");
	var Mcardcode = document.getElementById("Mcard_code");
	var Mcn = document.getElementById("Mcn");
	var Mcp = document.getElementById("Mcp");
	var Mcd = document.getElementById("Mcd");
	checkMobile(Mcardnum, Mcn, "账号6-10位哦", function(val) {
		if (val.trim().length == 10 || val.trim().length == 6) {
			return true;
		} else {
			sta = false;
			return false;
		}
	}, click);
	checkMobile(Mcardpass, Mcp, "初始为6-10位", function(val) {
		if (val.trim().length >= 6 && val.trim().length <= 20) {
			return true;
		} else {
			sta = false;
			return false;
		}
	}, click);
	checkMobile(Mcardcode, Mcd, "4位哦", function(val) {
		if (val.trim().length == 4) {
			return true;
		} else {
			sta = false;
			return false;
		}
	}, click);
	return sta;
}

$(document). ready(function() {
	logs();
	Mlogs();
});


if ($('footer').width() > 900) {
	$(function() {
		var elm = $('nav');
		var startPos = 200;
		$.event.add(window, "scroll", function() {
			var p = $(window).scrollTop();
			$(elm).css('position', ((p) > startPos) ? 'fixed' : '');
			$(elm).css('top', ((p) > startPos) ? '0' : '');
			$(elm).css('opacity', ((p) > startPos) ? '0.8' : '');
		});
	});
}
console.log("%c 欢迎光临广西民族大学失物招领平台",
		"font-size:32px;color:red;text-shadow:0 0 5px #666");
console.log("嘿嘿,大家都说好,你也是想火钳留名吧!开玩笑啦`~~");
console.log("ps:相互学习交流请联系，%c qq:2576843535", "color:red;font-weight:bold;");
//console.error('小东西，不喜请轻喷...');
// 改变信息流布局 12 21 20:15
$(document).ready(function() {

	// 默认布局
	function infoStreamOne() {
		$('#main').css('width', '')
		$('.left').css('width', '');
		$('.left').css('text-align', '');
		$('.news').css('width', '');
		$('figure').css('width', '');
		$('figure').css('margin-top', '');
		$('figure').css('border-left', '');
		$('figure').css('padding-left', '');
		$('#spot_btn').css('margin-left', '');
		$('.right').css('width', '');
		$('.right').css('margin-left', '');
		$('.right').css('margin-top', '');
	}

	// 简明布局
	function infoStreamTwo() {
		$('#main').css('width', '768px')
		$('.left').css('width', '98%');
		$('.left').css('text-align', 'left');
		$('.news').css('width', '68%');
		$('figure').css('width', '20%');
		$('figure').css('margin-top', '30px');
		$('figure').css('border-left', '1px dashed #aaa');
		$('figure').css('padding-left', '9px');
		$('#spot_btn').css('margin-left', '30px');
		$('.right').css('width', '100%');
		$('.right').css('margin-left', '-1%');
		$('.right').css('margin-top', '10px');
	}

	$('#infoStream').hover(function() {
		$('#layout').show(500);
	});

	$('#one').click(function() {
		infoStreamOne();
	});

	$('#two').click(function() {
		infoStreamTwo();
	});
});