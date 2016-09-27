package com.ai.ch.route.web.controller.routetargetarea;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ai.ch.route.web.bean.TargetAreaInfo;
import com.ai.ch.route.web.utils.RequestParameterUtils;
import com.ai.opt.base.vo.BaseListResponse;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.util.CollectionUtil;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.slp.product.api.product.interfaces.IProductSV;
import com.ai.slp.product.api.product.param.ProdTargetAreaInfo;
import com.ai.slp.product.api.product.param.ProductInfoQuery;
import com.ai.slp.route.api.routeitemmanage.interfaces.IRouteItemManageSV;
import com.ai.slp.route.api.routeitemmanage.param.RouteGroupIdQueryRequest;
import com.ai.slp.route.api.routeitemmanage.param.RouteItemListResponse;
import com.ai.slp.route.api.routeitemmanage.param.RouteItemVo;
import com.ai.slp.route.api.routetargetarea.interfaces.IRouteTargetAreaSV;
import com.ai.slp.route.api.routetargetarea.param.AreaAddListRequest;
import com.ai.slp.route.api.routetargetarea.param.AreaAddListResponse;
import com.ai.slp.route.api.routetargetarea.param.AreaAddVo;
import com.ai.slp.route.api.routetargetarea.param.AreaDeleteByRouteAreaIdRequest;
import com.ai.slp.route.api.routetargetarea.param.AreaDeleteByRouteAreaIdResponse;
import com.ai.slp.route.api.routetargetarea.param.AreaDeleteByRouteItemIdRequest;
import com.ai.slp.route.api.routetargetarea.param.AreaQueryByRouteItemIdListRequest;
import com.ai.slp.route.api.routetargetarea.param.AreaQueryByRouteItemIdRequest;
import com.ai.slp.route.api.routetargetarea.param.AreaQueryByRouteItemIdResponse;
import com.ai.slp.route.api.routetargetarea.param.AreaQueryByRouteItemIdVo;
import com.alibaba.fastjson.JSON;

@RequestMapping(value="/routetargetarea")
@RestController
public class RouteTargetAreaController {
	private static final Logger log = LoggerFactory.getLogger(RouteTargetAreaController.class);
	/**
	 * 根据租户id和routeItemId列表查询所有区域信息
	 * @param request
	 * @return
	 * @author zhangzd
	 * @ApiDocMethod
	 * @ApiCode
	 */
	public AreaQueryByRouteItemIdResponse queryAreaByRouteItemIds(HttpServletRequest request){
		String tenantId = request.getParameter("tenantId");
		String[] routeItemIds = request.getParameterValues("routeItemIds");
		//
		List<String> routeItemIdList = new ArrayList<String>();
		for(String routeItemId : routeItemIds){
			routeItemIdList.add(routeItemId);
		}
		AreaQueryByRouteItemIdListRequest requestVo = new AreaQueryByRouteItemIdListRequest();
		requestVo.setTenantId(tenantId);
		requestVo.setRouteItemIdList(routeItemIdList);
		//
		AreaQueryByRouteItemIdResponse response = DubboConsumerFactory.getService(IRouteTargetAreaSV.class).queryAreaListByRouteItemIdList(requestVo);
		//
		return response;
	}
	/**
	 * 根据租户id和routeItemId查询所有区域信息
	 * @param request
	 * @return
	 * @author zhangzd
	 * @ApiDocMethod
	 * @ApiCode
	 */
	public AreaQueryByRouteItemIdResponse queryAreaByRouteItemId(HttpServletRequest request){
		String tenantId = request.getParameter("tenantId");
		String routeItemId = request.getParameter("routeItemId");
		//
		AreaQueryByRouteItemIdRequest requestVo = new AreaQueryByRouteItemIdRequest();
		requestVo.setTenantId(tenantId);
		requestVo.setRouteItemId(routeItemId);
		//
		AreaQueryByRouteItemIdResponse response = DubboConsumerFactory.getService(IRouteTargetAreaSV.class).queryAreaListByRouteItemId(requestVo);
		//
		return response;
	}
	
