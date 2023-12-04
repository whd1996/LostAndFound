<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>招领信息面板</title>
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
            <legend>招领信息页面</legend>
            <div style="padding:5px;">
        	<table style="table-layout:fixed;">
                <tr>
                    <td class="text-rigth" style="width:70px;">账号：</td>
                    <td style="width:150px;">
                        <input name="userName" id="userName" class="mini-textbox" allowInput="false"/>
                    </td>
                    <td class="text-rigth" style="width:70px;">物品类型：</td>
                    <td style="width:150px;">    
                        <input name="thingsType" id="thingsType" class="mini-textbox" allowInput="false"/>
                    </td>
                </tr>
                <tr>
                    <td class="text-rigth" style="width:70px;">物品名称：</td>
                    <td style="width:150px;">
                        <input name="thingsName" id="thingsName" class="mini-textbox" allowInput="false"/>
                    </td>
                    <td class="text-rigth" style="width:70px;">捡到地点：</td>
                    <td style="width:150px;">    
                        <input name="pickPlace" id="pickPlace" class="mini-textbox" allowInput="false"/>
                    </td>
                </tr>
                <tr>
                    <td class="text-rigth">捡到时间：</td>
                    <td>    
                        <input name="pickTime" id="pickTime" class="mini-textbox" allowInput="false"/>
                    </td>
                    <td class="text-rigth">物品描述：</td>
                    <td>    
                        <input name="thingsDes" id="thingsDes" class="mini-textArea" allowInput="false"/>
                    </td>
                </tr>
                <tr>
                    <td class="text-rigth">存储地点：</td>
                    <td > 
	                    <input name="storagePlace" id="storagePlace" class="mini-textbox" allowInput="false"/>
                    </td>
                    <td class="text-rigth">联系电话：</td>
                    <td >   
                        <input name="telPhone" id="telPhone" class="mini-textbox" allowInput="false"/>
                    </td>
                </tr>
                <tr>
                	<td class="text-rigth">发布时间：</td>
                    <td>
                    	<input name="publishTime" id="publishTime" class="mini-textbox" allowInput="false"/> 
                    </td>
                    <td class="text-rigth">状&nbsp;&nbsp;态：</td>
                    <td> 
	                    <input name="status" id="status" class="mini-textbox" allowInput="false"/>
                    </td>
                </tr>  
            </table>
            </div>
        </fieldset>
        <div style="text-align:center;padding:10px;margin-top:25px;">               
            <a class="mini-button" onclick="onCancel" style="width:60px;">取消</a>       
        </div>        
    </form>
    <script type="text/javascript">
        mini.parse();

        var form = new mini.Form("form1");

        //标准方法接口定义
        function setData(data) {
            data = mini.clone(data);
            $.ajax({
                url: "${path}/admin/find-query.html",
                type: 'post',
                cache: false,
                data : {thingsId : data.id},
                success: function (text) {
                    var o = mini.decode(text);
                    o.thingsType = parseThingsType(o.thingsType);
                    o.pickTime = mini.formatDate(o.pickTime, "yyyy-MM-dd");
                    o.publishTime = mini.formatDate(o.publishTime, "yyyy-MM-dd HH:mm:ss");
                    o.status = parseStatus(o.status);
                    form.setData(o);
                }
            });
        }

        function closeWindow(action) {            
            
            if (window.CloseOwnerWindow) 
            	return window.CloseOwnerWindow(action);
            else 
            	window.close();            
        }
        
        function onCancel(e) {
            closeWindow("cancel");
        }
        
	     // 解析物品类型
	     function parseThingsType(value) {
	         var v;
	         if(value == "card")
	     		v = "卡类证件";
	     	else if(value == "book")
	     		v = "书籍资料";
	     	else if(value == "clo")
	     		v = "衣物服饰";
	     	else if(value == "per_eff")
	     		v = "随身物件";
	     	else if(value == "elec")
	     		v = "电子数码";
	     	else if(value == "veh")
	     		v = "交通工具";
	     	else if(value == "other")
	     		v = "其他宝贝";
	     	else
	     		v = "";
	         return v;
	     }
	        
	     // 解析状态
	     function parseStatus(value) {
	         if (value == 0) 
	         	return "已发布";
	         else if(value == 1)
	         	return "成功贴";
	         else 
	         	return "已删除";
	     }
        
    </script>
</body>
</html>
