package com.zzc.commons;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintWriter;

import com.zzc.commons.ErrorCode;
import com.zzc.commons.dao.PageInfo;
import com.zzc.commons.utility.StringUtils;

/**
 * 接口回复基础类
 * @author zk
 * @date 2016年1月20日 上午9:43:33
 */
public class ResponseBase {
	/** 状态码 */
	private int errCode;
	/** 描述信息 */
	private String errDesc;
	/** 数据域 */
	private Object datas;
	/** 页码信息 */
	private PageInfo pageInfo;
	/** 参数信息 */
	private Object paramsInfo;
	
	public ResponseBase(ErrorCode errorCode) {
		this.errCode = errorCode.getCode();
		this.errDesc = errorCode.getDesc();
	}
	
	public ResponseBase(ErrorCode errorCode, Object datas) {
		this.errCode = errorCode.getCode();
		this.errDesc = errorCode.getDesc();
		this.datas = datas;
	}
	
	public ResponseBase(ErrorCode errorCode, Exception e) {
		this.errCode = errorCode.getCode();
		ByteArrayOutputStream buf = new ByteArrayOutputStream();
		e.printStackTrace(new PrintWriter(buf, true));
		String  expMessage = buf.toString();
		if (buf != null) {
			try {
				buf.close();
			} catch (IOException e1) {
				
			}
		}
		this.errDesc = errorCode.getDesc() + ";-------" + expMessage;
	}
	
	public ResponseBase(ErrorCode errorCode, Object datas, String appendDesc) {
		this.errCode = errorCode.getCode();
		if (StringUtils.isNotBlank(appendDesc)) {
			appendDesc = ";-------" + appendDesc;
		}
		this.errDesc = errorCode.getDesc() + appendDesc;
		this.datas = datas;
	}
	
	public ResponseBase(ErrorCode errorCode, Object datas, PageInfo pageInfo, Object parmasInfo) {
		this.errCode = errorCode.getCode();
		this.errDesc = errorCode.getDesc();
		this.datas = datas;
		this.pageInfo = pageInfo;
		this.paramsInfo = parmasInfo;
	}
	
	public int getErrCode() {
		return errCode;
	}

	public void setErrCode(int errCode) {
		this.errCode = errCode;
	}

	public String getErrDesc() {
		return errDesc;
	}

	public void setErrDesc(String errDesc) {
		this.errDesc = errDesc;
	}

	public Object getDatas() {
		return datas;
	}

	public void setDatas(Object datas) {
		this.datas = datas;
	}

	public PageInfo getPageInfo() {
		return pageInfo;
	}

	public void setPageInfo(PageInfo pageInfo) {
		this.pageInfo = pageInfo;
	}

	public Object getParamsInfo() {
		return paramsInfo;
	}

	public void setParamsInfo(Object paramsInfo) {
		this.paramsInfo = paramsInfo;
	}



}
