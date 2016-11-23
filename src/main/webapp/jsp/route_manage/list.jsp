<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>仓库列表</title>
<%@include file="/inc/inc.jsp"%>
<script type="text/javascript">
	var pager;
	(function() {
		seajs.use('app/jsp/route_manage/list', function(ListPager) {
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
								<form id="queryRouteForm">
									<ul>
										<li class="col-md-6">
											<p class="word">仓库名称：</p>
											<p>
												<input name="command.routeName" class="int-text int-medium "
													type="text" />
											</p>
											<p>
												<input id="queryRouteButtonId" type="button"
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
                            	<h2 class="pull-left">仓库列表</h2>
                            </header>
							<!--标题结束-->
							<div class="row">
								<!--删格化-->
								<p class="right pr-30">
									<input type="button"
										class="biu-btn  btn-primary btn-blue btn-auto  ml-5"
										value="新  增" onclick="pager._reset();">
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
												<th>状态</th>
												<th>仓库ID</th>
												<th>仓库名称</th>
												<th>所在地区</th>
												<th>仓库下商品</th>
												<th>选择商品</th>
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

		<!-- 模态框（Modal） 开始 -->
		
		<div class="eject-big" >
		<div class="eject-medium" id="increase-samll">
		<!--编辑-->
		<div class="modal-header">
<!-- 		<div class="eject-medium-title"> -->
		<button type="button" class="close" data-dismiss="modal" onclick="pager._closeEditDiv();"
							aria-hidden="true">&times;</button>
            <p>编辑仓库信息</p>
            <!-- <p id="upCloseImg" class="img"><i class="fa fa-times"></i></p> -->
        </div>
		<div class="form-label">
		<form id="updateRouteFormId">
			<ul>
				<li class="col-md-12"><input type="hidden" id="tenantId"
					name="command.tenantId" value="changhong" /> <input type="hidden"
					id="routeId" name="command.routeId" value="" />
					<p class="word"><span>*</span>仓库名称</p>
					<p>
						<input name="command.routeName" id="routeName"
							class="int-text int-medium " type="text" onkeyup="this.value=this.value.replace(/^\s+|\s+$/g,'')" />
					</p></li>
				<li class="col-md-12">
					<p class="word"><span>*</span>所在地址</p>
					<p>
						<input type="hidden" id="provinceCode_old"/>
						<input type="hidden" id="cityCode_old"/>
						<input type="hidden" id="countyCode_old"/>
						
						<select id="provinceCode" name="command.provCode"
							onchange="pager._getCityListByProviceCode(this.value)"
							class="int-text int-medium ">
							<option value="">--请选择--</option>
						</select> 
					</p>
				</li>
				<li class="col-md-12">
					<p class="word">&nbsp;</p>
					<p>
						<select id="cityCode" name="command.cityCode"
							onchange="pager._getCountyListByCityCode(this.value)"
							class="int-text int-medium ">
							<option value="">--请选择--</option>
						</select>
					</p>
				</li>
				<li class="col-md-12">
					<p class="word">&nbsp;</p>
					<p>
						<select id="countyCode" name="command.countyCode"
							class="int-text int-medium ">
							<option value="">--请选择--</option>
						</select>
					</p>
				</li>
				<li class="col-md-12">

					<p class="word"><span>*</span>详细地址</p>
					<p>
						<input id="address" name="command.address"
							class="int-text int-medium " type="text" />
					</p>
				</li>
			</ul>
		</form>	 
		</div>
		<!--按钮-->
        <div class="modal-footer">
			<button onclick="pager._update();" type="button"
				class="biu-btn  btn-primary btn-blue btn-medium ml-10"
				>保存</button>
			<button type="button" onclick="pager._closeEditDiv();"
				class="biu-btn  btn-primary btn-blue btn-medium ml-10">取消</button>
			
		</div>
	</div>	
	<div class="mask" id="eject-mask"></div>	
	</div>
		
		
		
		
		
<!-- 		<div class="modal fade" id="editModal" tabindex="-1" role="dialog"
			aria-labelledby="editModalLabel" aria-hidden="true">
			<div class="modal-dialog" style="width: 600px;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">编辑仓库信息</h4>
					</div>
					<div class="modal-body" style="min-height: 220px;">
						<div class="form-label">
							
									<form id="updateRouteFormId">
										<ul>
											<li class="col-md-12"><input type="hidden" id="tenantId"
												name="command.tenantId" value="changhong" /> <input type="hidden"
												id="routeId" name="command.routeId" value="" />
												<p class="word"><span>*</span>仓库名称</p>
												<p>
													<input name="command.routeName" id="routeName"
														class="int-text int-medium " type="text" onkeyup="this.value=this.value.replace(/^\s+|\s+$/g,'')" />
												</p></li>
											<li class="col-md-12">
												<p class="word"><span>*</span>所在地址</p>
												<p>
													<input type="hidden" id="provinceCode_old"/>
													<input type="hidden" id="cityCode_old"/>
													<input type="hidden" id="countyCode_old"/>
													
													<select id="provinceCode" name="command.provCode"
														onchange="pager._getCityListByProviceCode(this.value)"
														class="int-text int-medium ">
														<option value="">--请选择--</option>
													</select> 
												</p>
											</li>
											<li class="col-md-12">
												<p class="word">&nbsp;</p>
												<p>
													<select id="cityCode" name="command.cityCode"
														onchange="pager._getCountyListByCityCode(this.value)"
														class="int-text int-medium ">
														<option value="">--请选择--</option>
													</select>
												</p>
											</li>
											<li class="col-md-12">
												<p class="word">&nbsp;</p>
												<p>
													<select id="countyCode" name="command.countyCode"
														class="int-text int-medium ">
														<option value="">--请选择--</option>
													</select>
												</p>
											</li>
											<li class="col-md-12">

												<p class="word"><span>*</span>详细地址</p>
												<p>
													<input id="address" name="command.address"
														class="int-text int-medium " type="text" />
												</p>
											</li>
										</ul>
									</form>
								

						</div>
					</div>
					<div class="modal-footer">
						<button onclick="pager._update();" type="button"
							class="biu-btn  btn-primary btn-blue btn-medium ml-10"
							>保存</button>
						<button type="button"
							class="biu-btn  btn-primary btn-blue btn-medium ml-10"
							data-dismiss="modal">取消</button>
						
					</div>
				</div>
				/.modal-content
			</div>
			/.modal
		</div> -->
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
					<div class="modal-body">
						<form id="updateRouteStateForm">
							<input type="hidden" id="updateRouteStateForm_tenantId" name="command.tenantId" value="CH"/>
							<input type="hidden" id="updateRouteStateForm_routeId" name="command.routeId" value=""/>
							<input type="hidden" id="updateRouteStateForm_state" name="command.state" value=""/>
						</form>
						您确定要<span id="stateMsgId"></span>当前仓库吗？
					</div>
					<div class="modal-footer">
						<button onclick="pager._updateRouteState();" type="button"
							class="biu-btn  btn-primary btn-blue btn-medium ml-10" 
							data-dismiss="modal">
							确认</button>
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
		
		<!-- 模态框（Modal） 开始 -->
		<div class="modal fade" id="freeSureModal" tabindex="-1" role="dialog"
			aria-labelledby="freeSureModalLabel" aria-hidden="true">
			<div class="modal-dialog" style="width: 400px;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">提示信息</h4>
					</div>
					<div class="modal-body">
						<form id="updateRouteStateForm">
							<input type="hidden" id="updateRouteStateForm_tenantId" name="command.tenantId" value="CH"/>
							<input type="hidden" id="updateRouteStateForm_routeId" name="command.routeId" value=""/>
							<input type="hidden" id="updateRouteStateForm_state" name="command.state" value=""/>
						</form>
						
							您确定要废弃当前仓库吗？
						
					</div>
					<div class="modal-footer">
						<button onclick="pager._updateRouteState();" type="button"
							class="biu-btn  btn-primary btn-blue btn-medium ml-10" 
							data-dismiss="modal">
							确认</button>
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
		
		<!-- 模态框（Modal） 开始 -->
		<div class="modal fade" id="validateModal" tabindex="-1" role="dialog"
			aria-labelledby="validateModalLabel" aria-hidden="true">
			<div class="modal-dialog" style="width: 400px;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">提示信息</h4>
					</div>
					<div class="modal-body">
						<div id="validateMsgId"></div>
					</div>
					<div class="modal-footer">
						<button type="button"
							class="biu-btn  btn-primary btn-blue btn-medium ml-10"
							data-dismiss="modal">关闭</button>
						
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
							<td>
							{{if state == '1'}}
								新增
							{{/if}}
							{{if state == '2'}}
								正常
							{{/if}}
							{{if state == '5'}}
								手动暂停
							{{/if}}
							{{if state == '6'}}
								已废弃
							{{/if}}
							</td>											
							<td>{{:routeId}}</td>
							<td title="{{:routeName}}">{{:~subStr(10,routeName)}}</td>
							<td title="{{:provName}}|{{:cityName}}|{{:countyName}}|{{:address}}">{{:~subStr(10,provName+'|'+cityName+'|'+countyName+'|'+address)}}</td>
							<td><a href="javascript:void(0);" onclick="pager._productList('{{:routeId}}','{{:routeName}}');">查看商品列表</a></td>
							<td><a href="javascript:void(0);" onclick="pager._productSelList('{{:routeId}}','{{:routeName}}');">选择商品</a></td>
							<td><a href="#" onclick="pager._edit('{{:routeId}}','{{:routeName}}','{{:provCode}}','{{:cityCode}}','{{:countyCode}}','{{:address}}');">编辑</a> 
								{{if state != '5'}}
								<a href="#" onclick="pager._editState('changhong','{{:routeId}}','5','{{:state}}');">暂停</a>
								{{/if}}
								{{if state == '5'}}
								<a href="#" onclick="pager._editState('changhong','{{:routeId}}','2','{{:state}}');">启用</a>
								{{/if}} 
								<a href="#" onclick="pager._editState('changhong','{{:routeId}}','6','{{:state}}');" data-toggle="modal" data-target="#freeSureModal">废弃</a></td>
						</tr>
						{{/for}}
					  </script>
</html>

