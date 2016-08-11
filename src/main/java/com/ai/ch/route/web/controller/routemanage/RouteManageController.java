package com.ai.ch.route.web.controller.routemanage;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ai.ch.route.web.utils.MapBeanUtils;
import com.ai.ch.route.web.utils.ParameterMapUtils;
import com.ai.ch.route.web.utils.RequestParameterUtils;
import com.ai.net.xss.util.StringUtil;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.util.CollectionUtil;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.opt.sso.client.filter.SLPClientUser;
import com.ai.opt.sso.client.filter.SSOClientConstants;
import com.ai.opt.base.vo.PageInfo;
import com.ai.slp.common.api.cache.interfaces.ICacheSV;
import com.ai.slp.common.api.cache.param.SysParam;
import com.ai.slp.common.api.cache.param.SysParamMultiCond;
import com.ai.slp.common.api.cache.param.SysParamSingleCond;
import com.ai.slp.route.api.routemanage.interfaces.IRouteManageSV;
import com.ai.slp.route.api.routemanage.param.RouteAddParamRequest;
import com.ai.slp.route.api.routemanage.param.RoutePageSearchRequest;
import com.ai.slp.route.api.routemanage.param.RoutePageSearchResponse;
import com.ai.slp.route.api.routemanage.param.RoutePageSearchVo;
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
	
	
}
