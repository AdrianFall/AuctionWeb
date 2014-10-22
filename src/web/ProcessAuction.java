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

/**
 * Servlet implementation class processItem
 */
@WebServlet("/ProcessAuction")
public class ProcessAuction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@EJB AuctionRegistrationSessionBeanRemote auctionRegistrationSession;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProcessAuction() {
        super();
    }
    
   @PostConstruct
	public
	void init() {}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Obtain the categories from the session bean and dispatch them through the request
		HttpSession session = request.getSession();
		//Obtain session and dispatch if the username is null
		RequestDispatcher reqDispatcher = request.getRequestDispatcher("InsertAuction.jsp");
		String username = (String) session.getAttribute("username");
		if (username == null) {
			request.setAttribute("Error", "You need to be logged in to access this page.");
			reqDispatcher = request.getRequestDispatcher("Login.jsp");
		} else {
			String from = request.getParameter("from");
			if (from == null) {
				ArrayList<String> items = obtainItemsByUser(username);
				request.setAttribute("items", items);
				reqDispatcher = request.getRequestDispatcher("InsertAuction.jsp");
			} else if (from.equals("newAuction")) {
				ArrayList<String> items = obtainItemsByUser(username);
				request.setAttribute("items", items);
			} else if (from.equals("myAuctions")) {
				ArrayList<Map<String,String>> auctions = auctionRegistrationSession.getAuctionsByUser(username);
				System.out.println("Obtained auctions = " + auctions);
				request.setAttribute("auctions", auctions);
				reqDispatcher = request.getRequestDispatcher("MyAuctions.jsp");
			}
		}
		reqDispatcher.forward(request, response);
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Process the new auction request
		System.out.println("Processing new auction request...");
		String auctionName = (String) request.getParameter("auctionName");
		System.out.println("auctionName = " + auctionName);
		
		RequestDispatcher reqDispatch = request.getRequestDispatcher("InsertAuction.jsp");
		
		String itemField = (String) request.getParameter("items");
		
		if (itemField == null) {
			request.setAttribute("ErrorItem", "Please <a href='ProcessItem?from=insertNewItem'>insert a new item.</a>");
			reqDispatch.forward(request, response);
		} else {
		
			System.out.println("itemField = " + itemField);
			
			String[] itemSplit = itemField.split(":");
			String itemId = itemSplit[0];
			String itemName = itemSplit[1];
			
			String auctionDescription = (String) request.getParameter("auctionDescription");
			System.out.println("auctionDescription = " + auctionDescription);
			
			String startPrice = (String) request.getParameter("startPrice");
			System.out.println("startPrice = " + startPrice);
			
			String auctionDurationDays = (String) request.getParameter("days");
			String auctionDurationHours = (String) request.getParameter("hours");
			String auctionDurationMinutes = (String) request.getParameter("minutes");
			System.out.println("auctionDuration - Days " + auctionDurationDays + " Hours " 
							   + auctionDurationHours + " Minutes " + auctionDurationMinutes);
			
			
			
			// Check if obtained parameters are not empty.
			if (!auctionName.trim().equals("") && !auctionDescription.trim().equals("") && !startPrice.trim().equals("")) {
				
				// Check that the start price is a number
				try {
					float startPriceFloat = Float.valueOf(startPrice);

					// Check that the auction duration lasts at least 1 minute
					if (auctionDurationDays.equals("0") && auctionDurationHours.equals("0") 
						&& auctionDurationMinutes.equals("0")) {
						HttpSession session = request.getSession();
						String username = (String) session.getAttribute("username");
						ArrayList<String> items = obtainItemsByUser(username);
						request.setAttribute("items", items);
						request.setAttribute("ErrorWrongNum", "Please define the auction duration.");
						reqDispatch.forward(request, response);
					} else { // Add the new auction
						int auctionId = auctionRegistrationSession.addAuction(auctionName, itemId, auctionDescription, startPrice, auctionDurationDays, auctionDurationHours, auctionDurationMinutes);
						/*reqDispatch = request.getRequestDispatcher("ProcessBids?from=seeAll");
						reqDispatch.forward(request, response);*/
						response.sendRedirect("/MiniEbayWeb/ProcessBids?from=seeAll&auctionId=" + auctionId);
					}
				} catch (NumberFormatException e) {
					System.out.println("Catched number format exception - " + e.getMessage());
					HttpSession session = request.getSession();
					String username = (String) session.getAttribute("username");
					ArrayList<String> items = obtainItemsByUser(username);
					request.setAttribute("items", items);
					request.setAttribute("ErrorWrongNum", "Invalid price amount.");
					reqDispatch.forward(request, response);
				}
				
			} else { // At least one of the obtained attributes was empty.
				HttpSession session = request.getSession(); 
				String username = (String) session.getAttribute("username");
				ArrayList<String> items = obtainItemsByUser(username);
				request.setAttribute("items", items);
				request.setAttribute("ErrorEmptyFields", "Some of the fields were empty.");
				reqDispatch.forward(request, response);
			}
		}
		
	}
	
	public ArrayList<String> obtainItemsByUser(String userId) {
		ArrayList<String> categories = auctionRegistrationSession.getItems(userId);
		return categories;
	}
	
	
}
