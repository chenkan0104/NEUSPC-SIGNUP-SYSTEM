package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Activity;
import dao.ActivityDAO;
import dao.DAOFactory;

public class EditActivity extends HttpServlet {

	private static final long serialVersionUID = 1L;

	/**
	 * Constructor of the object.
	 */
	public EditActivity() {
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
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int activityid = Integer.parseInt(request.getParameter("activityid"));
		String name = new String(request.getParameter("name").getBytes(
				"iso-8859-1"), "utf8");
		String info = new String(request.getParameter("info").getBytes(
				"iso-8859-1"), "utf8");
		String starttime = request.getParameter("starttime");
		String endtime = request.getParameter("endtime");

		ActivityDAO activityDAO = DAOFactory.getActivityDAOInstance();
		Activity activity = new Activity();
		activity.setActivityid(activityid);
		activity.setName(name);
		activity.setInfo(info);
		activity.setStarttime(starttime);
		activity.setEndtime(endtime);
		try {
			activityDAO.update(activity);
			request.getSession().setAttribute("edit", "false");
			response.sendRedirect("EditActivityPage?id="+activityid);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * The doPost method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to
	 * post.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

	/**
	 * Initialization of the servlet. <br>
	 * 
	 * @throws ServletException
	 *             if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
