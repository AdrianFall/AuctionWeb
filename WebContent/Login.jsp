<%@ page contentType="text/html; charset=iso-8859-1" language="java"  import="java.util.*" errorPage="" %>
<% String error = (String) request.getAttribute("Error");%>
<% String loggedOut = (String) request.getAttribute("LoggedOut");%>
<%
/** 
 *  A jsp that validates the user is logged off, otherwise redirects to member area
 */
String username = (String) session.getAttribute("username");
//initialise the RequestDisptacher and forward to Member Area page by the default
RequestDispatcher reqDispatcher = request.getRequestDispatcher("Member.jsp");
if (username != null) {
    //Redirect the logged in user to Member Area
    request.setAttribute("ErrorLoggedIn", "You are Already Logged in ");
    reqDispatcher.forward(request, response);
}
%>
<!DOCTYPE html>
<html>
<head>
<title> Login Form </title>
<!-- CSS external style sheet -->
<link rel="stylesheet" type="text/css" href="style.css" /> 
</head>
<body bgcolor="black">
<jsp:include page ="navigation.html" />
<center>
<h3 title="Title of the website">Login Form</h3>
<!-- Creates a div to style the form container -->
<div id="formContainer">
	<!-- Creates a div to style the elements of the form container i.e. input fields -->
	<div class="elements">
		<!-- Creates a div to place the image inside the form container -->
		<div class="avatarImage">
		<!-- End of div image -->
		</div>
		<p1><% if (error != null){%>
		<%= error %>
		<%}%></p1>
		<p1><% if (loggedOut != null){%>
		<%= loggedOut %>
		<%}%></p1>
		<!-- Create a form which will consist of the input fields and a button to proceed the login -->
		<form method=post action="loginAction">
			<input type="text" name="username" class="userLogin" maxlength=25 placeholder="Username..."/>
			<input type="password" name="password" class="password" maxlength=35 placeholder="Password"/>
			</br>
			<input type=submit name="Login" class="button" value="Log in">
		</form>
	<!-- End of div elements -->
	</div>
<!-- End of div form container -->
</div>
<!-- Create a div to style the information below the form container -->
<div id="bottomReminder">
	<div class="signup">
		Not registered yet? <a href="Registration.jsp">Register here!</a>
	</div>
</div>
</center>
</body>
</html>

