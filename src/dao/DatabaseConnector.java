package dao;

import java.sql.*;

public class DatabaseConnector {

	private final String DBDRIVER = "com.mysql.jdbc.Driver";
	private final String DBURL = "jdbc:mysql://localhost:3306/javaweb";
	private final String DBUSER = "root";
	private final String DBPASSWORD = "admin";
	private Connection conn = null;
	
	public DatabaseConnector(){
		try{
			Class.forName(DBDRIVER);
			this.conn = DriverManager.getConnection(DBURL,DBUSER,DBPASSWORD);
		} catch (Exception e){
			System.out.println("加载驱动失败");
		}
	}
	public Connection getConnection(){
		return conn;
	}
	public void close(){
		try{
			conn.close();
		}catch(Exception e){
			System.out.println("数据库连接关闭失败");
		}
	}
}
