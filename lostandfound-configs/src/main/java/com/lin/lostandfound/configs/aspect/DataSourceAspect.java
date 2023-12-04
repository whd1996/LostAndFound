package com.lin.lostandfound.configs.aspect;


import com.lin.lostandfound.common.annotation.DataSource;
import com.lin.lostandfound.configs.datasource.DataSourceContextHolder;
import org.springframework.aop.AfterReturningAdvice;
import org.springframework.aop.MethodBeforeAdvice;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;

import java.lang.reflect.Method;


@Order(-10)//保证该AOP在@Transactional之前执行
@Configuration("dataSourceExchange")
public class DataSourceAspect implements MethodBeforeAdvice, AfterReturningAdvice {

	@Override
	public void before(Method method, Object[] args, Object target)	throws Throwable {
		System.out.println("method.getClass(): " +method.getDeclaringClass());
		System.out.println("method: " +method.getName());

		boolean methodAnnotation = method.isAnnotationPresent(DataSource.class);
		boolean calzzAnnotation = method.getDeclaringClass().isAnnotationPresent(DataSource.class);

		if (methodAnnotation || calzzAnnotation) {
			DataSource datasource = method.getAnnotation(DataSource.class);
			datasource = method.getDeclaringClass().getAnnotation(DataSource.class);
			if((!datasource.name().equals("")))
				DataSourceContextHolder.setDataSourceType(datasource.name());

			System.out.println("@DataSource数据源： " +datasource.name());
			System.out.println("当前数据源： "  +DataSourceContextHolder.getDataSourceType());
		}
	}

	@Override
	public void afterReturning(Object returnValue, Method method,
							   Object[] args, Object target) throws Throwable {

		DataSourceContextHolder.clearDataSourceType();
	}
}
