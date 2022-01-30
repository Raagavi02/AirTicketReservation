<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login Page</title>
</head>
<body onload="checkUserType()">
<h1>Hello! ${username}</h1>
<a href="/home">Logout</a>
<ul>
<li><a id="hide" href="">Add Flight Details</a></li>
<li><a href="">Book Ticket</a></li>
<li><a href="">Cancel Ticket</a></li>
<li><a href="">Edit Ticket Details</a></li>
</ul>
<div id="usertype"></div>
<script>
function checkUserType(){
	var user="${usertype}";
		var hide=document.getElementById("hide");
	if(user=="admin"){
		document.getElementById("usertype").innerHTML=user;
	}else if(user=="user"){
		hide.style.display="none";
		document.getElementById("usertype").innerHTML=user;
	}
}
</script>
 <script type="text/javascript"> 
        window.history.forward(); 
        function noBack() { 
            window.history.forward(); 
        } 
    </script> 
</body>
</html>