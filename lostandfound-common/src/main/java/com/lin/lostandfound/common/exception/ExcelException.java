package com.lin.lostandfound.common.exception;

public class ExcelException extends Exception {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public ExcelException() {

	}
	
	public ExcelException(String message) {
		super(message);
	}
	
	public ExcelException(Throwable cause) {
		super(cause);
	}
	
	public ExcelException(String message, Throwable cause) {
		super(message, cause);
	}
}
