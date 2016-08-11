<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<meta name="decorator" content="mgmt">
<title>仓库商品列表</title>
</head>
<body>
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
							<ul>
								<li class="col-md-6">
									<p class="word">仓库ID:</p>
									<p>38374912000</p>

								</li>
								<li class="col-md-6">
									<p class="word">仓库名称:</p>
									<p>大汉三通移动流量仓库 </p>

								</li>
							</ul>

							<ul>
								<li class="col-md-6">
									<p class="word">商品ID:</p>
									<p>
										<input name="" class="int-text int-medium " type="text" />
									</p>

								</li>
								<li class="col-md-6">
									<p class="word">商品名称:</p>
									<p>
										<input name="" class="int-text int-medium " type="text" />
									</p>
									<p>
										<input type="button"
											class="biu-btn  btn-primary btn-blue btn-medium ml-10"
											value="搜索" data-toggle="modal" data-target="#saveModal">
									</p>
								</li>
							</ul>
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
								<input type="button"
									class="biu-btn  btn-primary btn-blue btn-auto  ml-5"
									value="类目1">
								<input type="button"
									class="biu-btn  btn-primary btn-blue btn-auto  ml-5"
									value="类目2">
								<input type="button"
									class="biu-btn  btn-primary btn-blue btn-auto  ml-5"
									value="类目3">
								
								<!-- <input type="button"
									class="biu-btn  btn-primary btn-blue btn-auto  ml-5"
									value="删  除"> -->
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
											<th>商品名称</th>
											<th>剩余供货量</th>
											<th>累计供货量</th>
											<th>供货量管理</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>1</td>
											<td>111</td>
											<td>中国电信100元充值卡（慢充）</td>
											<td>1000</td>
											<td>1000</td>
											<td><a href="#" data-toggle="modal" data-target="#amountModal">增加仓储量</a></td>
											<td><a href="#">仓储量变更记录</a></td>
										</tr>
										<tr>
											<td>1</td>
											<td>111</td>
											<td>中国电信100元充值卡（慢充）</td>
											<td>1000</td>
											<td>1000</td>
											<td><a href="#" data-toggle="modal" data-target="#amountModal">增加仓储量</a></td>
											<td><a href="#">仓储量变更记录</a></td>
										</tr>
										<tr>
											<td>1</td>
											<td>111</td>
											<td>中国电信100元充值卡（慢充）</td>
											<td>1000</td>
											<td>1000</td>
											<td><a href="#" data-toggle="modal" data-target="#amountModal">增加仓储量</a></td>
											<td><a href="#">仓储量变更记录</a></td>
										</tr>
										<tr>
											<td>1</td>
											<td>111</td>
											<td>中国电信100元充值卡（慢充）</td>
											<td>1000</td>
											<td>1000</td>
											<td><a href="#" data-toggle="modal" data-target="#amountModal">增加仓储量</a></td>
											<td><a href="#">仓储量变更记录</a></td>
										</tr>

									</tbody>
								</table>
							</div>
							<!--/table表格结束-->
							<!--分页-->
							<div class="paging">
								<ul class="pagination">
									<li class="disabled"><a href="#"><i
											class="fa fa-chevron-left"></i></a></li>
									<li class="active"><a href="#">1</a></li>
									<li><a href="#">2</a></li>
									<li><a href="#">3</a></li>
									<li><a href="#">4</a></li>
									<li><a href="#">5</a></li>
									<li><a href="#"><i class="fa fa-chevron-right"></i></a></li>
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
						<div class="panel panel-info">
							<div class="panel-heading">
								<h3 class="panel-title">仓储量</h3>
							</div>
							<div class="panel-body">
								<input name="" class="int-text int-medium " type="text" />
							</div>
						</div>

					</div>
				</div>
				<div class="modal-footer">
					<button type="button"
						class="biu-btn  btn-primary btn-blue btn-medium ml-10"
						data-dismiss="modal">关闭</button>
					<button onclick="javascript:alert('保存成功');" type="button"
						class="biu-btn  btn-primary btn-blue btn-medium ml-10">
						确认</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
	<!-- 模态框（Modal） 结束-->

</body>
</html>
