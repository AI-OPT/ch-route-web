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
    		USER_LEFT_MNU_ID: "route_list_left_menu"
    	},
    	//事件代理
    	events: {
    		//查询
            "click #queryRouteButtonId":"_queryPageSearch"
        },
    	//重写父类
    	setup: function () {
    		ListPager.superclass.setup.call(this);
    		//alert($('#'+ListPager.USER_LEFT_MNU_ID, window.parent.document).html());
    		//$('#'+ListPager.USER_LEFT_MNU_ID, window.parent.document).addClass("list-active");
    		this._queryPageSearch();
    	},
    	_reset:function(){
    		$('#updateRouteFormId')[0].reset();
    		//
    		$('#provinceCode_old').val('');
    		$('#cityCode_old').val('');
    		$('#countyCode_old').val('');
    		//
    		$('#provinceCode').html('');
    		$('#cityCode').html('');
    		$('#countyCode').html('');
    		
    		//
    		this._getProvinceList('');
    	},
    	_edit:function(routeId,routeName,provCode,cityCode,countyCode,address){
    		$('#updateRouteFormId :input[id=routeId]').val(routeId);
    		$('#updateRouteFormId :input[id=routeName]').val(routeName);
    		$('#updateRouteFormId :input[id=address]').val(address);
    		//
    		$('#provinceCode_old').val(provCode);
    		$('#cityCode_old').val(cityCode);
    		$('#countyCode_old').val(countyCode);
    		//
    		this._getProvinceList(provCode);
    		 
    	},
    	_update:function(){
    		//
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
				url: _base+"/routemanage/queryPageSearch?command.tenantId=changhong&"+data,
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
    	},
    	_getProvinceList:function(provCode){
    		
    		var _this = this;
    		
    		ajaxController.ajax({
					type: "POST",
					dataType: "json",
					processing: true,
					message: "请等待...",
					contentType:"application/x-www-form-urlencoded:charset=UTF-8",
					url: _base+"/areaquery/getProvinceList",
					data:"",
					success: function(data){
						//alert(data.length);
						var option ="<option value=''>--请选择--</option>";
						for(var i=0;i<data.length;i++){
							option += "<option value='"+data[i].provinceCode+"'>"+data[i].areaName+"</option>";
						}
						$('#provinceCode').html(option);
						
						//如果省份编码不为空就选中
						if(provCode != ''){
							$("#provinceCode").find("option[value='"+provCode+"']").attr("selected",true);
							//
							_this._getCityListByProviceCode(provCode);
						}
					}
				}
			);
    	},
    	_getCityListByProviceCode:function(provinceCode){
    		if(provinceCode == ""){
    			$('#cityCode').html('');
    			$('#countyCode').html('');
    			return;
    		}
    		var _this = this;
    		//var provinceCode = $(obj).val();
    		ajaxController.ajax({
					type: "POST",
					dataType: "json",
					processing: true,
					message: "请等待...",
					contentType:"application/x-www-form-urlencoded:charset=UTF-8",
					url: _base+"/areaquery/getCityListByProviceCode?provinceCode="+provinceCode,
					data:"",
					success: function(data){
						var option = "<option value=''>--请选择--</option>";
						for(var i=0;i<data.length;i++){
							option += "<option value='"+data[i].cityCode+"'>"+data[i].areaName+"</option>";
						}
						//alert(option);
						$('#cityCode').html(option);
						//
						//如果城市编码不为空就选中
						var cityCode = $('#cityCode_old').val();
						if(cityCode != ''){
							
							$("#cityCode").find("option[value='"+cityCode+"']").attr("selected",true);
							//
							_this._getCountyListByCityCode(cityCode);
						}
					}
				}
			);
    	},
    	_getCountyListByCityCode:function(cityCode){
    		if(cityCode == ""){
    			$('#countyCode').html('');
    			return;
    		}
    		var _this = this;
    		ajaxController.ajax({
					type: "POST",
					dataType: "json",
					processing: true,
					message: "请等待...",
					contentType:"application/x-www-form-urlencoded:charset=UTF-8",
					url: _base+"/areaquery/getCountyListByCityCode?cityCode="+cityCode,
					data:"",
					success: function(data){
						var option = "<option value=''>--请选择--</option>";
						for(var i=0;i<data.length;i++){
							option += "<option value='"+data[i].areaCode+"'>"+data[i].areaName+"</option>";
						}
						//alert(option);
						$('#countyCode').html(option);
						//
						//如果区域编码不为空就选中
						var countyCode = $('#countyCode_old').val();
						if(countyCode != ''){
							$("#countyCode").find("option[value='"+countyCode+"']").attr("selected",true);
						}
						
						//
						var cityCode = $('#cityCode_old').val();
						var citySelCode = $('#cityCode option:selected').val();
						if(citySelCode == ""){
							$("#countyCode").html("<option value=''>--请选择--</option>");
						}
//						var provCode = $('#provinceCode option:selected').val();
//						
//						if(provCode != $('#provinceCode_old').val()){
//							$('#countyCode').html("<option value=''>--请选择--</option>");
//						}
					}
				}
			);
    	},
    	_editState:function(tenantId,routeId,state){
    		$('#updateRouteStateForm_tenantId').val(tenantId);
    		$('#updateRouteStateForm_routeId').val(routeId);
    		$('#updateRouteStateForm_state').val(state);
    		//
    	},
    	_updateRouteState:function(){
    		var data = $("#updateRouteStateForm").serialize();
    		//alert(data);
    		ajaxController.ajax({
				type: "POST",
				dataType: "json",
				processing: true,
				message: "请等待...",
				contentType:"application/x-www-form-urlencoded:charset=UTF-8",
				url: _base+"/routemanage/updateRouteState?"+data,
				data:"",
				success: function(data){
					alert("操作成功");
					location.href=_base+"/jsp/route_manage/list.jsp";
				}
			}
		);
    	}
      	
      	
    	
    });
    
    module.exports = ListPager
});