	@RequestMapping(value="/queryAreaInfosOfProduct",method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public List<TargetAreaInfo> queryAreaInfosOfProduct(HttpServletRequest request){
		String routeItemId = request.getParameter("routeItemId");
		//
		ProductInfoQuery productInfoQuery = RequestParameterUtils.request2Bean(request, ProductInfoQuery.class);
		String tenantId = productInfoQuery.getTenantId();
		//
		BaseListResponse<ProdTargetAreaInfo> response = DubboConsumerFactory.getService(IProductSV.class).queryAreaInfosOfProduct(productInfoQuery);
		//
		log.info("response:"+JSON.toJSONString(response));
		log.info("response 排除前的区域大小:"+response.getResult().size());
		
		//ResponseData<BaseListResponse<ProdTargetAreaInfo>> responseData = new ResponseData<BaseListResponse<ProdTargetAreaInfo>>(ResponseData.AJAX_STATUS_SUCCESS, "success",response); 
		//
		
		//1.根据routeGroupid查询出routeItemList
		RouteGroupIdQueryRequest routeGroupIdQueryRequest = RequestParameterUtils.request2Bean(request, RouteGroupIdQueryRequest.class);
		//
		RouteItemListResponse routeItemListResponse = DubboConsumerFactory.getService(IRouteItemManageSV.class).queryRouteItemList(routeGroupIdQueryRequest);
		//
		if(null != routeItemListResponse && !CollectionUtil.isEmpty(routeItemListResponse.getVoList())){
			
			for(int i=0;i<routeItemListResponse.getVoList().size();i++){
				if(routeItemListResponse.getVoList().get(i).getRouteItemId() == routeItemId || routeItemListResponse.getVoList().get(i).getRouteItemId().equals(routeItemId)){
					routeItemListResponse.getVoList().remove(i);
				}
			}
			log.info("排除后的routeItemId列表："+JSON.toJSONString(routeItemListResponse));
			log.info("排除后的routeItemId列表大小："+routeItemListResponse.getVoList().size());
		}
		
		//2.根据排除后查询的routeItemidList查询相应的区域集合
		AreaQueryByRouteItemIdListRequest areaQueryByRouteItemIdListRequest = new AreaQueryByRouteItemIdListRequest();
		areaQueryByRouteItemIdListRequest.setTenantId(tenantId);
		//
		List<String> routeItemIdStrList = new ArrayList<String>();
		//
		List<RouteItemVo> routeItemVoList = routeItemListResponse.getVoList();
		if(!CollectionUtil.isEmpty(routeItemVoList)){
			for(RouteItemVo routeItemVo : routeItemVoList){
				routeItemIdStrList.add(routeItemVo.getRouteItemId());
			}
		}
		
		//
		areaQueryByRouteItemIdListRequest.setRouteItemIdList(routeItemIdStrList);
		//
		AreaQueryByRouteItemIdResponse areaQueryByRouteItemIdResponse =  DubboConsumerFactory.getService(IRouteTargetAreaSV.class).queryAreaListByRouteItemIdList(areaQueryByRouteItemIdListRequest);
		
		//3.获得排除后的区域信息列表
		List<ProdTargetAreaInfo> prodTargetAreaInfoList = response.getResult();
		if(!CollectionUtil.isEmpty(prodTargetAreaInfoList)){
			for(int i=0;i< prodTargetAreaInfoList.size();i++){
				boolean flag = this.routeItemIdInTargetArea(prodTargetAreaInfoList.get(i).getAreaCode(), areaQueryByRouteItemIdResponse);
				if(flag){
					response.getResult().remove(i);
				}
			}
		}
		log.info("response 排除后的区域大小:"+response.getResult().size());
		
		//4.查询当前选中的仓库下已经配置的区域信息,拼装后返回
		AreaQueryByRouteItemIdRequest areaQueryByRouteItemIdRequestSingle = new AreaQueryByRouteItemIdRequest();
		areaQueryByRouteItemIdRequestSingle.setTenantId(tenantId);
		areaQueryByRouteItemIdRequestSingle.setRouteItemId(routeItemId);
		//
		AreaQueryByRouteItemIdResponse areaQueryByRouteItemIdResponseSigle = DubboConsumerFactory.getService(IRouteTargetAreaSV.class).queryAreaListByRouteItemId(areaQueryByRouteItemIdRequestSingle);
		//
		List<TargetAreaInfo> targetAreaInfoList = new ArrayList<TargetAreaInfo>();
		TargetAreaInfo targetAreaInfo = null;
		for(int i=0;i<response.getResult().size();i++){
			//
			targetAreaInfo = new TargetAreaInfo();
			//
			targetAreaInfo.setAreaCode(response.getResult().get(i).getAreaCode());
			targetAreaInfo.setAreaName(response.getResult().get(i).getAreaName());
			boolean flag = this.routeItemIdInTargetArea(response.getResult().get(i).getAreaCode(), areaQueryByRouteItemIdResponseSigle);
			if(flag){
				targetAreaInfo.setChecked("checked");
			}
			//
			targetAreaInfoList.add(targetAreaInfo);
		}
		return targetAreaInfoList;
	}
	/**
	 * 判断商品域的区域是否在配货组下的仓库域已经选择
	 * @param routeItemId
	 * @param areaQueryByRouteItemIdResponse
	 * @return
	 * @author zhangzd
	 * @ApiDocMethod
	 * @ApiCode
	 */
	public boolean routeItemIdInTargetArea(String areaCode,AreaQueryByRouteItemIdResponse areaQueryByRouteItemIdResponse){
		boolean flag = false;
		if(null != areaQueryByRouteItemIdResponse && !CollectionUtil.isEmpty(areaQueryByRouteItemIdResponse.getVoList())){
			for(int i=0;i<areaQueryByRouteItemIdResponse.getVoList().size();i++){
				if(areaQueryByRouteItemIdResponse.getVoList().get(i).getAreaCode().equals(areaCode) || areaQueryByRouteItemIdResponse.getVoList().get(i).getAreaCode() == areaCode){
					flag = true;
					break;
				}
			}
		}
		return flag;
		
	}
	@RequestMapping(value="/addTargetAreaToList",method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public AreaAddListResponse addTargetAreaToList(HttpServletRequest request){
		String tenantId = request.getParameter("tenantId");
		String[] provCodes = request.getParameterValues("provCodes");
		String routeItemId = request.getParameter("routeItemId");
		
		//删除当前routeItemId下的区域信息
		this.deleteAreaByRouteItemId(tenantId, routeItemId);
		//
		AreaAddListRequest requestVo = new AreaAddListRequest();
		List<AreaAddVo> voList = new ArrayList<AreaAddVo>();
		AreaAddVo vo = null;
		for(String provCode : provCodes){
			vo = new AreaAddVo();
			//
			vo.setOperId("1");
			vo.setProvCode(provCode);
			vo.setRouteItemId(routeItemId);
			vo.setState("1");
			vo.setTenantId(tenantId);
			//
			voList.add(vo);
		}
		//
		requestVo.setVoList(voList);
		//
		AreaAddListResponse response = DubboConsumerFactory.getService(IRouteTargetAreaSV.class).addTargetAreaToList(requestVo);
		//
		return response;
	}
	/**
	 * 删除区域信息
	 * @param tenantId
	 * @param routeItemId
	 * @author zhangzd
	 * @ApiDocMethod
	 * @ApiCode
	 */
	public void deleteAreaByRouteItemId(String tenantId,String routeItemId){
		AreaDeleteByRouteItemIdRequest request = new AreaDeleteByRouteItemIdRequest();
		//
		request.setRouteItemId(routeItemId);
		request.setTenantId(tenantId);
		//
		DubboConsumerFactory.getService(IRouteTargetAreaSV.class).deleteByRouteItemId(request);
		//
	}
	@RequestMapping(value="/deleteAreaByRouteAreaId",method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public AreaDeleteByRouteAreaIdResponse deleteAreaByRouteAreaId(HttpServletRequest request){
		AreaDeleteByRouteAreaIdRequest requestVo = RequestParameterUtils.request2Bean(request, AreaDeleteByRouteAreaIdRequest.class);
		//
		AreaDeleteByRouteAreaIdResponse response = DubboConsumerFactory.getService(IRouteTargetAreaSV.class).deleteByRouteAreaId(requestVo);
		//
		log.info("response:"+JSON.toJSONString(response));
		return response;
	}
}
