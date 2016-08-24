define('app/jsp/route_item/list', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
    Widget = require('arale-widget/1.2.0/widget'),
    Dialog = require("artDialog/src/dialog"),
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
            //"click #queryRouteButtonId":"_queryPageSearch"
        },
    	//重写父类
    	setup: function () {
    		ListPager.superclass.setup.call(this);
    		this._queryPageSearch();
    	},
    	_queryPageSearch:function(){
    		var data = $("#queryForm").serialize();
    		alert('queryParam：'+data);
    		//
    		$("#pagination").runnerPagination({
				url: _base+"/routeitemmanage/queryPageSearch?command.tenantId=CH&"+data,
				method: "POST",
				dataType: "json",
				processing: true,
				renderId:"table_info_id_pay_id",
				messageId:"showMessageDiv",
				data : {},
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
    	}
      	
      	
    	
    });
    
    module.exports = ListPager
});

