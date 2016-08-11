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
import com.alibaba.fastjson.JSON;

@RestController
public class RouteManageController {
	private static final Logger log = LoggerFactory.getLogger(RouteManageController.class);
	@RequestMapping(value="/routemanage/routeAdd",method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String addRoute(HttpServletRequest request){
		String flag = "true";
		RouteAddParamRequest routeAddParamRequest = RequestParameterUtils.request2Bean(request, RouteAddParamRequest.class);
		//
		DubboConsumerFactory.getService(IRouteManageSV.class).addRoute(routeAddParamRequest);
		
		return flag;
	}
//	@RequestMapping(value="/account/queryAccountBalanceDetailList",method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
//	@ResponseBody
//	public ResponseData<PageInfo<ChargeBaseInfo>> queryAccountBalanceDetailList(HttpServletRequest request) {
//		String strPageNo=(null==request.getParameter("pageNo"))?"1":request.getParameter("pageNo");
//        String strPageSize=(null==request.getParameter("pageSize"))?"10":request.getParameter("pageSize");
//		//
//        String busiType = request.getParameter("busiType");
//        //
//        String selectDateId = request.getParameter("selectDateId");
//        log.info("selectDateId:"+selectDateId);
//        //
//		String startTime = request.getParameter("startTime");
//		String endTime = request.getParameter("endTime");
//		log.info("startTime:"+startTime);
//		log.info("endTime:"+endTime);
//        //
//		ResponseData<PageInfo<ChargeBaseInfo>> responseData;
//		//
//		ChargeInfoQueryByAcctIdParam chargeInfoQueryByAcctIdParam = new ChargeInfoQueryByAcctIdParam();
//		SLPClientUser user = this.getUserInfo(request);
//		chargeInfoQueryByAcctIdParam.setAccountId(user.getAcctId());//(new Long(ACCOUNT_ID));
//		chargeInfoQueryByAcctIdParam.setTenantId(user.getTenantId());//(TENANT_ID);
//		//
//		if(!StringUtil.isBlank(busiType)){
//			chargeInfoQueryByAcctIdParam.setBusiType(busiType);
//		}
//		PageInfo<ChargeBaseInfo> chargeBaseInfoPageInfo = new PageInfo<ChargeBaseInfo>();
//		chargeBaseInfoPageInfo.setPageNo(Integer.valueOf(strPageNo));
//		chargeBaseInfoPageInfo.setPageSize(Integer.valueOf(strPageSize));
//		chargeInfoQueryByAcctIdParam.setPageInfo(chargeBaseInfoPageInfo);
//		//
//		
//		//快速检索 近三个月  近一个月 近七天 
//		if(!StringUtil.isBlank(selectDateId)){
//			//
//			Map<String,String> time = new HashMap<String,String>();
//			if(selectDateId.startsWith("MONTH_")){
//				String monthAmount = selectDateId.replace("MONTH_", "");
//				time = DateUtil.getTimeInterval(Calendar.MONTH, Integer.valueOf(monthAmount));
//			}
//			//
//			if(selectDateId.startsWith("DAY_")){
//				String dayAmount = selectDateId.replace("DAY_", "");
//				time = DateUtil.getTimeInterval(Calendar.DATE, Integer.valueOf(dayAmount));
//			}
//			log.info("selectDate startTime:"+time);
//			//
//			if(!selectDateId.startsWith("ALL")){
//				chargeInfoQueryByAcctIdParam.setStartTime(Timestamp.valueOf(time.get(DateUtil.KEY_START_TIME)));
//				chargeInfoQueryByAcctIdParam.setEndTime(Timestamp.valueOf(time.get(DateUtil.KEY_END_TIME)));
//			}
//		}else{
//			//如果开始时间和结束时间不为空
//			if(!StringUtil.isBlank(startTime) && !StringUtil.isBlank(endTime)){
//				chargeInfoQueryByAcctIdParam.setStartTime(DateUtil.getTimestamp(startTime+" 00:00:00",DateUtil.DATETIME_FORMAT));
//				chargeInfoQueryByAcctIdParam.setEndTime(DateUtil.getTimestamp(endTime+" 23:59:59",DateUtil.DATETIME_FORMAT));
//			}else{
//				//默认查询7天前的记录
//				Map<String,String> time = new HashMap<String,String>();
//				time = DateUtil.getTimeInterval(Calendar.DATE, 7);
//				log.info("selectDate default startTime:"+time);
//				chargeInfoQueryByAcctIdParam.setStartTime(Timestamp.valueOf(time.get(DateUtil.KEY_START_TIME)));
//				chargeInfoQueryByAcctIdParam.setEndTime(Timestamp.valueOf(time.get(DateUtil.KEY_END_TIME)));
//			}
//		}
//		
//		//
//		PageInfo<ChargeBaseInfo> pageInfo = DubboConsumerFactory.getService(IPaymentQuerySV.class).queryChargeBaseInfoByAcctId(chargeInfoQueryByAcctIdParam);
//		//
//		pageInfo = this.getChargeBaseInfoPageInfo(pageInfo);
//		//
//		log.info(" queryAccountBalanceDetailList json:"+JSON.toJSONString(pageInfo));
//		//
//		responseData = new ResponseData<PageInfo<ChargeBaseInfo>>(ResponseData.AJAX_STATUS_SUCCESS,"success",pageInfo);
//		//
//		log.info(" ResponseData json:"+JSON.toJSONString(responseData));
//		//
//		return responseData;
//    }
//	
	
}
