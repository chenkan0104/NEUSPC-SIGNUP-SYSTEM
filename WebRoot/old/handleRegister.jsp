<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'handleRegister.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    <jsp:useBean id="user" scope="page" class="javaweb.UserBean"></jsp:useBean>
    <jsp:setProperty property="name" name="user"/>
    <jsp:setProperty property="schoolnumber" name="user"/>
    <jsp:setProperty property="email" name="user"/>
    <jsp:setProperty property="password" name="user"/>
    <%
    	Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
    	try{
    		Class.forName("com.mysql.jdbc.Driver");
    		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/javaweb?user=root&password=admin");
    	} catch (ClassNotFoundException e) {
    		out.println("找不到驱动类");
    	} catch (SQLException e) {
    		out.println("连接MYSQL数据库失败");
    	}
    	try{
    		String queryAll = "SELECT * FROM user WHERE email=?;";
    		pstmt = conn.prepareStatement(queryAll);
    		pstmt.setString(1,user.getEmail());
    		rs = pstmt.executeQuery();
    		if (rs.next()){
    			out.println("This email has been taken!");
    		}
    		else{
    			String addUser = "INSERT INTO user(userid,name,schoolnumber,password,email) VALUES(null,?,?,?,?);";
    			pstmt = conn.prepareStatement(addUser);
    			pstmt.setString(1,new String(user.getName().getBytes("iso-8859-1"),"utf8"));
    			pstmt.setString(2, user.getSchoolnumber());
    			pstmt.setString(3,user.getPassword());
    			pstmt.setString(4, user.getEmail());
    			pstmt.executeUpdate();
    			out.println("Welcome, "+new String(user.getName().getBytes("iso-8859-1"),"utf8")+"!<br>");
    		}
    	} catch (SQLException e) {
    		out.println("数据库处理失败");
    	}
    	try{
    		if (rs != null) {
    			rs.close();
    			rs = null;
    		}
    		if (pstmt != null) {
    			pstmt.close();
    			pstmt = null;
    		}
    		if (conn != null) {
    			conn.close();
    			conn = null;
    		}
    	} catch (Exception e) {
    		out.println("数据库关闭异常");
    	}
     %>
  </body>
</html>
