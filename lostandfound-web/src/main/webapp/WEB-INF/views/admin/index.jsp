<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>${webSiteTitle} 后台管理</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="keywords" content="" />
	<meta name="description" content=""/> 
	<link rel="shortcut icon" href="${path}/static/images/favicon.ico" type="image/x-icon">
	<link rel="apple-touch-icon" href="${path}/static/images/applogo.png">
	<%@include file="common/base-css-js.jsp"%>
	<script src="${path}/static/admin/js/core.js" type="text/javascript"></script>
	<style type="text/css">
	    html, body{
	        margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
	    }
	
	    .logo {
	        font-family:"微软雅黑","Helvetica Neue",​Helvetica,​Arial,​sans-serif;
	        font-size:28px;
	        font-weight:bold;        
	        cursor:default;
	        position:absolute;top:25px;left:14px;        
	        line-height:28px;
	        color:#444;
	    }    
	    .topNav {
	        position:absolute;right:8px;top:12px;        
	        font-size:12px;
	        line-height:25px;
	    }
	    .topNav a {
	        text-decoration:none;        
	        font-weight:normal;
	        font-size:12px;
	        line-height:25px;
	        margin-left:3px;
	        margin-right:3px;
	        color:#333;        
	    }
	    .topNav a:hover {
	        text-decoration:underline;        
	    }   
	    .mini-layout-region-south img {
	        vertical-align:top;
	    }
	  </style>
</head>
<body>

<!-- main container start -->
 
<div class="mini-layout" style="width:100%;height:100%;">
	
	<!-- top start -->
	
    <div title="north" region="north" class="app-header" bodyStyle="overflow:hidden;" height="80" showHeader="false" showSplit="false">
        <div class="logo">${webSiteTitle} 后台管理</div>

        <div class="topNav">    
            <a href="${path}/admin/index.html">首页</a> |
            <a href="javascript:void(0);" onclick="refresh();">刷新</a> |
			<span>欢迎您[ <b style="color: red;">${admin.userName}</b> ]</span>|
            <a href="javascript:void(0);" onclick="logout();">注销</a>
        </div>

        <div style="position:absolute;right:12px;bottom:8px;font-size:12px;line-height:25px;font-weight:normal;">
           	 皮肤：
            <select id="selectSkin" onchange="onSkinChange(this.value)" style="width:100px;margin-right:10px;" >
                <option value="metro-green">metro-green</option>
                <option value="">Default</option>
                <option value="blue">Blue</option>
                <option value="pure">Pure</option>
                <option value="gray">Gray</option>                
                <option value="olive2003">Olive2003</option>
                <option value="blue2003">Blue2003</option>
                <option value="blue2010">Blue2010</option>
                <option value="bootstrap">Bootstrap</option>
                <option value="metro">metro</option>
                <option value="metro-orange">metro-orange</option>
                <option value="jqueryui-cupertino">jqueryui-cupertino</option>
                <option value="jqueryui-smoothness">jqueryui-smoothness</option>
            </select>
  			 尺寸：
            <select id="selectMode" onchange="onModeChange(this.value)" style="width:100px;" >
                <option value="">Default</option>
                <option value="medium" >Medium</option>
                <option value="large">Large</option>                
            </select>
        </div>
    </div>
    
    <!-- top end -->
  
    <!-- left start -->
    <div region="west" title="菜单导航" headerStyle="font-size:16px;padding-left:25%;" showHeader="true" bodyStyle="border:0;padding-left:10px;" showSplitIcon="true" width="180" minWidth="150" maxWidth="220" >
    
    	<div class="mini-splitter" style="width:100%;height:95%;" borderStyle="border:0;" allowResize="false" handlerSize="0">
            <div size="100%" showCollapseButton="false" style="border:0;text-align: center;">
                <!--OutlookTree-->
                <div id="leftTree" class="mini-outlooktree" url="${path}/admin/menuItem.html" onnodeclick="onNodeSelect" 
                    textField="menuItemName" idField="menuId" parentField="parentId" dataField="menuItemUrl" resultAsTree="false" >
                </div>                	
            </div>
       </div>
    
    </div>
   <!-- left end -->
   
   <!-- main start -->
   <div title="center" region="center" style="border:0;" bodyStyle="overflow:hidden;">
        <!--Splitter-->
        <div class="mini-splitter" style="width:100%;height:100%;" borderStyle="border:0;" allowResize="false">
            
            <div size="0" showCollapseButton="false" style="border:0;" visible="false">
            </div>
                        
            <div showCollapseButton="false" style="border:0;">
                <!--Tabs-->
                <div id="mainTabs" class="mini-tabs" activeIndex="0" style="width:100%;height:100%;"      
                     plain="false" onactivechanged="onTabsActiveChanged">
                    <div title="首页" url="${path}/admin/default.html" ></div>
                </div>
            </div>        
        </div>
   </div>
    
   <!-- main end -->
   
   <!-- footer start -->
    
   <div showHeader="false" region="south" style="width:100%;border:0;text-align:center;" height="25" showSplit="false">
        Copyright © ${webSiteTitle}版权所有 &nbsp;2016 - ${thisYear}
   </div>
    
   <!-- footer end -->
   
</div>

<!-- main container end -->

</body>

<script type="text/javascript">
    mini.parse();
    
  	// 当前激活的tab
    var eventTab;
  	
    // 刷新
    function refresh() {
    	if(eventTab)
    		reloadTab(eventTab);
    	else
    		window.location.reload(true);
    		
    }
    
    // 注销
    function logout(){
    	mini.confirm("确定注销？", "消息", function(r) {
    		if(r == "ok")
    			window.location.href = "${path}/admin/logout.html";
    	});
    }
   
    // reload Tab
    function reloadTab(tab){
    	 var tabs = mini.get("mainTabs");
    	 tabs.reloadTab(tab);
    }
   
    function onBeforeExpand(e) {
        var tree = e.sender;
        var nowNode = e.node;
        var level = tree.getLevel(nowNode);

        var root = tree.getRootNode();        
        tree.cascadeChild(root, function (node) {
            if (tree.isExpandedNode(node)) {
                var level2 = tree.getLevel(node);
                if (node != nowNode && !tree.isAncestor(node, nowNode) && level == level2) {
                    tree.collapseNode(node, true);
                }
            }
        });

    }
       
    // Tabs
    var tree = mini.get("leftTree");

    function showTab(node) {
        var tabs = mini.get("mainTabs");
        var tabId = "tab$" + node.id + node.menuId;
        var tab = tabs.getTab(tabId);
        if (!tab) {
            tab = {};
            tab._nodeid = node.id + node.menuId;
            tab.name = tabId;
            tab.title = node.menuItemName;
            tab.showCloseButton = true;
            tab.url = "${path}" + node.menuItemUrl;
            tabs.addTab(tab);
        } else {
        	tabs.reloadTab(tab);
        }
        
        tabs.activeTab(tab);
    }

    function onNodeSelect(e) {
        var node = e.node;
        var isLeaf = e.isLeaf;

        if (isLeaf) {
            showTab(node);
        }
    }

    function onClick(e) {
        var text = this.getText();
        //alert(text);
    }
    function onQuickClick(e) {
        tree.expandPath("datagrid");
        tree.selectNode("datagrid");
    }

    function onTabsActiveChanged(e) {
        var tabs = e.sender;
        var tab = tabs.getActiveTab();
        eventTab = tab;
        if (tab && tab._nodeid) {
            var node = tree.getNode(tab._nodeid);
            if (node && !tree.isSelectedNode(node)) {
                tree.selectNode(node);
            }
        }
    }
    
</script>

</html>