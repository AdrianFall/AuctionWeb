package web;

import java.io.IOException;
import java.sql.Time;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;

import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import auction.AuctionRegistrationSessionBeanRemote;
import auction.BidRegistrationSessionBeanRemote;

/**
 * Servlet implementation class ProcessBids
 */
@WebServlet("/ProcessBids")
public class ProcessBids extends HttpServlet {
	@EJB AuctionRegistrationSessionBeanRemote auctionSession;
	@EJB BidRegistrationSessionBeanRemote bidSession;
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProcessBids() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");
		RequestDispatcher reqDisp = request.getRequestDispatcher("AllAuctions.jsp");
		if (username == null) {
			System.out.println("TEST !!! USERNAME NULL");
		} else {
			System.out.println("TEST!!! USERNAME = " + username);
		}
			String from = request.getParameter("from");
			if (from.equals("seeAll")) {
				//Obtain all the auctions and their bids
				if (request.getParameter("category") != null) {
					ArrayList<Map<String,String>> categoryAuctions = auctionSession.getAuctionsByCategory(request.getParameter("category"));
					ArrayList<String> categories = auctionSession.getAllCategories();
					request.setAttribute("requestedCategory", request.getParameter("category"));
					request.setAttribute("categories", categories);
					request.setAttribute("allAuctions", categoryAuctions);
				} else {
					ArrayList<Map<String,String>> unexpiredAuctions = auctionSession.getUnexpiredAuctions();
					ArrayList<String> categories = auctionSession.getAllCategories();
					request.setAttribute("requestedCategory", "all");
					request.setAttribute("categories", categories);
					request.setAttribute("allAuctions", unexpiredAuctions);
				}
				
				
			} else if (from.equals("myBids")) {
				
				// Obtain the category parameter
				String category = request.getParameter("category");
				if (category != null) {
					System.out.println("Category = " + category);
					if (category.equals("won")) {
						// Obtain all won bids
						ArrayList<Map<String,String>> wonBids = bidSession.getAllWonBidsOfUser(username);
						System.out.println("OBTAINED won bids = " + wonBids);
						request.setAttribute("reqCategory", "won");
						request.setAttribute("wonBids", wonBids);
						reqDisp = request.getRequestDispatcher("myBid.jsp");
					} else if (category.equals("ongoing")) {
						//TODO
						
						ArrayList<Map<String,String>> ongoingBids = bidSession.getAllOngoingBidsOfUser(username);
						System.out.println("OBTAINED Ongoing Bids = " + ongoingBids);
						request.setAttribute("reqCategory", "ongoing");
						request.setAttribute("ongoingBids", ongoingBids);
						reqDisp = request.getRequestDispatcher("myBid.jsp");
					}
				} else {
					
					// FIXME Obtain all my bids
					
					ArrayList<Map<String,String>> wonBids = bidSession.getAllWonBidsOfUser(username);
					System.out.println("OBTAINED won bids = " + wonBids);
					request.setAttribute("reqCategory", "all");
					request.setAttribute("wonBids", wonBids);
					reqDisp = request.getRequestDispatcher("myBid.jsp");
				}
				
				
				
				
			} else if (from.equals("seeBid")) {
				
				//TODO Obtain the auction
				String auctionId = request.getParameter("auctionId");
				Map<String, Object> auctionMap = auctionSession.getAuctionById(auctionId);
				request.setAttribute("auction", auctionMap);
				Map<String, Object> bidMap = bidSession.getBidOfAuction(auctionId);
				request.setAttribute("bid", bidMap);
				
				String auctionName = (String) auctionMap.get("auctionName");
				System.out.println("Auction: " + auctionName);
				
				String auctionDescrption = (String) auctionMap.get("auctionDescription");
				System.out.println("Description: " + auctionDescrption);
				String daysLeft = (String) auctionMap.get("auctionDaysLeft");
				System.out.println("daysLeft = " + daysLeft);
				String timeLeft = (String) auctionMap.get("auctionTimeLeft");
				System.out.println("Time left - " + timeLeft.toString());
				int itemId = (int) auctionMap.get("auctionItemId");
				String startPrice = (String) auctionMap.get("auctionStartPrice");
				
				if (bidMap.size() == 0) {
					System.out.println("EMPTY bidMap");
					
				} else {
					System.out.println("bidMap contains " + bidMap.size() + " elements.");
					int consequence = (int) bidMap.get("consequence");
					System.out.println("Conseq = " + consequence);
					double currentHighest = (double) bidMap.get("currentHighest");
					String usernameOfBidder = (String) bidMap.get("usernameOfBidder"); 
				}
				
				
				
				reqDisp = request.getRequestDispatcher("Bid.jsp");
			} // End of if (from.equals("seeBid")
		/*}*/
		reqDisp.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("**************ProcessBids doPost()************");
		HttpSession session = request.getSession();
		String userName = (String) session.getAttribute("username");
		RequestDispatcher reqDisp = request.getRequestDispatcher("Bid.jsp");
		String bidPrice = (String) request.getParameter("bidPrice");
		String auctionId = (String) request.getParameter("auctionId");
		System.out.println("Auction id = " + auctionId);
		Map<String, Object> bidMap = bidSession.getBidOfAuction(auctionId);
		// TODO Check if the bid field wasn't empty
		if (!bidPrice.trim().equals("")) {
			System.out.println("Bid input = " + bidPrice);
			
			//TODO STARTING POINT attempt to add bid..
			int bidStatus = bidSession.addNewBid(auctionId, bidPrice, userName);
			if (bidStatus == 0) {
				System.out.println("BID ADDED!!!!!!!!!!!");
				request.setAttribute("ErrorBidProcess", "Your bid has been accepted.");
			} else if (bidStatus == 1) {
				System.out.println("Too low bid price.");
				request.setAttribute("ErrorBidProcess", "Bid price too low.");
			} else if (bidStatus == 2) {
				System.out.println("Bid has expired.");
				request.setAttribute("ErrorBidProcess", "Bid has expired.");
			}
			Map<String, Object> auctionMap = auctionSession.getAuctionById(auctionId);
			Map<String, Object> newBidMap = bidSession.getBidOfAuction(auctionId);
			request.setAttribute("auction", auctionMap);
			request.setAttribute("bid", newBidMap);
		} else {
			System.out.println("Bid input NULL");
			request.setAttribute("ErrorBidProcess", "Please input a valid bid amount.");
			Map<String, Object> auctionMap = auctionSession.getAuctionById(auctionId);
			request.setAttribute("auction", auctionMap);
			
			request.setAttribute("bid", bidMap);
		}
		System.out.println("**************END ProcessBids doPost()************");
		reqDisp.forward(request, response);
	}

}
