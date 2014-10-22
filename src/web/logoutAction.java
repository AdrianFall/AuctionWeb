package web;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class logoutAction
 */
@WebServlet("/logoutAction")
public class logoutAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public logoutAction() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Initialise the requestDispatcher and set it so that it forwards to Login.jsp by default
		RequestDispatcher reqDispatcher = request.getRequestDispatcher("Login.jsp");

		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");
		
		// If the username is already logged out
		if (username == null) {
			request.setAttribute("Error", "You are already logged out.");
		} else {
			// Remove all the session attributes to invalidate the session
			session.removeAttribute("username");
			session.removeAttribute("email");
			session.removeAttribute("firstname");
			session.removeAttribute("lastname");
			request.setAttribute("Error", "You have been logged out.");
		}
		
		reqDispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("logoutAction - do post");
	}

}
