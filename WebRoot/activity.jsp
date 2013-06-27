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

	<%
		Activity activity = (Activity) request.getAttribute("activity");
	%>

	<div class="container">

		<div class="page-header">
			<div class="pull-right"></div>
			<h1>
				<%
					out.print(activity.getName());
				%>
			</h1>
		</div>

		<%
			TeamDAO teamDAO = DAOFactory.getTeamDAOInstance();
			List<Team> teamlist = teamDAO.queryByActivityId(activity
					.getActivityid());
		%>

		<ul class="nav nav-tabs">
			<li class="active"><a href="#activity" data-toggle="tab">活动信息</a>
			</li>
			<li><a href="#teams" data-toggle="tab">参加团队 <span
					class="badge badge-info"> <%
 	out.print(teamlist.size());
 %> </span> </a>
			</li>
			<%
				int activityid = Integer.parseInt(request.getParameter("id"));
				int leaderid = -1;
				if (session.getAttribute("login") != null)
					leaderid = DAOFactory.getUserDAOInstance().queryByEmail((String)session.getAttribute("login")).getUserid();
				Team teamTemp = DAOFactory.getTeamDAOInstance().queryByLeaderIdAndActivityId(leaderid, activityid);
				List<ActivityMember> activityMemberList = DAOFactory.getActivityMemberDAOInstance().queryByUserId(leaderid);
				List<Team> teamList = new ArrayList<Team>();
				for (ActivityMember activityMember : activityMemberList) {
					teamList.add(DAOFactory.getTeamDAOInstance().queryById(activityMember.getTeamid()));
				}
				boolean boo = true;
				for (Team team : teamList) {
					if (team.getActivityid() == activityid) {
						boo = false;
						break;
					}
				}
				String now = new SimpleDateFormat("yyyy-MM-dd HH:mm",
						Locale.SIMPLIFIED_CHINESE).format(new java.util.Date());
				if ((activity.getEndtime().compareTo(now) > 0)
						&& (activity.getStarttime().compareTo(now) < 0)&&(session.getAttribute("login") != null)&&(teamTemp == null)&&boo)
					out.println("<li><a href=\"#signup\" data-toggle=\"tab\">组队参加</a></li>");
			%>
		</ul>

		<div class="tab-content">
			<div class="tab-pane fade active in" id="activity">
				<div>
					<%
						if (session.getAttribute("signup") != null) {
							out.print("<div class=\"alert alert-success\">");
							out.print("<button type=\"button\" class=\"close\" data-dismiss=\"alert\">&times;</button>");
							out.print("<strong>OK!</strong> &nbsp;您的团队正在审核中，请耐心等待&hellip;");
							out.print("</div>");
							session.removeAttribute("signup");
						}
						out.print(activity.getInfo());
					%>
					<hr />
				</div>
			</div>

			<div class="tab-pane fade" id="teams">
				<table class="table table-bordered table-striped">
					<thead>
						<tr>
							<th width="45"></th>
							<th>队名</th>
							<th width="120">创建时间</th>
							<th width="60">成员数量</th>
						</tr>
					</thead>
					<tbody>
						<%
							for (int i = teamlist.size() - 1; i >= 0; i--) {
								Team team = new Team();
								team = teamlist.get(i);
								out.println("<tr>");
								out.println("<td>");
								if (team.getStatus().equals("已生效"))
									out.println("<span class=\"label label-success\">审核通过</span>");
								else if (team.getStatus().equals("未生效"))
									out.println("<span class=\"label\">正在审核</span>");
								else if (team.getStatus().equals("已拒绝"))
									out.println("<span class=\"label\">拒绝申请</span>");
								out.println("</td>");
								out.println("<td>");
								out.println("<a href=\"TeamPage?id=" + team.getTeamid() + "\">");
								out.println(team.getName() + "</a>");
								out.println("</td>");
								out.println("<td>" + team.getCreatetime() + "</td>");

								ActivityMemberDAO activityMemberDAO = DAOFactory
										.getActivityMemberDAOInstance();

								out.println("<td>"
										+ activityMemberDAO.queryByTeamId(team.getTeamid())
												.size() + "</td>");
								out.println("</tr>");
							}
						%>
						<!-- <tr>
							<td><span class="label label-success">已经生效</span>
							</td>
							<td><a href="/teams/1586">陈侃的团队</a></td>
							<td>07 Apr 12:54</td>
							<td>1</td>
						</tr> -->
					</tbody>
				</table>
			</div>

			<div class="tab-pane fade" id="signup">
				<%
					if (session.getAttribute("login") == null) {
						out.print("<div class=\"alert alert-error\">");
						out.print("<button type=\"button\" class=\"close\" data-dismiss=\"alert\">&times;</button>");
						out.print("<strong>OOOOOOH NO!</strong> &nbsp;请先登录&hellip;");
						out.print("</div>");
						out.print("<hr>");
					} else {
						out.print("<br>");
						out.print("<form accept-charset=\"UTF-8\" class=\"form-horizontal\"	action=\"SignUpAsTeam\" method=\"post\" id=\"SignUpAsTeam\">");
						out.print("<div class=\"control-group\">");
						out.print("<label class=\"control-label\" for=\"teamname\">团队名称</label>");
						out.print("<div class=\"controls\">");
						String teamname = "";
						if (session.getAttribute("login") != null)
							teamname = DAOFactory.getUserDAOInstance().queryByEmail((String)session.getAttribute("login")).getName()+"的团队";
						out.print("<input type=\"text\" name=\"teamname\" id=\"teamname\" spellcheck=\"false\" placeholder=\"团队名称\" tabindex=\"1\" autofocus=\"autofocus\" value=\""+teamname+"\" required>");
						out.print("</div>");
						out.print("</div>");
						out.print("<div class=\"control-group\">");
						out.print("<label class=\"control-label\" for=\"teachername\">指导教师</label>");
						out.print("<div class=\"controls\">");
						out.print("<input type=\"text\" name=\"teachername\" id=\"teachername\" placeholder=\"教师姓名\" tabindex=\"2\" required>");
						out.print("</div>");
						out.print("</div>");
						out.print("<input type=\"text\" name=\"activityid\" value=\"");
						out.print(activity.getActivityid()
								+ "\" style=\"display: none\"");
						out.print("<br>");
						out.print("<div class=\"form-actions\">");
						out.print("<input class=\"btn btn-primary\" type=\"submit\" value=\"提交\" tabindex=\"5\">");
						out.print("</div>");
						out.print("</form>");
					}
				%>
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
