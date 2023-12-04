package com.lin.lostandfound.configs.aspect;

import org.aspectj.lang.annotation.Aspect;
import org.springframework.aop.Advisor;
import org.springframework.aop.aspectj.AspectJExpressionPointcut;
import org.springframework.aop.support.DefaultPointcutAdvisor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * @author lgllink
 * @date 2020/3/20
 */
@Aspect
@Configuration
public class DataSourceAdviceConfig {

    private static final String AOP_POINTCUT_EXPRESSION = "execution(* com.lin.lostandfound.services.*.*(..))";

    @Autowired
    @Qualifier("dataSourceExchange")
    private DataSourceAspect dataSourceExchange;


    @Bean(name = "dataSourceAdvisor")
    public Advisor dataSourceAdvisor() {
        AspectJExpressionPointcut pointcut = new AspectJExpressionPointcut();
        pointcut.setExpression(AOP_POINTCUT_EXPRESSION);
        DefaultPointcutAdvisor advisor = new DefaultPointcutAdvisor(pointcut, dataSourceExchange);
        advisor.setOrder(1);
        return advisor;
    }

}
