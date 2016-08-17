package com.ai.ch.route.web.controller.routemanage;


import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ai.ch.route.web.utils.RequestParameterUtils;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.opt.base.vo.PageInfo;
import com.ai.slp.route.api.routemanage.interfaces.IRouteManageSV;
import com.ai.slp.route.api.routemanage.param.RouteAddParamRequest;
import com.ai.slp.route.api.routemanage.param.RoutePageSearchRequest;
import com.ai.slp.route.api.routemanage.param.RoutePageSearchResponse;
import com.ai.slp.route.api.routemanage.param.RoutePageSearchVo;
import com.ai.slp.route.api.routemanage.param.RouteUpdateParamRequest;
import com.ai.slp.route.api.routemanage.param.RouteUpdateStateRequest;
import com.alibaba.fastjson.JSON;
@RequestMapping(value="/routemanage")
@RestController
public class RouteManageController {
	private static final Logger log = LoggerFactory.getLogger(RouteManageController.class);
	@RequestMapping(value="/addRoute",method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String addRoute(HttpServletRequest request){
		String flag = "true";
		
		RouteAddParamRequest routeAddParamRequest = RequestParameterUtils.request2Bean(request, RouteAddParamRequest.class);
		//
		log.info("routeName:"+routeAddParamRequest.getRouteName());
		log.info("request:"+JSON.toJSONString(routeAddParamRequest));
		DubboConsumerFactory.getService(IRouteManageSV.class).addRoute(routeAddParamRequest);
		
		return flag;
	}
	@RequestMapping(value="/queryPageSearch",method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public ResponseData<PageInfo<RoutePageSearchVo>> queryPageSearch(HttpServletRequest request) {
		//
		String strPageNo=(null==request.getParameter("pageNo"))?"1":request.getParameter("pageNo");
        String strPageSize=(null==request.getParameter("pageSize"))?"10":request.getParameter("pageSize");
		
        RoutePageSearchRequest routePageSearchRequest = RequestParameterUtils.request2Bean(request, RoutePageSearchRequest.class);
        //
        routePageSearchRequest.setPageNo(Integer.parseInt(strPageNo));
        routePageSearchRequest.setPageSize(Integer.parseInt(strPageSize));
		//
        RoutePageSearchResponse response = DubboConsumerFactory.getService(IRouteManageSV.class).queryPageSearch(routePageSearchRequest);
        PageInfo<RoutePageSearchVo> pageInfo = response.getPageInfo();
        //
		ResponseData<PageInfo<RoutePageSearchVo>> responseData;
		//
		responseData = new ResponseData< PageInfo<RoutePageSearchVo>>(ResponseData.AJAX_STATUS_SUCCESS,"success",pageInfo);
		//
		log.info(" ResponseData json:"+JSON.toJSONString(responseData));
		//
		return responseData;
    }
	@RequestMapping(value="/updateRoute",method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String updateRoute(HttpServletRequest request){
		String flag = "true";
		
		RouteUpdateParamRequest routeUpdateParamRequest = RequestParameterUtils.request2Bean(request, RouteUpdateParamRequest.class);
		//
		log.info("routeName:"+routeUpdateParamRequest.getRouteName());
		log.info("request:"+JSON.toJSONString(routeUpdateParamRequest));
		DubboConsumerFactory.getService(IRouteManageSV.class).updateRoute(routeUpdateParamRequest);
		
		return flag;
	}
	@RequestMapping(value="/updateRouteState",method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String updateRouteState(HttpServletRequest request){
		String flag = "true";
		
		RouteUpdateStateRequest routeUpdateStateRequest = RequestParameterUtils.request2Bean(request, RouteUpdateStateRequest.class);
		//
		log.info("request:"+JSON.toJSONString(routeUpdateStateRequest));
		DubboConsumerFactory.getService(IRouteManageSV.class).updateRouteState(routeUpdateStateRequest);
		
		return flag;
	}
}
