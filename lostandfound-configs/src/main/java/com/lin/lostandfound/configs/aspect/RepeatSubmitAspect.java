package com.lin.lostandfound.configs.aspect;

import com.lin.lostandfound.common.annotation.NoRepeatSubmit;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.Assert;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;

/**
 * @author lgllink
 * @date 2020/4/13
 */
public class RepeatSubmitAspect {
    private final static Logger log = LoggerFactory.getLogger(RepeatSubmitAspect.class);


   // private RedisLock redisLock;

    @Pointcut()
    public void pointcut() {

    }

    @Around("pointcut()")
   public Object around(ProceedingJoinPoint joinPoint, NoRepeatSubmit noRepeatSubmit){
        int lockSeconds = noRepeatSubmit.lockTime();
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        Assert.notNull(request, "request can not null!");




        return null;
    }

    private boolean isRepeatSubmit(HttpServletRequest request) {
        String serverToken = (String) request.getSession(false).getAttribute("token");
        if (serverToken == null) {
            return true;
        }
        String clinetToken = request.getParameter("token");
        System.out.println("serverToken: " +serverToken+ " " +"clinetToken: " +clinetToken);
        if (clinetToken == null) {
            return true;
        }
        if (!serverToken.equals(clinetToken)) {
            return true;
        }
        return false;
    }
}
