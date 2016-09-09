package com.ai.ch.route.web.controller.routeitemmanage;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ai.ch.route.web.utils.RequestParameterUtils;
import com.ai.opt.base.vo.PageInfo;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.slp.route.api.routeitemmanage.interfaces.IRouteItemManageSV;
import com.ai.slp.route.api.routeitemmanage.param.RouteGroupIdRequest;
import com.ai.slp.route.api.routeitemmanage.param.RouteItemDeleteByRouteItemIdRequest;
import com.ai.slp.route.api.routeitemmanage.param.RouteItemDeleteByRouteItemIdResponse;
import com.ai.slp.route.api.routeitemmanage.param.RouteItemPageSearchResponse;
import com.ai.slp.route.api.routeitemmanage.param.RouteItemResponse;
import com.ai.slp.route.api.routemanage.param.RoutePageSearchVo;
import com.alibaba.fastjson.JSON;

@RequestMapping(value = "/routeitemmanage")
@RestController
public class RouteItemManageController {
	private static final Logger log = LoggerFactory.getLogger(RouteItemManageController.class);

	@RequestMapping(value = "/queryPageSearch", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public ResponseData<PageInfo<RouteItemResponse>> queryPageSearch(HttpServletRequest request) {
		//
		//
		String strPageNo = (null == request.getParameter("pageNo")) ? "1" : request.getParameter("pageNo");
		String strPageSize = (null == request.getParameter("pageSize")) ? "10" : request.getParameter("pageSize");

		//
		RouteGroupIdRequest requestVo = RequestParameterUtils.request2Bean(request, RouteGroupIdRequest.class);
		//
		requestVo.setPageNo(Integer.parseInt(strPageNo));
		requestVo.setPageSize(Integer.parseInt(strPageSize));
		//
		RouteItemPageSearchResponse response = DubboConsumerFactory.getService(IRouteItemManageSV.class)
				.queryPageInfo(requestVo);
		//
		PageInfo<RouteItemResponse> pageInfo = response.getPageInfo();
		//
		ResponseData<PageInfo<RouteItemResponse>> responseData;
		//
		responseData = new ResponseData<PageInfo<RouteItemResponse>>(ResponseData.AJAX_STATUS_SUCCESS, "success",
				pageInfo);
		//
		log.info(" ResponseData json:" + JSON.toJSONString(responseData));
		//
		return responseData;
	}
	@RequestMapping(value = "/deleteByRouteItemId", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public RouteItemDeleteByRouteItemIdResponse deleteByRouteItemId(HttpServletRequest request) {
		RouteItemDeleteByRouteItemIdRequest requestVo = RequestParameterUtils.request2Bean(request, RouteItemDeleteByRouteItemIdRequest.class);
		
		RouteItemDeleteByRouteItemIdResponse response = DubboConsumerFactory.getService(IRouteItemManageSV.class).deleteByRouteItemId(requestVo);
		//
		return response;
	}
}
