<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${path}/static/js/jquery-1.10.2.min.js"></script>
<title>批量导入用户</title>

<style type="text/css">
	body {
		margin:0;
		padding:0;
		font-size:12px;
		background:#fff none repeat ;
		width:98%;
	}
	body, h1, h2, h3, h4, h5, h6, ul, ol, li, form, p, dl, dt, dd, legend, table, th, td, fieldset {
	    margin: 0;
	    padding: 0;
	}
	a, a:link, a:visited {
	    cursor: pointer;
	    outline: medium none;
	    text-decoration: none;
		color:#9B2404;
	}
	a:hover{
		color:red;
	}
	.maincontainer{
		font-family: "lucida Grande",Verdana;
		font-size:12px;
		width:100%;
	}
	.columnconn {
		background-color:#f5f5f5;
		height:35px;
		line-height:35px;
		border-bottom:1px solid #d7d7d7;
	}
	.columntitle{
		color:#4d4d4d;
		font-weight:bold;
		margin:0 20px;
		font-size:14px;
	}
	.fmcontainer{
		padding:10px;
		width:100%;
		height:100%;
	}
	.fmsubmitbtn{
		text-align:left;
		height:40px;
		line-height:40px;
	}
	table.inputtable{
		border-collapse:collapse;
		border:#d3d3d3 solid;
		border-width:1px 0 0 1px;
	}
	table.inputtable caption {
		font-size:14px;
		font-weight:bold;
	}
	table.inputtable th,table.inputtable td {
		border:solid #d3d3d3;
		border-width:0 1px 1px 0;
		padding:2px;
	}
	.leftlabel{
		text-align:right;
		background-color:#f9f9f9;
	}
	.btn {
	    background: none repeat scroll 0 0 gray;
	    color: #FFFFFF !important;
	    cursor: pointer;
	    height: 26px;
	    line-height: 26px;
	    padding: 0 12px;
		border-radius:3px;
		border:1px solid #333;
		font-family: Simsun;
		margin-left:100px;
	    display: inline-block;
	}
	
	#warning-msg{
		width:80%;
		position: relative;
		top:20px;
		padding:15px;
	}
	
	.red-size14{
		color: red;font-size: 14px;
	}
	
	.blue-size16{
		color:blue;font-size: 16px;
	}

</style>
</head>
<body>

	<div class="maincontainer">
		<div class="columnconn">
			<span class="columntitle">批量用户数据导入</span>
		</div>
		<form id="excelForm" enctype="multipart/form-data">
			<div class="fmcontainer">
				<table class="inputtable" width="500px">
					<tr>
						<td class="leftlabel">用户数据(EXCEL)：</td>
						<td><input id="excelFile" name="excelFile" type="file" width="150"/></td>
						<td class="leftlabel">模板：</td>
						<td><a href="${path}/admin/download.html?fileName=userTemplate.xls" title="点击下载模板 " >点击下载模板</a> </td>
					</tr>
				</table>
				<div class="fmsubmitbtn">
					<input type="button" name="submit" id="btn" class="btn" value="导入" /> 
					<input type="reset" name="cancle" class="btn" value="取 消" />
				</div>
			</div>
		</form>
	</div>
	
	<div id="warning-msg">
		<div style="font-family:微软雅黑;line-height:1.5em;">
			<strong style="font-family:Arial; font-weight:bold; font-size:20px;">${webSiteTitle} 温馨提示：</strong>
		　　　 <br><br><b class="blue-size16">一、点击下载模板下载平台提供的标准用户信息导入模板；</b>
		　　　 <br><br><b class="blue-size16">二、不能对模板做任何修改（包括工作表标题头和所有单元格格式）；</b>
		　　　 <br><br><b class="blue-size16">三、填写注意事项：</b>
			 <div style="padding:5px 15px 10px 15px;">
			 	<p class="red-size14">1.模板的所有列均为必须填写列，所有单元格格式均为文本类型，不能对其格式进行任何修改；</p>
			 	<p class="red-size14">2.用户名一列不能重复（即账号不能重复），否则会导入失败；</p>
			 	<p class="red-size14">3.年级一列（学生则填写其所在年级即可，教师则固定填写为QJNU）；</p>
			 	<p class="red-size14">4.每个工作表中均不能含有空行（空白行），删除数据时需要清除其单元格的格式，否则不能正常导入。</p>
			 </div>
		　　　 <br><b class="blue-size16">四、如果遇到导入失败，请按照（三）检查每个工作表。</b>
		</div>
	</div>

 <script type="text/javascript">  
       //ajax 方式上传文件操作  
        $(document).ready(function(){  
           $('#btn').click(function(){  
               if(checkData()){  
               	var formData = new FormData($("#excelForm")[0]);
                   $.ajax({    
                       url:'${path}/admin/user-import.do', 
                       type: 'post',
                       data: formData,
                       async: false, 
                       cache: false, 
                       contentType: false, 
                       processData: false,
                       success: function(data) {
                    	   alert(data.mesg);
                    	   $("#excelFile").val("");
                       },  
                       error: function(data) {
                    	   alert("导入数据出错！");
                       } 
                   });   
               }  
           });  
        });  
          
        //JS校验form表单信息  
        function checkData(){  
           var fileDir = $("#excelFile").val();  
           var suffix = fileDir.substr(fileDir.lastIndexOf("."));  
           if("" == fileDir){  
               alert("选择需要导入的Excel模板文件！");  
               return false;
           }  
           if(".xls" != suffix && ".xlsx" != suffix ){  
               alert("选择Excel格式的模板文件导入！");
               $("#excelFile").val("");
               return false;  
           }  
           return true;  
        } 
        
        
        //全局的ajax访问，处理ajax清求时sesion超时  
    	$.ajaxSetup({  
    	    contentType:"application/x-www-form-urlencoded;charset=utf-8",  
    	    complete:function(XMLHttpRequest,textStatus){
    	        //通过XMLHttpRequest取得响应头，sessionstatus，  
    	        var sessionstatus = XMLHttpRequest.getResponseHeader("sessionstatus");   
    	        if(sessionstatus == "timeout"){  
    	        	//如果超时就处理 ，指定要跳转的页面  
    	        	alert("页面过期，请重新登录!"); 
    	        	parent.window.location.reload(true);  
    	        }  
    	    }  
    	});
 </script>  

</body>
</html>