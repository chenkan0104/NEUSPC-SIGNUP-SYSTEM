package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Activity;
import dao.ActivityDAO;
import dao.DAOFactory;

/**
 * Servlet implementation class AddActivity
 */
@WebServlet("/AddActivity")
public class AddActivity extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddActivity() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String name = new String(request.getParameter("name").getBytes("iso-8859-1"),"utf8");
		String info = new String(request.getParameter("info").getBytes("iso-8859-1"),"utf8");
		String starttime = request.getParameter("starttime");
		String endtime = request.getParameter("endtime");
		
		ActivityDAO activityDAO = DAOFactory.getActivityDAOInstance(); 
		Activity activity = new Activity();
		activity.setName(name);
		activity.setInfo(info);
		activity.setStarttime(starttime);
		activity.setEndtime(endtime);
		try {
			activityDAO.insert(activity);
			response.sendRedirect("admin.jsp");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request,response);
	}

}
