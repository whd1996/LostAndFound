package com.lin.lostandfound.common.annotation;

import java.lang.annotation.*;

/**
 * 自定义注解 数据源DataSource
 */

@Target({ ElementType.METHOD, ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Inherited
public @interface DataSource {
	String name() default "";
}
