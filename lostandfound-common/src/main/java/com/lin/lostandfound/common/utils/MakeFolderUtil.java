package com.lin.lostandfound.common.utils;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

public class MakeFolderUtil {
	
	private MakeFolderUtil() {
		
	}

	public static String makeDir(String basePath, Date date, String user) {
		
		String year = MakeFolderUtil.dateFormatToString("yyyy", date);
		basePath = basePath + "\\" + year;
		File file = new File(basePath);
		if (!file.exists())
			file.mkdirs();

		String month = MakeFolderUtil.dateFormatToString("MM", date);
		basePath = basePath + "\\" + month;
		file = new File(basePath);
		if (!file.exists())
			file.mkdirs();

		basePath = basePath + "\\" + user;
		file = new File(basePath);
		if (!file.exists())
			file.mkdirs();

		return basePath;
	}
	
	private static String dateFormatToString(String key,Date date) {

		return new SimpleDateFormat(key).format(date);
	}
	
	public static void main(String[] args) {
		//System.out.println(makeDir("E:\\date", "2017", "02", "2013143218"));
		System.out.println(dateFormatToString("dd",new Date()));
	}
}
