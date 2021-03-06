<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="uedroot" value="${pageContext.request.contextPath}/template/default"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<%@include file="/inc/inc.jsp" %>
<script type="text/javascript">
	var pager;
	(function () {
		seajs.use('app/jsp/route_manage/add', function (AddPager) {
			pager = new AddPager({element: document.body});
			pager.render();
		});
	})();
</script>
<title>添加仓库信息</title>
</head>
<body>
	<div class="content-wrapper-iframe">
		<!--右侧灰色背景-->
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
								<form id="addRouteForm">
								<ul>
													<li class="col-md-12">
														<input type="hidden" name="command.tenantId" value="changhong" />
														<p class="word"><span>*</span>仓库名称</p>
														<p>
															<input id="routeName" name="command.routeName" class="int-text int-medium " type="text" 
															commonText="/^[a-zA-Z_()0-9\u4e00-\u9fa5\-]+$/"
															onblur="this.value=this.value.replace(/^\s+|\s+$/g,'')" />
														</p>
													</li>
													<li class="col-md-12">
														<p class="word"><span>*</span>所在地址</p>
														<p>
															<select id="provinceCode" name="command.provCode" onchange="pager._getCityListByProviceCode(this.value)" class="int-text int-medium ">
																<option value="">--请选择--</option>
															</select> 
															<select id="cityCode" name="command.cityCode" onchange="pager._getCountyListByCityCode(this.value)" class="int-text int-medium ">
																<option value="">--请选择--</option>
															</select> 
															<select id="countyCode" name="command.countyCode" class="int-text int-medium ">
																<option value="">--请选择--</option>
															</select>
														</p>
													</li>
													<li class="col-md-12">

														<p class="word"><span>*</span>详细地址</p>
														<p>
															<input id="address" name="command.address" class="int-text int-medium " type="text" commonText="/^[a-zA-Z_()0-9\u4e00-\u9fa5\-]+$/"/>
														</p>
													</li>
												</ul>
								<ul>
												<li class="width-xlag">
													<p class="word">&nbsp;</p>
													<p>
														<input type="button" id="addRouteId"
															class="biu-btn  btn-primary btn-blue btn-medium ml-10"
															value="保  存" onclick="pager._addRoute();">
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
		<!-- 模态框（Modal） 开始 -->
		<div class="modal fade" id="saveModal" tabindex="-1" role="dialog"
			aria-labelledby="saveModalLabel" aria-hidden="true">
			<div class="modal-dialog" style="width: 400px;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">保存</h4>
					</div>
					<div class="modal-body">你是否确认保存信息？</div>
					<div class="modal-footer">
						<button id="addRouteButtonId" type="button"
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

		<!--内侧框架
				<div style="padding-left: 50px;">
					<h2>创建模态框（Modal）</h2>
					
					<button class="biu-btn btn-primary btn-blue btn-medium ml-30" data-toggle="modal" 
					   data-target="#myModal">
					   开始演示模态框
					</button>
				</div>-->
		<!-- 模态框（Modal） 开始 -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">模态框（Modal）标题</h4>
					</div>
					<div class="modal-body">在这里添加一些文本 在这里添加一些文本 在这里添加一些文本
						在这里添加一些文本 在这里添加一些文本 在这里添加一些文本</div>
					<div class="modal-footer">
						<button type="button"
							class="biu-btn  btn-primary btn-blue btn-medium ml-10"
							data-dismiss="modal">关闭</button>
						<button type="button"
							class="biu-btn  btn-primary btn-blue btn-medium ml-10">
							提交更改</button>
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
</html>
