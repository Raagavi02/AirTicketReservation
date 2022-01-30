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
<title>Add details</title>
<link href="webjars/bootstrap/3.3.6/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">


<style type="text/css">
.myform {
	padding-top: 20px;
	padding-bottom: 20px;
	margin: 0 auto;
	text-align: center;
	width: 80%;
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

input, select {
	border-radius: 4px;
	padding: 5.5px 4px;
	border-color: #D0D0D0;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0
		rgba(0, 0, 0, 0.19);
}

#footer {
	height: 50px;
}
</style>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
	$(function() {
		$("#departure_date").datepicker({
			minDate : +1
		});
	});
</script>
</head>
<body>
	<form id="form1" action="/loginAction?username=${username}"
		method="post">
		<h4>
			<a href="javascript:;"
				onclick="document.getElementById('form1').submit();">BACK</a>
		</h4>
	</form>
	<h1 style="text-align: center; padding: 30px; padding-top: 0">Add
		Flight Details</h1>
	<form action="/addFlightDetails" method="post" onsubmit="return checks()">
		<div class="myform">
			<table>
				<tr>
					<td>Flight Number</td>
					<td><input name="flight_number" type="text"
						required="required"></td>
				</tr>
				<tr>
					<td>Flight Name</td>
					<td><input name="flight_name" type="text" required="required"></td>
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
					<td><input name="departure_date" type="text"
						id="departure_date" required="required" /></td>
				</tr>
				<tr>
					<td>Time</td>
					<td><input name="time" type="text" required="required" /></td>
				</tr>
				<tr>
					<td>Distance</td>
					<td><input name="distance" type="text" required="required" /></td>
				</tr>
			</table>
		</div>
		<br>
		<div style="text-align: center; padding-top: 20px;">
			<input class="btn btn-success" type="submit" value="Add">
		</div>
	</form>
	<script src="webjars/jquery/1.9.1/jquery.min.js"></script>
	<script src="webjars/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<script>
	function checks(){
		var a=document.getElementById("from_place").value;
		var b=document.getElementById("to_place").value;
		if(a==b){
			alert("From and To location cannot be same");
		}
	}
     window.history.forward(); 
     function noBack() { 
         window.history.forward(); 
     } 

</script>
</body>
</html>