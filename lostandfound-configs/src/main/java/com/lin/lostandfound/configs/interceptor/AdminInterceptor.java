package com.lin.lostandfound.configs.interceptor;

import com.lin.lostandfound.common.constants.Constants;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Component
public class AdminInterceptor implements HandlerInterceptor {

	//方法处理后，主要用于资源释放
	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object object, Exception exception)
			throws Exception {

	}

	//方法处理完成后，显示页面前
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response,
			Object object, ModelAndView modelAndView) throws Exception {

	}

	//方法处理前
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object object) throws Exception {
		HttpSession session = request.getSession();
	    if (session.getAttribute(Constants.ADMIN) == null) {
	    	System.out.println("admin未登录...");	
	    	if (request.getHeader("x-requested-with") != null
					&& request.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")) { // 如果是ajax请求响应头会有，x-requested-with
				response.setHeader("sessionstatus", "timeout");// 在响应头设置session状态
				return false;
			}
	    	
	    	response.getWriter().write("<script>parent.window.document.location.href='" +request.getContextPath()+ "/admin/login.html';</script>");
	    	return false;
	    } else {
	        return true;
	    }
	}

}
