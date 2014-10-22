<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*, java.util.*, java.io.*" errorPage=""%>
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
%>
<!DOCTYPE html>
<html>
<head>
<!-- CSS external style sheet -->
<link rel="stylesheet" type="text/css" href="style.css" />

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<title>My Items</title>


</head>
<body bgcolor="black">
	<jsp:include page="navigation.html" />
	<center>
		<h3>All Auctions</h3>
	</center>
	

	<!-- Creates a div to style the form container -->
	<div id="formContainer">
		
		<!-- Creates a div to style the elements of the form container i.e. user's details -->
		<div class="elementsMemberArea">
		<%! public String requestedCategory; %>
		<% 
		ArrayList<Map<String,String>> allAuctions = (ArrayList<Map<String,String>>) request.getAttribute("allAuctions");
		ArrayList<String> categories = (ArrayList<String>) request.getAttribute("categories"); 
		requestedCategory = (String) request.getAttribute("requestedCategory"); %>
			<center>
				
				<%out.println(" "); %>
				
					<div id="navigationContainer" style="background:url(images/bg2.jpg);">
					<div id="navigation" style="width:450px">
					<ul ><li>
					<B><a style="color:black" href="ProcessBids?from=seeAll">All</a></B>
					</li>
					
					<%for (int i = 0; i < categories.size(); i++) { %>
						
						<li><B>
						<%out.println("<a style='color:black' href='ProcessBids?from=seeAll&category=" +categories.get(i)+ "'>" + categories.get(i));%> </a> <% out.println(" ");%>
						</B>
						</li>
				<%	} %>
				</ul>
				</div>
					</div>
				<% 	if (!requestedCategory.equals("all") && allAuctions.size() == 0) { %>
						<h4>There are no ongoing auctions in the category of <%=requestedCategory%>.</h4>
					<%} else if (requestedCategory.equals("all") && allAuctions.size() == 0) {%>
					</BR>
					<h4>There are no ongoing auctions. Why not <a href="ProcessAuction?from=newAuction">create one now ?</a></h4>
					<%}%>
					
				
				<BR>
			</center>
			<BR>
			<div id="formScroll">
			<table id="resultTable">
				<%  
				Calendar currentCalendar;
			for (int i = 0; i < allAuctions.size(); i++) { 
				String auctionId = allAuctions.get(i).get("auctionId");
				String auctionName = allAuctions.get(i).get("auctionName");
				String auctionDescription = allAuctions.get(i).get("auctionDescription");
				String auctionDurationDays = allAuctions.get(i).get("auctionDaysLeft");
				String auctionDurationTime = allAuctions.get(i).get("auctionTimeLeft");
				String[] splitAuctionDurationTime = auctionDurationTime.split(":");
				String hours = splitAuctionDurationTime[0];
				String minutes = splitAuctionDurationTime[1];
				String seconds = splitAuctionDurationTime[2];
				int hoursInt = Integer.valueOf(hours);
				int minutesInt = Integer.valueOf(minutes);
				int secondsInt = Integer.valueOf(seconds);
				int auctionBidConsequence = Integer.valueOf(allAuctions.get(i).get("auctionBidConsequence"));
				double auctionHighestBid = Double.valueOf(allAuctions.get(i).get("auctionHighestBid"));%>

				<tr>
					<td id="auctionInformationCell">
						<%out.println("<a href='ProcessBids?from=seeBid&auctionId=" +auctionId+ "'>" + auctionName); out.println(" ");%>
						<%out.println(auctionDescription + "</a>"); %><BR>
						<% if (auctionBidConsequence == 0) { 
						out.println("Nobody has bid yet.");
						out.println(" Starting price - £" + auctionHighestBid);
						} else {
							out.println(auctionBidConsequence + " bids so far.");
							out.println(" Current price - £" + auctionHighestBid);
						}%>
					</td>

					<td>
						<% out.println(auctionDurationDays + " Days, " + hoursInt + " Hours, " + minutesInt + " Minutes, " + secondsInt + " Seconds till closure."); %>
						
					</td>
				</tr>
				<%} %>
				
			</table>
			</div>
			
			<!-- End of div elements -->
		</div>
		<!-- End of div form container -->
	</div>
</body>
</html>