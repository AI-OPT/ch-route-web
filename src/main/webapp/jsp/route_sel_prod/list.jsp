<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>仓库选择商品列表</title>
<%@include file="/inc/inc.jsp"%>
<script type="text/javascript">
	var routeId = "${param.routeId}";
	var tenantId = "changhong";
	var pager;
	(function() {
		seajs.use('app/jsp/route_sel_prod/list', function(ListPager) {
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
									<input type="hidden" name="command.productCatId" value="">
									<ul>
										<li class="col-md-6">
											<p class="word">仓库ID</p>
											<p>${param.routeId}</p>

										</li>
										<li class="col-md-6">
											<p class="word">仓库名称</p>
											<p>${param.routeName}</p>

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
								<h2 class="pull-left"></h2>
							</header>
							<!--标题结束-->
							<div class="row">
								<!--删格化-->
								<p class="left ml-30">
									<input type="button"
										class="biu-btn  btn-primary btn-blue btn-auto  ml-5"
										value="确  认" onclick="pager._addRouteProdSupplyList();">
									
								</p>
							</div>
							<div class="main-box-body clearfix">
								<!--table表格-->
								<div class="table-responsive clearfix">
									<table class="table table-hover table-border table-bordered">
										<thead>
											<tr>
												<th><input type="checkbox" id="chkSel" name="chkSel" onclick="pager._chkSel();"/>选择</th>
												<th>商品ID</th>
												<th>商品名称</th>
												<th>关键属性1</th>
												<th>关键属性2</th>
												<th>供货数量</th>

											</tr>

										</thead>
										<tbody id="table_info_id_pay_id">
											<!-- <tr>
												<td><input type="checkbox" id="chk" name="chk" onclick="pager._chkSelOnclick(this)" value="1"/></td>
												<td>商品ID</td>
												<td>商品名称</td>
												<td>关键属性1</td>
												<td>关键属性2</td>
												<td id="amount_1">供货数量</td>
											</tr>
											<tr>
												<td><input type="checkbox" id="chk" name="chk" onclick="pager._chkSelOnclick(this)" value="2"/></td>
												<td>商品ID</td>
												<td>商品名称</td>
												<td>关键属性1</td>
												<td>关键属性2</td>
												<td>供货数量</td>
											</tr>
											<tr>
												<td><input type="checkbox" id="chk" name="chk" onclick="pager._chkSelOnclick(this)" value="3"/></td>
												<td>商品ID</td>
												<td>商品名称</td>
												<td>关键属性1</td>
												<td>关键属性2</td>
												<td>供货数量</td>
											</tr>
											<tr>
												<td><input type="checkbox" id="chk" name="chk" onclick="pager._chkSelOnclick(this)" value="4"/></td>
												<td>商品ID</td>
												<td>商品名称</td>
												<td>关键属性1</td>
												<td>关键属性2</td>
												<td>供货数量</td>
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
									</ul>
 -->
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
												<td><input type="checkbox" id="chk" name="chk" onclick="pager._chkSelOnclick(this)" value="{{:productId}}"/></td>
												<td>{{:productId}}</td>
												<td>{{:productName}}</td>
												<td>
												{{for attrOne}}
													
														{{:attrValue}} 
													
												{{/for}}
												</td>
												<td>
													{{for attrTwo}}
													
														{{:attrValue}} 
													
													{{/for}}
												</td>
												<td>--</td>
											</tr>
						{{/for}}
					  </script>
</html>

