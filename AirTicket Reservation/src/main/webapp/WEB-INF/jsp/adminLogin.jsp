<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin login page</title>
<link href="webjars/bootstrap/3.3.6/css/bootstrap.min.css"
	rel="stylesheet">
<style>
#myform {
	padding-top: 20px;
	padding-bottom: 20px;
	margin: 0 auto;
	text-align: center;
	width: 50%;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0
		rgba(0, 0, 0, 0.19);
}

td {
	width: 250px;
	padding: 10px;
}

table {
	width: 100%;
}

input {
	border-radius: 4px;
	padding: 5.5px 4px;
	border-color: #D0D0D0;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0
		rgba(0, 0, 0, 0.19);
}

.popup, .popupagain {
	background: rgba(0, 0, 0, 0.6);
	width: 100%;
	height: 100%;
	position: absolute;
	top: 0;
	display: none;
	justify-content: center;
	align-items: center;
	text-align: center;
}

.popup-container {
	height: 400px;
	width: 500px;
	position: relative;
	background-color: white;
}
</style>
</head>
<body>
	<h1 style="text-align: center; padding: 60px;">Admin Login</h1>
	<div>${check}</div>
	<form id="myform" action="/logged" method="post">
		<table>
			<tr>
				<td>UserName</td>
				<td><input name="username" id="username" type="text"
					required="required" /></td>
			</tr>
			<tr>
				<td>Password</td>
				<td><input name="password" id="password" type="password" /></td>
			</tr>
			<tr>
				<td><input type="submit" class="btn btn-success" value="Login"></td>
				<td><a href="#" id="container">Forgot Password</a></td>
			</tr>
		</table>

	</form>
	<div class="popup">
		<div class="popup-container">
			<a style="float: right; padding: 20px;" id="hide" href="#">X</a>
			<h2 style="padding-top: 60px; margin: 0; padding-bottom: 20px;">Forgot
				Password</h2>
			<h4>Enter Email</h4>
			<br>
			<form onsubmit="my()" action="/forgot" method="post">
				<input name="username" id="email" type="email" /><br> <br><br>
				<input type="submit" class="btn btn-success" value="continue"
					required="required"><br>
			</form>
		</div>
	</div>
	<script>
		document.getElementById("container").addEventListener("click",
				function() {
					document.querySelector(".popup").style.display = "flex";
				})
		document.getElementById("hide").addEventListener("click", function() {
			document.querySelector(".popup").style.display = "none";
		})
	</script>
	<script src="webjars/jquery/1.9.1/jquery.min.js"></script>
	<script src="webjars/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	 <script type="text/javascript"> 
        window.history.forward(); 
        function noBack() { 
            window.history.forward(); 
        } 
    </script> 
</body>
</html>