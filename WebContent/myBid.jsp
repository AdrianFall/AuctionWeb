<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*, java.util.*, java.io.*, java.util.Date" errorPage=""%>
<% String errorBidProcess = (String) request.getAttribute("ErrorBidProcess");%>
<%
/** 
 *Members area with username protection
 */

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
    request.setAttribute("Error", "You need to be logged in to see your bids.");
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
<title>My Bids</title>

</head>
<body bgcolor="black">
	<jsp:include page="navigation.html" />
	<center>
		<h3>My Bids</h3>
	</center>
	

	<!-- Creates a div to style the form container -->
	<div id="formContainer">
		
		<!-- Creates a div to style the elements of the form container i.e. user's details -->
		<div class="elementsMemberArea">
			</BR>
			<center>
			<p2><a href="ProcessBids?from=myBids&category=won">Won</a>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="ProcessBids?from=myBids&category=ongoing">Ongoing</a></p2>
			</center>
			<div id="formScroll">
			
			<table id="resultTable">
			<thead>
				<tr>
					<th scope="col"> Auction Details </th>
					<th scope="col"> Date </th>
				</thead>
					
				</tr>
			
				<%
				ArrayList<Map<String,String>> bidsList = new ArrayList<Map<String,String>>();
				String requestedCategory = (String) request.getAttribute("reqCategory"); 
				System.out.println("***JSP requestedCategory = " + requestedCategory);
				if (requestedCategory.equals("ongoing")) {
					System.out.println("requestedCategory.equals('ongoing')");
					bidsList = (ArrayList<Map<String,String>>) request.getAttribute("ongoingBids");
					System.out.println("obtained wonBids = " + bidsList);
				} else if (requestedCategory.equals("won")) {
					System.out.println("requestedCategory.equals('won')");
					bidsList = (ArrayList<Map<String,String>>) request.getAttribute("wonBids");
					System.out.println("obtained ongoingBids = " + bidsList);
				} else {
					bidsList = (ArrayList<Map<String,String>>) request.getAttribute("wonBids");
				}
				System.out.println("***JSP bidsList = " + bidsList);
				 
				Calendar currentCalendar;
			for (int i = 0; i < bidsList.size(); i++) { 
				String winningBidUserName = null;
				String auctionId = (String) bidsList.get(i).get("auctionId");
				String auctionName = (String) bidsList.get(i).get("auctionName");
				String auctionDescription = (String) bidsList.get(i).get("auctionDescription");
				String pricePaid = (String) bidsList.get(i).get("price");
				String auctionDate = (String) bidsList.get(i).get("date"); 
				if (requestedCategory.equals("ongoing")) {
					winningBidUserName = (String) bidsList.get(i).get("winningBidUserName");
				}%>
				
				<tr>
					<td>
						<%out.println("Auction: <a href='ProcessBids?from=seeBid&auctionId=" +auctionId+ "'>" + auctionName); out.println("</a>");%>
						</BR>
						<%out.println("Auction Description: <a href='ProcessBids?from=seeBid&auctionId=" +auctionId+ "'>"+  auctionDescription + "</a>"); %>
						</BR>
						<%out.println("Price paid:" +  pricePaid); %>
						<% 
						if (winningBidUserName != null) {
							if (winningBidUserName == username) {
								out.println("You are winning the bid!");
							} else {
								out.println("Somebody else is winning the bid.");
							}
						} %>
						
					</td>

					<td>
						<% out.println(auctionDate); %>
						
					</td>
				</tr>
				<%} %>
			</table>
			</div>
			
				
					
		</div>
		<!-- End of div elements -->
		
	</div>
</body>
</html>