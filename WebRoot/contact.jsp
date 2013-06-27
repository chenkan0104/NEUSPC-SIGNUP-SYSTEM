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
						<li><a href="index.jsp">活动列表</a></li>
						<li><a href="MyTeam.jsp">我的团队</a></li>
						<li><a href="about.jsp">关于中心</a></li>
						<li class="active"><a href="contact.jsp">联系我们</a></li>
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
				<div>
					<h1>联系我们</h1>
					<hr>
				</div>
				<fieldset>
					<legend>联系方式</legend>
					<table class="table table-bordered table-striped">
						<thead>
							<tr>
								<th width="45"></th>
								<th width="200">渠道</th>
								<th>联系方式</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td></td>
								<td>电子邮件</td>
								<td><i class="icon-envelope"></i>&nbsp;<a href="mailto:neushsjzx[ta]163[tod]com">neushsjzx@163.com</a></td>
							</tr>
							<tr>
								<td></td>
								<td>人人主页</td>
								<td><i class="icon-home"></i>&nbsp;<a href="http://www.renren.com/601011444">人人网</a></td>
							</tr>
							<tr>
								<td></td>
								<td>办公地址</td>
								<td><i class="icon-map-marker"></i>&nbsp;大学生活动中心304</td>
							</tr>
						</tbody>
					</table>
				</fieldset>

				<fieldset>
					<legend>各个部门</legend>
					<table class="table table-bordered table-striped">
						<thead>
							<tr>
								<th width="45"></th>
								<th>部门</th>
								<th width="120">负责人</th>
								<th width="200">联系方式</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td></td>
								<td>办公室</td>
								<td>王迪</td>
								<td></td>
							</tr>
							<tr>
								<td></td>
								<td>实践管理部</td>
								<td>王锐</td>
								<td></td>
							</tr>
							<tr>
								<td></td>
								<td>实践培训部</td>
								<td>殷路菊</td>
								<td></td>
							</tr>
							<tr>
								<td></td>
								<td>就业见习部</td>
								<td>郭龙刚、李亚运</td>
								<td></td>
							</tr>
							<tr>
								<td></td>
								<td>活动项目部</td>
								<td>李恒捷、韦怡琳</td>
								<td></td>
							</tr>
							<tr>
								<td></td>
								<td>文化传媒部</td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td></td>
								<td>科技部</td>
								<td>陈侃</td>
								<td>15041233035</td>
							</tr>
						</tbody>
					</table>
				</fieldset>
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
