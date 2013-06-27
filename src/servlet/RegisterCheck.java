package servlet;

import dao.*;

public class RegisterCheck {

	public boolean registerOK (String email) throws Exception{
		UserDAO userDAO = DAOFactory.getUserDAOInstance();
		User user = userDAO.queryByEmail(email);
		if (user == null)
			return true;
		else
			return false;
	}
}
