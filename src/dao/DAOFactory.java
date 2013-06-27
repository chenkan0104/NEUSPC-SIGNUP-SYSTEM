package dao;

public class DAOFactory {
	public static UserDAO getUserDAOInstance(){
		return new UserDAO();
	}
	public static ActivityDAO getActivityDAOInstance(){
		return new ActivityDAO();
	}
	public static TeamDAO getTeamDAOInstance(){
		return new TeamDAO();
	}
	public static ActivityMemberDAO getActivityMemberDAOInstance(){
		return new ActivityMemberDAO();
	}
}
