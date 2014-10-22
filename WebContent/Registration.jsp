<%@ page contentType="text/html; charset=iso-8859-1" language="java"  import="java.util.*" errorPage="" %>
<!-- Declare the error attributes which will be used to inform the user of different errors that have occured  -->
<% String errorUserExists = (String) request.getAttribute("ErrorUserExists");%>  <!-- An error associated with the validation of inputted vs existing username  -->
<% String errorEmptyFields = (String) request.getAttribute("ErrorEmptyFields");%> <!-- An error indicating that fields have been ommited  -->
<% String errorPassword = (String) request.getAttribute("ErrorPassword");%> <!-- An error indicating the password incompatibility -->

<!DOCTYPE html>

<html>
<head>

<title> Registration </title>	
<!-- CSS external style sheet -->
<link rel="stylesheet" type="text/css" href="style.css"> 

</head>
<body bgcolor="black">
<jsp:include page ="navigation.html" />
<center>
<h3 title="Title of the website">Registration</h3>
<!-- Creates a div to style the form container -->
<div id="formContainer">
	<!-- Creates a div to style the elements of the form container i.e. input fields -->
	<div class="elements">
		<!-- Creates a div to place the avatar image inside the form container -->
		<div class="avatarImage" title="an avatar image">
		<!-- End of div avatarImage -->
		</div>
		<p1><% if (errorEmptyFields != null){%>
		<%= errorEmptyFields %>
		<%}%>
		</p1>
		<!-- Create a form which will consist of the input fields and a button to proceed the registration -->
		<form method=post action="processRegistration">
			<input type="text" name="username" class="userLogin" title="Input username" maxlength=25 placeholder="Username..."/>
			<p1><% if(errorUserExists != null){ %>
			<%= errorUserExists %>
			<%}%></p1>
			<input type="password" name="password" class="password" title="Input password" maxlength=35 placeholder="Password"/>
			<p1><% if(errorPassword != null){ %>
			<%= errorPassword %>
			<%}%></p1>
			<input type="text" name="email" class="email" title="Input email address" maxlength=60 placeholder="Your email address..."/>
			<input type="text" name="firstname" class="firstname" title="Input first name" maxlength=40 placeholder="First Name..."/>
			<input type="text" name="lastname" class="surname" title="Input surname" maxlength=55 placeholder="Surname..."/>
			</br>
			<input type=submit name="register" class="button" title="Register button" value="Register">
		</form>
	<!-- End of div elements -->
	</div>
<!-- End of div form container -->
</div>
<!-- Create a div to style the information below the form container -->
<div id="bottomReminder">
	<div class="signup">
		Already a registered user? <a href="Login.jsp">Login here!</a>
	</div>
</div>
</center>
</body>
</html>