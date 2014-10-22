<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
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
    request.setAttribute("Error", "You need to be logged in to access Member Area");
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
<title> Member Area</title>
</head>
<body bgcolor="black">
<jsp:include page ="navigation.html" />
<center>
<h3>Member Area</h3>
</center>
<!-- Creates a div to style the form container -->
<div id="formContainer">
	<!-- Creates a div to style the elements of the form container i.e. user's details -->
	<div class="elementsMemberArea">
		
		<p1><% if (errorLoggedIn != null){%>
		<center>
		<%= errorLoggedIn %>
		<%= username %>
		<% out.println(" </br>&nbsp&nbsp&nbspWould you like to <a href='logoutAction'>Log out</a>?"); %></p1></center>
		<%} 
		else {%>
		</br>
		<p3>Your username:<p2><%= username %></p2></p3>
		
	 <% }%>
	 	</br>
		<p3>Your name:<p2><%= firstName%></p2></p3>
		</br>
		<p3>Your surname:<p2><%=lastName%></p2></p3>
		</br>
		<p3>Your email:<p2><%=email%></p2></p3>
		</br>
		<% if(errorLoggedIn == null) { %>
		
		<center><h1><a href="logoutAction">Log out</a></h1></center>
		<% } %>
	<!-- End of div elements -->
	</div>
<!-- End of div form container -->
</div>
</body>
</html>