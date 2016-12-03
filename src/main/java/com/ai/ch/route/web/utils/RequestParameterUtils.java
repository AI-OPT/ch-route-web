package com.ai.ch.route.web.utils;

import java.util.Map;

import javax.servlet.ServletRequest;

/**
 * Request工具类
 *
 */
public class RequestParameterUtils {

	public static <T> T request2Bean(ServletRequest request, Class<T> beanClass){
		Map<String,String> map = ParameterMapUtils.getCommandParametersMap(request);
		//
		return MapBeanUtils.map2Bean(map,beanClass);
	}

}
