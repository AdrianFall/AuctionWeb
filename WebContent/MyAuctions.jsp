<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*, java.util.*" errorPage=""%>
<% String errorLoggedIn = (String) request.getAttribute("ErrorLoggedIn");%>
<% String errorAdminArea = (String) request.getAttribute("ErrorAdminArea");%>
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
    request.setAttribute("Error", "You need to be logged in to access My Auctions Area");
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
<title>My Auctions</title>
</head>
<body bgcolor="black">
	<jsp:include page="navigation.html" />
	<center><h3>My Auctions</h3></center>
	<!-- Creates a div to style the form container -->

		<!-- Creates a div to style the elements of the form container i.e. user's details -->
		
			<center><B>Your List of Auctions</B></center>
			<BR>
			<form method=get action="ProcessItem">
				<% request.setAttribute("from", "deleteItem"); %>
				
				<%  ArrayList<Map<String,String>> auctions = (ArrayList<Map<String,String>>) request.getAttribute("auctions");
					System.out.println("Hallelujah here are the auctions - " + auctions);
							if (auctions.size() == 0) { %>
								<h2>You have no auction yet, why not<a href="ProcessAuction?from=newAuction"> make one now ?</a></h2>
							<% } else { %>
							
				<table id="resultTable">
				
				
				<thead>
				<tr>
					<th scope="col"> Auction Details </th>
					<th scope="col"> Item Details </th>
					<th scope="col"> Auction Status </th>
				</tr>
				</thead>
				
				<%! 
				public String auctionDescription;
				public String auctionName;
				public String startPrice;
				public String startDate;
				public String endDate;
				public String itemName;
				public String itemDescription;
				public String itemModel;
				public String itemCategory;
				public String auctionStatus;
				
				public String auctionDaysLeft;
				public String auctionTimeLeft;
				public String bidConsequence;
				public String highestBid;
				%>
				<% for (int i = 0; i < auctions.size(); i++) {
					Map<String, String> aucMap = auctions.get(i);
					auctionDescription = (String) aucMap.get("auctionDescription");
					auctionName = (String) aucMap.get("auctionName");
					startPrice = (String) aucMap.get("startPrice");
					startDate = (String) aucMap.get("startDate");
					endDate = (String) aucMap.get("endDate");
					itemName = (String) aucMap.get("itemName");
					itemDescription = (String) aucMap.get("itemDescription");
					itemModel = (String) aucMap.get("itemModel");
					itemCategory = (String) aucMap.get("itemCategory");
					auctionStatus = (String) aucMap.get("auctionStatus");
					bidConsequence = (String) aucMap.get("bidConsequence");
					highestBid = (String) aucMap.get("highestBid");
					
					
					System.out.println("auctionStatus = " + auctionStatus);
					
					if (auctionStatus.equals("ongoing")) {
						System.out.println("ongoing......");
						auctionDaysLeft = (String) aucMap.get("auctionDaysLeft");
						auctionTimeLeft = (String) aucMap.get("auctionTimeLeft");
						
					} %>
					
					<tr>
					<td>
					Name: <%=auctionName%>
					</BR>
					Description: <%=auctionDescription%>
					</BR>
					Start Date: <%=startDate%>
					</BR>
					End Date: <%=endDate%>
					</BR>
					Start Price: <%=startPrice%>
					</td>
				
					<td>
					Name: <%=itemName%>
					</BR>
					Description: <%=itemDescription%>
					</BR>
					Model: <%=itemModel%>
					</BR>
					Category: <%=itemCategory%>
					</td>
					
					<td>
					
					<% if (auctionStatus.equals("ongoing")) {
						out.println("Status: Ongoing</BR>");
						out.println("Time left: ");
						out.println(auctionDaysLeft + " days ");
						String[] splitTime = auctionTimeLeft.split(":");
						out.println(splitTime[0] + " hours " + splitTime[1] + " minutes " + splitTime[2] + " seconds.");
							
						if (bidConsequence.equals("0")) {
							out.println("</BR> Nobody has bid yet this auction.");
							
						} else {
							out.println("</BR> There are " + bidConsequence + " bids on this auction with the highest one being: " + highestBid);
						}
						
						
					} else if (auctionStatus.equals("expired")){ // Auction has expired 
						out.println("Status: Finished. </BR>");
						if (bidConsequence.equals("0")) {
							out.println("</BR> Nobody has won this auction.");
						} else {
							out.println("</BR> The auction finished with " + bidConsequence + " bids, with the winning one of: " + highestBid);
						}
					} %>
					</td>
					
					</tr>
					
				<% } // End for (auctions) %>
				
				</table>
							
					<%-- <SELECT NAME="item" SIZE="5">
						
							<% for (int i = 0; i < auctions.size(); i++) { 
								System.out.println("processing " + i );
								String auctionName = auctions.get(i);

								if (i==0) { %>
						<OPTION SELECTED>
							<% out.println("Name - " + auctionName);
								} else { %>
						
						<OPTION>
							<% out.println("Name - " + auctionName);%>
							<% } %>

							<%} %>
						
					</SELECT> --%>
					<% } %>
				
			</form>

			
</body>
</html>