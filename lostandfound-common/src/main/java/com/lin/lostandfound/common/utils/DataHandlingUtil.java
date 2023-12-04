package com.lin.lostandfound.common.utils;

import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.sql.Clob;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

public class DataHandlingUtil {

	@SuppressWarnings("unchecked")
	public static <T> List<T> resultSetToList(ResultSet rs, Class<T> obj) throws Exception {
		ResultSetMetaData md = rs.getMetaData();
		int columnCount = md.getColumnCount();
		List<T> list = new ArrayList<T>();
		Map<String, Object> rowData;
		while (rs.next()) {
			rowData = new HashMap<String, Object>(columnCount);
			for (int i = 1; i <= columnCount; i++) {
				Object v = rs.getObject(i);

				if (v != null
						&& (v.getClass() == Date.class || v.getClass() == java.sql.Date.class)) {
					Timestamp ts = rs.getTimestamp(i);
					v = new Date(ts.getTime());
					DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					v = df.format(v);
					// v = ts;
				} else if (v != null && v.getClass() == Clob.class) {
					v = clob2String((Clob) v);
				}
				rowData.put(md.getColumnName(i), v);
			}
			System.out.println("rowData: " +rowData);
			T newInstance = obj.newInstance();
			newInstance = (T) BeanToMapUtil.convertMap(obj, rowData);
			list.add(newInstance);
		}

		return list;
	}

	// 反转list
	public static List<Object> reverseList(List<Object> list) {
		int j = list.size() - 1;
		for (int i = 0; i < list.size() / 2; i++) {
			Object temp = list.get(i);
			list.set(i, list.get(j));
			list.set(j, temp);
			j--;
		}

		return list;
	}

	private static String clob2String(Clob clob) throws Exception {
		return (clob != null ? clob.getSubString(1, (int) clob.length()) : null);
	}

	public int toInt(Object o) {
		if (o == null)
			return 0;
		double d = Double.parseDouble(o.toString());
		int i = 0;
		i -= d;
		return -i;
	}

	public String toString(Object o) {
		if (o == null)
			return "";
		return o.toString();
	}

	public Timestamp toDate(Object o) {
		try {
			if (o.getClass() == String.class) {

				DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				o = format.parse(o.toString());
				return new Timestamp(((Date) o).getTime());
			}
			return o != null ? new Timestamp(((Date) o).getTime())
					: null;
		} catch (Exception ex) {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	public static void excelWrite(HttpServletRequest request,
			HttpServletResponse response, Map<String, Object> resultMap, String fileName)
			throws Exception {
		OutputStream out = response.getOutputStream();
		response.reset();// 清空输出流

		response.setCharacterEncoding("UTF-8");// 设置相应内容的编码格式
		fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
		response.setHeader("Content-Disposition", "attachment;filename="
				+ new String(fileName.getBytes("UTF-8"), "UTF-8") + ".xls");
		response.setContentType("application/ms-excel");// 定义输出类型
		String json = request.getParameter("columns");
		//System.out.println("json:" + json);
		List<Object> rows = (List<Object>) JSONUtil.decode(json);
		Map<String, Object> data = resultMap;

		WritableWorkbook workbook = null;
		try {
			// 获得开始时间
			long start = System.currentTimeMillis();
			// 创建Excel工作薄
			workbook = Workbook.createWorkbook(out);
			// 添加第一个工作表并设置第一个Sheet的名字
			WritableSheet sheet = workbook.createSheet(java.net.URLDecoder.decode(fileName, "UTF-8"), 0);
			Label label;
			// 写出列名
			for (int i = 0; i < rows.size(); i++) {
				Map<String, Object> hm = (Map<String, Object>)rows.get(i);
				// Iterator<String> iterator = hm.keySet().iterator();
				label = new Label(i, 0, hm.get("header").toString());
				sheet.addCell(label);
			}
			// 写出数据
			List<Object> list = (List<Object>) data.get("data");
			for (int i = 1; i <= list.size(); i++) {
				Map<String, Object> hm1 = BeanToMapUtil.convertBean(list.get(i - 1));
				for (int k = 1; k < hm1.size(); k++) {
					for (int j = 0; j < rows.size(); j++) {
						Map<String, Object> hm = (Map<String, Object>) rows.get(j);
						String key = hm.get("field").toString();
						String value = String.valueOf(hm1.get(key) == null ? "" : hm1.get(key));
						label = new Label(j, i, value);
						sheet.addCell(label);
					}
				}
			}
			// 写入数据
			workbook.write();
			long end = System.currentTimeMillis();
			System.out.println("----完成该操作共用的时间是:"+(end-start)/1000);
		} catch (Exception e) {
			System.out.println("---出现异常---");
			e.printStackTrace();
		} finally {
			// 关闭文件
			if (workbook != null)
				workbook.close();
			if (out != null)
				out.close();
		}
	}
}
