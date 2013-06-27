package dao;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;

public class TeamDAO {

	public void insert(Team team) throws Exception {
		String sql = "INSERT INTO team (teamid,leaderid,name,teachername,status,activityid,createtime) VALUES(null,?,?,?,?,?,?);";
		PreparedStatement pstmt = null;
		DatabaseConnector dbc = null;
		try{
			dbc = new DatabaseConnector();
			pstmt = dbc.getConnection().prepareStatement(sql);
			pstmt.setInt(1, team.getLeaderid());
			pstmt.setString(2, team.getName());
			pstmt.setString(3, team.getTeachername());
			pstmt.setString(4, team.getStatus());
			pstmt.setInt(5, team.getActivityid());
			pstmt.setString(6, new SimpleDateFormat("yyyy-MM-dd HH:mm",Locale.SIMPLIFIED_CHINESE).format(new java.util.Date()));
			pstmt.executeUpdate();
			pstmt.close();
		}catch (Exception e){
			throw new Exception("操作出现异常");
		}
		finally{
			dbc.close();
		}
		
	}

	public void update(Team team) throws Exception {
		String sql = "UPDATE team SET leaderid=?,name=?,teachername=?,status=?,activityid=? WHERE teamid=?;";
		PreparedStatement pstmt = null;
		DatabaseConnector dbc = null;
		try{
			dbc = new DatabaseConnector();
			pstmt = dbc.getConnection().prepareStatement(sql);
			pstmt.setInt(1, team.getLeaderid());
			pstmt.setString(2, team.getName());
			pstmt.setString(3, team.getTeachername());
			pstmt.setString(4, team.getStatus());
			pstmt.setInt(5, team.getTeamid());
			pstmt.setInt(6, team.getActivityid());
			pstmt.executeUpdate();
			pstmt.close();
		}catch (Exception e){
			throw new Exception("操作出现异常");
		}
		finally{
			dbc.close();
		}
	}

	public void delete(int teamid) throws Exception {
		String sql = "DELETE FROM team WHERE teamid=?;";
		PreparedStatement pstmt = null;
		DatabaseConnector dbc = null;
		try{
			dbc = new DatabaseConnector();
			pstmt = dbc.getConnection().prepareStatement(sql);
			pstmt.setInt(1, teamid);
			pstmt.executeUpdate();
			pstmt.close();
		}catch(Exception e){
			throw new Exception("操作出现异常");
		} finally {
			dbc.close();
		}
	}

	public Team queryById(int teamid) throws Exception {
		Team team = null;
		String sql = "SELECT * FROM team WHERE teamid=?;";
		PreparedStatement pstmt = null;
		DatabaseConnector dbc = null;
		try{
			dbc = new DatabaseConnector();
			pstmt = dbc.getConnection().prepareStatement(sql);
			pstmt.setInt(1, teamid);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()){
				team = new Team();
				team.setTeamid(rs.getInt(1));
				team.setLeaderid(rs.getInt(2));
				team.setName(rs.getString(3));
				team.setTeachername(rs.getString(4));
				team.setStatus(rs.getString(5));
				team.setActivityid(rs.getInt(6));
				team.setCreatetime(rs.getString(7));
			}
			rs.close();
			pstmt.close();
		} catch (Exception e){
			throw new Exception("操作出现异常");
		} finally {
			dbc.close();
		}
		return team;
	}
	
	public Team queryByLeaderIdAndActivityId(int leaderid,int activityid) throws Exception {
		Team team = null;
		String sql = "SELECT * FROM team WHERE leaderid=?&&activityid=?;";
		PreparedStatement pstmt = null;
		DatabaseConnector dbc = null;
		try{
			dbc = new DatabaseConnector();
			pstmt = dbc.getConnection().prepareStatement(sql);
			pstmt.setInt(1, leaderid);
			pstmt.setInt(2, activityid);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()){
				team = new Team();
				team.setTeamid(rs.getInt(1));
				team.setLeaderid(rs.getInt(2));
				team.setName(rs.getString(3));
				team.setTeachername(rs.getString(4));
				team.setStatus(rs.getString(5));
				team.setActivityid(rs.getInt(6));
				team.setCreatetime(rs.getString(7));
			}
			rs.close();
			pstmt.close();
		} catch (Exception e){
			throw new Exception("操作出现异常");
		} finally {
			dbc.close();
		}
		return team;
	}
	
	public List<Team> queryByLeaderId(int leaderid) throws Exception {
		List<Team> all = new ArrayList<Team>();
		String sql = "SELECT * FROM team WHERE leaderid=?;";
		PreparedStatement pstmt = null;
		DatabaseConnector dbc = null;
		try{
			dbc = new DatabaseConnector();
			pstmt = dbc.getConnection().prepareStatement(sql);
			pstmt.setInt(1, leaderid);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()){
				Team team = new Team();
				team.setTeamid(rs.getInt(1));
				team.setLeaderid(rs.getInt(2));
				team.setName(rs.getString(3));
				team.setTeachername(rs.getString(4));
				team.setStatus(rs.getString(5));
				team.setActivityid(rs.getInt(6));
				team.setCreatetime(rs.getString(7));
				all.add(team);
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
	
	public List<Team> queryByActivityId(int activityid) throws Exception {
		List<Team> all = new ArrayList<Team>();
		String sql = "SELECT * FROM team WHERE activityid=?;";
		PreparedStatement pstmt = null;
		DatabaseConnector dbc = null;
		try{
			dbc = new DatabaseConnector();
			pstmt = dbc.getConnection().prepareStatement(sql);
			pstmt.setInt(1, activityid);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()){
				Team team = new Team();
				team.setTeamid(rs.getInt(1));
				team.setLeaderid(rs.getInt(2));
				team.setName(rs.getString(3));
				team.setTeachername(rs.getString(4));
				team.setStatus(rs.getString(5));
				team.setActivityid(rs.getInt(6));
				team.setCreatetime(rs.getString(7));
				all.add(team);
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

	public List<Team> queryAll() throws Exception {
		List<Team> all = new ArrayList<Team>();
		String sql = "SELECT * FROM team;";
		PreparedStatement pstmt = null;
		DatabaseConnector dbc = null;
		try{
			dbc = new DatabaseConnector();
			pstmt = dbc.getConnection().prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()){
				Team team = new Team();
				team.setTeamid(rs.getInt(1));
				team.setLeaderid(rs.getInt(2));
				team.setName(rs.getString(3));
				team.setTeachername(rs.getString(4));
				team.setStatus(rs.getString(5));
				team.setActivityid(rs.getInt(6));
				team.setCreatetime(rs.getString(7));
				all.add(team);
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

	public void updateStatus(int teamid, String status) throws Exception {
		
		String sql = "UPDATE team SET status=? WHERE teamid=?;";
		PreparedStatement pstmt = null;
		DatabaseConnector dbc = null;
		try{
			dbc = new DatabaseConnector();
			pstmt = dbc.getConnection().prepareStatement(sql);

			pstmt.setString(1, status);
			pstmt.setInt(2, teamid);
			pstmt.executeUpdate();
			pstmt.close();
		}catch (Exception e){
			throw new Exception("操作出现异常");
		}
		finally{
			dbc.close();
		}
	}
}
