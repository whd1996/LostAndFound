
	var isSelectCard = false;
	
	function upload(_this) {
		var value = _this.value;
		var extension = value.substring(value.lastIndexOf(".")).toLowerCase();
		if(extension != ".gif" && extension != ".jpg" && extension != ".jpeg" && extension != ".png") {
			$("#selectFile").next().show();
			$("#selectFile").next().html("<b style='color: red;'>请选择(gif,jpg,jpeg,png)格式的图片!</b>");
			var file = $("#file") ;
			file.after(file.clone().val(""));      
			file.remove();
			value = "未选择任何图片";
		} else {
			$("#selectFile").next().hide();
		}
			
	    document.getElementById("userdefinedFile").value = value;
	}
	
	function selectType(obj,cardTr) {
		var tab = obj.parentNode.parentNode.parentNode;
		var tr = obj.parentNode.parentNode;
		var showIndex = tr.rowIndex + 1;	
		
		if(obj.value == "card" && !isSelectCard) {
			isSelectCard = true;		
			//插入的行 
			var cardNo = tab.insertRow(showIndex);
			cardNo.innerHTML = cardTr;
		} else {		
			if(jQuery(tr).next().children().attr("id") == "card") {
				isSelectCard = false;
				tab.deleteRow(showIndex);
			}
		}
	}



	function valueListenerLimiter(_this, length) {
		$(_this).next().show();
		$(_this).bind('input porpertychange',function(e){
			var value = _this.value;
			var len = value.length;
			if((length - len) >= 0)
				$(_this).next().html("您还能输入<b style='color:red;'>" +(length - len)+ "</b>个字符");
			if(len > length) 
				_this.value = value.substring(0, length);
			
			console.log(length - len);
		});
	}
		
	function labelHidden(_this) {
		$(_this).next().hide(500);
	}
	
	
	function validCardNumFormater(_this) {
		var value = _this.value;
		var reg = /\d|[a-z|A-Z]/;
		if(!reg.test(value))
			_this.value = "";
	}
	
	function showTelFormater(_this) {
		$(_this).next().css("color","red").html("（xxxxxxxxxxx）");
	}
	
	function onBlurValidTel(_this) {
		var value = _this.value;
		var reg = /^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\d{8}$/;
		if(value != ""){
			if(!reg.test(value)) {
				$(_this).val("");
				$(_this).next().css("color","red").html("格式错误");
				return false;
			} else {
				$(_this).next().css("color","green").html("✔");
				return true;
			}
		} else {
			$(_this).next().html("");
		}
	}
	
	function valid(_this, name){
		$(_this).next().show();
		$(_this).next().html("<b style='color:red;'>"+name+ "为必填项!</b>");
	}
	
	function showError(upValue, saveValue) {
		if(upValue != "")
			alert(upValue);
		else if(saveValue != "")
			alert(saveValue);
	}
