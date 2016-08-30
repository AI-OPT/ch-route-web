package com.ai.ch.route.web.controller.areaquery;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.platform.common.api.area.interfaces.IGnAreaQuerySV;
import com.ai.platform.common.api.area.param.GnAreaVo;
import com.alibaba.fastjson.JSON;

@RequestMapping(value="/areaquery")
@RestController
public class AreaQueryController {
	private static final Logger log = LoggerFactory.getLogger(AreaQueryController.class);
	//
	@RequestMapping(value="/getProvinceList",method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public List<GnAreaVo> getProvinceList(HttpServletRequest request){
		List<GnAreaVo> list = DubboConsumerFactory.getService(IGnAreaQuerySV.class).getProvinceList();
		//
		log.info("provinceList:"+JSON.toJSONString(list));
		return list;
	}
	//
	@RequestMapping(value="/getCityListByProviceCode",method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public List<GnAreaVo> getCityListByProviceCode(HttpServletRequest request){
		String provinceCode = request.getParameter("provinceCode");
		//
		List<GnAreaVo> list = DubboConsumerFactory.getService(IGnAreaQuerySV.class).getCityListByProviceCode(provinceCode);
		//
		log.info("cityList:"+JSON.toJSONString(list));
		return list;
	}
	//
	@RequestMapping(value="/getCountyListByCityCode",method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public List<GnAreaVo> getCountyListByCityCode(HttpServletRequest request){
		String cityCode = request.getParameter("cityCode");
		//
		List<GnAreaVo> list = DubboConsumerFactory.getService(IGnAreaQuerySV.class).getCountyListByCityCode(cityCode);
		//
		log.info("cityCode:"+JSON.toJSONString(list));
		return list;
	}
}
