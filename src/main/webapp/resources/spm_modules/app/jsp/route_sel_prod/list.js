define('app/jsp/route_sel_prod/list', function (require, exports, module) {
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
    		this._getTableObj();
    	},
    	_getTableObj:function(){
    		//JSON.stringify(ids);
//    		alert($('tbody').html());
//    		var o={};
//    		o.tbody=$('tbody').html();
//    		alert(o);
//    		alert(JSON.stringify(o));
    		
    		//
    		var prodArray = new Array();
    		
    		//totalUsers.pop();
    		//
    		var html = '';  
	        $('#table_info_id_pay_id').find('tr').each(function () {
	        	//
	        	var prodInfo = new Object();
	        	//判断是否选中
	        	var chkSel = $(this).children(":first").children(":first").prop('checked');
	        	if(chkSel){
	        	$(this).find('td').each(function () {
	            	//
	            	if($(this).index() == 0){
	            		var val = $(this).children(":first").val();
	            		//alert('checkedbox val:'+val);
	            		prodInfo.chkId = val;
	            	}
	            	if($(this).index() == 1){
	            		prodInfo.prodId = $(this).text();
	            	}
	            	if($(this).index() == 2){
	            		prodInfo.prodName = $(this).text();
	            	}
	            	if($(this).index() == 5){
	            		prodInfo.amount = $(this).children(":first").val();
	            	}
	            	//
//	            	alert("当前td的序号："+$(this).index());
//	                html += $(this).text() + ',';  
	            });
	        	
	            prodArray.push(prodInfo);
	        	}
	            
	        });
	        
	        alert(JSON.stringify(prodArray));
    	},
    	_chkSel:function(){
    		var _this = this;
    		if($('#chkSel').prop('checked')){
    			$("input:checkbox[name='chk']").prop('checked',true);
    			
    		}else{
    			$("input:checkbox[name='chk']").prop('checked',false);
    		}
    		
    		//
    		_this._inputText();
    		//
    		_this._getTableObj();
    		
    	},
    	_chkSelOnclick:function(obj){
    		var _this = this;
    		//alert('obj:'+obj);
    		if(obj.checked){
    			$(obj).prop('checked',true);
    		}else{
    			$(obj).prop('checked',false);
    		}
    		//
    		_this._inputText();
    		//
    		_this._getTableObj();
    	},
    	//转变为文本框
    	_inputText:function(){
    		
    		$('#table_info_id_pay_id').find('tr').each(function () {
	        	//默认无文本框模式
    			$(this).find('td').each(function () {
	            	
	            	if($(this).index() == 5){
	            		var inputHtml = "--";
	            		$(this).html(inputHtml);
	            	}
	            	//
	            });
    			
    			
	        	//判断是否选中
	        	var chkSel = $(this).children(":first").children(":first").prop('checked');
	        	if(chkSel){
		        	$(this).find('td').each(function () {
		            	
		            	if($(this).index() == 5){
		            		var inputHtml = "<input type='text' class='int-text int-medium' />";
		            		$(this).html(inputHtml);
		            	}
		            	//
		            });
	        	}
	            
    		});
    	}
    	
    });
    
    module.exports = ListPager
});

