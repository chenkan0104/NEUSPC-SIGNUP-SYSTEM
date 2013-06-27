package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.*;

public class EditPassword extends HttpServlet {

	private static final long serialVersionUID = 1L;

	/**
	 * Constructor of the object.
	 */
	public EditPassword() {
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

		String oldpassword = request.getParameter("oldpassword");
		String newpassword = request.getParameter("newpassword");
		String renewpassword = request.getParameter("renewpassword");

		UserDAO userDAO = DAOFactory.getUserDAOInstance();
		User user = new User();
		
		HttpSession session = request.getSession();
		
		try {
			user = userDAO.queryByEmail((String) request.getSession().getAttribute("login"));
			if (!oldpassword.equals(user.getPassword())) {
				session.setAttribute("oldpasswordwrong", "true");
				response.sendRedirect("editPassword.jsp");
			}else if (!newpassword.equals(renewpassword)) {
				session.setAttribute("repasswordwrong", "true");
				response.sendRedirect("editPassword.jsp");
			} else {
				userDAO.updatePassword(newpassword, user.getUserid());
				session.setAttribute("editsuccess", "true");
				response.sendRedirect("index.jsp");
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
