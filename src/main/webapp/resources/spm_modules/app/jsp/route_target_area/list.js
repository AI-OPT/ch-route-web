define('app/jsp/route_target_area/list', function (require, exports, module) {
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
    require("bootstrap/js/modal");
    
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
    		//alert('queryParam：'+data);
    		//
    		$("#pagination").runnerPagination({
				url: _base+"/routeitemmanage/queryPageSearch?"+data,
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
    	_queryAreaInfosOfProduct:function(){
    		var data = $("#queryForm").serialize();
    		//alert(data);
    		//
    		ajaxController.ajax({
					type: "POST",
					dataType: "json",
					processing: true,
					message: "请等待...",
					contentType:"application/x-www-form-urlencoded:charset=UTF-8",
					url: _base+"/routetargetarea/queryAreaInfosOfProduct?"+data,
					data:"",
					success: function(data){
						//alert(JSON.stringify(data));
						var htmlOut = "";
						for(var i=0;i<data.length;i++){
							//alert(data.result[i].areaName);
							if(i % 5 == 0){
									htmlOut += "<tr>";
							}
							var checkedAttr = '';
							if(data[i].checked == 'checked'){
								checkedAttr = "checked = checked";
							}
							htmlOut+='<td style="text-align:left;"><div style="padding-left:10px;"><input type="checkbox" '+checkedAttr+' name="provCodes" value="'+data[i].areaCode+'" />'+data[i].areaName+'</div></td>'
							/*if(i%4 == 0 && i > 0){
								htmlOut += "</tr>";
							}*/
						}
						
//						var template = $.templates("#targetAreaTmpl");
//						var htmlOut = template.render(data.result);
						
						$("#targetAreaId").html(htmlOut);
						//alert($('#targetAreaId').html());
					}
				}
			);
    	},
    	_editTargetArea:function(tenantId,routeItemId){
    		var _this = this;
    		//
    		$('#targetAreaForm input[name=tenantId]').val(tenantId);
    		$('#targetAreaForm input[name=routeItemId]').val(routeItemId);
    		//
    		$('#queryForm input[name=routeItemId]').val(routeItemId);
    		
    		$('#editModal').modal('show');
    		//
    		_this._queryAreaInfosOfProduct();
    	},
    	_addTargetAreaToList:function(){
    		var _this = this;
    		var data = $("#targetAreaForm").serialize();
    		//alert(data);
    		//
    		ajaxController.ajax({
					type: "POST",
					dataType: "json",
					processing: true,
					message: "请等待...",
					contentType:"application/x-www-form-urlencoded:charset=UTF-8",
					url: _base+"/routetargetarea/addTargetAreaToList?"+data,
					data:"",
					success: function(data){
						if(data.responseHeader.resultCode == '000000'){
							//alert('分配区域成功');
							var d = Dialog({
								content:'分配区域成功',
								icon:'success',
								okValue: '确 定',
								ok:function(){
									this.close();
								}
							});
							d.show();
							//
							_this._queryPageSearch();
						}else{
							//alert('分配区域失败');
							var d = Dialog({
								content:'分配区域失败',
								icon:'fail',
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
    	_deleteAreaByRouteAreaId:function(tenantId,routeAreaId){
    		var _this = this;
    		//
    		var data = "command.tenantId="+tenantId+"&command.routeAreaId="+routeAreaId;
    		ajaxController.ajax({
					type: "POST",
					dataType: "json",
					processing: true,
					message: "请等待...",
					contentType:"application/x-www-form-urlencoded:charset=UTF-8",
					url: _base+"/routetargetarea/deleteAreaByRouteAreaId?"+data,
					data:"",
					success: function(data){
						if(data.responseHeader.resultCode == '000000'){
							//alert('删除区域成功');
							var d = Dialog({
								content:'删除区域成功',
								icon:'success',
								okValue: '确 定',
								ok:function(){
									this.close();
								}
							});
							d.show();
							//
							_this._queryPageSearch();
						}else{
							//alert('删除区域失败');
							var d = Dialog({
								content:'删除区域失败',
								icon:'fail',
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
    	}
      	
      	
    	
    });
    
    module.exports = ListPager
});

