<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Airline Reservation System</title>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
div {
	line-height: 250%;
}

.popup {
	background: rgba(0, 0, 0, 0.1);
	width: 100%;
	height: 100%;
	position: absolute;
	top: 0;
	left: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	backdrop-filter: blur(5px);
}


#myform {
	padding-right: 20px;
	padding-left: 20px;
}

a {
	text-decoration: none;
	padding-left: 120px;
	padding-right: 120px;
	color:white;
}

a:hover {
	color: white;
	font-size: 1.2em;
}

a.ui-datepicker-prev.ui-corner-all.ui-state-disabled, a.ui-datepicker-next.ui-corner-all.ui-state-disabled,
	a.ui-datepicker-prev.ui-corner-all, a.ui-datepicker-next.ui-corner-all
	{
	padding: 0;
}

input, select {
	padding: 5.5px 4px;
	border-radius: 4px;
	color:black;
}

.popup-container {
	margin: 10px;
	height: 350px;
	width: 920px;
	background: rgb(0,0,0, 0.6);
	border-radius: 4px;
	position: relative;
}

body {
	font-size: 0.9em;
	font-family: verdana;
	color: 	#F5F5F5;
	background: url("/Images/plane.jpg") no-repeat center center fixed;
	background-size: cover;
}

h1 {
	text-align: center;
	color:	#F5F5F5;
	font-size: 1.5em;
}
</style>
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
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
	<div class="popup">
		<div style="height:80%;">
			<h1 style="padding-bottom:25px;">AIR TICKET RESERVATION</h1>
			<div style="text-align: center; color: 	#F5F5F5;">
				<h3>${log}</h3>
			</div>
			<div class="popup-container">
				<div style="text-align: center;">
					<a href="/admin">Login as Admin</a> <a href="/user">Login as
						User</a>
				</div>
				<form action="/flight" method="post">
					<div class="myform">
						<table>
							<tr>
								<td>From</td>
								<td><select name="from_place" id="from_place"
									required="required">
										<c:forEach var="element" items="${Places}">
											<option value="${element}">${element}</option>
										</c:forEach>
								</select></td>
							</tr>
							<tr>
								<td>To</td>
								<td><select name="to_place" id="to_place"
									required="required">
										<c:forEach var="element" items="${Places}">
											<option value="${element}">${element}</option>
										</c:forEach>
								</select></td>
							</tr>
							<tr>
								<td>Departure(MM/DD/YYYY)</td>
								<td><div class="input-group date" data-provide="datepicker">
										<input type="text" name="departure_date" class="form-control"
											required="required">
										<div class="input-group-addon">
											<span class="glyphicon glyphicon-th"></span>
										</div>
									</div></td>
							</tr>
							<tr>
								<td><strong>Passengers</strong></td>
							</tr>
							<tr>
								<td>Adult(s)</td>
								<td><input name="adults" type="number" value="1" min="1"
									required="required"> Children <input name="kids"
									type="number" value="0" required="required" min="0"> Infant(s)
									<input name="infants" type="number" value="0" min="0"
									required="required"></td>
							</tr>
							<tr>
								<td>Class</td>
								<td><select name="bookingClass" id="bookingClass"
									required="required">
										<option value="Economy">Economy</option>
										<option value="Business">Business</option>
								</select></td>
							</tr>
					</table>
					</div>
					<div style="text-align: center;">
						<input style="color:black;" type="submit" value="Search Flights">
					</div>
				</form>
			</div>
		</div>
	</div>
	 <script type="text/javascript"> 
        window.history.forward(); 
        function noBack() { 
            window.history.forward(); 
        } 
    </script> 
</body>
</html>