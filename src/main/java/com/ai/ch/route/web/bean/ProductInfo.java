package com.ai.ch.route.web.bean;

import java.util.ArrayList;
import java.util.List;

public class ProductInfo {
	/**
	 * 
	 */
	private String disabled;
	/**
	 * 商品标识
	 */
	private String productId;
	/**
	 * 商品名称
	 */
	private String productName;
	/**
	 * 类目标识
	 */
	private String productCatId;
	/**
	 * 属性集合
	 */
	private List<AttrInfo> attrOne = new ArrayList<AttrInfo>();
	/**
	 * 属性集合
	 */
	private List<AttrInfo> attrTwo = new ArrayList<AttrInfo>();
	/**
	 * 属性
	 */
	private String attrOneStr;
	/**
	 * 属性
	 */
	private String attrTwoStr;
	
	public String getAttrOneStr() {
		return attrOneStr;
	}

	public void setAttrOneStr(String attrOneStr) {
		this.attrOneStr = attrOneStr;
	}

	public String getAttrTwoStr() {
		return attrTwoStr;
	}

	public void setAttrTwoStr(String attrTwoStr) {
		this.attrTwoStr = attrTwoStr;
	}

	public String getProductCatId() {
		return productCatId;
	}

	public void setProductCatId(String productCatId) {
		this.productCatId = productCatId;
	}

	public String getDisabled() {
		return disabled;
	}

	public void setDisabled(String disabled) {
		this.disabled = disabled;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public List<AttrInfo> getAttrOne() {
		return attrOne;
	}

	public void setAttrOne(List<AttrInfo> attrOne) {
		this.attrOne = attrOne;
	}

	public List<AttrInfo> getAttrTwo() {
		return attrTwo;
	}

	public void setAttrTwo(List<AttrInfo> attrTwo) {
		this.attrTwo = attrTwo;
	}

}
