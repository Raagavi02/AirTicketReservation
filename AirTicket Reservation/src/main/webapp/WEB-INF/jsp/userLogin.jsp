<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="webjars/bootstrap/3.3.6/css/bootstrap.min.css"
	rel="stylesheet">
<title>User Sign in</title>
<style>
	#myform{
		padding-top:20px;
		padding-bottom:20px;
		margin:0 auto;
		text-align:center;
	
		width:50%;
		box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	}
	td{
		width:250px;
		padding:10px;
	}table{
		width:100%;
	}input{
		border-radius: 4px;
		padding: 5.5px 4px;
		border-color:#D0D0D0;
		box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	}
	.popup,.popupagain{
		background:rgba(0,0,0,0.6);
		width:100%;
		height:100%;
		position:absolute;
		top:0;
		display:none;
		justify-content:center;
		align-items:center;
		text-align:center;
	}
	.popup-container{
		height:400px;
		width:500px;
		position:relative;
		background-color:white;
	}
</style>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
<h1 style="text-align:center;padding:60px;">Login to continue booking</h1>
<form id="myform" action="/logged" method="post" >
<table>
	<tr>
		<td>UserName</td>
		<td><input type="text" id="username" name="username" required="required"></td>
	</tr>
	<tr></tr>
	<tr>
		<td>Password</td>
		<td><input type="password" id="password" name="password" required="required"></td>
	</tr>
	<tr>
		<td><input id="refer" type="submit" class="btn btn-success" value="Login"></td>
		<td><a class="btn btn-success" href="#" id="container">SignUp </a></td>
	</tr>
</table><br>
<a href="#" id="containeragain">Forgot password?</a>
</form>
<div class="popup">
	<div class="popup-container">
 		<a style="float:right;padding:20px;" id="hide" href="#">X</a>
		<h2 style="padding-top:60px;margin:0;padding-bottom:20px;">Signup</h2>
		<h4>Email</h4><br>
		<form action="/checkingmail" method="post" >	
			<input name="username" id="email" type="email" /><br><br>
			<input type="submit" class="btn btn-success" value="continue" required="required"><br><br>
		</form>
	</div>
</div>
<div class="popupagain">
	<div class="popup-container">
 		<a style="float:right;padding:20px;" id="hidde" href="#">X</a>
		<h2 style="padding-top:60px;margin:0;padding-bottom:20px;">Forgot Password</h2>
		<h4>Change Email</h4><br>
		<form action="/forgot" method="post">	
			<input name="username" id="email" type="email" /><br><br>
			<input type="submit" class="btn btn-success" value="continue" required="required"><br>
		</form>
	</div>
</div>	
	
<script type="text/javascript">
document.getElementById("container").addEventListener("click",function(){
	document.querySelector(".popup").style.display="flex";
})
	document.getElementById("containeragain").addEventListener("click",function(){
		document.querySelector(".popupagain").style.display="flex";
	})
	document.getElementById("hide").addEventListener("click", function() {
		document.querySelector(".popup").style.display = "none";
	})
	document.getElementById("hidde").addEventListener("click", function() {
		document.querySelector(".popupagain").style.display = "none";
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