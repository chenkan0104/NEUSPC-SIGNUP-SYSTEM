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
	<%
		if (session.getAttribute("login") == null) {
			session.setAttribute("alert", "true");
			response.sendRedirect("adminLogin.jsp");
			return;
		} else if (!((String)session.getAttribute("login")).equals("admin")) {
			session.removeAttribute("login");
			session.setAttribute("alert", "true");
			response.sendRedirect("adminLogin.jsp");
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

	<%
		Activity activity = (Activity) request.getAttribute("activity");
	%>
	<%
		List<Team> teamListTemp = DAOFactory.getTeamDAOInstance().queryByActivityId(activity
			.getActivityid());
	%>

	<div class="container">

		<ul class="nav nav-tabs">
			<li class="active"><a href="#activity" data-toggle="tab">活动信息</a>
			</li>
			<li><a href="#teams" data-toggle="tab">参加团队 <span
					class="badge badge-info"> <% out.print(teamListTemp.size()); %> </span> </a></li>
		</ul>

		<div class="tab-content">
			<div class="tab-pane fade active in" id="activity">
				<div <%if (request.getParameter("edit") != null) out.print("style=\"display: none\"");%>>
					<form accept-charset="UTF-8" class="form-horizontal" method="post"
						action="EditActivity">
						<input name="activityid" style="display: none"
							value="<%out.print(activity.getActivityid());%>">
						<fieldset class="control-group">
							<legend>活动内容</legend>
							<div class="control-group">
								<div class="controls" style="margin-top:40px">
									<textarea placeholder="活动标题 &hellip;" name="name" style="width: 810px; height: 20px"><%out.print(activity.getName());%>	</textarea>
								</div>
								<div class="controls" style="margin-top:40px">
									<textarea class="info-textarea" placeholder="活动内容 &hellip;" name="info" style="width: 810px; height: 200px"><%out.print(activity.getInfo());%></textarea>
								</div>
							</div>
						</fieldset>

						<fieldset class="control-group">
							<legend>活动设置</legend>
							<div class="control-group">
								<label class="control-label" for="starttime">开始时间</label>
								<div class="controls">
									<div class="input-append date form_starttime">
										<input size="16" type="text" name="starttime"
											value="<%out.print(activity.getStarttime());%>" readonly>
										<span class="add-on" id="starttime"><i class="icon-th"></i>
										</span>
									</div>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="endtime">结束时间</label>
								<div class="controls">
									<div class="input-append date form_endtime">
										<input size="16" type="text" name="endtime"
											value="<%out.print(activity.getEndtime());%>" readonly>
										<span class="add-on" id="endtime"><i class="icon-th"></i>
										</span>
									</div>
								</div>
							</div>
						</fieldset>
						<div class="form-actions">
							<input class="btn btn-primary" type="submit" value="修改活动">
						</div>
					</form>
				</div>
				<%
					if (request.getParameter("edit") != null) {
						out.print(activity.getInfo());
					}
				%>
				<hr />
			</div>
			<%
				TeamDAO teamDAO = DAOFactory.getTeamDAOInstance();
				List<Team> teamlist = teamDAO.queryByActivityId(activity.getActivityid());
			%>
			<div class="tab-pane fade" id="teams">
				<table class="table table-bordered table-striped">
					<thead>
						<tr>
							<th width="45"></th>
							<th>队名</th>
							<th width="120">创建时间</th>
							<th width="60">成员数量</th>
							<%
								if (request.getParameter("edit") == null) {
									out.print("<th width=\"70\">同意申请</th>");
									out.print("<th width=\"70\">拒绝申请</th>");
								} 
							 %>
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
								ActivityMemberDAO activityMemberDAO = DAOFactory.getActivityMemberDAOInstance();
								out.println("<td>"+ activityMemberDAO.queryByTeamId(team.getTeamid()).size() + "</td>");
								if (request.getParameter("edit") == null) {
									out.println("<td><a href=\"AcceptApply?id="+team.getTeamid()+"&&activityid="+activity.getActivityid()+"\" class=\"btn btn-mini btn-danger\">同意申请</a></td>");
									out.print("<td><a href=\"DeclineApply?id="+team.getTeamid()+"&&activityid="+activity.getActivityid()+"\" class=\"btn btn-mini btn-danger\">拒绝申请</a></td>");
								}
								out.println("</tr>");
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
