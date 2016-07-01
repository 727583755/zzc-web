package com.zzc.commons;

/**
 * 异常类
 * @author zk
 * @date 2015年7月28日 下午5:09:53
 */
public class GowildException extends RuntimeException {

	private static final long serialVersionUID = 1L;
	
	private ErrorCode errorCode;
	private String appendDesc;
	
	public GowildException(ErrorCode errorCode) {
		this(errorCode, "");
	}
	
	public GowildException(ErrorCode errorCode, String appendDesc) {
		super();
		this.errorCode = errorCode;
		this.appendDesc = appendDesc;
	}

	public ErrorCode getErrorCode() {
		return errorCode;
	}

	public void setErrorCode(ErrorCode errorCode) {
		this.errorCode = errorCode;
	}

	public String getAppendDesc() {
		return appendDesc;
	}

	public void setAppendDesc(String appendDesc) {
		this.appendDesc = appendDesc;
	}
	
}
