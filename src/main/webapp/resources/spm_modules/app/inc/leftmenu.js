define('app/inc/leftmenu',function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
    Widget = require('arale-widget/1.2.0/widget');
    //定义页面组件类
    var LeftMenuPager = Widget.extend({
    	//属性，使用时由类的构造函数传入
    	attrs: {
    		activemenu: "m_home"
    	},
    	//事件代理
    	events: {
        },
    	//重写父类
    	setup: function () {
    		LeftMenuPager.superclass.setup.call(this);
    		this._onActive();
    		this._onActiveThree();
    		
    	},
    	_onActive:function(){
    		var _this = this;
    		
			$("li [menuAttr='menu']").each(function(){
    			//
                $(this).click(function(i){
                		
                		//执行二级清空
	                	$("li [menuAttr='menu']").each(function(){
	                		$(this).removeClass("list-active");
	                	});
                		
                		$(this).addClass("list-active");
                		//
                		//_this._noActiveThree();
                		
                	
                });

    		});
    			
    			
    	},
    	_onActiveThree:function(){
    		$("li [menuAttr='threemenu']").each(function(){
    			//
                $(this).click(function(i){
	                	$("li [menuAttr='threemenu']").each(function(){
	                		$(this).removeClass("three-list-active");
	                	});
                		
                		$(this).addClass("three-list-active");
                	
                });

    		});
    	},
    	_noActiveThree:function(){
    		$("li [menuAttr='threemenu']").each(function(){
        		$(this).removeClass("three-list-active");
        	});
    	},
    	//当activemenu属性的值发生变化时候触发
    	_onRenderActivemenu: function(activemenu) {
    		if(activemenu==undefined || activemenu==""){
    			 activemenu="m_home";
    		}
    		$("#"+activemenu).addClass("active");
    	 },
    });
    
    module.exports = LeftMenuPager
});

