package com.ai.ch.route.web.bean;

public class TargetAreaInfo {
	/**
	 * 选择
	 */
	private String checked;
	/**
	 * 地域编码
	 */
	private String areaCode;
	/**
	 * 地域名称
	 */
	private String areaName;

	public String getChecked() {
		return checked;
	}

	public void setChecked(String checked) {
		this.checked = checked;
	}

	public String getAreaCode() {
		return areaCode;
	}

	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}

	public String getAreaName() {
		return areaName;
	}

	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}
}
