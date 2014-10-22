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
    request.setAttribute("Error", "You need to be logged in to access My Items Area");
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
</head>
<body bgcolor="black">
	<jsp:include page="navigation.html" />
	<center><h3>My Items</h3></center>
	<!-- Creates a div to style the form container -->
	<div id="formContainer">
		<!-- Creates a div to style the elements of the form container i.e. user's details -->
		<div class="elementsMemberArea">
			<center><B>Your List of Items</B></center> <BR> 
			
			<%! 
			public String itemName;
			public String itemId;
			public String itemDescription;
			public String category;
			public String itemModel;
			 %>
			
			<% 
			ArrayList<Map<String,String>> items = (ArrayList<Map<String,String>>) request.getAttribute("items");
			if (items.size() == 0) { %>
				<center><p2>You have no items, fancy <a href="ProcessItem?from=insertNewItem">adding a new one ?</a></p2></center>
			<% } else { %>
				<table id="resultTable">
				
				
				<thead>
				<tr>
					<th scope="col"> Item Name </th>
					<th scope="col"> Item Model </th>
					<th scope="col"> Item Description </th>
					<th scope="col"> Category </th>
				</tr>
				</thead>
				
				
				
				
				<% for (int i = 0; i < items.size(); i++) { 
					System.out.println(items.get(i));
					Map<String,String> itemMap = items.get(i);
					
					itemName = itemMap.get("itemName");
					itemId = itemMap.get("itemId");
					itemDescription = itemMap.get("itemDescription");
					category = itemMap.get("category");
					itemModel = itemMap.get("itemModel"); %>
					<tr>
					<td><%=itemName%></td>
					<td><%=itemModel%></td>
					<td><%=itemDescription%></td>
					<td><%=category%></td>
					</tr>
				<%}%>
				
				</table>
				
			<%}%>
			
			
		
			
			
		
			
			<!-- End of div elements -->
		</div>
		<!-- End of div form container -->
	</div>
</body>
</html>