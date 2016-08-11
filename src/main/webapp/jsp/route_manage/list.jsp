<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<meta name="decorator" content="mgmt">
<title>Document</title>
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
									<p class="word">仓库名称</p>
									<p>
										<input name="control_date" class="int-text int-medium "
											type="text" />
									</p>
									<p>
										<input type="button"
											class="biu-btn  btn-primary btn-blue btn-medium ml-10"
											value="搜  索">
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
						<!--标题-->
						<header class="main-box-header clearfix">
							<h2 class="pull-left">查询结果</h2>
						</header>
						<!--标题结束-->
						<div class="row">
							<!--删格化-->
							<p class="left ml-30">
								<input type="button"
									class="biu-btn  btn-primary btn-blue btn-auto  ml-5"
									value="新  增"> <!-- <input type="button"
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
											<th>状态</th>
											<th>仓库ID</th>
											<th>仓库名称</th>
											<th>所在地区</th>
											<th>仓库下商品</th>
											<th>操作</th>

										</tr>
									</thead>
									<tbody>
										<tr>
											<td>1</td>
											<td>状态</td>
											<td>biu</td>
											<td>分公司</td>
											<td>全国</td>
											<td>总部</td>
											<td><a href="#" data-toggle="modal"
												data-target="#editModal">编辑</a> <a href="#"
												data-toggle="modal" data-target="#stopSureModal">暂停</a><a
												href="#">废弃</a></td>
										</tr>
										<tr>
											<td>2</td>
											<td>状态</td>
											<td>biu</td>
											<td>分公司</td>
											<td>全国</td>
											<td>总部</td>
											<td><a href="#" data-toggle="modal"
												data-target="#editModal">编辑</a> <a href="#"
												data-toggle="modal" data-target="#stopSureModal">暂停</a><a
												href="#">废弃</a></td>
										</tr>
										<tr>
											<td>3</td>
											<td>状态</td>
											<td>biu</td>
											<td>分公司</td>
											<td>全国</td>
											<td>总部</td>
											<td><a href="#" data-toggle="modal"
												data-target="#editModal">编辑</a> <a href="#"
												data-toggle="modal" data-target="#stopSureModal">暂停</a> <a
												href="#">废弃</a></td>
										</tr>
										<tr>
											<td>4</td>
											<td>状态</td>
											<td>biu</td>
											<td>分公司</td>
											<td>全国</td>
											<td>总部</td>
											<td><a href="#" data-toggle="modal"
												data-target="#editModal">编辑</a> <a href="#"
												data-toggle="modal" data-target="#stopSureModal">暂停</a> <a
												href="#">废弃</a></td>
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
	<div class="modal fade" id="editModal" tabindex="-1" role="dialog"
		aria-labelledby="editModalLabel" aria-hidden="true">
		<div class="modal-dialog" style="width: 900px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">编辑仓库信息</h4>
				</div>
				<div class="modal-body" style="min-height: 220px;">
					<div class="form-label">
						<div class="panel panel-info">
							<div class="panel-heading">
								<h3 class="panel-title">仓库信息</h3>
							</div>
							<div class="panel-body">
								<ul>
									<li class="col-md-12">

										<p class="word">仓库名称</p>
										<p>
											<input name="" class="int-text int-medium " type="text" />
										</p>
									</li>
									<li class="col-md-12">
										<p class="word">所在地址</p>
										<p>
											<select id="" name="" class="int-text int-medium ">
												<option value="">北京市</option>
												<option value="">天津市</option>
												<option value="">河北省</option>
											</select> <select id="" name="" class="int-text int-medium ">
												<option value="">北京市</option>
												<option value="">天津市</option>
												<option value="">河北省</option>
											</select> <select id="" name="" class="int-text int-medium ">
												<option value="">北京市</option>
												<option value="">天津市</option>
												<option value="">河北省</option>
											</select>
										</p>
									</li>
									<li class="col-md-12">

										<p class="word">详细地址</p>
										<p>
											<input name="" class="int-text int-medium " type="text" />
										</p>
									</li>
								</ul>
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

	<!-- 模态框（Modal） 开始 -->
	<div class="modal fade" id="stopSureModal" tabindex="-1" role="dialog"
		aria-labelledby="stopSureModalLabel" aria-hidden="true">
		<div class="modal-dialog" style="width: 400px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">提示信息</h4>
				</div>
				<div class="modal-body">您确定要暂停当前仓库吗？</div>
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
