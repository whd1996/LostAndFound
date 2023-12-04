package com.lin.lostandfound.configs.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * @author lgllink
 * @date 2020/3/19
 */
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    public static final String[] UserInterceptor_PATH = {"/find/**","/lost/**","/user/**","/message/**"};
    public static final String[] UserInterceptor_EXCLUDES_PATH = {"/find/find-list.do/**","/find/find-list.html/**",
            "/find/find-details.do/**","/find/find-details.html/**","/lost/lost-list.do/**","/lost/lost-list.html/**",
            "/lost/lost-details.do/**","/lost/lost-details.html/**","/static/**"};

    public static final String[] TokenInterceptor_PATH = {"/find/**","/lost/**"};
    public static final String[] TokenInterceptor_EXCLUDES_PATH = {};

    public static final String[] AdminInterceptor_PATH = {"/admin/**"};
    public static final String[] AdminInterceptor_EXCLUDES_PATH = {"/admin/login","/admin/login.do","/admin/login.html"};

    @Autowired
    private UserInterceptor userInterceptor;
    @Autowired
    private TokenInterceptor tokenInterceptor;
    @Autowired
    private AdminInterceptor adminInterceptor;

    @Bean
    public WebMvcConfig getWebMvcConfig() {
        WebMvcConfig WebMvcConfig = new WebMvcConfig() {

            @Override
            public void addViewControllers(ViewControllerRegistry registry) {

                registry.addViewController("/index1").setViewName("index");
            }

            //注册拦截器
            @Override
            public void addInterceptors(InterceptorRegistry registry) {
                registry.addInterceptor(userInterceptor).addPathPatterns(UserInterceptor_PATH)
                        .excludePathPatterns(UserInterceptor_EXCLUDES_PATH);

                registry.addInterceptor(tokenInterceptor).addPathPatterns(TokenInterceptor_PATH)
                        .excludePathPatterns(TokenInterceptor_EXCLUDES_PATH);

                registry.addInterceptor(adminInterceptor).addPathPatterns(AdminInterceptor_PATH)
                        .excludePathPatterns(AdminInterceptor_EXCLUDES_PATH);
            }
        };

        return WebMvcConfig;
    }

}