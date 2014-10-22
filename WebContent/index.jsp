<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- CSS external style sheet -->
<link rel="stylesheet" type="text/css" href="style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Miniebay</title>
</head>
<body>
<jsp:include page ="navigation.html" />


<script type="text/javascript">
		<!-- Create a script to cache the images -->
		//Cache the images
		var carimage1 = new Image()
		carimage1.src = "images/weird_bike.jpg"
		var carimage2 = new Image()
		carimage2.src = "images/Acer_Aspire_S7.png"
		var carimage3 = new Image()
		carimage3.src = "images/telephone-8.jpg"
		var carimage4 = new Image()
		carimage4.src = "images/tl_16_april_toshiba_satellite_c_series.jpg"
		var carimage5 = new Image()
		carimage5.src = "images/desktop-pc.jpg"
		//Once cache is done, shift the image slideshow to the right
		document.write("&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp")
	</script>
	<center><img src="images/telephone-8.jpg" name="slideShow" title="Auction Slide Show" width=400 height=250></center>
	<script>
		<!-- Create a script for dynamic display of car pictures, every 3 seconds. -->
		//declare the variable for incrementing
		var increment = 1

			function dynamicSlideShow() {

				document.images.slideShow.src = eval("carimage" + increment + ".src")
				if (increment < 5) //When the current image isn't the last one
					increment++
				else //When the current image is the last one.
				//Change the number to 1 and call the function with 3 second intervals
					increment = 1
				setTimeout("dynamicSlideShow()", 3000)
			}
		dynamicSlideShow()
	</script>

<center><h3><a href ="Registration.jsp">Register</a> and start bidding!</h3></center>

</body>
</html>