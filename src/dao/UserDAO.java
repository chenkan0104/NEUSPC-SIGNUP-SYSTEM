package dao;

import java.sql.*;
import java.util.*;

public class UserDAO {

	public void insert(User user) throws Exception {
		String sql = "INSERT INTO user (email,name,studentnumber,college,classname,gender,password,phonenumber) VALUES(?,?,?,?,?,?,?,?);";
		PreparedStatement pstmt = null;
		DatabaseConnector dbc = null;
		try{
			dbc = new DatabaseConnector();
			pstmt = dbc.getConnection().prepareStatement(sql);
			pstmt.setString(1, user.getEmail());
			pstmt.setString(2, user.getName());
			pstmt.setString(3, user.getStudentnumber());
			pstmt.setString(4, user.getCollege());
			pstmt.setString(5, user.getClassname());
			pstmt.setString(6, user.getGender());
			pstmt.setString(7, user.getPassword());
			pstmt.setString(8, user.getPhonenumber());
			pstmt.executeUpdate();
			pstmt.close();
		}catch (Exception e){
			throw new Exception("操作出现异常");
		}
		finally{
			dbc.close();
		}
		
	}

	public void update(User user) throws Exception {
		String sql = "UPDATE user SET name=?,gender=?,phonenumber=?,studentnumber=?,college=?,classname=? WHERE userid=?;";
		PreparedStatement pstmt = null;
		DatabaseConnector dbc = null;
		try{
			dbc = new DatabaseConnector();
			pstmt = dbc.getConnection().prepareStatement(sql);
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getGender());
			pstmt.setString(3, user.getPhonenumber());
			pstmt.setString(4, user.getStudentnumber());
			pstmt.setString(5, user.getCollege());
			pstmt.setString(6, user.getClassname());
			pstmt.setInt(7, user.getUserid());
			pstmt.executeUpdate();
			pstmt.close();
		}catch (Exception e){
			throw new Exception("操作出现异常");
		}
		finally{
			dbc.close();
		}
	}

	public void updatePassword(String newpassword,int userid) throws Exception {
		String sql = "UPDATE user SET password=? WHERE userid=?;";
		PreparedStatement pstmt = null;
		DatabaseConnector dbc = null;
		try{
			dbc = new DatabaseConnector();
			pstmt = dbc.getConnection().prepareStatement(sql);
			pstmt.setString(1, newpassword);
			pstmt.setInt(2,userid);
			pstmt.executeUpdate();
			pstmt.close();
		}catch (Exception e){
			throw new Exception("操作出现异常");
		}
		finally{
			dbc.close();
		}
	}

	public void delete(int userid) throws Exception {
		String sql = "DELETE FROM user WHERE userid=?;";
		PreparedStatement pstmt = null;
		DatabaseConnector dbc = null;
		try{
			dbc = new DatabaseConnector();
			pstmt = dbc.getConnection().prepareStatement(sql);
			pstmt.setInt(1, userid);
			pstmt.executeUpdate();
			pstmt.close();
		}catch(Exception e){
			throw new Exception("操作出现异常");
		} finally {
			dbc.close();
		}
	}

	public User queryById(int userid) throws Exception {
		User user = null;
		String sql = "SELECT * FROM user WHERE userid=?;";
		PreparedStatement pstmt = null;
		DatabaseConnector dbc = null;
		try{
			dbc = new DatabaseConnector();
			pstmt = dbc.getConnection().prepareStatement(sql);
			pstmt.setInt(1, userid);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()){
				user = new User();
				user.setUserid(rs.getInt(1));
				user.setEmail(rs.getString(2));
				user.setName(rs.getString(3));
				user.setStudentnumber(rs.getString(4));
				user.setCollege(rs.getString(5));
				user.setClassname(rs.getString(6));
				user.setGender(rs.getString(7));
				user.setPassword(rs.getString(8));
				user.setPhonenumber(rs.getString(9));
			}
			rs.close();
			pstmt.close();
		} catch (Exception e){
			throw new Exception("操作出现异常");
		} finally {
			dbc.close();
		}
		return user;
	}

	public List<User> queryAll() throws Exception {
		List<User> all = new ArrayList<User>();
		String sql = "SELECT * FROM user;";
		PreparedStatement pstmt = null;
		DatabaseConnector dbc = null;
		try{
			dbc = new DatabaseConnector();
			pstmt = dbc.getConnection().prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()){
				User user = new User();
				user.setUserid(rs.getInt(1));
				user.setEmail(rs.getString(2));
				user.setName(rs.getString(3));
				user.setStudentnumber(rs.getString(4));
				user.setCollege(rs.getString(5));
				user.setClassname(rs.getString(6));
				user.setGender(rs.getString(7));
				user.setPassword(rs.getString(8));
				user.setPhonenumber(rs.getString(9));
				all.add(user);
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			throw new Exception("操作出现异常");
		} finally {
			dbc.close();
		}
		return all;
	}

	public User queryByEmail(String email) throws Exception {
		User user = null;
		String sql = "SELECT * FROM user WHERE email=?;";
		PreparedStatement pstmt = null;
		DatabaseConnector dbc = null;
		try{
			dbc = new DatabaseConnector();
			pstmt = dbc.getConnection().prepareStatement(sql);
			pstmt.setString(1, email);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()){
				user = new User();
				user.setUserid(rs.getInt(1));
				user.setEmail(rs.getString(2));
				user.setName(rs.getString(3));
				user.setStudentnumber(rs.getString(4));
				user.setCollege(rs.getString(5));
				user.setClassname(rs.getString(6));
				user.setGender(rs.getString(7));
				user.setPassword(rs.getString(8));
				user.setPhonenumber(rs.getString(9));
			}
			rs.close();
			pstmt.close();
		} catch (Exception e){
			throw new Exception("操作出现异常");
		} finally {
			dbc.close();
		}
		return user;
	}
}
