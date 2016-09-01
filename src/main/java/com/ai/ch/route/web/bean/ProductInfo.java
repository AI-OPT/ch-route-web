package com.ai.ch.route.web.bean;

import java.util.ArrayList;
import java.util.List;

public class ProductInfo {

	private String disabled;
	private String productId;
	private String productName;
	private String productCatId;
	private List<AttrInfo> attrOne = new ArrayList<AttrInfo>();
	private List<AttrInfo> attrTwo = new ArrayList<AttrInfo>();
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
