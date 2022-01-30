<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="webjars/bootstrap/3.3.6/css/bootstrap.min.css"
	rel="stylesheet">
<title>Details</title>
<style type="text/css">
	.myform{
		padding-top:20px;
		padding-bottom:20px;
		margin:0 auto;
		text-align:center;
		width:50%;
		box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	}td{
		width:250px;
		padding:10px;
	}table{
		width:100%;
	}input{
		border-radius: 4px;
		padding: 5.5px 4px;
		border-color:#D0D0D0;
		box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	}#footer{
		height:50px;
	}
</style>
</head>
<body>
<h4><a href="/logout">LOGOUT</a></h4>
<h1 style="text-align:center;padding:30px;padding-top:0">Personal details</h1>
<form action="/details?flight_id=${flight_id}&&username=${username}" method="post" >
<div class="myform">
<table>
		<tr>
		<td>Email</td>
		<td><input type="email" name="email" required="required"></td>
		</tr>
		<tr>
		<td>MobileNumber</td>
		<td><input type="text" pattern="^[7-9]{1}[0-9]{9}" placeholder="Enter valid mobile number" name="mobile" maxlength="10" required="required"></td>
		</tr>
</table>
</div>
<h1 style="text-align:center;padding:30px;">Payment details</h1>
<div class="myform">

	<table>
		<tr>
		<td>Card No.</td>
		<td><input type="text" placeholder="Enter 16 digit number" pattern="\d*" maxlength="16" required="required"></td>
		</tr>
		<tr>
		<td>Card Holder Name</td>
		<td><input type="text" pattern="[a-zA-Z ]*$" placeholder="Alphabets and space allowed" required="required"></td>
		</tr>
		<tr>
		<td>Month</td>
		<td><input type="number" placeholder="Enter valid month" min="1" max="12" required="required"></td>
		</tr>
		<tr>
		<td>Year(Eg: 2020)</td>
		<td><input type="number" placeholder="Enter valid Year" min="2020" max="2100" required="required"></td>
		</tr>
		<tr>
		<td>CCV Number</td>
		<td><input type="text" pattern="\d*" maxlength="3" placeholder="Enter 3 digit number" required="required"></td>
		</tr>
	</table>
	
</div>
<div style="text-align: center;padding-top:20px;">
	<input class="btn btn-success" type="submit" value="Payment and Book"></div>
</form>
	<div id="footer"></div>
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