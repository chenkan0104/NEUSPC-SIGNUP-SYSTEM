<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
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

<title>东北大学社会实践中心 | 报名系统</title>

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
				<a class="brand" href="index.jsp">东北大学社会实践中心</a>
				<div class="nav-collapse collapse">
					<ul class="nav">
						<li class="active"><a href="index.jsp">活动列表</a>
						</li>
						<li><a href="MyTeam.jsp">我的团队</a>
						</li>
						<li><a href="about.jsp">关于中心</a>
						</li>
						<li><a href="contact.jsp">联系我们</a>
						</li>
					</ul>
					<%
						UserDAO userDAO = DAOFactory.getUserDAOInstance();
						User user = userDAO.queryByEmail((String) session
								.getAttribute("login"));
						if (user == null) {
							out.println("<ul class=\"nav pull-right\">");
							out.println("<li><a href=\"login.jsp\">登录</a></li>");
							out.println("<li><a href=\"register.jsp\">注册</a></li>");
							out.println("</ul>");
						} else {
							out.println("<ul class=\"nav pull-right\">");
							out.println("<li class=\"dropdown\"><a href=\"#\" class=\"dropdown-toggle\" data-toggle=\"dropdown\">");
							out.println(user.getEmail());
							out.println("<b class=\"caret\"></b></a>");
							out.println("<ul class=\"dropdown-menu\">");
							out.println("<li><a href=\"PersonalInformation.jsp\">个人资料</a></li>");
							out.println("<li><a href=\"editPassword.jsp\">修改密码</a></li>");
							out.println("<li class=\"divider\"></li>");
							out.println("<li><a href=\"logout.jsp\" data-method=\"delete\" rel=\"nofollow\">退出登录</a></li>");
							out.println("</ul></li></ul>");
						}
					%>

				</div>
				<!--/.nav-collapse -->
			</div>
		</div>
	</div>

	<div class="container">

		<div class="row">
			<div class="span12">

				<div class="page-header">
					<h1>活动列表</h1>
				</div>

				<% String divide = request.getParameter("divide"); %>

				<ul class="nav nav-pills">
					<li class="<% if (divide == null || divide.equals("all")) out.print("active"); %>"><a href="index.jsp?divide=all">所有活动</a>
					</li>
					<li class="<% if (divide != null && divide.equals("ongoing")) out.print("active"); %>"><a href="index.jsp?divide=ongoing">正在报名</a>
					</li>
					<li class="<% if (divide != null && divide.equals("tobego")) out.print("active"); %>"><a href="index.jsp?divide=tobego">尚未开始</a>
					</li>
					<li class="<% if (divide != null && divide.equals("hasgone")) out.print("active"); %>"><a href="index.jsp?divide=hasgone">报名结束</a>
					</li>
				</ul>

				<table class="table table-bordered table-striped">
					<thead>
						<tr>
							<th width="45"></th>
							<th>活动名称</th>
							<th width="120">报名开始</th>
							<th width="120">报名结束</th>
							<th width="60">队伍数量</th>
						</tr>
					</thead>
					<tbody>
						<%
							ActivityDAO activityDAO = DAOFactory.getActivityDAOInstance();
							List<Activity> activitylist = activityDAO.queryAll();
							String now = new SimpleDateFormat("yyyy-MM-dd HH:mm",
									Locale.SIMPLIFIED_CHINESE).format(new java.util.Date());
							
							if ((divide == null)||divide.equals("all")) {
								for (int i=activitylist.size()-1;i>=0;i--) {
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
									out.println("<a href=\"ActivityPage?id="
											+ activity.getActivityid() + "\">");
									out.println(activity.getName() + "</a>");
									out.println("</td>");
									out.println("<td>" + activity.getStarttime() + "</td>");
									out.println("<td>" + activity.getEndtime() + "</td>");
									TeamDAO teamDAO = DAOFactory.getTeamDAOInstance();
									int teamamount = teamDAO.queryByActivityId(activity.getActivityid()).size();
									out.println("<td>" + teamamount + "</td>");
									out.println("</tr>");
								}
							} else if (divide.equals("ongoing")) {
								for (int i=activitylist.size()-1;i>=0;i--) {
									Activity activity = new Activity();
									activity = activitylist.get(i);
									if ((activity.getEndtime().compareTo(now) > 0)
											&& (activity.getStarttime().compareTo(now) < 0)) {
										out.println("<tr>");
										out.println("<td>");
										out.println("<span class=\"label label-success\">正在报名</span>");
										out.println("</td>");
										out.println("<td>");
										out.println("<a href=\"ActivityPage?id="
												+ activity.getActivityid() + "\">");
										out.println(activity.getName() + "</a>");
										out.println("</td>");
										out.println("<td>" + activity.getStarttime() + "</td>");
										out.println("<td>" + activity.getEndtime() + "</td>");
										out.println("<td>" + "0" + "</td>");
										out.println("</tr>");
									}
								}
							} else if (divide.equals("tobego")) {
								for (int i=activitylist.size()-1;i>=0;i--) {
									Activity activity = new Activity();
									activity = activitylist.get(i);
									if (activity.getStarttime().compareTo(now) > 0) {
										out.println("<tr>");
										out.println("<td>");
										out.println("<span class=\"label label-info\">即将开始</span>");
										out.println("</td>");
										out.println("<td>");
										out.println("<a href=\"ActivityPage?id="
												+ activity.getActivityid() + "\">");
										out.println(activity.getName() + "</a>");
										out.println("</td>");
										out.println("<td>" + activity.getStarttime() + "</td>");
										out.println("<td>" + activity.getEndtime() + "</td>");
										out.println("<td>" + "0" + "</td>");
										out.println("</tr>");
									}
								}
							} else if (divide.equals("hasgone")) {
								for (int i=activitylist.size()-1;i>=0;i--) {
									Activity activity = new Activity();
									activity = activitylist.get(i);
									if (activity.getEndtime().compareTo(now) < 0) {
										out.println("<tr>");
										out.println("<td>");
										out.println("<span class=\"label\">报名结束</span>");
										out.println("</td>");
										out.println("<td>");
										out.println("<a href=\"ActivityPage?id="
												+ activity.getActivityid() + "\">");
										out.println(activity.getName() + "</a>");
										out.println("</td>");
										out.println("<td>" + activity.getStarttime() + "</td>");
										out.println("<td>" + activity.getEndtime() + "</td>");
										out.println("<td>" + "0" + "</td>");
										out.println("</tr>");
									}
								}
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
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>
