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
<title>Edit flight details</title>

<link href="webjars/bootstrap/3.3.6/css/bootstrap.min.css"
	rel="stylesheet">

<style type="text/css">
.myform{
		padding-top:20px;
		padding-bottom:20px;
		margin:0 auto;
		text-align:center;
		width:80%;
		box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	}td{
		width:250px;
		padding:10px;
	}table{
		width:100%;
	}input,select{
		border-radius: 4px;
		padding: 5.5px 4px;
		border-color:#D0D0D0;
		box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	}#footer{
		height:50px;
	}</style>
</head>
<body>
<form id="form1" action="/availableFlights?username=${username}" method="post">
<h4><a  href="javascript:;" onclick="document.getElementById('form1').submit();">BACK</a></h4>
</form>
	<h1 style="text-align:center;padding:30px;padding-top:0">Edit Flight Form</h1>
	<form action="/editFlightDetails" method="post" class="myform" onsubmit="return checks()">
	
		<table>
			<tr>
				<td>Flight Number</td>
				<td><input name="flight_number" type="text"
					required="required"></td>
			</tr>
			<tr>
				<td>Flight Name</td>
				<td><input name="flight_name" type="text"
					required="required"></td>
			</tr>
			<tr>
				<td>From</td>
				<td><select name="from_place" id="from_place">
						<c:forEach var="element" items="${places}">
							<option value="${element}">${element}</option>
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td>To</td>
				<td><select name="to_place" id="to_place">
						<c:forEach var="element" items="${places}">
							<option value="${element}">${element}</option>
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td>Departure(MM/DD/YYYY)</td>
				<td><input name="departure_date" type="text" id="departure_date"
					required="required" /></td>
			</tr>
			<tr>
				<td>Time</td>
				<td><input name="time" type="text"
					required="required" /></td>
			</tr>
			<tr>
				<td>Distance</td>
				<td><input name="distance" type="text"
					required="required" /></td>
			</tr>
		</table>
		<br>
		<div style="text-align: center;padding-top:20px;">
	<input class="btn btn-success" type="submit" value="Change"></div>
	</form>
	<script type="text/javascript">
window.onload=function(){
	if(${check}){
		document.body.style.display="none";
		alert("Invalid Access");
		window.location.href="/logout";
	}
}</script>
<script src="webjars/jquery/1.9.1/jquery.min.js"></script>
		<script src="webjars/bootstrap/3.3.6/js/bootstrap.min.js"></script><script src="webjars/bootstrap-datepicker/1.0.1/js/bootstrap-datepicker.js"></script>
	<script>
	function checks(){
		var a=document.getElementById("from_place").value;
		var b=document.getElementById("to_place").value;
		if(a==b){
			alert("From and To location cannot be same");
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