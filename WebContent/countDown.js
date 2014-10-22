
function countDown(hours, minutes, secs) {
	document.getElementById("headId").innerHTML = hours + ' hours, ' + minutes + ' minutes,' + secs + ' seconds remaining.';
	if (secs == 0) {
		if (minutes == 0) {
			if (hours == 0) {
				
			} else {
				hours--;
				minutes = 59;
				secs = 59;
			}
		} else {
			minutes--;
			secs = 59;
		}
	} else {
		secs--;
	}
	//document.getElementsByTagName("h1").innerHTML = secs;
	//seconds.value = secs;
	setTimeout('countDown('+hours+','+minutes+','+secs+')', 1000);
}
