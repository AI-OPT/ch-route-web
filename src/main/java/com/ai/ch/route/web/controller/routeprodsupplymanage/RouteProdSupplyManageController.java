package com.ai.ch.route.web.controller.routeprodsupplymanage;

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
import com.ai.slp.route.api.routeprodsupplymanage.interfaces.IRouteProdSupplyManageSV;
import com.ai.slp.route.api.routeprodsupplymanage.param.RouteProdSupplyPageSearchRequest;
import com.ai.slp.route.api.routeprodsupplymanage.param.RouteProdSupplyPageSearchResponse;
import com.ai.slp.route.api.routeprodsupplymanage.param.RouteProdSupplyPageSearchVo;
import com.alibaba.fastjson.JSON;

@RequestMapping(value="/routeprodsupplymanage")
@RestController
public class RouteProdSupplyManageController {
	private static final Logger log = LoggerFactory.getLogger(RouteProdSupplyManageController.class);
	
	@RequestMapping(value="/queryPageSearch",method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public ResponseData<PageInfo<RouteProdSupplyPageSearchVo>> queryPageSearch(HttpServletRequest request) {
		//
		String strPageNo=(null==request.getParameter("pageNo"))?"1":request.getParameter("pageNo");
        String strPageSize=(null==request.getParameter("pageSize"))?"10":request.getParameter("pageSize");
		
        RouteProdSupplyPageSearchRequest requestVo = RequestParameterUtils.request2Bean(request, RouteProdSupplyPageSearchRequest.class);
        //
        requestVo.setPageNo(Integer.parseInt(strPageNo));
        requestVo.setPageSize(Integer.parseInt(strPageSize));
        //
        RouteProdSupplyPageSearchResponse response = DubboConsumerFactory.getService(IRouteProdSupplyManageSV.class).queryPageSearch(requestVo);
        PageInfo<RouteProdSupplyPageSearchVo> pageInfo = response.getPageInfo();
        //
		ResponseData<PageInfo<RouteProdSupplyPageSearchVo>> responseData;
		//
		responseData = new ResponseData<PageInfo<RouteProdSupplyPageSearchVo>>(ResponseData.AJAX_STATUS_SUCCESS,"success",pageInfo);
		//
		log.info(" ResponseData json:"+JSON.toJSONString(responseData));
		//
		return responseData;
	}

}
