package com.lin.lostandfound.configs.listener;

import com.lin.lostandfound.common.constants.Constants;
import com.lin.lostandfound.common.utils.TimerManager;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.util.Calendar;

@Configuration
@WebListener
public class InitializedListener implements ServletContextListener {

	private TimerManager timerManager;

	@Value("${lostandfound.webSiteTitle}")
	private String webSiteTitle;
	@Value("${lostandfound.copyRight}")
	private String copyRight;
	@Value("${lostandfound.backuptime}")
	private String backuptime;
	@Value("${lostandfound.period}")
	private String timeInterval;

	@Override
	public void contextInitialized(ServletContextEvent servletContextEvent) {
		ServletContext servletContext = servletContextEvent.getServletContext();
		System.out.println("初始化path：" +servletContext.getContextPath());
		
		//String webSiteTitle = servletContext.getInitParameter("webSiteTitle");
		//String copyRight = servletContext.getInitParameter("copyRight");

		System.out.println("webSiteTitle: " + this.webSiteTitle +"===" + "copyRight: " +this.copyRight);
		servletContext.setAttribute("webSiteTitle", this.webSiteTitle);
		servletContext.setAttribute("copyRight", this.copyRight);
		servletContext.setAttribute(Constants.PATH, servletContext.getContextPath());
		
		// 当前年份
		servletContext.setAttribute("thisYear", Calendar.getInstance().get(Calendar.YEAR));
		
		// 初始化数据库备份
		initDataBaseBackup(servletContext);
	}
	
	@Override
	public void contextDestroyed(ServletContextEvent servletContextEvent) {
		String path = (String) servletContextEvent.getServletContext().getAttribute(Constants.PATH);
		servletContextEvent.getServletContext().removeAttribute(Constants.PATH);
		System.out.println("销毁path：" +path);
		
		// 销毁数据库备份
		destroyedDataBaseBackup();

	}
	
	private void initDataBaseBackup(ServletContext servletContext) {
		System.out.println("数据库备份初始化...");

		//String backuptime = servletContext.getInitParameter("backuptime");
		//String timeInterval = servletContext.getInitParameter("period");

		System.out.println("backuptime: " + this.backuptime + "====" +"timeInterval: " +this.timeInterval);
		String[] time = this.timeInterval.split("\\*");
		long period = 1;
		for(String value : time)
			period *= Long.parseLong(value);
		
		timerManager = new TimerManager();
		timerManager.start(this.backuptime, period);
	}
	
	private void destroyedDataBaseBackup() {
		if (timerManager != null)
			timerManager.stop();
	}
}
