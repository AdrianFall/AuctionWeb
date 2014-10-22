<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.util.*" errorPage=""%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String errorEmptyFields = (String) request.getAttribute("ErrorEmptyFields");%>
<% String errorWrongDuration = (String) request.getAttribute("ErrorWrongDuration");%>
<% String errorWrongNum = (String) request.getAttribute("ErrorWrongNum");%>

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
			<center><h4>Insert new item</h4></center>
			<%-- <ul>
				<li class="Line"></li>
			</ul>
			<ul>
				<li class="textHiddenBox">
					<center>
						<h4>Insert new item</h4>
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
		<form method=post action="ProcessItem">
			<center><table id="resultTable">
				<% if (errorEmptyFields != null){%>
				<tr>
					<td>
						<h1><%= errorEmptyFields %></h1>
					</td>
					<td></td>
				</tr>
				<% } %>
				<tr>
					<td>Item name</td>
					<td><input type="text" name="itemName" class="insertForm"
						maxlength=80 placeholder="Name..." /></td>
				</tr>
				<tr>
					<td>Insert Item Model</td>
					<td><input type="text" name="itemModel" class="insertForm"
						maxlength=100 placeholder="Item Model..." /></td>
				<tr>
				<tr>
					<td>Choose Category</td>
					<td>
						<%-- <% processItem item = new processItem(); 
							item.init();
						   ArrayList<String> categories = item.getCategories();
						   System.out.println("categories from jsp = " + categories);%> --%>
						<% ArrayList<String> categories = (ArrayList<String>) request.getAttribute("categories"); %>
						<select name="category" id="categories-dropdown">
							<%-- <% obj.init(); %> --%>
							<c:forEach var="category" items="${categories}">
								<%-- <%System.out.println("categories = " + obj.getCategories()); %> --%>
								<option value="${category}">${category}</option>
							</c:forEach>
					</select>
					</td>
				</tr>
				<tr>
					<td>Item Description</td>
					<td><input type="text" height="400" name="itemDescription" class="insertForm"
						maxlength=200 placeholder="Description..." /></td>
						<!-- <TEXTAREA NAME="Comments" ROWS="5" COLS="100"> Comments: </TEXTAREA> -->
				</tr>
			</table>
			
			<input type=submit name="insertAuction" class="button" value="Insert item">
		</form>
		</center>
	</div>
</body>
</html>