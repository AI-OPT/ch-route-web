<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>仓库商品列表</title>
<%@include file="/inc/inc.jsp"%>
<script type="text/javascript">
	var pager;
	(function() {
		seajs.use('app/jsp/route_prod_supply_manage/list', function(ListPager) {
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
								<ul>
									
									<li class="col-md-6">
										<a href="${_base}/jsp/route_manage/list.jsp"><input type="button"
												class="biu-btn  btn-primary btn-blue btn-medium ml-5"
												value="返  回">
										</a>
									</li>
								</ul>
								<ul>
									<input type="hidden" id="currentPageNo" value="" />
									<input type="hidden" name="command.tenantId" value="changhong" />
									<input type="hidden" name="command.routeId" value="${param.routeId }" />
									<input type="hidden" id="productCatId" name="command.productCatId" value="" />
									<li class="col-md-6">
										<p class="word">仓库ID:</p>
										<p>${param.routeId }</p>

									</li>
									<li class="col-md-6">
										<p class="word">仓库名称:</p>
										<p>${param.routeName}</p>

									</li>
								</ul>

								<ul>
									<li class="col-md-6">
										<p class="word">商品ID:</p>
										<p>
											<!-- <input name="command.supplyId" class="int-text int-medium " type="text" /> -->
											<input name="command.standedProdId" class="int-text int-medium " type="text" />
										</p>

									</li>
									<li class="col-md-6">
										<p class="word">商品名称:</p>
										<p>
											<input name="command.supplyName" class="int-text int-medium " type="text" />
										</p>
										<p>
											<input id="queryButtonId" type="button"
												class="biu-btn  btn-primary btn-blue btn-medium ml-10"
												value="搜索" data-toggle="modal" data-target="#saveModal">
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

							<!--标题结束-->
							<div class="row">
								<!--删格化-->
								<p class="left ml-30">
									<!-- <input type="button"
										class="biu-btn  btn-primary btn-blue btn-auto  ml-5"
										value="类目1"> <input type="button"
										class="biu-btn  btn-primary btn-blue btn-auto  ml-5"
										value="类目2"> <input type="button"
										class="biu-btn  btn-primary btn-blue btn-auto  ml-5"
										value="类目3"> -->
								<div id="productCatListId"></div>
					 <script id="productCatListTmpl" type="text/x-jsrender">
					  	{{for}}
							<input id="{{:productCatId}}" type="button"
										class="biu-btn  btn-primary btn-blue btn-auto  ml-5"
										value="{{:productCatName}}" onclick="pager._productCatFunc(this);">
						{{/for}}
					  </script>
								</p>
							</div>
							<div class="main-box-body clearfix">
								<!--table表格-->
								<div class="table-responsive clearfix">
									<table class="table table-hover table-border table-bordered">
										<thead>
											<tr>
												<th>序号</th>
												<th>商品ID</th>
												<th>供应品ID</th>
												<th>商品名称</th>
												<th>剩余供货量</th>
												<th>累计供货量</th>
												<th>供货量管理</th>
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

		<!-- 模态框（Modal） 开始 -->
		<div class="modal fade" id="amountModal" tabindex="-1" role="dialog"
			aria-labelledby="amountModalLabel" aria-hidden="true">
			<div class="modal-dialog" style="width: 400px;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">增加仓储量</h4>
					</div>
					<div class="modal-body" style="min-height: 120px;">
						<div class="form-label">
							<form id="updateUsableNumForm">
							<div class="panel panel-info">
								<div class="panel-heading">
									<h3 class="panel-title">仓储量</h3>
								</div>
								<div class="panel-body">
									<input id="updateUsableNumForm_supplyId" name="command.supplyId" type="hidden"/>
									<input id="updateUsableNumForm_supplyName" name="command.supplyName" type="hidden"/>
									<input id="updateUsableNumForm_usableNum" name="command.usableNum" maxlength="8" class="int-text int-medium " type="text" />
								</div>
							</div>
							</form>
						</div>
					</div>
					<div class="modal-footer">
						<button onclick="pager._updateUsableNum();" type="button"
							class="biu-btn  btn-primary btn-blue btn-medium ml-10">
							保存</button>
						<button type="button"
							class="biu-btn  btn-primary btn-blue btn-medium ml-10"
							data-dismiss="modal">取消</button>
						
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal -->
		</div>
		<!-- 模态框（Modal） 结束-->
	</div>
</body>
<script id="pageSearchTmpl" type="text/x-jsrender">
					  	{{for}}
						<tr>
							<td>{{:index}}</td>
							<td>{{:standedProdId}}</td>
							<td>{{:supplyId}}</td>
							<td title="{{:supplyName}}">{{:~subStr(10,supplyName)}}</td>
							<td>{{:usableNum}}</td>
							<td>{{:totalNum}}</td>
							<td><a href="#" onclick="pager._openUpdateUsableNumForm('{{:supplyId}}','{{:supplyName}}');">增加仓储量</a></td>
							<td><a href="${_base}/jsp/route_supply_adds_log/list.jsp?supplyId={{:supplyId}}">仓储量变更记录</a></td>
						</tr>
						{{/for}}
					  </script>
</html>
