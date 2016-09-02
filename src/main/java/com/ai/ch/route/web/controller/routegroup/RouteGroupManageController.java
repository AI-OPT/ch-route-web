package com.ai.ch.route.web.controller.routegroup;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ai.ch.route.web.bean.ProductInfo;
import com.ai.ch.route.web.utils.RequestParameterUtils;
import com.ai.opt.base.vo.PageInfo;
import com.ai.opt.base.vo.PageInfoResponse;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.slp.product.api.product.interfaces.IProductServerSV;
import com.ai.slp.product.api.product.param.ProductRouteGroupInfo;
import com.ai.slp.product.api.product.param.RouteGroupQuery;
import com.alibaba.fastjson.JSON;

@RequestMapping(value="/routeGroupManage")
@RestController
public class RouteGroupManageController {
	private static final Logger log = LoggerFactory.getLogger(RouteGroupManageController.class);
	//
	@RequestMapping(value="/queryProductAndRouteGroup",method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public ResponseData<PageInfoResponse<ProductRouteGroupInfo>> queryProductAndRouteGroup(HttpServletRequest request){
		//
		String strPageNo = (null == request.getParameter("pageNo")) ? "1" : request.getParameter("pageNo");
		String strPageSize = (null == request.getParameter("pageSize")) ? "10" : request.getParameter("pageSize");

		RouteGroupQuery requestVo = RequestParameterUtils.request2Bean(request, RouteGroupQuery.class);
		//
		requestVo.setPageNo(Integer.parseInt(strPageNo));
		requestVo.setPageSize(Integer.parseInt(strPageSize));
		//
		PageInfoResponse<ProductRouteGroupInfo> response = DubboConsumerFactory.getService(IProductServerSV.class).queryProductAndRouteGroup(requestVo);
		//
		ResponseData<PageInfoResponse<ProductRouteGroupInfo>> responseData;
		responseData = new ResponseData<PageInfoResponse<ProductRouteGroupInfo>>(ResponseData.AJAX_STATUS_SUCCESS,
				"success", response);
		log.info("responseData :" + JSON.toJSONString(response));
		return responseData;

	}

}
