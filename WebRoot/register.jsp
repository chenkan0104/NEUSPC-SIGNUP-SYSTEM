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

<title>东北大学社会实践中心 | 注册</title>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="东北大学,社会实践,一周一企,报名,注册">
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
				<a class="brand" href="#">东北大学社会实践中心</a>
				<div class="nav-collapse collapse">
					<ul class="nav">
						<li><a href="#">活动列表</a></li>
						<li><a href="MyTeam.jsp">我的团队</a></li>
						<li><a href="about.jsp">关于中心</a></li>
						<li><a href="contact.jsp">联系我们</a></li>
					</ul>
					<ul class="nav pull-right">
						<li><a href="login.jsp">登录</a></li>
						<li class="active"><a href="register.jsp">注册</a></li>
					</ul>

				</div>
				<!--/.nav-collapse -->
			</div>
		</div>
	</div>

	<div class="container">
		<div class="page-header">
			<h1>用户注册</h1>
		</div>

		<%
			if (session.getAttribute("empty") != null) {
				out.print("<div class=\"help-block alert alert-error\">对不起，请不要留空&hellip;</div>");
				session.removeAttribute("empty");
			}
			if (session.getAttribute("emailwrong") != null) {
				out.print("<div class=\"help-block alert alert-error\">对不起，该邮箱地址已被使用，请重新输入&hellip;</div>");
				session.removeAttribute("emailwrong");
			}
			if (session.getAttribute("repasswordwrong") != null) {
				out.print("<div class=\"help-block alert alert-error\">请使新密码与确认密码保持一致&hellip;</div>");
				session.removeAttribute("repasswordwrong");
			}
		%>

		<form accept-charset="UTF-8" class="form-horizontal" method="post"
			action="RegisterConf" id="regist">
			<fieldset class="control-group">
				<legend>登录信息</legend>
				<div class="control-group">
					<label class="control-label" for="email">邮件地址</label>
					<div class="controls">
						<input id="email" name="email" size="30" type="email"
							placeholder="邮箱" spellcheck="false" autofocus="autofocus"
							required/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="password">输入密码</label>
					<div class="controls">
						<input id="password" name="password" size="30" type="password"
							placeholder="密码"  required/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="repassword">确认密码</label>
					<div class="controls">
						<input id="repassword" name="repassword" size="30" type="password"
							placeholder="确认密码"  required/>
					</div>
				</div>
			</fieldset>

			<fieldset>
				<legend>基本信息</legend>
				<div class="control-group">
					<label class="control-label" for="fullname">姓名</label>
					<div class="controls">
						<input id="fullname" name="name" size="30" type="text"
							placeholder="我们需要你的真实姓名"  required/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="gender">性别</label>
					<div class="controls">
						<select id="gender" name="gender">
							<option value="男">男</option>
							<option value="女">女</option>
							<option value="其他">其他</option>
						</select>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="phonenumber">联系电话</label>
					<div class="controls">
						<input id="phonenumber" name="phonenumber" size="30" type="text"
							placeholder="联系电话"   required/>
					</div>
				</div>
			</fieldset>

			<fieldset>
				<legend>学生信息</legend>
				<div class="control-group">
					<label class="control-label" for="studentnumber">学号</label>
					<div class="controls">
						<input id="studentnumber" name="studentnumber" size="30"
							type="text" placeholder="学号"   required/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="college">学院</label>
					<div class="controls">
						<select id="college" name="college">
							<option value="文法学院">文法学院</option>
							<option value="外国语学院">外国语学院</option>
							<option value="艺术学院">艺术学院</option>
							<option value="工商管理学院">工商管理学院</option>
							<option value="理学院">理学院</option>
							<option value="资源与土木工程学院">资源与土木工程学院</option>
							<option value="材料与冶金学院">材料与冶金学院</option>
							<option value="机械工程与自动化学院">机械工程与自动化学院</option>
							<option value="信息科学与工程学院">信息科学与工程学院</option>
							<option value="软件学院">软件学院</option>
							<option value="中荷生物医学与信息工程学院">中荷生物医学与信息工程学院</option>
							<option value="国防教育学院">国防教育学院</option>
							<option value="体育部">体育部</option>
							<option value="秦皇岛分校">秦皇岛分校</option>
							<option value="计算中心[网络中心]">计算中心[网络中心]</option>
						</select>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="classname">班级</label>
					<div class="controls">
						<input id="classname" name="classname" size="30" type="text"
							placeholder="班级"   required/>
					</div>
				</div>
			</fieldset>

			<div class="form-actions">
				<label> <input type="checkbox" name="terms"
					checked="checked" value="true">&nbsp;&nbsp;同意 <a
					href="terms.jsp">社会实践中心协议</a> </label><br> <input
					class="btn btn-primary" type="submit" value="注册">
			</div>
		</form>

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
