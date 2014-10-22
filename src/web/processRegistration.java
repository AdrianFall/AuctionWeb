package web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import auction.UserRegistrationSessionBeanRemote;

/**
 * Servlet implementation class processRegistration
 */
@WebServlet("/processRegistration")
public class processRegistration extends HttpServlet {
	@EJB UserRegistrationSessionBeanRemote userRegistrationSession;
	private static final long serialVersionUID = 1L;
	final String EMAIL_VALIDATION_REGEX = "^[\\w-_\\.+]*[\\w-_\\.]\\@([\\w]+\\.)+[\\w]+[\\w]$";
   
	/**
	 *  Constructor of the class processRegistration
	 */
    public processRegistration() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("TEST1");
		// Obtain the data of the forms passed through the request
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String firstname = request.getParameter("firstname");
		String lastname = request.getParameter("lastname");
		RequestDispatcher reqDispatcher;
		
		// If the input fields are not empty
		if (username != null && password != null && !username.trim().equals("") && !password.trim().equals("") && firstname != null && lastname != null && !firstname.trim().equals("") && !lastname.trim().equals("") && email != null && !email.trim().equals("")) {
			
			// Validate the email with a Regex.
			boolean matches = email.matches(EMAIL_VALIDATION_REGEX);
			
			// If the email is validated by the regex
			
			if (matches) {
				// Attempt to register the user
				boolean registered = userRegistrationSession.registerUser(username, password, email, firstname, lastname);
				if (registered) {
					request.setAttribute("Error", "You have been successfully registered.");
					reqDispatcher = request.getRequestDispatcher("Login.jsp");
				} else {
					request.setAttribute("ErrorUserExists", "User already exists, choose another one.");
				    reqDispatcher = request.getRequestDispatcher("Registration.jsp");
				}
				
			} else { // The email wasn't validated by regex
				request.setAttribute("ErrorEmptyFields", "The email you have entered could not be validated.");
				reqDispatcher = request.getRequestDispatcher("Registration.jsp");
			}
			
			
		} else { //some input fields were empty
		    request.setAttribute("ErrorEmptyFields", "Some of the required fields are empty!");
		    reqDispatcher = request.getRequestDispatcher("Registration.jsp");
		}
	    reqDispatcher.forward(request, response);
	    
		
	} // End of doPost method

}
