package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DAOFactory;
import dao.User;

public class UpdatePersonalInfo extends HttpServlet {

	private static final long serialVersionUID = 1L;

	/**
	 * Constructor of the object.
	 */
	public UpdatePersonalInfo() {
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

		String email = (String) request.getSession().getAttribute("login");
		String name = new String(request.getParameter("name").getBytes(
				"iso-8859-1"), "utf8");
		String gender = new String(request.getParameter("gender").getBytes(
				"iso-8859-1"), "utf8");
		String phonenumber = request.getParameter("phonenumber");
		String studentnumber = request.getParameter("studentnumber");
		String college = new String(request.getParameter("college").getBytes(
				"iso-8859-1"), "utf8");
		String classname = new String(request.getParameter("classname")
				.getBytes("iso-8859-1"), "utf8");

		try {
			User user = DAOFactory.getUserDAOInstance().queryByEmail(email);
			user.setName(name);
			user.setGender(gender);
			user.setPhonenumber(phonenumber);
			user.setStudentnumber(studentnumber);
			user.setCollege(college);
			user.setClassname(classname);
			DAOFactory.getUserDAOInstance().update(user);

			request.getSession().setAttribute("updatesuccess", "true");
			response.sendRedirect("PersonalInformation.jsp");
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
