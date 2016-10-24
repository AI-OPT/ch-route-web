define('app/jsp/route_group/list', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
    Widget = require('arale-widget/1.2.0/widget'),
    Dialog = require("optDialog/src/dialog"),
    Paging = require('paging/0.0.1/paging-debug'),
    AjaxController = require('opt-ajax/1.0.0/index');
    require("jsviews/jsrender.min");
    require("jsviews/jsviews.min");
    require("bootstrap-paginator/bootstrap-paginator.min");
    require("app/util/jsviews-ext");
    
    require("opt-paging/aiopt.pagination");
    require("twbs-pagination/jquery.twbsPagination.min");
    var SendMessageUtil = require("app/util/sendMessage");
    
    //实例化AJAX控制处理对象
    var ajaxController = new AjaxController();
    //定义页面组件类
    var ListPager = Widget.extend({
    	
    	Implements:SendMessageUtil,
    	//属性，使用时由类的构造函数传入
    	attrs: {
    	},
    	Statics: {
    		DEFAULT_PAGE_SIZE: 10,
    		USER_LEFT_MNU_ID: "left_mnu_account_balance"
    	},
    	//事件代理
    	events: {
    		//查询
            "click #queryButtonId":"_queryPageSearch"
        },
    	//重写父类
    	setup: function () {
    		ListPager.superclass.setup.call(this);
    		this._queryPageSearch();
    	},
    	_queryPageSearch:function(){
    		var data = $("#queryForm").serialize();
    		//alert('queryParam：'+data);
    		//
    		$("#pagination").runnerPagination({
				url: _base+"/routeGroupManage/queryProductAndRouteGroup?"+data,
				method: "POST",
				dataType: "json",
				processing: true,
				renderId:"table_info_id_pay_id",
				messageId:"showMessageDiv",
				data : "",
				pageSize: 10,
				visiblePages:5,
				message: "正在为您查询数据..",
				render: function (data) {
					
					var template = $.templates("#pageSearchTmpl");
					var htmlOut = template.render(data);
					//alert(data.result);
					$("#table_info_id_pay_id").html(htmlOut);
					
				}
			});
    	},
    	_insertRouteGroup:function(tenantId,standedProdId,standedProdName,routeGroupId,productId){
    		//
    		//alert('standedProdId:'+standedProdId+" length:"+standedProdId.length);
    		var data = encodeURI("command.tenantId="+tenantId+"&command.standedProdName="+standedProdName+"&command.standedProdId="+standedProdId+"&command.routeGroupId="+routeGroupId+"&command.productId="+productId);
    		var url = _base+"/routeGroupManage/insertRouteGroup?"+data
    		var dataJson = {"tenantId":tenantId,"standedProdName":encodeURI(standedProdName),"standedProdId":standedProdId,"routeGroupId":routeGroupId,"productId":productId};
    		//alert(JSON.stringify(dataJson));
    		//alert(data);
    		var _this = this;
    		//
    		ajaxController.ajax({
					type: "POST",
					dataType: "json",
					processing: true,
					message: "请等待...",
					contentType:"application/x-www-form-urlencoded:charset=UTF-8",
					url: url,
					data:dataJson,
					success: function(data){
						var responseHeader = data.responseHeader;
						if(responseHeader.resultCode == '000000'){
							/*alert('操作成功');
							_this._queryPageSearch();*/
							location.href= encodeURI(_base+"/jsp/route_target_area/list.jsp?routeGroupId="+data.routeGroupId+"&standedProdId="+standedProdId+"&standedProdName="+standedProdName+"&productId="+productId);
						}else{
							var d = Dialog({
								content:responseHeader.resultMessage,
								icon:'fail',
								okValue: '确 定',
								ok:function(){
									this.close();
								}
							});
							d.show();
							//alert(responseHeader.resultMessage);
						}
						
					}
				}
			);
    	},
    	_detailInfo:function(routeGroupId,standedProdId,standedProdName){
    		//alert(encodeURI(_base+"/jsp/route_item/list.jsp?routeGroupId="+routeGroupId+"&standedProdId="+standedProdId+"&standedProdName="+standedProdName+"&routeGroupName="+standedProdName+"-配货组"));
    		location.href = encodeURI(_base+"/jsp/route_item/list.jsp?routeGroupId="+routeGroupId+"&standedProdId="+standedProdId+"&standedProdName="+standedProdName+"&routeGroupName="+standedProdName+"-配货组");
    	}
      	
    	
    });
    
    module.exports = ListPager
});

