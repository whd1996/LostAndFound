package com.lin.lostandfound.entities.domain;

// Generated 2017-4-14 22:53:26 by Hibernate Tools 4.0.0

import java.util.Date;

/**
 * Systemlog generated by hbm2java
 */
public class SystemLog implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Long id;
	private String description;
	private String exceptionCode;
	private String type;
	private String requestIp;
	private String exceptionDetail;
	private String method;
	private String params;
	private String createBy;
	private Date createDate;

	public SystemLog() {
	}

	public SystemLog(Date createDate) {
		this.createDate = createDate;
	}

	public SystemLog(String description, String exceptionCode, String type,
			String requestIp, String exceptionDetail, String method,
			String params, String createBy, Date createDate) {
		this.description = description;
		this.exceptionCode = exceptionCode;
		this.type = type;
		this.requestIp = requestIp;
		this.exceptionDetail = exceptionDetail;
		this.method = method;
		this.params = params;
		this.createBy = createBy;
		this.createDate = createDate;
	}

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getExceptionCode() {
		return this.exceptionCode;
	}

	public void setExceptionCode(String exceptionCode) {
		this.exceptionCode = exceptionCode;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getRequestIp() {
		return this.requestIp;
	}

	public void setRequestIp(String requestIp) {
		this.requestIp = requestIp;
	}

	public String getExceptionDetail() {
		return this.exceptionDetail;
	}

	public void setExceptionDetail(String exceptionDetail) {
		this.exceptionDetail = exceptionDetail;
	}

	public String getMethod() {
		return this.method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public String getParams() {
		return this.params;
	}

	public void setParams(String params) {
		this.params = params;
	}

	public String getCreateBy() {
		return this.createBy;
	}

	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

	public Date getCreateDate() {
		return this.createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	@Override
	public String toString() {
		return "SystemLog [id=" + id + ", description=" + description
				+ ", exceptionCode=" + exceptionCode + ", type=" + type
				+ ", requestIp=" + requestIp + ", exceptionDetail="
				+ exceptionDetail + ", method=" + method + ", params=" + params
				+ ", createBy=" + createBy + ", createDate=" + createDate + "]";
	}

}
