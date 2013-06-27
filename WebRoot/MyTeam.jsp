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
	<%
		if (session.getAttribute("login") == null) {
			session.setAttribute("alert", "true");
			response.sendRedirect("login.jsp");
			return;
		}
	%>
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
						<li><a href="index.jsp">活动列表</a></li>
						<li class="active"><a href="MyTeam.jsp">我的团队</a></li>
						<li><a href="about.jsp">关于中心</a></li>
						<li><a href="contact.jsp">联系我们</a></li>
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
					<h1>我的团队</h1>
				</div>

				<%
					String divide = request.getParameter("divide");
				%>

				<ul class="nav nav-pills">
					<li
						class="<%if (divide == null || divide.equals("all"))
				out.print("active");%>">
						<a href="MyTeam.jsp?divide=all">所有队伍</a></li>
					<li
						class="<%if (divide != null && divide.equals("waitting"))
				out.print("active");%>"><a
						href="MyTeam.jsp?divide=waitting">等待审核</a></li>
					<li
						class="<%if (divide != null && divide.equals("finished"))
				out.print("active");%>"><a
						href="MyTeam.jsp?divide=finished">已经生效</a></li>
				</ul>

				<table class="table table-bordered table-striped">
					<thead>
						<tr>
							<th width="45"></th>
							<th>所属活动</th>
							<th width="200">团队名称</th>
							<th width="120">创建日期</th>
						</tr>
					</thead>
					<tbody>
						<%
							TeamDAO teamDAO = DAOFactory.getTeamDAOInstance();
							int userid = DAOFactory.getUserDAOInstance().queryByEmail((String)session.getAttribute("login")).getUserid();
							List<ActivityMember> activityMemberList = DAOFactory.getActivityMemberDAOInstance().queryByUserId(userid);
							List<Team> teamlist = new ArrayList<Team>();
							for (ActivityMember activityMember : activityMemberList) {
								teamlist.add(teamDAO.queryById(activityMember.getTeamid()));
							}
							ActivityDAO activityDAO = DAOFactory.getActivityDAOInstance();

							if (divide == null || divide.equals("all")) {
								for (int i = teamlist.size() - 1; i >= 0; i--) {
									Team team = new Team();
									team = teamlist.get(i);
									out.println("<tr>");
									out.println("<td>");
									if (team.getStatus().equals("已生效"))
										out.println("<span class=\"label label-success\">已经生效</span>");
									else
										out.println("<span class=\"label\">等待审核</span>");
									out.println("</td>");
									out.println("<td>");
									String activityname = activityDAO.queryById(
											team.getActivityid()).getName();
									out.println("<a href=\"ActivityPage?id="
											+ team.getActivityid() + "\">");
									out.println(activityname + "</a>");
									out.println("</td>");
									out.println("<td>");
									out.println("<a href=\"TeamPage?id=" + team.getTeamid()
											+ "\">");
									out.println(team.getName() + "</a>");
									out.println("</td>");
									out.println("<td>" + team.getCreatetime() + "</td>");
									out.println("</tr>");
								}
							} else if (divide.equals("waitting")) {
								for (int i = teamlist.size() - 1; i >= 0; i--) {
									Team team = new Team();
									team = teamlist.get(i);
									if (!team.getStatus().equals("已生效")) {
										out.println("<tr>");
										out.println("<td>");
										out.println("<span class=\"label\">等待审核</span>");
										out.println("</td>");
										out.println("<td>");
										String activityname = activityDAO.queryById(
												team.getActivityid()).getName();
										out.println("<a href=\"ActivityPage?id="
												+ team.getActivityid() + "\">");
										out.println(activityname + "</a>");
										out.println("</td>");
										out.println("<td>");
										out.println("<a href=\"TeamPage?id=" + team.getTeamid()
												+ "\">");
										out.println(team.getName() + "</a>");
										out.println("</td>");
										out.println("<td>" + team.getCreatetime() + "</td>");
										out.println("</tr>");
									}
								}
							} else if (divide.equals("finished")) {
								for (int i = teamlist.size() - 1; i >= 0; i--) {
									Team team = new Team();
									team = teamlist.get(i);
									if (team.getStatus().equals("已生效")) {
										out.println("<tr>");
										out.println("<td>");
										out.println("<span class=\"label label-success\">已经生效</span>");
										out.println("</td>");
										out.println("<td>");
										String activityname = activityDAO.queryById(
												team.getActivityid()).getName();
										out.println("<a href=\"ActivityPage?id="
												+ team.getActivityid() + "\">");
										out.println(activityname + "</a>");
										out.println("</td>");
										out.println("<td>");
										out.println("<a href=\"TeamPage?id=" + team.getTeamid()
												+ "\">");
										out.println(team.getName() + "</a>");
										out.println("</td>");
										out.println("<td>" + team.getCreatetime() + "</td>");
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
