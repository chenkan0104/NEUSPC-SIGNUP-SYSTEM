package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ActivityMemberDAO {

	public void insert(ActivityMember activityMember) throws Exception {
		String sql = "INSERT INTO activitymember (userid,teamid) VALUES(?,?);";
		PreparedStatement pstmt = null;
		DatabaseConnector dbc = null;
		try{
			dbc = new DatabaseConnector();
			pstmt = dbc.getConnection().prepareStatement(sql);
			pstmt.setInt(1, activityMember.getUserid());
			pstmt.setInt(2, activityMember.getTeamid());
			pstmt.executeUpdate();
			pstmt.close();
		}catch (Exception e){
			throw new Exception("操作出现异常");
		}
		finally{
			dbc.close();
		}
		
	}

	public List<ActivityMember> queryByTeamId(int teamid) throws Exception {
		List<ActivityMember> activityMemberList = new ArrayList<ActivityMember>();
		String sql = "SELECT * FROM activitymember WHERE teamid=?;";
		PreparedStatement pstmt = null;
		DatabaseConnector dbc = null;
		try{
			dbc = new DatabaseConnector();
			pstmt = dbc.getConnection().prepareStatement(sql);
			pstmt.setInt(1, teamid);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()){
				ActivityMember activityMember = new ActivityMember();
				activityMember.setUserid(rs.getInt(1));
				activityMember.setTeamid(rs.getInt(2));
				activityMemberList.add(activityMember);
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			throw new Exception("操作出现异常");
		} finally {
			dbc.close();
		}
		return activityMemberList;
	}
	
	public List<ActivityMember> queryByUserId(int userid) throws Exception {
		List<ActivityMember> activityMemberList = null;
		String sql = "SELECT * FROM activitymember WHERE userid=?;";
		PreparedStatement pstmt = null;
		DatabaseConnector dbc = null;
		try{
			activityMemberList = new ArrayList<ActivityMember>();
			dbc = new DatabaseConnector();
			pstmt = dbc.getConnection().prepareStatement(sql);
			pstmt.setInt(1, userid);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()){
				ActivityMember activityMember = new ActivityMember();
				activityMember.setUserid(rs.getInt(1));
				activityMember.setTeamid(rs.getInt(2));
				activityMemberList.add(activityMember);
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			throw new Exception("操作出现异常");
		} finally {
			dbc.close();
		}
		return activityMemberList;
	}
	
	public ActivityMember queryByUserIdAndTeamId(int userid, int teamid) throws Exception {
		ActivityMember activityMember = null;
		String sql = "SELECT * FROM activitymember WHERE userid=?&&teamid=?;";
		PreparedStatement pstmt = null;
		DatabaseConnector dbc = null;
		try{
			dbc = new DatabaseConnector();
			pstmt = dbc.getConnection().prepareStatement(sql);
			pstmt.setInt(1, userid);
			pstmt.setInt(2, teamid);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()){
				activityMember = new ActivityMember();
				activityMember.setUserid(rs.getInt(1));
				activityMember.setTeamid(rs.getInt(2));
			}
			rs.close();
			pstmt.close();
		} catch (Exception e){
			throw new Exception("操作出现异常");
		} finally {
			dbc.close();
		}
		return activityMember;
	}
}
