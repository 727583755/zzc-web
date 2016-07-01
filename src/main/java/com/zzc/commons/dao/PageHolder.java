package com.zzc.commons.dao;

import java.util.List;


public class PageHolder<T> {

	private int pageNum;
	private int maxPageNum;
	private int pageSize;
	private int totalCount;
	private boolean hasPrevious;
	private boolean hasNext;
	private ConditionHolder cholder;
	private List<T> result;
	private PageInfo pageInfo;

	public PageHolder(int pageNum, int maxPageNum, int pageSize, int totalCount, boolean hasPrevious, boolean hasNext,
			ConditionHolder cholder, List<T> result) {
		super();
		this.pageNum = pageNum;
		this.maxPageNum = maxPageNum;
		this.pageSize = pageSize;
		this.totalCount = totalCount;
		this.hasPrevious = hasPrevious;
		this.hasNext = hasNext;
		this.cholder = cholder;
		this.result = result;
		this.pageInfo = new PageInfo(pageNum, pageSize, totalCount);
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getMaxPageNum() {
		return maxPageNum;
	}

	public void setMaxPageNum(int maxPageNum) {
		this.maxPageNum = maxPageNum;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public boolean isHasPrevious() {
		return hasPrevious;
	}

	public void setHasPrevious(boolean hasPrevious) {
		this.hasPrevious = hasPrevious;
	}

	public boolean isHasNext() {
		return hasNext;
	}

	public void setHasNext(boolean hasNext) {
		this.hasNext = hasNext;
	}

	public ConditionHolder getCholder() {
		return cholder;
	}

	public void setCholder(ConditionHolder cholder) {
		this.cholder = cholder;
	}

	public List<T> getResult() {
		return result;
	}

	public void setResult(List<T> result) {
		this.result = result;
	}

	public PageInfo getPageInfo() {
		return pageInfo;
	}

	public void setPageInfo(PageInfo pageInfo) {
		this.pageInfo = pageInfo;
	}

}
