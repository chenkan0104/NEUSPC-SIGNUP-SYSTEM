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
						<li class="active"><a href="index.jsp">活动列表</a></li>
						<li><a href="MyTeam.jsp">我的团队</a></li>
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
					<h1>社会实践中心协议</h1>
				</div>
				<fieldset>
					<legend>协议内容</legend>
					<div class="span10">
						<p class="text-center text-error lead">
							<strong>一切解释权归东北大学社会实践中心所有。</strong>
						</p>
					</div>
					<br> <br>
				</fieldset>
				<fieldset>
					<legend>联系方式</legend>
					<div class="span5">
						<address>
							<strong>办公地点</strong><br> 辽宁省沈阳市和平区<br> 文化路三号巷11号<br>
							东北大学大学生活动中心304<br> <abbr title="Telephone">Tel:</abbr> (024)
							***-****
						</address>
						<address>
							<strong>东北大学社会实践中心</strong><br> <i class="icon-envelope"></i>&nbsp;<a
								href="mailto:neushsjzx@163.com">neushsjzx@163.com</a>
						</address>
						<address>
							<strong>人人公共主页</strong><br> <i class="icon-home"></i>&nbsp;<a
								href="http://www.renren.com/601011444">东北大学社会实践中心</a>
						</address>
					</div>
					<div class="span5">
						<address>
							<strong>Office</strong><br> 304, Student's Activity Center,
							Northeastern Univ.<br> NO.11, 3th Alley, Wenhua Road<br>
							Heping District, Shenyang, Liaoning Province<br> <abbr
								title="Telephone">P:</abbr> (024) ***-****
						</address>
						<address>
							<strong>E-mail</strong><br> <i class="icon-envelope"></i>&nbsp;<a
								href="mailto:neushsjzx@163.com">neushsjzx@163.com</a>
						</address>
						<address>
							<strong>RenRen HomePage</strong><br> <i class="icon-home"></i>&nbsp;<a
								href="http://www.renren.com/601011444"><abbr
								title="Northeaster University Social Practice Center">NEUSPC</abbr>
							</a>
						</address>
					</div>
				</fieldset>

				<hr>



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
