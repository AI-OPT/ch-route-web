<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>配货组下仓库列表(某商品)</title>
<%@include file="/inc/inc.jsp"%>
<script type="text/javascript">
	var pager;
	(function() {
	seajs.use('app/jsp/route_item/list', function(ListPager) {
		pager = new ListPager({
			element : document.body
		});
		pager.render();
	});
	})(); 
</script>
</head>
<body>
	<div class="content-wrapper-iframe">
		<!--框架标签结束-->
		<div class="row">
			<!--外围框架-->
			<div class="col-lg-12">
				<!--删格化-->
				<div class="row">
					<!--内侧框架-->
					<div class="col-lg-12">
						<!--删格化-->
						<div class="main-box clearfix">
							<!--白色背景-->
							<!--查询条件-->
							<div class="form-label">
								<form id="queryForm">
									<input name="command.routeGroupId" type="hidden" value="${param.routeGroupId }"/>
									<ul>
										<li class="col-md-6">
											<p class="word">配货组ID:</p>
											<p>
												${param.routeGroupId }
											</p>
											
										</li>
										<li class="col-md-6">
											<p class="word">配货组名称:</p>
											<p>
												${param.routeGroupName }
											</p>

										</li>

									</ul>
									<ul>
										<li class="col-md-6">
											<p class="word">关联商品ID:</p>
											<p>
												${param.standedProdId }
											</p>
											
										</li>
										<li class="col-md-6">
											<p class="word">商品名称:</p>
											<p>
												${param.standedProdName }
											</p>

										</li>

									</ul>
									<ul>
										<li class="col-md-6">
											<p class="word">销售地域:</p>
											<p>
												北上广
											</p>
											
										</li>
										
									</ul>
								</form>
							</div>
							<!--查询结束-->
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--框架标签结束-->
		<div class="row">
			<!--外围框架-->
			<div class="col-lg-12">
				<!--删格化-->
				<div class="row">
					<!--内侧框架-->
					<div class="col-lg-12">
						<!--删格化-->
						<div class="main-box clearfix">
							<!--白色背景-->
							<!--标题-->
							<header class="main-box-header clearfix">
								<h2 class="pull-left">组下仓库</h2>
							</header>
							<!--标题结束-->
							
							<div class="main-box-body clearfix">
								<!--table表格-->
								<div class="table-responsive clearfix">
									<table class="table table-hover table-border table-bordered">
										<thead>
											<tr>
												<th>仓库ID</th>
												<th>仓库名称</th>
												<th>可发货区域</th>
												<th>操作</th>

											</tr>

										</thead>
										<tbody id="table_info_id_pay_id">
											
										</tbody>
									</table>
									<div id="showMessageDiv"></div>
								</div>
								<!--/table表格结束-->
								<!--分页-->
								<div class="paging">
									<ul id="pagination">
									</ul>

								</div>
								<!--分页结束-->
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>

	</div>
</body>
<script id="pageSearchTmpl" type="text/x-jsrender">
					  	{{for}}
							<tr>
								<td>{{:routeId}}</td>
								<td>{{:routeName}}</td>
								<td>
									{{for area}}
										{{:provinceName}} 
									{{/for}}
								</td>
								<td>
									<a>删除</a>
								</td>
							</tr>
						{{/for}}
					  </script>
</html>

