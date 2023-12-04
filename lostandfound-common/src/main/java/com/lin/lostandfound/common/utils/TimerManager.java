package com.lin.lostandfound.common.utils;

import java.util.Calendar;
import java.util.Date;
import java.util.Timer;

public class TimerManager {

	private Timer timer;

	// 时间间隔 一天时间
	//private static final long PERIOD_DAY = 24 * 60 * 60 * 1000;

	public TimerManager() {
	}

	// 开始
	public void start(String backuptime, long period) {

		// 获取并处理配置文件中的时间
		String[] time = backuptime.split(":");
		int hours = Integer.parseInt(time[0]);
		int minute = Integer.parseInt(time[1]);
		int second = Integer.parseInt(time[2]);

		Calendar calendar = Calendar.getInstance();

		/*** 定制每日2:00执行方法 ***/
		calendar.set(Calendar.HOUR_OF_DAY, hours);
		calendar.set(Calendar.MINUTE, minute);
		calendar.set(Calendar.SECOND, second);

		Date date = calendar.getTime(); // 第一次执行定时任务的时间

		// 如果第一次执行定时任务的时间 小于 当前的时间
		// 此时要在 第一次执行定时任务的时间 加一天，以便此任务在下个时间点执行。如果不加一天，任务会立即执行。
		if (date.before(new Date())) {
			date = this.addDay(date, 1);
		}

		timer = new Timer();

		DataBaseTimerTask task = new DataBaseTimerTask();
		// 安排指定的任务在指定的时间开始进行重复的固定延迟执行。
		timer.schedule(task, date, period);

	}

	// 停止
	public void stop() {
		if (timer != null)
			timer.cancel();
	}

	// 增加或减少天数
	public Date addDay(Date date, int num) {
		Calendar startDate = Calendar.getInstance();
		startDate.setTime(date);
		startDate.add(Calendar.DAY_OF_MONTH, num);

		return startDate.getTime();
	}

}
