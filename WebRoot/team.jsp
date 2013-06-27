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
						<li class="active"><a href="index.jsp">活动列表</a></li>
						<li><a href="MyTeam.jsp">我的团队</a></li>
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

	<%
		Team team = (Team) request.getAttribute("team");
	%>

	<div class="container">

		<div class="page-header">
			<div class="pull-right"></div>
			<h1>
				<%
					out.print(team.getName());
				%>
			</h1>
		</div>

		<%
			ActivityMemberDAO teamMemberDAO = DAOFactory
					.getActivityMemberDAOInstance();
			List<ActivityMember> activityMemberList = teamMemberDAO
					.queryByTeamId(team.getTeamid());
		%>

		<ul class="nav nav-tabs">
			<li class="active"><a href="#teammember" data-toggle="tab">团队成员<span
					class="badge badge-info"> <%
 	out.print(activityMemberList.size());
 %>
				</span> </a></li>
			<li><a href="#teacher" data-toggle="tab">指导教师 <span
					class="badge badge-info">1</span> </a></li>
			<li><a href="#prize" data-toggle="tab">获奖情况<span
					class="badge badge-info">0</span> </a></li>
			<%
				if (session.getAttribute("login") != null) {
					out.print("<a href=\"JoinTeam?id=" + team.getTeamid()
							+ "\" class=\"pull-right btn btn-success\">加入团队</a>");
				}
			%>
		</ul>

		<div class="tab-content">
			<div class="tab-pane fade active in" id="teammember">
				<table class="table table-bordered table-striped">
					<thead>
						<tr>
							<th width="45"></th>
							<th width="45">职务</th>
							<th>所属学院</th>
							<th width="80">班级</th>
							<th width="60">姓名</th>
							<th width="45"></th>
						</tr>
					</thead>
					<tbody>
						<%
							if (session.getAttribute("joinsuccess") != null) {
								out.print("<div class=\"help-block alert alert-success\">You have joined this team successfully!</div>");
								session.removeAttribute("joinsuccess");
							}
							if (session.getAttribute("exist") != null) {
								out.print("<div class=\"help-block alert alert-warning\">You are already in this team!</div>");
								session.removeAttribute("exist");
							}
						%>
						<%
							for (ActivityMember activityMember : activityMemberList) {
								User member = userDAO.queryById(activityMember.getUserid());
								out.println("<tr>");
								out.println("<td>");
								out.println("<span class=\"label label-success\">审核通过</span>");
								out.println("</td>");
								out.println("<td>");
								if (team.getLeaderid() == activityMember.getUserid())
									out.print("队长");
								else
									out.print("队员");
								out.println("</td>");
								out.println("<td>" + member.getCollege() + "</td>");
								out.println("<td>" + member.getClassname() + "</td>");
								out.println("<td>" + member.getName() + "</td>");
								out.println("<td></td>");
								out.println("</tr>");
							}
						%>
					</tbody>
				</table>
			</div>

			<div class="tab-pane fade" id="teacher">
				<table class="table table-bordered table-striped">
					<thead>
						<tr>
							<th width="200">所属学院</th>
							<th>姓名</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td></td>
							<td>
								<%
									out.print(team.getTeachername());
								%>
							</td>
						</tr>
					</tbody>
				</table>
			</div>

			<div class="tab-pane fade" id="prize">
				<table class="table table-bordered table-striped">
					<thead>
						<tr>
							<th width="200">获奖等级</th>
							<th>奖励名称</th>
						</tr>
					</thead>
					<tbody>
						<%
							
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
