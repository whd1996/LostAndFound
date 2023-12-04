
// 查看物品信息
function showView(url, title, id) {
	mini.open({
        url: url,
        title: title, width: 600, height: 300, allowResize: false,
        onload: function () {
            var iframe = this.getIFrameEl();
            var data = {id: id };
            iframe.contentWindow.setData(data);
        },
        ondestroy: function (action) {
            grid.reload();
        }
    });
}

// 解析物品类型
function onThingsTypeRenderer(e) {
    var value = e.value;
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

// 导出excel
function exportExcel() {
    var columns = grid.getBottomColumns();
    
    function getColumns(columns) {
        columns = columns.clone();
        for (var i = columns.length - 1; i >= 0; i--) {
            var column = columns[i];
            if (!column.field) {
                columns.removeAt(i);
            } else {
                var c = { header: column.header, field: column.field };
                columns[i] = c;
            }
        }
        return columns;
    }
    
    var columns = getColumns(columns);
    var json = mini.encode(columns);                        
    document.getElementById("excelData").value = json;
    var excelForm = document.getElementById("excelForm");
    excelForm.submit();            
}