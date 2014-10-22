package web;

import java.io.IOException;
import java.util.Map;

import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sun.xml.ws.runtime.dev.Session;

import auction.UserRegistrationSessionBeanRemote;

/**
 * Servlet implementation class loginAction
 */
@WebServlet("/loginAction")
public class loginAction extends HttpServlet {
	@EJB UserRegistrationSessionBeanRemote userRegistrationSession;
	private static final long serialVersionUID = 1L;

	
	public loginAction() {
		super();
		// TODO Auto-generated constructor stub
	}

	/*
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {}*/

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		// Initialise the requestDispatcher and set it so that it forwards to Login.jsp by default
		RequestDispatcher reqDispatcher = request.getRequestDispatcher("Login.jsp");

		// Obtain the data of the form input fields passed through the request
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		// Check that all the input fields are not empty.
		if (username != null && password != null && !username.trim().equals("")
				&& !password.trim().equals("")) {
			
			boolean userExists = userRegistrationSession.getUserExists(username);
			
			if (userExists) {
				boolean userMatchesPass = userRegistrationSession.getUserMatchesPassword(username, password);
				if (userMatchesPass) {
					// Obtain the user details
					Map<String, String> userRecord = userRegistrationSession.obtainUserRecord(username);
					String email = userRecord.get("EMAIL");
					String firstname = userRecord.get("FIRST_NAME");
					String lastname = userRecord.get("LAST_NAME");
					
					HttpSession session = request.getSession();
					
					// Set the session attributes
					session.setAttribute("username", username);
					session.setAttribute("email", email);
					session.setAttribute("firstname", firstname);
					session.setAttribute("lastname", lastname);
					
					// Set the request dispatcher to be forwarded to member area jsp
					reqDispatcher = request.getRequestDispatcher("Member.jsp");
				} else { // The username didn't match with password
					request.setAttribute("Error", "The username doesn't match with password.");
				}
			} else { // The username doesn't exist in database
				request.setAttribute("Error", "The username doesn't exists.");
			}
		} else { // Some or all input fields are empty
			request.setAttribute("Error", "Username or password field empty.");
		}
		reqDispatcher.forward(request, response);

	} // End of doPost method

}
