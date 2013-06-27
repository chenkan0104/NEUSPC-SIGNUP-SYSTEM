<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
		if (session.getAttribute("login") == null)
			;
		else if (((String) session.getAttribute("login")).equals("admin")) {
			response.sendRedirect("admin.jsp");
		} else if (session.getAttribute("login") != null) {
			session.removeAttribute("login");
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
						<li class="active"><a href="#">活动列表</a></li>
						<li><a href="#about">我的团队</a></li>
						<li><a href="about.jsp">关于中心</a>
						</li>
						<li><a href="contact.jsp">联系我们</a>
						</li>
					</ul>
					<ul class="nav pull-right">
						<li><a href="index.jsp">前台页面</a></li>
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
					<h1>管理登录</h1>
				</div>
				
				<%
					if (session.getAttribute("alert") != null) {
						out.print("<div class=\"help-block alert alert-error\">You need to log in before continuing&hellip;</div>");
						session.removeAttribute("alert");
					} 
				 %>

				<form accept-charset="UTF-8" class="form-horizontal"
					action="LoginConf" method="post" id="loginForm">
					<div class="control-group">
						<label class="control-label" for="email">账号</label>
						<div class="controls">
							<input type="text" name="email" id="email" spellcheck="false"
								placeholder="Account" tabindex="1" autofocus="autofocus" required>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="password">密码</label>
						<div class="controls">
							<input type="password" name="password" id="email"
								placeholder="Password" tabindex="2" required>
						</div>
					</div>
					<div class="control-group">
						<div class="controls">
							<label class="remember_me" for="remember_me"> <input
								id="rememberme" type="checkbox" name="rememberme"
								checked="checked" tabindex="3" value="true">&nbsp;&nbsp;记住我
								<span class="middot">·</span> <a class="reset"
								href="resetpassword" tabindex="4">忘记密码?</a> </label>
						</div>
					</div>
					<div class="form-actions">
						<input class="btn btn-primary" type="submit" value="登录"
							tabindex="5">
					</div>
				</form>

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
