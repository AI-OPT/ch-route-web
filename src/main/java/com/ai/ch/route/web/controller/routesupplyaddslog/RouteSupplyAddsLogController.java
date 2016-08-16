package com.ai.ch.route.web.controller.routesupplyaddslog;

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
import com.ai.slp.route.api.routesupplyaddslog.interfaces.IRouteSupplyAddsLogManageSV;
import com.ai.slp.route.api.routesupplyaddslog.param.RouteSupplyAddsLogPageSearchRequest;
import com.ai.slp.route.api.routesupplyaddslog.param.RouteSupplyAddsLogPageSearchResponse;
import com.ai.slp.route.api.routesupplyaddslog.param.RouteSupplyAddsLogPageSearchVo;
import com.alibaba.fastjson.JSON;

@RequestMapping(value="/routesupplyaddslog")
@RestController
public class RouteSupplyAddsLogController {

private static final Logger log = LoggerFactory.getLogger(RouteSupplyAddsLogController.class);
	
	@RequestMapping(value="/queryPageSearch",method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public ResponseData<PageInfo<RouteSupplyAddsLogPageSearchVo>> queryPageSearch(HttpServletRequest request) {
		//
		String strPageNo=(null==request.getParameter("pageNo"))?"1":request.getParameter("pageNo");
        String strPageSize=(null==request.getParameter("pageSize"))?"10":request.getParameter("pageSize");
		
        RouteSupplyAddsLogPageSearchRequest requestVo = RequestParameterUtils.request2Bean(request, RouteSupplyAddsLogPageSearchRequest.class);
        //
        requestVo.setPageNo(Integer.parseInt(strPageNo));
        requestVo.setPageSize(Integer.parseInt(strPageSize));
        //
        RouteSupplyAddsLogPageSearchResponse response = DubboConsumerFactory.getService(IRouteSupplyAddsLogManageSV.class).queryPageSearch(requestVo);
        PageInfo<RouteSupplyAddsLogPageSearchVo> pageInfo = response.getPageInfo();
        //
		ResponseData<PageInfo<RouteSupplyAddsLogPageSearchVo>> responseData;
		//
		responseData = new ResponseData<PageInfo<RouteSupplyAddsLogPageSearchVo>>(ResponseData.AJAX_STATUS_SUCCESS,"success",pageInfo);
		//
		log.info(" ResponseData json:"+JSON.toJSONString(responseData));
		//
		return responseData;
	}

}
