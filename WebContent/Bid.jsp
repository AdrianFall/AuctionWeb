<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*, java.util.*, java.io.*, java.util.Date" errorPage=""%>
<% String errorBidProcess = (String) request.getAttribute("ErrorBidProcess");%>
<%



//Force caches to obtain a new copy of the page from the origin server
response.setHeader("Cache-Control", "no-cache");
//Direct caches not to store the page under any circumstance
response.setHeader("Cache-Control", "no-store");
//Prevents caching at the proxy server
response.setDateHeader("Expires", 0);
//HTTP 1.0
response.setHeader("Pragma", "no-cache");

//Obtain the session attributes
String username = (String) session.getAttribute("username");
String firstName = (String) session.getAttribute("firstname");
String lastName = (String) session.getAttribute("lastname");
String email = (String) session.getAttribute("email");

//Check that the user is logged in.
if (username == null) {
    request.setAttribute("Error", "You need to be logged in to bid an auction.");
    RequestDispatcher rd = request.getRequestDispatcher("Login.jsp");
    rd.forward(request, response);
}
%>
<!DOCTYPE html>
<html>
<head>
<!-- CSS external style sheet -->
<link rel="stylesheet" type="text/css" href="style.css" />

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<title>My Items</title>

<script type="text/javascript" src="ajax.js"></script>

</head>
<body bgcolor="black">
	<jsp:include page="navigation.html" />
	<center>
		<h3>Bid Auction</h3>
	</center>
	

	<!-- Creates a div to style the form container -->
	<div id="formContainer">
		
		<!-- Creates a div to style the elements of the form container i.e. user's details -->
		<div class="elementsMemberArea">
			
				<%! public boolean auctionExpired = false; %>
			
				<%
				Map<String, Object> auctionMap = (Map<String,Object>) request.getAttribute("auction");
				Map<String, Object> bidMap = (Map<String,Object>) request.getAttribute("bid");
				
				int daysLeft = Integer.parseInt((String) auctionMap.get("auctionDaysLeft"));
				System.out.println("JSP * days left = " + daysLeft);
				
				String timeLeft = (String) auctionMap.get("auctionTimeLeft");
				System.out.println("JSP * time left - " + timeLeft);
				if (!timeLeft.equals("-1") && daysLeft != -1) {
				auctionExpired = false;
				System.out.println("Auction Expired..." + auctionExpired);
			
				
				String[] splitTimeLeft = timeLeft.split(":");
				int hours = Integer.parseInt(splitTimeLeft[0]);
				hours += daysLeft * 24;
				int minutes = Integer.parseInt(splitTimeLeft[1]);
				System.out.println("JSP * minutes - " + minutes);
				//String seconds = splitTimeLeft[2];
				int seconds = Integer.parseInt(splitTimeLeft[2]);
				
				%>
				
				<h1 id="headId"></h1>
				
				<script type="text/javascript" src="countDown.js"></script>
				<script>countDown(<%=hours%>,<%=minutes%>,<%=seconds%>);</script>
				<BR>
				<% } else { auctionExpired = true;%>
				 	<center><h2>Auction Finished.</h2></center>
				 <% } %>
				<h4>
				<%out.println(auctionMap.get("auctionName")); 
				out.println(auctionMap.get("auctionDescription"));
				%></h4>
				<BR>
				<%
				System.out.println("auctionExpired = " + auctionExpired);
				if (bidMap.size() == 0) {
					if (auctionExpired) {
						out.println("Nobody won the auction.");
					} else {
						String startPrice = (String) auctionMap.get("auctionStartPrice");
						out.println("No bids yet, Starting price: " + startPrice);
					}
				} else {
					/* int consequence = (int) bidMap.get("consequence");
					double currentHighest = (double) bidMap.get("currentHighest");
					String usernameOfBidder = (String) bidMap.get("usernameOfBidder");  */
					
					if (auctionExpired) {
						out.println("Auction has been won by " + bidMap.get("usernameOfBidder") + "</BR>Price paid: " + bidMap.get("currentHighest"));
					} else {
						out.println("So far <p1 id='consequence'>" + bidMap.get("consequence") + "</p1> bids on this auction.");
						out.println("Current highest bid is " + bidMap.get("currentHighest") + " by " + bidMap.get("usernameOfBidder"));
					}	
						
					
			
					//TODO table with bids history
				}
				out.println("<BR>Item Name <B>" + auctionMap.get("itemName") +"</B>");
				out.println("<BR>Item Model <B>" + auctionMap.get("itemModel") + "</B>");
				out.println("<BR> Item Description - <B>" + auctionMap.get("itemDescription") + "</B>");%>
				
				<%if (errorBidProcess != null) { %>
				</BR><p1>
				<%= errorBidProcess%>
				</p1>
				<%}%>
				<% String auctionId = (String) auctionMap.get("auctionId");
				System.out.println("JSP * auctionId = " + auctionId);%>
				<% if (!auctionExpired) { %>
				<form method=post action="ProcessBids">
				<input type="number" name ="bidPrice"/>
				<input type="hidden" name="auctionId" value="<%=auctionId%>" />
				<input type=submit name="bidInput" class="button" title="Bid Auction" value="Bid">
				</form>
				<% } %>
						<%-- <%out.println(auctionDescription + "</a>"); %><BR>
						<% if (auctionBidConsequence == 0) { 
						out.println("Nobody has bid yet.");
						out.println(" Starting price - £" + auctionHighestBid);
						} else {
							out.println(auctionBidConsequence + " bids so far.");
							out.println(" Current price - £" + auctionHighestBid);
						}%> --%>
					
			</div>
			<!-- End of div elements -->
		
	</div>
</body>
</html>