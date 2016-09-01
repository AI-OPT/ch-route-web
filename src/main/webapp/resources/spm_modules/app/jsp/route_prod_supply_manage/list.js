define('app/jsp/route_prod_supply_manage/list', function (require, exports, module) {
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
            "click #queryButtonId":"_queryPageSearch"
        },
    	//重写父类
    	setup: function () {
    		ListPager.superclass.setup.call(this);
    		this._queryPageSearch();
    	},
    	_openUpdateUsableNumForm:function(supplyId,supplyName,usableNum){
    		var _this = this;
    		//
    		$('#updateUsableNumForm_supplyId').val(supplyId);
    		$('#updateUsableNumForm_supplyName').val(supplyName);
    		$('#updateUsableNumForm_usableNum').val('');
    		//
    		$('#amountModal').modal('show');
    		$('#updateUsableNumForm_usableNum').bind('input propertychange', function() {
    			//alert($(this).val());
    			var flag = _this._numberValidate($(this).val());
    			//alert(flag);
    			//
    			if(flag == false){
    				$(this).val("1");
    				alert('请输入正整数,如果您输入其他字符，默认为1');
    			}
    		});
    	},
    	_updateUsableNum:function(){
    		$('#amountModal').modal('hide');
    		var _this = this;
    		var data = $("#updateUsableNumForm").serialize();
    		var usableNum = $('#updateUsableNumForm_usableNum').val();
    		if(usableNum == ''){
    			alert("请输入仓储量");
    			return;
    		}
    		//
    		var flag = _this._numberValidate(usableNum);
    		if(flag == false){
    			$('#updateUsableNumForm_usableNum').val("1");
				alert('请输入正整数,如果您输入其他字符，默认为1');
				return;
    		}
    		//
    		ajaxController.ajax({
					type: "POST",
					dataType: "json",
					processing: true,
					message: "请等待...",
					contentType:"application/x-www-form-urlencoded:charset=UTF-8",
					url: _base+"/routeprodsupplymanage/updateUsableNum?"+data,
					data:"",
					success: function(data){
						var responseHeader = data.responseHeader;
						if(responseHeader.resultCode == '000000'){
							alert('操作成功');
							//location.href=_base+"/jsp/route_prod_supply_manage/list.jsp";
							var currentPageNo = $('#currentPageNo').val();
							_this._queryPageSearch(currentPageNo);
						}else{
							alert(responseHeader.resultMessage);
						}
						
					}
				}
			);
    	},
    	_queryPageSearch:function(currentPageNo){
    		var data = $("#queryForm").serialize();
    		
    		if(currentPageNo != undefined && typeof currentPageNo != 'object'){
    			data+=data+"&pageNo="+currentPageNo;
    		}
    		//alert('queryParam：'+data);
    		//
    		$("#pagination").runnerPagination({
				url: _base+"/routeprodsupplymanage/queryPageSearch?"+data,
				method: "POST",
				dataType: "json",
				processing: true,
				renderId:"table_info_id_pay_id",
				messageId:"showMessageDiv",
				data:{},
				pageSize: 10,
				visiblePages:5,
				message: "正在为您查询数据..",
				render: function (data) {
					
					var template = $.templates("#pageSearchTmpl");
					var htmlOut = template.render(data);
					//alert(data.result);
					$("#table_info_id_pay_id").html(htmlOut);
					
				},
				callback: function(data){
					$('#currentPageNo').val(data.pageNo);
					
				}
			});
    	},
    	_numberValidate:function(str){
    		var t = str;
    		var z= /^[0-9]*$/;
    		if(z.test(t)){
    		   return true;
    		}else{
    		   return false;
    		};
    	}
    	
      	
    	
    });
    
    module.exports = ListPager
});

