package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ActivityDAO {
	
	public void insert(Activity activity) throws Exception {
		String sql = "INSERT INTO activityinfo (activityid,name,info,starttime,endtime) VALUES(null,?,?,?,?);";
		PreparedStatement pstmt = null;
		DatabaseConnector dbc = null;
		try{
			dbc = new DatabaseConnector();
			pstmt = dbc.getConnection().prepareStatement(sql);
			pstmt.setString(1, activity.getName());
			pstmt.setString(2, activity.getInfo());
			pstmt.setString(3, activity.getStarttime());
			pstmt.setString(4, activity.getEndtime());
			pstmt.executeUpdate();
			pstmt.close();
		}catch (Exception e){
			throw new Exception("操作出现异常");
		}
		finally{
			dbc.close();
		}
	}

	public void update(Activity activity) throws Exception {
		String sql = "UPDATE activityinfo SET name=?,starttime=?,endtime=?,info=? WHERE activityid=?;";
		PreparedStatement pstmt = null;
		DatabaseConnector dbc = null;
		try{
			dbc = new DatabaseConnector();
			pstmt = dbc.getConnection().prepareStatement(sql);
			pstmt.setString(1, activity.getName());
			pstmt.setString(2, activity.getStarttime());
			pstmt.setString(3, activity.getEndtime());
			pstmt.setString(4, activity.getInfo());
			pstmt.setInt(5, activity.getActivityid());
			pstmt.executeUpdate();
			pstmt.close();
		}catch (Exception e){
			throw new Exception("操作出现异常");
		}
		finally{
			dbc.close();
		}
	}

	public void delete(int activityid) throws Exception {
		String sql_activity = "DELETE FROM activityinfo WHERE activityid=?;";
		PreparedStatement pstmt_activity = null;
		DatabaseConnector dbc_activity = null;
		try{
			dbc_activity = new DatabaseConnector();
			pstmt_activity = dbc_activity.getConnection().prepareStatement(sql_activity);
			pstmt_activity.setInt(1, activityid);
			pstmt_activity.executeUpdate();
			pstmt_activity.close();
		}catch(Exception e){
			throw new Exception("操作出现异常");
		} finally {
			dbc_activity.close();
		}
		
		TeamDAO teamDAO = DAOFactory.getTeamDAOInstance();
		//ActivityMemberDAO activityMemberDAO = DAOFactory.getActivityMemberDAOInstance();
		List<Team> teamlist = teamDAO.queryByActivityId(activityid);
		
		for (Team team : teamlist) {
			String sql_am = "DELETE FROM activitymember WHERE teamid=?;";
			PreparedStatement pstmt_am = null;
			DatabaseConnector dbc_am = null;
			try{
				dbc_am = new DatabaseConnector();
				pstmt_am = dbc_am.getConnection().prepareStatement(sql_am);
				pstmt_am.setInt(1, team.getTeamid());
				pstmt_am.executeUpdate();
				pstmt_am.close();
			}catch(Exception e){
				throw new Exception("操作出现异常");
			} finally {
				dbc_am.close();
			}
		}
		
		String sql_team = "DELETE FROM team WHERE activityid=?;";
		PreparedStatement pstmt_team = null;
		DatabaseConnector dbc_team = null;
		try{
			dbc_team = new DatabaseConnector();
			pstmt_team = dbc_team.getConnection().prepareStatement(sql_team);
			pstmt_team.setInt(1, activityid);
			pstmt_team.executeUpdate();
			pstmt_team.close();
		}catch(Exception e){
			throw new Exception("操作出现异常");
		} finally {
			dbc_team.close();
		}
	}

	public Activity queryById(int activityid) throws Exception {
		Activity activity = null;
		String sql = "SELECT * FROM activityinfo WHERE activityid=?;";
		PreparedStatement pstmt = null;
		DatabaseConnector dbc = null;
		try{
			dbc = new DatabaseConnector();
			pstmt = dbc.getConnection().prepareStatement(sql);
			pstmt.setInt(1, activityid);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()){
				activity = new Activity();
				activity.setActivityid(rs.getInt(1));
				activity.setName(rs.getString(2));
				activity.setStarttime(rs.getString(3));
				activity.setEndtime(rs.getString(4));
				activity.setInfo(rs.getString(5));
			}
			rs.close();
			pstmt.close();
		} catch (Exception e){
			throw new Exception("操作出现异常");
		} finally {
			dbc.close();
		}
		return activity;
	}

	public List<Activity> queryAll() throws Exception {
		List<Activity> all = new ArrayList<Activity>();
		String sql = "SELECT * FROM activityinfo;";
		PreparedStatement pstmt = null;
		DatabaseConnector dbc = null;
		try{
			dbc = new DatabaseConnector();
			pstmt = dbc.getConnection().prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()){
				Activity activity = new Activity();
				activity.setActivityid(rs.getInt(1));
				activity.setName(rs.getString(2));
				activity.setStarttime(rs.getString(3));
				activity.setEndtime(rs.getString(4));
				activity.setInfo(rs.getString(5));
				all.add(activity);
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

}
