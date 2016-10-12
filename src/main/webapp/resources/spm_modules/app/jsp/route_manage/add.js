define('app/jsp/route_manage/add', function (require, exports, module) {
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
    require("app/util/aiopt-validate-ext");
    require("jquery-validation/1.15.1/jquery.validate");
    
    require("opt-paging/aiopt.pagination");
    require("twbs-pagination/jquery.twbsPagination.min");
    require("bootstrap/js/modal");
    var SendMessageUtil = require("app/util/sendMessage");
    
    //实例化AJAX控制处理对象
    var ajaxController = new AjaxController();
    //定义页面组件类
    var AddPager = Widget.extend({
    	
    	Implements:SendMessageUtil,
    	//属性，使用时由类的构造函数传入
    	attrs: {
    	},
    	Statics: {
    		DEFAULT_PAGE_SIZE: 10,
    		USER_LEFT_MNU_ID: "route_add_left_menu"
    	},
    	//事件代理
    	events: {
    		//查询
            //"click #BTN_SEARCH":"_search",
            "click #addRouteId":"_addRoute"
        },
    	//重写父类
    	setup: function () {
    		AddPager.superclass.setup.call(this);
    		this._getProvinceList();
    		var formValidator=this._addFormValidate();
			$(":input").bind("focusout",function(){
				formValidator.element(this);
			});
			
    		
    	},
    	_validateDialog:function(msg){
    		$('#validateModal').modal('show');
    		$('#validateMsgId').html(msg);
    	},
    	_addRouteFormValidate:function(){
    		var _this = this;
    		//
    		var routeName = $('#routeName').val();
    		var provinceCode = $('#provinceCode').val();
    		var cityCode = $('#cityCode').val();
    		var countyCode = $('#countyCode').val();
    		var address = $('#address').val();
    		//
    		if(routeName == ''){
    			_this._validateDialog('仓库名称不能为空');
    			return false;
    		}
    		if(routeName.length > 45){
    			_this._validateDialog('仓库名称的长度不能超过45个字符');
    			return false;
    		}
    		if(provinceCode == ''){
    			_this._validateDialog('请选择一级地区');
    			return false;
    		}
    		if(cityCode == ''){
    			_this._validateDialog('请选择二级地区');
    			return false;
    		}
    		if(countyCode == ''){
    			_this._validateDialog('请选择三级地区');
    			return false;
    		}
    		if(address == ''){
    			_this._validateDialog('请填写详细地址');
    			return false;
    		}
    		if(address.length > 50){
    			_this._validateDialog('详细地址不能超过50个字符');
    			return false;
    		}
    		return true;
    		
    	},
    	_addFormValidate:function(){
//    		var routeName = $('#routeName').val();
//    		var provinceCode = $('#provinceCode').val();
//    		var cityCode = $('#cityCode').val();
//    		var countyCode = $('#countyCode').val();
//    		var address = $('#address').val();
    		//
    		var formValidator=$("#addRouteForm").validate({
    			rules: {
    				"command.routeName": {
    					required:true,
    					maxlength:45,
    					minlength:1,
    					commonText:true
    				},
    				"command.provCode": {
    					required:true
    				},
    				"command.cityCode": {
    					required:true
    				},
    				"command.countyCode": {
    					required:true
    				},
    				"command.address": {
    					required:true,
    					maxlength:50,
    					minlength:1,
    					commonText:true
    				}
    				
    			},
    			messages: {
    				"command.routeName": {
    					required:"请输入仓库名称",
    					maxlength:"最大长度不能超过{0}",
    					minlength:"最小长度不能小于{0}",
    					commonText:"只允许输入中文、英文、_+()"
    				},
    				"command.provCode": {
    					required:"请选择一级地区"
    				},
    				"command.cityCode": {
    					required:"请选择二级地区"
    				},
    				"command.countyCode": {
    					required:"请选择三级地区"
    				},
    				"command.address": {
    					required:"请输入地址信息",
    					maxlength:"最大长度不能超过{0}",
    					minlength:"最小长度不能小于{0}",
    					commonText:"只允许输入中文、英文、_+()"
    				}
    			}
    		});
    		
    		return formValidator;
    	},
    	_addRoute:function(){
    		var _this = this;
    		//
    		/*var flag = _this._addRouteFormValidate();
    		if(flag == false){
    			return;
    		}*/
    		var formValidator=_this._addFormValidate();
			formValidator.form();
			if(!$("#addRouteForm").valid()){
				return;
			}
    		//
    		var data = $("#addRouteForm").serialize();
    		//alert(data);
    		ajaxController.ajax({
					type: "POST",
					dataType: "text",
					processing: true,
					message: "请等待...",
					contentType:"application/x-www-form-urlencoded:charset=UTF-8",
					url: _base+"/routemanage/addRoute?"+data,
					data:"",
					success: function(data){
						if(data == 'true'){
							//alert('保存成功');
							var d = Dialog({
								content:"保存成功",
								icon:'success',
								okValue: '确 定',
								ok:function(){
									this.close();
								}
							});
							d.show();
						}
						
					}
				}
			);
    	},
    	_getProvinceList:function(){

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
						var option = "<option value=''>--请选择--</option>";
						for(var i=0;i<data.length;i++){
							option += "<option value='"+data[i].provinceCode+"'>"+data[i].areaName+"</option>";
						}
						$('#provinceCode').html(option);
					}
    				
				}
			);
    	},
    	_getCityListByProviceCode:function(provinceCode){
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
						
					}
				}
			);
    	},
    	_getCountyListByCityCode:function(cityCode){

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
						
						
					}
				}
			);
    	}
      	
    	
    });
    
    module.exports = AddPager
});

