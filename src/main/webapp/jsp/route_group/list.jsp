<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>配货组列表</title>
<%@include file="/inc/inc.jsp"%>
<script type="text/javascript">
	var pager;
	(function() {
	seajs.use('app/jsp/route_group/list', function(ListPager) {
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
									<input type="hidden" name="command.tenantId" value="changhong">
									<input type="hidden" name="command.supplierId" value="-1">
									<ul>
										<li class="col-md-6">
											<p class="word">商品名称</p>
											<p>
												<input name="command.standedProdName" class="int-text int-medium "
													type="text" />
											</p>

										</li>
										<li class="col-md-6">
											<p class="word">商品ID</p>
											<p>
												<input name="command.standedProdId" class="int-text int-medium "
													type="text" />
											</p>

										</li>
										<li class="col-md-6">
											<p class="word">配货组ID</p>
											<p>
												<input name="command.routeGroupId" class="int-text int-medium "
													type="text" />
											</p>
											<p>
												<input id="queryButtonId" type="button"
													class="biu-btn  btn-primary btn-blue btn-medium ml-10"
													value="搜  索">
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
								<h2 class="pull-left">配货组商品列表</h2>
							</header>
							<!--标题结束-->
							
							<div class="main-box-body clearfix">
								<!--table表格-->
								<div class="table-responsive clearfix">
									<table class="table table-hover table-border table-bordered">
										<thead>
											<tr>
												<th>序号</th>
												<th>商品ID</th>
												<th>商品名称</th>
												<th>配货组ID</th>
												<!-- <th>状态</th> -->
												<th>操作</th>

											</tr>

										</thead>
										<tbody id="table_info_id_pay_id">
											<!-- <tr>
												<td>1</td>
												<td>1</td>
												<td>1</td>
												<td>1</td>
												<td>1</td>
												<td>
													<a>查看</a>
													<a>分配仓库配货</a>
													<a>删除</a>
												</td>
											</tr>
											<tr>
												<td>1</td>
												<td>1</td>
												<td>1</td>
												<td>1</td>
												<td>1</td>
												<td>
													<a>查看</a>
													<a>分配仓库配货</a>
													<a>删除</a>
												</td>
											</tr>
											<tr>
												<td>1</td>
												<td>1</td>
												<td>1</td>
												<td>1</td>
												<td>1</td>
												<td>
													<a>查看</a>
													<a>分配仓库配货</a>
													<a>删除</a>
												</td>
											</tr>
											<tr>
												<td>1</td>
												<td>1</td>
												<td>1</td>
												<td>1</td>
												<td>1</td>
												<td>
													<a>查看</a>
													<a>分配仓库配货</a>
													<a>删除</a>
												</td>
											</tr>
											<tr>
												<td>1</td>
												<td>1</td>
												<td>1</td>
												<td>1</td>
												<td>1</td>
												<td>
													<a>查看</a>
													<a>分配仓库配货</a>
													<a>删除</a>
												</td>
											</tr> -->
											
										</tbody>
									</table>
									<div id="showMessageDiv"></div>
								</div>
								<!--/table表格结束-->
								<!--分页-->
								<div class="paging">
									<ul id="pagination">
									</ul>
									<!-- <ul class="pagination">
										<li class="disabled"><a href="#"><i
												class="fa fa-chevron-left"></i></a></li>
										<li class="active"><a href="#">1</a></li>
										<li><a href="#">2</a></li>
										<li><a href="#">3</a></li>
										<li><a href="#">4</a></li>
										<li><a href="#">5</a></li>
										<li><a href="#"><i class="fa fa-chevron-right"></i></a></li>
									</ul> -->

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
					  	
						<tr>
							<td>{{:#index+1}}</td>
												<td>{{:standedProdId}} <!--{{:productId}}--></td>
												<td title="{{:standedProdName}}">{{:~subStr(10,standedProdName)}}</td>
												<td>{{:routeGroupId}}</td>
												<!-- <td>{{:state}}</td> -->
												
												{{if state=="1" || state=="2" || state=="3"}}
												<td>
													<a href="javascript:void(0);" onclick="pager._detailInfo('{{:routeGroupId}}','{{:standedProdId}}','{{:standedProdName}}');">查看</a>
													<a href="javascript:void(0);" onclick="pager._insertRouteGroup('changhong','{{:standedProdId}}','{{:standedProdName}}','{{:routeGroupId}}','{{:productId}}')">分配仓库配货</a>
												</td>
												{{else}}
												<td>
													<a href="javascript:void(0);" onclick="pager._detailInfo('{{:routeGroupId}}','{{:standedProdId}}','{{:standedProdName}}');">查看</a>
												</td>
												{{/if}}
						</tr>
						
					  </script>
</html>

