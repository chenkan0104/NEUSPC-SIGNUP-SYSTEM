<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="dao.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">

<title>东北大学社会实践中心</title>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="东北大学,社会实践,一周一企,报名">
<meta http-equiv="description" content="东北大学社会实践中心报名系统">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="css/bootstrap-responsive.min.css" rel="stylesheet">

<link href="css/datetimepicker.css" rel="stylesheet">

<link rel="stylesheet" type="text/css"
	href="css/bootstrap-wysihtml5.css">

<style>
body {
	padding-top: 60px;
	/* 60px to make the container go all the way to the bottom of the topbar */
}
</style>

<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
      <script src="//cdnjs.bootcss.com/ajax/libs/html5shiv/3.6.2/html5shiv.js"></script>
    <![endif]-->

<link rel="shortcut icon" href="ico/favicon.png">
</head>

<body>
	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container">
				<button type="button" class="btn btn-navbar" data-toggle="collapse"
					data-target=".nav-collapse">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="brand" href="admin.jsp">东北大学社会实践中心</a>
				<div class="nav-collapse collapse">
					<ul class="nav">
						<li><a href="admin.jsp">活动列表</a></li>
						<li class="active"><a href="addActivity.jsp">添加活动</a></li>
					</ul>
					<ul class="nav pull-right">
						<li><a href="logout.jsp">退出登录</a></li>
					</ul>
				</div>
				<!--/.nav-collapse -->
			</div>
		</div>
	</div>

	<div class="container">

		<div class="page-header">
			<div class="pull-right"></div>
			<h1>添加活动</h1>
		</div>

		<form accept-charset="UTF-8" class="form-horizontal" method="post"
			action="AddActivity">
			<fieldset class="control-group">
				<legend>活动内容</legend>
				<div class="control-group">
					<div class="controls" style="margin-top:40px">
						<textarea placeholder="活动标题 &hellip;" name="name"
							style="width: 810px; height: 20px"></textarea>
					</div>
					<div class="controls" style="margin-top:40px">
						<textarea class="info-textarea" placeholder="活动内容 &hellip;"
							name="info" style="width: 810px; height: 200px"></textarea>
					</div>
				</div>
			</fieldset>

			<fieldset class="control-group">
				<legend>活动设置</legend>
				<div class="control-group">
					<label class="control-label" for="starttime">开始时间</label>
					<div class="controls">
						<div class="input-append date form_starttime">
							<input size="16" type="text" name="starttime" value="" readonly>
							<span class="add-on" id="starttime"><i class="icon-th"></i>
							</span>
						</div>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="endtime">结束时间</label>
					<div class="controls">
						<div class="input-append date form_endtime">
							<input size="16" type="text" name="endtime" value="" readonly>
							<span class="add-on" id="endtime"><i class="icon-th"></i>
							</span>
						</div>
					</div>
				</div>
			</fieldset>
			<div class="form-actions">
				<input class="btn btn-primary" type="submit" value="添加活动">
			</div>
		</form>

		<hr />

		<div class="tab-pane fade" id="teams">
			<table class="table table-bordered table-striped">
				<thead>
					<tr>
						<th width="45"></th>
						<th>队名</th>
						<th width="80">创建时间</th>
						<th width="60">成员数量</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><span class="label label-success">已经生效</span>
						</td>
						<td><a href="/teams/1586">陈侃的团队</a></td>
						<td>07 Apr 12:54</td>
						<td>1</td>
					</tr>
				</tbody>
			</table>
		</div>


		<footer>
			<p class="pull-right">
				<%
					out.print(new java.util.Date());
				%>, <a href="admin.jsp">后台管理</a>
			</p>
			<p>
				&copy; 2013<a href="index.jsp" target="_blank">东北大学社会实践中心</a> ·<a
					href="joinUs.jsp">加入我们</a>
			</p>
		</footer>
	</div>

	<!-- /container -->
	<script src="js/wysihtml5-0.3.0.js"></script>
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/bootstrap-datetimepicker.js"></script>
	<script src="js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
	<script src="js/bootstrap-wysihtml5.js"></script>
	<script src="js/bootstrap-wysihtml5.zh-CN.js" charset="UTF-8"></script>

	<script type="text/javascript">
		$('.form_starttime').datetimepicker({
			language : 'zh-CN',
			weekStart : 7,
			todayBtn : 1,
			autoclose : 1,
			todayHighlight : 1,
			startView : 2,
			forceParse : 0,
			showMeridian : 1,
			pickerPosition : "bottom-left"
		});
		$('.form_endtime').datetimepicker({
			language : 'zh-CN',
			weekStart : 7,
			todayBtn : 1,
			autoclose : 1,
			todayHighlight : 1,
			startView : 2,
			forceParse : 0,
			showMeridian : 1,
			pickerPosition : "bottom-left"
		});
	</script>
	<script>
		$('.info-textarea').wysihtml5({
			locale : "zh-CN"
		});
	</script>
</body>
</html>
