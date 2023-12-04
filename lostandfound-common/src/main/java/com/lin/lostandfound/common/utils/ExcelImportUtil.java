package com.lin.lostandfound.common.utils;

import com.lin.lostandfound.entities.domain.User;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.NumberToTextConverter;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ExcelImportUtil {

	private ExcelImportUtil() {
	
	}
	
	public static List<User> exportListFromExcel(Workbook workBook) {
		int sheetNum = 0;
		// 解析公式结果
		FormulaEvaluator evaluator = workBook.getCreationHelper().createFormulaEvaluator();
		List<User> list = new ArrayList<User>();
		User user = null;
		
		while(sheetNum < workBook.getNumberOfSheets()) {
			Sheet sheet = workBook.getSheetAt(sheetNum);
			int minRowIx = sheet.getFirstRowNum();
			int maxRowIx = sheet.getLastRowNum();
			// System.out.println("minRowIx: " +minRowIx + " " +"maxRowIx: " +maxRowIx);
			// 从Sheet的第1行到当前页面的最大行获取
			// 把Excel表头去掉（第一行）
			for (int rowIx = (minRowIx + 1); rowIx <= maxRowIx; rowIx++) {
				Row row = sheet.getRow(rowIx);// 取第几行
				if(row == null)
					break;

				short minColIx = row.getFirstCellNum();
				short maxColIx = row.getLastCellNum();
				// System.out.println("minColIx: " +minColIx + " " +"maxColIx: " +maxColIx);
				user = new User();
				
				for (short colIx = minColIx; colIx <= maxColIx; colIx ++) {
					
					Cell cell = row.getCell(new Integer(colIx));
					if(cell == null)
						break;
					String result = getCellValueAsText(cell, evaluator);
					if(result == null)
						break;
					result = result.trim();
					switch (colIx) {
					case 0: {
						user.setUserName(result);
						user.setPassword(MD5Util.string2MD5(result));
						break;
					}
					case 1: {
						user.setGrade(result);
						break;
					}
					case 2: {
						user.setName(result);
						break;
					}
					case 3: {
						user.setTelPhone(result);
						break;
					}
					default:
						break;
					}
					
					user.setState(1);
					user.setCreateTime(new Date());
				}
				//System.out.println("user: "+user);
				list.add(user);
			}
			
			sheetNum ++;
		}
		
		return list;
	}
	
	// 把初时间日期外的CELL_TYPE_NUMERIC以String类型解析
	private static String getCellValueAsText(Cell cell, FormulaEvaluator evaluator) {

		CellValue cellValue = evaluator.evaluate(cell);
		if (cellValue == null) {
			return null;
		}
		
		Object result;

		switch (cell.getCellType()) {
		case Cell.CELL_TYPE_BLANK:
			result = null;
			break;
		case Cell.CELL_TYPE_BOOLEAN:
			result = String.valueOf(cell.getBooleanCellValue());
			break;
		case Cell.CELL_TYPE_ERROR:
			result = null;
			break;
		case Cell.CELL_TYPE_FORMULA:
			result = null;
			break;
		case Cell.CELL_TYPE_NUMERIC:
			if (org.apache.poi.ss.usermodel.DateUtil.isCellDateFormatted(cell)) {
				SimpleDateFormat simpleDateFormat;
				if (cell.getCellStyle().getDataFormat() == HSSFDataFormat
						.getBuiltinFormat("h:mm")) {
					simpleDateFormat = new SimpleDateFormat("HH:mm");
				} else if (cell.getCellStyle().getDataFormat() == HSSFDataFormat
						.getBuiltinFormat("h:mm:ss")) {
					simpleDateFormat = new SimpleDateFormat("HH:mm:ss");
				} else {
					simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
				}
				Date theDate = cell.getDateCellValue();
				result = simpleDateFormat.format(theDate);
			} else {
				result = NumberToTextConverter.toText(cell.getNumericCellValue());
			}
			break;
		case Cell.CELL_TYPE_STRING:
			result = cell.getRichStringCellValue().getString();
			break;
		default:
			result = null;
		}

		return result.toString();
	}

}
