package servlet;

import dao.*;

public class LoginCheck {

	public boolean isLogin (String email, String password) throws Exception{
		UserDAO userDAO = DAOFactory.getUserDAOInstance();
		User user = userDAO.queryByEmail(email);
		if (user == null)
			return false;
		if (password.equals(user.getPassword()))
			return true;
		else
			return false;
	}
}
