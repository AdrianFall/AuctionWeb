package web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import auction.AuctionRegistrationSessionBeanRemote;
import auction.ItemRegistrationSessionBeanRemote;

/**
 * Servlet implementation class processItem
 */
@WebServlet("/ProcessItem")
public class ProcessItem extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@EJB ItemRegistrationSessionBeanRemote itemRegistrationSession;
	@EJB AuctionRegistrationSessionBeanRemote auctionRegistrationSession;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProcessItem() {
        super();
    }
    
   @PostConstruct
	public
	void init() {}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher reqDispatcher = request.getRequestDispatcher("ProcessItem?from=myItems");
		HttpSession session = request.getSession();
		
		//Obtain session and dispatch if the username is null
		String username = (String) session.getAttribute("username");
		if (username == null) {
			request.setAttribute("Error", "You need to be logged in to access this page.");
			reqDispatcher = request.getRequestDispatcher("Login.jsp");
		} else { // The user is logged in
	
			String from = request.getParameter("from");
			System.out.println("From = " + from);
			if (from.equals("insertNewItem")) {
			ArrayList<String> categories = obtainCategories();
			request.setAttribute("categories", categories);
			reqDispatcher = request.getRequestDispatcher("InsertItem.jsp");
			} else if (from.equals("myItems")) {
				ArrayList<Map<String,String>> myItems = obtainMyItems(username);
				System.out.println("myItems= " + myItems);
				request.setAttribute("items", myItems);
				reqDispatcher = request.getRequestDispatcher("MyItems.jsp");
			} 
		}
		reqDispatcher.forward(request, response);
	}
	private ArrayList<Map<String,String>> obtainMyItems(String username) {
		ArrayList<Map<String,String>> items = itemRegistrationSession.getItemsOfUser(username);
		return items;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");
		// Process the new item request
		System.out.println("Processing new item request...");
		String itemName = (String) request.getParameter("itemName");
		System.out.println("itemName = " + itemName);
		String itemModel = (String) request.getParameter("itemModel");
		System.out.println("itemModel = " + itemModel);
		String category = (String) request.getParameter("category");
		System.out.println("category = " + category);
		String itemDescription = (String) request.getParameter("itemDescription");
		System.out.println("itemDescription = " + itemDescription);
		
		RequestDispatcher reqDispatch = request.getRequestDispatcher("InsertItem.jsp");
		
		// Check if obtained parameters are not empty.
		if (!itemName.trim().equals("") && !itemModel.trim().equals("") && !category.trim().equals("")
			&& !itemDescription.trim().equals("")) {
			
			//Obtain the username from the session
			
			// Add the new item
			itemRegistrationSession.registerNewItem(itemName, itemModel, itemDescription, category, username);
			ArrayList<Map<String,String>> myItems = obtainMyItems(username);
			System.out.println("myItems= " + myItems);
			request.setAttribute("items", myItems);
			reqDispatch = request.getRequestDispatcher("MyItems.jsp");
			reqDispatch.forward(request, response);
			
		} else { // At least one of the obtained attributes was empty.
			ArrayList<String> categories = obtainCategories();
			request.setAttribute("categories", categories);
			request.setAttribute("ErrorEmptyFields", "Some of the fields were empty.");
			reqDispatch.forward(request, response);
		}
		
	}
	
	@PostConstruct
	public ArrayList<String> obtainCategories() {
		ArrayList<String> categories = itemRegistrationSession.getCategories();
		return categories;
	}
}
