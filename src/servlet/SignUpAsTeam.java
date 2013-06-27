package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ActivityMember;
import dao.ActivityMemberDAO;
import dao.DAOFactory;
import dao.Team;
import dao.TeamDAO;
import dao.User;
import dao.UserDAO;

public class SignUpAsTeam extends HttpServlet {

	private static final long serialVersionUID = 1L;

	/**
	 * Constructor of the object.
	 */
	public SignUpAsTeam() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String teamname = new String(request.getParameter("teamname").getBytes("iso-8859-1"),"utf8");
		String teachername = new String(request.getParameter("teachername").getBytes("iso-8859-1"),"utf8");
		int activityid = Integer.parseInt(request.getParameter("activityid"));
		
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("login");
		
		UserDAO userDAO = DAOFactory.getUserDAOInstance();
		try {
			User user = userDAO.queryByEmail(email);
			int leaderid = user.getUserid();
			
			Team team = new Team();
			team.setName(teamname);
			team.setLeaderid(leaderid);
			team.setTeachername(teachername);
			team.setStatus("Î´ÉúÐ§");
			team.setActivityid(activityid);
			
			TeamDAO teamDAO = DAOFactory.getTeamDAOInstance();
			
			if (teamDAO.queryByLeaderIdAndActivityId(leaderid, activityid) != null) {
				session.setAttribute("reapply", "true");
				response.sendRedirect("ActivityPage?id="+activityid);
				return;
			}
			
			teamDAO.insert(team);
			
			int teamid = teamDAO.queryByLeaderIdAndActivityId(leaderid,activityid).getTeamid();
			
			ActivityMember activityMember = new ActivityMember();
			activityMember.setTeamid(teamid);
			activityMember.setUserid(leaderid);
			
			ActivityMemberDAO activityMemberDAO = DAOFactory.getActivityMemberDAOInstance();
			activityMemberDAO.insert(activityMember);
			
			session.setAttribute("signup", "success");
			response.sendRedirect("ActivityPage?id="+activityid);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request,response);
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}
}
