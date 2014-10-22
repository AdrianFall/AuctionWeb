<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.util.*" errorPage=""%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String errorEmptyFields = (String) request.getAttribute("ErrorEmptyFields");%>
<% String errorWrongDuration = (String) request.getAttribute("ErrorWrongDuration");%>
<% String errorWrongNum = (String) request.getAttribute("ErrorWrongNum");
   String errorItem = (String) request.getAttribute("ErrorItem");%>

<% 
//get the session attribute
String username = (String) session.getAttribute("username");
RequestDispatcher rd;

//Ensure that the user is logged in, and as an admin to allow him to see the website.
if (username == null) { //User is not logged in
    request.setAttribute("Error", "You need to login to access this page.");
    rd = request.getRequestDispatcher("Login.jsp");
    rd.forward(request, response);
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Insert New Auction</title>
<!-- CSS external style sheet -->
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<body>
	<jsp:include page="navigation.html" />
	<br>
	<br>
	<br>
	<div id="greetingContentContainer">
		<div id="greetingInfo">
			<center><h4>Insert new auction</h4></center>
			<%-- <ul>
				<li class="Line"></li>
			</ul>
			<ul>
				<li class="textHiddenBox">
					<center>
						
					</center>
				</li>
			</ul>
			<ul>
				<li class="Line"></li>
			</ul> --%>
		</div>
	</div>
	<!-- End of greeting content -->

	<div id="areaForTable">
	<center>
		<form method=post action="ProcessAuction">
			<table id="resultTable">
				<% if (errorEmptyFields != null){%>
				<tr>
					<td>
						<h1><%= errorEmptyFields %></h1>
					</td>
					<td></td>
				</tr>
				<% } else if (errorItem != null) {%>
					<tr>
					<td>
						<h3><%= errorItem %></h3>
					</td>
					<td></td>
				</tr>
				<%}%>
				<tr>
					<td>Auction Name</td>
					<td><input type="text" name="auctionName" class="insertForm"
						maxlength=80 placeholder="Auction Name..." /></td>
				</tr>
				<tr>
					<td>Choose Item</td>
					<td>
						<% ArrayList<String> items = (ArrayList<String>) request.getAttribute("items"); 
							if (items == null){ %>
								<script>
								alert("Please insert new item.");
								</script>					
							 <%} else if (items.size() == 0) { %>
								<p2>Please <a href="ProcessItem?from=insertNewItem">insert a new item</a> first.</p2>
							<%} else {%>
						<select name="items" id="items-dropdown">
							<%-- <% obj.init(); %> --%>
							<c:forEach var="items" items="${items}">
								<%-- <%System.out.println("categories = " + obj.getCategories()); %> --%>
								<option value="${items}">${items}</option>
							</c:forEach>
							</select>
							<% } %>
					
					</td>
				</tr>
				<tr>
					<td>Auction Description</td>
					<td><input type="text" height="400" name="auctionDescription" class="insertForm"
						maxlength=200 placeholder="Description..." /></td>
				</tr>
				<tr>
					<td>Start Price</td>
					<td><input type="text" name="startPrice" class="insertForm"
						maxlength=12 placeholder="Starting price..." /></td>
				</tr>
				<% if (errorWrongNum != null) { %>
				<tr>
					<td>
						<h1><%= errorWrongNum %></h1>
					</td>
					<td></td>
				</tr>
				<% } %>
				<tr>
					<td>Auction Duration</td>
					<td>
						Days 
						<select name="days">
					   	 <%for (int i = 0; i < 31; i++) { %>
					   	 	<option><%=i%></option>
						 <%}%>
						</select>
						Hours
						<select name="hours">
						<%for (int j = 0; j < 24; j++) { %>
							<option><%=j%></option>
						<%}%>
						</select>
						Minutes
						<select name="minutes">
						<%for (int m = 0; m < 60; m++) { %>
							<option><%=m%></option>
						<%}%>
						</select>
					</td>
				</tr>
				
			</table>
			<input type=submit name="insertAuction" class="button" value="Create Auction">
		</form>
		</center>
	</div>
</body>
</html>