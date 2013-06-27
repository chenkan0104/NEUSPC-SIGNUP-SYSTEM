<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
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

<title>东北大学社会实践中心 | 后台管理</title>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="东北大学,社会实践,一周一企,报名,登录">
<meta http-equiv="description" content="东北大学社会实践中心报名系统">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="css/bootstrap-responsive.min.css" rel="stylesheet">

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
	<%
		if (((String) session.getAttribute("login")) == null
		|| (!((String) session.getAttribute("login"))
				.equals("admin")))
			response.sendRedirect("adminLogin.jsp");
	%>
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
						<li class="active"><a href="admin.jsp">活动列表</a></li>
						<li><a href="addActivity.jsp">添加活动</a></li>
					</ul>
					<ul class="nav pull-right">
						<li><a href="logout.jsp">退出登录</a>
						</li>
					</ul>
				</div>
				<!--/.nav-collapse -->
			</div>
		</div>
	</div>

	<div class="container">

		<div class="row">
			<div class="span12">

				<div class="page-header">
					<h1>后台管理</h1>
				</div>

				<table class="table table-bordered table-striped">
					<thead>
						<tr>
							<th width="45"></th>
							<th>活动名称</th>
							<th width="120">队伍数量</th>
							<th width="70">修改活动</th>
							<th width="70">删除活动</th>
						</tr>
					</thead>
					<tbody>
						<%
							ActivityDAO activityDAO = DAOFactory.getActivityDAOInstance();
							List<Activity> activitylist = activityDAO.queryAll();
							String now = new SimpleDateFormat("yyyy-MM-dd HH:mm",
									Locale.SIMPLIFIED_CHINESE).format(new java.util.Date());
							for (int i = activitylist.size() - 1; i >= 0; i--) {
								Activity activity = new Activity();
								activity = activitylist.get(i);
								out.println("<tr>");
								out.println("<td>");
								if ((activity.getEndtime().compareTo(now) > 0)
										&& (activity.getStarttime().compareTo(now) < 0))
									out.println("<span class=\"label label-success\">正在报名</span>");
								else if (activity.getStarttime().compareTo(now) > 0)
									out.println("<span class=\"label label-info\">即将开始</span>");
								else if (activity.getEndtime().compareTo(now) < 0)
									out.println("<span class=\"label\">报名结束</span>");
								out.println("</td>");
								out.println("<td>");
								out.println("<a href=\"EditActivityPage?id="
										+ activity.getActivityid() + "&edit=false\">");
								out.println(activity.getName() + "</a>");
								out.println("</td>");
								TeamDAO teamDAO = DAOFactory.getTeamDAOInstance();
								int teamamount = teamDAO.queryByActivityId(
										activity.getActivityid()).size();
								out.println("<td>" + teamamount + "</td>");
								out.println("<td><a href=\"EditActivityPage?id="
										+ activity.getActivityid()
										+ "\" class=\"btn btn-mini btn-danger\">修改活动</a></td>");
								out.println("<td><a href=\"#myModal"
										+ activity.getActivityid()
										+ "\" class=\"btn btn-mini btn-danger\" data-toggle=\"modal\">删除活动</a></td>");
								out.println("</tr>");
								out.print("<div id=\"myModal"
										+ activity.getActivityid()
										+ "\" class=\"modal hide fade\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"myModalLabel\" aria-hidden=\"true\">");
								out.print("<div class=\"modal-header\">");
								out.print("<button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">×</button>");
								out.print("<h3 class=\"text-error\" id=\"myModalLabel\">注意</h3>");
								out.print("</div>");
								out.print("<div class=\"modal-body\">");
								out.print("<p>确定删除活动：<strong>" + activity.getName()
										+ "</strong>?</p>");
								out.print("</div>");
								out.print("<div class=\"modal-footer\">");
								out.print("<button class=\"btn\" data-dismiss=\"modal\" aria-hidden=\"true\">关闭</button>");
								out.print("<button class=\"btn btn-danger\" onclick=\"sureToDelete("
										+ activity.getActivityid() + ")\">确定</button>");
								out.print("</div>");
								out.print("</div>");
							}
						%>
					</tbody>
				</table>

			</div>

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

	<script>
		function sureToDelete(activityid) {
			location.href = "DeleteActivity?id=" + activityid;
		}
	</script>

	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>
