package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.DAOFactory;
import dao.User;
import dao.UserDAO;

public class RegisterConf extends HttpServlet {

	private static final long serialVersionUID = 1L;

	/**
	 * Constructor of the object.
	 */
	public RegisterConf() {
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

		// String name = new
		// String(request.getParameter("name").getBytes("iso-8859-1"),"utf8");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String repassword = request.getParameter("repassword");
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

		HttpSession session = request.getSession();

		if (email.equals("") || password.equals("") || repassword.equals("")
				|| name.equals("") || gender.equals("")
				|| phonenumber.equals("") || studentnumber.equals("")
				|| college.equals("") || classname.equals("")) {
			session.setAttribute("empty", "true");
			response.sendRedirect("register.jsp");
			return;
		}

		if (!password.equals(repassword)) {
			session.setAttribute("repasswordwrong", "true");
			response.sendRedirect("register.jsp");
			return;
		}

		RegisterCheck rc = new RegisterCheck();
		try {
			if (rc.registerOK(email)) {
				session.setAttribute("login", email);

				UserDAO userDAO = DAOFactory.getUserDAOInstance();
				User user = new User();
				user.setEmail(email);
				user.setPassword(password);
				user.setName(name);
				user.setGender(gender);
				user.setPhonenumber(phonenumber);
				user.setStudentnumber(studentnumber);
				user.setCollege(college);
				user.setClassname(classname);
				userDAO.insert(user);

				// request.getRequestDispatcher("index.jsp").forward(request,
				// response);
				response.sendRedirect("login.jsp");
			} else {
				// request.getRequestDispatcher("register.jsp").forward(request,
				// response);
				session.setAttribute("emailwrong", "true");
				response.sendRedirect("register.jsp");
			}
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
