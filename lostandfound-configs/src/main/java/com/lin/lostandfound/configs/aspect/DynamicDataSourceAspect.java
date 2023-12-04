package com.lin.lostandfound.configs.aspect;

import com.lin.lostandfound.common.annotation.DataSource;
import com.lin.lostandfound.configs.datasource.DataSourceContextHolder;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;

import java.lang.reflect.Method;

/**
 * @author lgllink
 * @date 2020/3/29
 */
//@Aspect
//@Order(-10)// 保证该AOP在@Transactional之前执行
//@Component
public class DynamicDataSourceAspect {

    @Pointcut("@annotation(com.lin.lostandfound.common.annotation.DataSource)")
    public void pointcut() {
    }

    @Before("pointcut()")
    public void beforeExecute(JoinPoint joinPoint) {
        Signature signature = joinPoint.getSignature();
        MethodSignature methodSignature = (MethodSignature) signature;
        Method targetMethod = methodSignature.getMethod();
        Class<?> targetClazz =  joinPoint.getTarget().getClass();

        DataSource datasource = targetMethod.getAnnotation(DataSource.class);
        if (null == datasource) {
            datasource = targetClazz.getAnnotation(DataSource.class);
        }
        if (null != datasource) {
            // 切换数据源
            DataSourceContextHolder.setDataSourceType(datasource.name());
        }

        System.out.println("@DataSource数据源： " +datasource.name());
        System.out.println("当前数据源： "  +DataSourceContextHolder.getDataSourceType());
    }

    @After("pointcut()")
    public void afterExecute() {
        DataSourceContextHolder.clearDataSourceType();
    }

}
