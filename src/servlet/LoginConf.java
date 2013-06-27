package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LoginConf
 */
@WebServlet("/LoginConf")
public class LoginConf extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginConf() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");

		HttpSession session = request.getSession();
		
		if (email.equals("") || password.equals("")) {
			session.setAttribute("empty", "true");
			response.sendRedirect("login.jsp");
			return;
		}
		
		if (email.equals("admin") && password.equals("admin")) {
			session.setAttribute("login", email);
			response.sendRedirect("admin.jsp");
			return;
		} else {
			LoginCheck lc = new LoginCheck();
			try {
				if (lc.isLogin(email, password)) {
					session.setAttribute("login", email);
					response.sendRedirect("index.jsp");
					// request.getRequestDispatcher("login_success.jsp").forward(request,
					// response);
				} else {
					// request.getRequestDispatcher("login.jsp").forward(request,
					// response);
					session.setAttribute("loginwrong", "true");
					response.sendRedirect("login.jsp");
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
