define('app/jsp/route_manage/list', function (require, exports, module) {
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
            "click #queryRouteButtonId":"_queryPageSearch"
        },
    	//重写父类
    	setup: function () {
    		ListPager.superclass.setup.call(this);
    		this._queryPageSearch();
    	},
    	_reset:function(){
    		$('#updateRouteFormId')[0].reset();
    	},
    	_edit:function(routeId,routeName,provCode,cityCode,countyCode,address){
    		$('#updateRouteFormId :input[id=routeId]').val(routeId);
    		$('#updateRouteFormId :input[id=routeName]').val(routeName);
    		$('#updateRouteFormId :input[id=address]').val(address);
    	},
    	_update:function(){
    		var data = $("#updateRouteFormId").serialize();
    		var routeId = $('#updateRouteFormId :input[id=routeId]').val();
    		//
    		var operMethod = '';
    		var msg = '';
    		if(routeId != ''){
    			operMethod = "updateRoute";
    			msg = "修改";
    		}else{
    			operMethod = "addRoute";
    			msg = "保存";
    		}
    		
    		ajaxController.ajax({
					type: "POST",
					dataType: "text",
					processing: true,
					message: "请等待...",
					contentType:"application/x-www-form-urlencoded:charset=UTF-8",
					url: _base+"/routemanage/"+operMethod+"?"+data,
					data:"",
					success: function(data){
						if(data == 'true'){
							alert(msg+'成功');
							location.href=_base+"/jsp/route_manage/list.jsp";
						}
						
					}
				}
			);
    	},
    	_queryPageSearch:function(){
    		var data = $("#queryRouteForm").serialize();
    		//alert('queryParam：'+data);
    		//
    		$("#pagination").runnerPagination({
				url: _base+"/routemanage/queryPageSearch?command.tenantId=CH&"+data,
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

