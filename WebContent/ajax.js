var xmlHttp = createXmlHttpRequestObject();


function createXmlHttpRequestObject() {
	var xmlHttp;
	
	if (window.XMLHttpRequest) {
		xmlHttp = new XMLHttpRequest();
	} else {
		xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	
	return xmlHttp;
}

function process() {
	//alert("process");
	var test = document.getElementById('consequence').toString();
	alert("test = " + test);
}