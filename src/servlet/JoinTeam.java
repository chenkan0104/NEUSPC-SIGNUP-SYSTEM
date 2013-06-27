package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.*;

public class JoinTeam extends HttpServlet {

	private static final long serialVersionUID = 1L;

	/**
	 * Constructor of the object.
	 */
	public JoinTeam() {
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

		HttpSession session = request.getSession();
		
		int teamid = Integer.parseInt(request.getParameter("id"));
		try {
			int userid = DAOFactory.getUserDAOInstance().queryByEmail((String)session.getAttribute("login")).getUserid();
			ActivityMemberDAO activityMemberDAO = DAOFactory.getActivityMemberDAOInstance();
			if (activityMemberDAO.queryByUserIdAndTeamId(userid, teamid) != null) {
				session.setAttribute("exist", "true");
				response.sendRedirect("TeamPage?id="+teamid);
				return;
			} else {
				ActivityMember activityMember = new ActivityMember();
				activityMember.setUserid(userid);
				activityMember.setTeamid(teamid);
				activityMemberDAO.insert(activityMember);
				session.setAttribute("joinsuccess", "true");
				response.sendRedirect("TeamPage?id="+teamid);
			}
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
