package com.lin.lostandfound.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/error")
public class HandelErrorController {
	
	// 获取拒绝访问视图
	@RequestMapping(value = { "/refuse-error.html" })
	public String refuseError() {

		return "error/refuse-error";
	}

	// 获取错误页面视图
	@RequestMapping(value = {"/{code}"})
	public String errorPage(@PathVariable String code) {

		return "error/" + code;
	}
}
