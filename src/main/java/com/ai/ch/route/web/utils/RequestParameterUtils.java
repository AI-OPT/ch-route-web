package com.ai.ch.route.web.utils;

import java.util.Map;

import javax.servlet.ServletRequest;

/**
 * 请求工具类--实现泛型实现map2bean
 *
 */
public class RequestParameterUtils {
	
	/**
	 * 参数转换
	 */
	public static <T> T request2Bean(ServletRequest request, Class<T> beanClass){
		Map<String,String> map = ParameterMapUtils.getCommandParametersMap(request);
		//
		return MapBeanUtils.map2Bean(map,beanClass);
	}

}
