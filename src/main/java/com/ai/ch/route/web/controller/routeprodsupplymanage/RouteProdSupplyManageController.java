package com.ai.ch.route.web.controller.routeprodsupplymanage;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ai.ch.route.web.bean.AttrInfo;
import com.ai.ch.route.web.bean.ProductInfo;
import com.ai.ch.route.web.bean.SelProdInfo;
import com.ai.ch.route.web.utils.RequestParameterUtils;
import com.ai.opt.base.vo.PageInfo;
import com.ai.opt.base.vo.PageInfoResponse;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.util.CollectionUtil;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.slp.product.api.normproduct.interfaces.INormProductSV;
import com.ai.slp.product.api.normproduct.param.AttrValInfo;
import com.ai.slp.product.api.normproduct.param.NormProdAndKeyAttrRes;
import com.ai.slp.product.api.normproduct.param.NormProdRequest;
import com.ai.slp.route.api.routeprodsupplymanage.interfaces.IRouteProdSupplyManageSV;
import com.ai.slp.route.api.routeprodsupplymanage.param.ProductCatIdListResponse;
import com.ai.slp.route.api.routeprodsupplymanage.param.RouteProdSupplyAddListRequest;
import com.ai.slp.route.api.routeprodsupplymanage.param.RouteProdSupplyAddRequest;
import com.ai.slp.route.api.routeprodsupplymanage.param.RouteProdSupplyPageSearchRequest;
import com.ai.slp.route.api.routeprodsupplymanage.param.RouteProdSupplyPageSearchResponse;
import com.ai.slp.route.api.routeprodsupplymanage.param.RouteProdSupplyPageSearchVo;
import com.ai.slp.route.api.routeprodsupplymanage.param.RouteProdSupplyRouteIdRequest;
import com.ai.slp.route.api.routeprodsupplymanage.param.RouteProdSupplyUpdateUsableNumRequest;
import com.ai.slp.route.api.routeprodsupplymanage.param.RouteProdSupplyUpdateUsableNumResponse;
import com.ai.slp.route.api.routeprodsupplymanage.param.StandedProdIdListResponse;
import com.ai.slp.route.api.routeprodsupplymanage.param.StandedProdIdVo;
import com.alibaba.fastjson.JSON;

@RequestMapping(value = "/routeprodsupplymanage")
@RestController
public class RouteProdSupplyManageController {
	private static final Logger log = LoggerFactory.getLogger(RouteProdSupplyManageController.class);

