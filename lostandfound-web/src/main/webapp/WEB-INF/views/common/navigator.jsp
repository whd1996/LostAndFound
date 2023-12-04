<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<div id="navbardiv" class="navbar" style="box-shadow: 1px 1px 7px #999;width:100%;overflow:hidden;z-index:99;">
      <div class="navbar-inner" style="width:100%;max-width:1680px;margin:0 auto;padding:0;">
       <ul id="nav" class="nav" style="height:40px;width:90%;float:none;margin:0 auto;border:1px solid green;">
	    <li style="width:5%;" class="span1"></li>
        <li class="index"><a href="${path}/index.html"><i class="icon-home"></i> 首页  </a></li>    
        <li class="find-list"><a href="${path}/find/find-list.html" title="招领信息汇总"><i class="icon-picture"></i> 招领信息 </a></li>
	    <li class="lost-list"><a href="${path}/lost/lost-list.html" title="寻物信息汇总"><i class="icon-zoom-in"></i> 寻物信息 </a></li>
        <li class="leave-thanks"><a href="${path}/leave-thanks.html" title="留言感谢墙"><i class="icon-star-empty"></i> 留言感谢墙  </a></li>
        <li class="user-help"><a href="${path}/user-help.html" title="平台使用指南"><i class="icon-hand-right"></i> 平台指南  </a></li>
       </ul>
      </div>
    </div>
    
    <script>
    // 激活导航条图标
    function activeNav(index){
    	$("#nav li").each(function (){
    		if($(this).hasClass(index)){
    			$(this).removeClass(index);
    			$(this).addClass("active");
    		}
    	});
    }
    
 	// 滚动触发事件
  	$(function() {
        $.event.add(window, "scroll", function() {
       	 changeNavLayout();
     	});
   	});
  
  	// 改变浏览器窗口大小
  	window.onresize = function(e) {
	  	// 调用changeNavLayout()函数
		changeNavLayout();
		//alert("浏览器窗口改变了");
	}
	
  	// 改变导航条布局
	function changeNavLayout(){
		var elm = $('#navbardiv');
        var startPos = 270;//270较之原来的$(elm).offset().top好，原来的代码一滚动就到顶固定
		var p = $(window).scrollTop();
		if($('body').width() > 960 ){ //判断移动端方法 temp!
  			//pc端导航条到顶固定and下铺
	        if((p) > startPos){
		        $(elm).css('position','fixed');
		        $(elm).css('top','80px');
		        $(elm).css('width','140px');   
		        $(elm).css('opacity','0.6');//opacity			
		        $('#nav').css('height','260px');//形成长菜单
		        $('#nav').css('width','140px');//限制容器宽度
				$('#nav li').css('display','inline-block');//关键
		        $('#nav li').css('width','140px');//限制项目宽度
		        $('#showTel').css('margin-left','130px');//防止导航条下铺,挡住此按钮
	        } else {
	        	$(elm).css('position', 'static');
		        $(elm).css('top', '');
		        $(elm).css('width', '100%');   
		        $(elm).css('opacity','');//opacity			
		        $('#nav').css('height', '40px');//形成长菜单
		        $('#nav').css('width','90%');//限制容器宽度
				$('#nav li').css('display', 'block');//关键
		        $('#nav li').css('width','');//限制项目宽度
		        $('#showTel').css('margin-left','');//防止导航条下铺,挡住此按钮
	        }
		} else {
			$(elm).css('position','fixed');
	        $(elm).css('top','0px');
	        $(elm).css('width','100%');   
	        $(elm).css('opacity','');//opacity			
	        $('#nav').css('height','40px');//形成长菜单
	        $('#nav').css('width','90%');//限制容器宽度
			$('#nav li').css('display','block');//关键
	        $('#nav li').css('width','');//限制项目宽度
		}
	}
    </script>