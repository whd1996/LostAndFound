package com.lin.lostandfound.common.utils;

import jxl.common.Logger;

import java.io.IOException;
import java.util.TimerTask;
import java.util.concurrent.ExecutionException;

public class DataBaseTimerTask extends TimerTask {

	private static Logger log = Logger.getLogger(DataBaseTimerTask.class);

	@Override
	public void run() {
		String username = DataBaseInfoUtils.getDataBaseInfo().get("username");
		String password = DataBaseInfoUtils.getDataBaseInfo().get("password");
		String ip = DataBaseInfoUtils.getDataBaseInfo().get("ip");
		String port = DataBaseInfoUtils.getDataBaseInfo().get("port");
		String databaseName = DataBaseInfoUtils.getDataBaseInfo().get(
				"databaseName");

		MysqlDumpUtils.config(username, password, databaseName, ip, port);
		try {
			// 定时自动备份路径autobackup
			MysqlDumpUtils.backup(MysqlDumpUtils.getBackupPath() + "/autobackup/backup");
		} catch (IOException e) {
			e.printStackTrace();
			log.error("备份出错!");
		} catch (InterruptedException e) {
			e.printStackTrace();
			log.error("备份出错!");
		} catch (ExecutionException e) {
			e.printStackTrace();
			log.error("备份出错!");
		}

	}

}