	@RequestMapping(value = "/queryPageSearch", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public ResponseData<PageInfo<RouteProdSupplyPageSearchVo>> queryPageSearch(HttpServletRequest request) {
		//
		String strPageNo = (null == request.getParameter("pageNo")) ? "1" : request.getParameter("pageNo");
		String strPageSize = (null == request.getParameter("pageSize")) ? "10" : request.getParameter("pageSize");

		RouteProdSupplyPageSearchRequest requestVo = RequestParameterUtils.request2Bean(request,
				RouteProdSupplyPageSearchRequest.class);
		//
		requestVo.setPageNo(Integer.parseInt(strPageNo));
		requestVo.setPageSize(Integer.parseInt(strPageSize));
		//
		RouteProdSupplyPageSearchResponse response = DubboConsumerFactory.getService(IRouteProdSupplyManageSV.class)
				.queryPageSearch(requestVo);
		PageInfo<RouteProdSupplyPageSearchVo> pageInfo = response.getPageInfo();
		//
		ResponseData<PageInfo<RouteProdSupplyPageSearchVo>> responseData;
		//
		responseData = new ResponseData<PageInfo<RouteProdSupplyPageSearchVo>>(ResponseData.AJAX_STATUS_SUCCESS,
				"success", pageInfo);
		//
		log.info(" ResponseData json:" + JSON.toJSONString(responseData));
		//
		return responseData;
	}

	@RequestMapping(value = "/updateUsableNum", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public RouteProdSupplyUpdateUsableNumResponse updateUsableNum(HttpServletRequest request) {
		//
		RouteProdSupplyUpdateUsableNumRequest requestVo = RequestParameterUtils.request2Bean(request,
				RouteProdSupplyUpdateUsableNumRequest.class);
		RouteProdSupplyUpdateUsableNumResponse response = DubboConsumerFactory.getService(IRouteProdSupplyManageSV.class).updateUsableNum(requestVo);
		//
		log.info("response:"+JSON.toJSONString(response));
		return response;
	}

	@RequestMapping(value = "/queryNormProductAndKeyAttr", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public ResponseData<PageInfo<ProductInfo>> queryNormProductAndKeyAttr(
			HttpServletRequest request) {
		//
		String strPageNo = (null == request.getParameter("pageNo")) ? "1" : request.getParameter("pageNo");
		String strPageSize = (null == request.getParameter("pageSize")) ? "10" : request.getParameter("pageSize");
		//

		NormProdRequest requestVo = RequestParameterUtils.request2Bean(request, NormProdRequest.class);
		log.info("NormProdRequest:"+JSON.toJSONString(requestVo));
		
		//find route_prod_supply db info by routeId and tenantId
		RouteProdSupplyRouteIdRequest routeProdSupplyRouteIdRequest = RequestParameterUtils.request2Bean(request, RouteProdSupplyRouteIdRequest.class);
		log.info("routeProdSupplyRouteIdRequest:"+JSON.toJSONString(routeProdSupplyRouteIdRequest));
		StandedProdIdListResponse standedProdIdListResponse = DubboConsumerFactory.getService(IRouteProdSupplyManageSV.class).queryStandedProdIdList(routeProdSupplyRouteIdRequest);
		
		//
		requestVo.setPageNo(Integer.parseInt(strPageNo));
		requestVo.setPageSize(Integer.parseInt(strPageSize));

		PageInfoResponse<NormProdAndKeyAttrRes> response = DubboConsumerFactory.getService(INormProductSV.class)
				.queryNormProductAndKeyAttr(requestVo);
		log.info("response:"+JSON.toJSONString(response));
		PageInfo<ProductInfo> pageInfo = new PageInfo<ProductInfo>();
		//
		pageInfo.setCount(response.getCount());
		pageInfo.setPageCount(response.getPageCount());
		pageInfo.setPageNo(response.getPageNo());
		pageInfo.setPageSize(response.getPageSize());
		//
		List<ProductInfo> productInfoList = new ArrayList<ProductInfo>();
		//
		ProductInfo productInfo = null;
		for (NormProdAndKeyAttrRes normProdAndKeyAttrRes : response.getResult()) {
			//
			productInfo = new ProductInfo();
			//
			if(null != standedProdIdListResponse && !CollectionUtil.isEmpty(standedProdIdListResponse.getList())){
				for(StandedProdIdVo standedProdIdVo : standedProdIdListResponse.getList()){
					if(normProdAndKeyAttrRes.getProductId().equals(standedProdIdVo.getStandedProdId())){
						productInfo.setDisabled("disabled");
					}
				}
			}
			productInfo.setProductId(normProdAndKeyAttrRes.getProductId());
			productInfo.setProductName(normProdAndKeyAttrRes.getProductName());
			//
			Map<Long, List<AttrValInfo>> hashMap = normProdAndKeyAttrRes.getKeyAttrMap();
			
			//
			Iterator iter = hashMap.entrySet().iterator();
			//
			List<AttrInfo> attrOne = new ArrayList<AttrInfo>();
			List<AttrInfo> attrTwo = new ArrayList<AttrInfo>();
			//
			int i = 0;
			AttrInfo attrInfo = null;
			while (iter.hasNext()) {
				i++;
				//
				if(i >= 3){
					break;
				}
				//
				Map.Entry entry = (Map.Entry) iter.next();
				// Object key = entry.getKey();
				// Object val = entry.getValue();
				//
				List<AttrValInfo> attrValInfoList = (List<AttrValInfo>) entry.getValue();
				for (AttrValInfo attrValInfo : attrValInfoList) {
					attrInfo = new AttrInfo();
					attrInfo.setAttrValue(attrValInfo.getAttrVal());
					//
					if (i == 1) {
						attrOne.add(attrInfo);
					}
					if (i == 2) {
						attrTwo.add(attrInfo);
					}
				}
				
			}
			//
			String attrOneStr = null;
			String attrTwoStr = null;
			
			if(attrOne.size() > 0){
				String[] arr1 = new String[attrOne.size()];
				int attrOneIndex = 0;
				for(AttrInfo attrOneVo : attrOne){
					attrOneIndex ++;
					arr1[attrOneIndex - 1] = attrOneVo.getAttrValue();
				}
				//
				attrOneStr = StringUtils.arrayToDelimitedString(arr1, "、");
			}
			if(attrTwo.size() > 0){
				String[] arr2 = new String[attrTwo.size()];
				int attrTwoIndex = 0;
				for(AttrInfo attrTwoVo : attrTwo){
					attrTwoIndex ++;
					arr2[attrTwoIndex - 1] = attrTwoVo.getAttrValue();
				}
				//
				attrTwoStr = StringUtils.arrayToDelimitedString(arr2, "、");
			}
			//
			productInfo.setAttrOneStr(attrOneStr);
			productInfo.setAttrTwoStr(attrTwoStr);
			productInfo.setAttrOne(attrOne);
			productInfo.setAttrTwo(attrTwo);
			productInfo.setProductCatId(normProdAndKeyAttrRes.getProductCatId());
			//
			productInfoList.add(productInfo);
		}
		//
		pageInfo.setResult(productInfoList);
		
		ResponseData<PageInfo<ProductInfo>> responseData;
		responseData = new ResponseData<PageInfo<ProductInfo>>(ResponseData.AJAX_STATUS_SUCCESS,
				"success", pageInfo);
		log.info("response normProd:" + JSON.toJSONString(response));

		return responseData;
	}
	
	@RequestMapping(value = "/addRouteProdSupplyList", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String addRouteProdSupplyList(HttpServletRequest request){
		//
		String flag = "true";
		SelProdInfo selProdInfo = RequestParameterUtils.request2Bean(request, SelProdInfo.class);
		List<RouteProdSupplyAddRequest> list = JSON.parseArray(selProdInfo.getJsonProdList(), RouteProdSupplyAddRequest.class);
		
		RouteProdSupplyAddListRequest requestVo = new RouteProdSupplyAddListRequest();
		//
		requestVo.setRouteProdSupplyAddRequestList(list);
		//
		DubboConsumerFactory.getService(IRouteProdSupplyManageSV.class).addRouteProdSupplyList(requestVo);
		
		return flag;
	}
	@RequestMapping(value = "/queryProductCatList", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public ProductCatIdListResponse queryProductCatList(HttpServletRequest request){
		//
		RouteProdSupplyRouteIdRequest requestVo = RequestParameterUtils.request2Bean(request, RouteProdSupplyRouteIdRequest.class);
		//
		ProductCatIdListResponse response = DubboConsumerFactory.getService(IRouteProdSupplyManageSV.class).queryProductCatList(requestVo);
		
		return response;
	}
}
