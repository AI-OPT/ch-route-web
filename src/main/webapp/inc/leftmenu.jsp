<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<script type="text/javascript">
	var pager;
	(function () {
		seajs.use('app/inc/leftmenu', function (LeftMenuPager) {
			pager = new LeftMenuPager({element: document.body});
			pager.render();
		});
	})();
</script>
<!--左侧菜单-->
<div id="nav-col">
	<section id="col-left" class="col-left-nano">
		<div id="col-left-inner" class="col-left-nano-content">
			<div class="collapse navbar-collapse navbar-ex1-collapse"
				id="sidebar-nav">
				<ul class="nav nav-pills nav-stacked">

					<li><!-- 一级菜单--> <a href="#" class="dropdown-toggle"> <i
							class="fa fa-inbox"></i><span>仓库管理</span> <i
							class="fa fa-chevron-circle-right drop-icon"></i>
					</a> <!-- 一级菜单结束--> <!--二级菜单-->
						<ul class="submenu">
							<li menuAttr="menu"><a href="${_base}/jsp/route_manage/add.jsp" target="mainFrame">新建仓库</a></li>
							<li menuAttr="menu"><a href="${_base}/jsp/route_manage/list.jsp" target="mainFrame">仓库列表</a></li>
							<li menuAttr="menu"><a href="${_base}/jsp/route_supply_adds_log/list.jsp" target="mainFrame">仓储量更改记录列表</a></li>
							<li menuAttr="menu"><a href="${_base}/jsp/route_group/list.jsp" target="mainFrame">配货组列表</a></li>
							<!-- <li menuAttr="menu"><a href="#" class="dropdown-toggle">服务器对接管理3<i
									class="fa fa-chevron-circle-right drop-icon"></i></a>
								<ul class="submenu three-list">
									<li menuAttr="threemenu" class="three-list-active"><a href="#">新建路由</a></li>
									<li menuAttr="threemenu"><a href="#">添加路由规则</a></li>
									<li menuAttr="threemenu"><a href="#">新增预警接收人</a></li>
								</ul> 
							</li> -->

						</ul> <!--二级菜单结束--></li>

				</ul>
			</div>
		</div>
	</section>
</div>
<!--/左侧菜单结束-->