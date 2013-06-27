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

	<%
		if (session.getAttribute("login") == null) {
			session.setAttribute("alert", "true");
			response.sendRedirect("login.jsp");
			return;
		}
	 %>

	<div class="container">

		<div class="row">
			<div class="span12">

				<div class="page-header">
					<h1>个人资料</h1>
				</div>
				
				<%
					if (session.getAttribute("updatesuccess") != null) {
						out.print("<div class=\"help-block alert alert-success\">修改信息成功&hellip;</div>");
						session.removeAttribute("updatesuccess");
					} 
				 %>
				
				<form accept-charset="UTF-8" class="form-horizontal" method="post"
					action="UpdatePersonalInfo" id="updatepersonalinfo">
					<fieldset>
						<legend>基本信息</legend>
						<div class="control-group">
							<label class="control-label" for="fullname">姓名</label>
							<div class="controls">
								<input id="fullname" name="name" size="30" type="text"
									placeholder="我们需要你的真实姓名" value="<%out.print(user.getName());%>"
									required />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="gender">性别</label>
							<div class="controls">
								<select id="gender" name="gender">
									<option value="男"
										<%if (user.getGender().equals("男"))
				out.print("selected");%>>男</option>
									<option value="女"
										<%if (user.getGender().equals("女"))
				out.print("selected");%>>女</option>
									<option value="其他"
										<%if (user.getGender().equals("其他"))
				out.print("selected");%>>其他</option>
								</select>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="phonenumber">联系电话</label>
							<div class="controls">
								<input id="phonenumber" name="phonenumber" size="30" type="text"
									placeholder="联系电话"
									value="<%out.print(user.getPhonenumber());%>" required />
							</div>
						</div>
					</fieldset>

					<fieldset>
						<legend>学生信息</legend>
						<div class="control-group">
							<label class="control-label" for="studentnumber">学号</label>
							<div class="controls">
								<input id="studentnumber" name="studentnumber" size="30"
									type="text" placeholder="学号"
									value="<%out.print(user.getStudentnumber());%>" required />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="college">学院</label>
							<div class="controls">
								<select id="college" name="college">
									<option value="文法学院"
										<%if (user.getCollege().equals("文法学院"))
				out.print("selected");%>>文法学院</option>
									<option value="外国语学院"
										<%if (user.getCollege().equals("外国语学院"))
				out.print("selected");%>>外国语学院</option>
									<option value="艺术学院"
										<%if (user.getCollege().equals("艺术学院"))
				out.print("selected");%>>艺术学院</option>
									<option value="工商管理学院"
										<%if (user.getCollege().equals("工商管理学院"))
				out.print("selected");%>>工商管理学院</option>
									<option value="理学院"
										<%if (user.getCollege().equals("理学院"))
				out.print("selected");%>>理学院</option>
									<option value="资源与土木工程学院"
										<%if (user.getCollege().equals("资源与土木工程学院"))
				out.print("selected");%>>资源与土木工程学院</option>
									<option value="材料与冶金学院"
										<%if (user.getCollege().equals("材料与冶金学院"))
				out.print("selected");%>>材料与冶金学院</option>
									<option value="机械工程与自动化学院"
										<%if (user.getCollege().equals("机械工程与自动化学院"))
				out.print("selected");%>>机械工程与自动化学院</option>
									<option value="信息科学与工程学院"
										<%if (user.getCollege().equals("信息科学与工程学院"))
				out.print("selected");%>>信息科学与工程学院</option>
									<option value="软件学院"
										<%if (user.getCollege().equals("软件学院"))
				out.print("selected");%>>软件学院</option>
									<option value="中荷生物医学与信息工程学院"
										<%if (user.getCollege().equals("中荷生物医学与信息工程学院"))
				out.print("selected");%>>中荷生物医学与信息工程学院</option>
									<option value="国防教育学院"
										<%if (user.getCollege().equals("国防教育学院"))
				out.print("selected");%>>国防教育学院</option>
									<option value="体育部"
										<%if (user.getCollege().equals("体育部"))
				out.print("selected");%>>体育部</option>
									<option value="秦皇岛分校"
										<%if (user.getCollege().equals("秦皇岛分校"))
				out.print("selected");%>>秦皇岛分校</option>
									<option value="计算中心[网络中心]"
										<%if (user.getCollege().equals("计算中心[网络中心]"))
				out.print("selected");%>>计算中心[网络中心]</option>
								</select>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="classname">班级</label>
							<div class="controls">
								<input id="classname" name="classname" size="30" type="text"
									placeholder="班级" value="<%out.print(user.getClassname());%>"
									required />
							</div>
						</div>
					</fieldset>

					<!-- <fieldset>
						<legend>用户头像</legend>
						<div class="control-group">
							<div class="controls">
								<img alt="Noavatar" height="128" src="">
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="user_avatar">个人头像照片</label>
							<div class="controls">
								<input id="user_avatar" name="user[avatar]" type="file">
							</div>
						</div>
					</fieldset> -->

					<div class="form-actions">
						<input class="btn btn-primary" type="submit" value="提交修改">
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
